#Verify data of reference of IMGT/NCBI =============================================================================
#(This process is execute only one time)

#Create file with name of genes functionais ========================================================================
#2019/04/11 download of files REGIONs .fasta of site: http://www.imgt.org/genedb/
java -jar bin/getNameGenesRegion.jar data/reference/imgt/V-REGION.fasta "IMGT site access 16-04-2021" > data/reference/imgt/genesV.txt
java -jar bin/getNameGenesRegion.jar data/reference/imgt/D-REGION.fasta "IMGT site access 06-12-2020" > data/reference/imgt/genesD.txt
java -jar bin/getNameGenesRegion.jar data/reference/imgt/J-REGION.fasta "IMGT site access 06-12-2020" > data/reference/imgt/genesJ.txt

echo "Create file with name of genes functionais"
#===================================================================================================================

#The command below format the sequence of file FASTA for one line (file download of IMGT) ==========================
java -cp bin/formatFileFasta.jar formatfilefasta.FormatFileFastaOneLine data/reference/imgt/V-REGION.fasta data/reference/imgt/V-REGION-fmt.fasta
java -cp bin/formatFileFasta.jar formatfilefasta.FormatFileFastaOneLine data/reference/imgt/D-REGION.fasta data/reference/imgt/D-REGION-fmt.fasta
java -cp bin/formatFileFasta.jar formatfilefasta.FormatFileFastaOneLine data/reference/imgt/J-REGION.fasta data/reference/imgt/J-REGION-fmt.fasta

echo "Format the sequence of file FASTA for one line (file download of IMGT)"
#===================================================================================================================

#This program filter the file .gff of NCBI. Get the cromossomo 14, this for working with file smaller ==============
#Obs.: The NCBI use the reference of IMGT (file .gff downlod of site NCBI)

#Descompact
gunzip data/reference/ncbi-imgt/GRCh37_latest_genomic.gff.gz
java -jar bin/filterCromossomoFileGff.jar NC_000014 data/reference/ncbi-imgt/GRCh37_latest_genomic.gff > data/reference/ncbi-imgt/GRCh37-ncbi-gff-filtrado.txt

#Compact
gzip data/reference/ncbi-imgt/GRCh37_latest_genomic.gff

echo "This program filter the file .gff of NCBI"
#===================================================================================================================

#Identify ocorency of genes in file .gff ===========================================================================
#param1: file with name of genes (Ex.: genesV.txt create above IMGT).
#param2: file .gff cromossomo 14.

#GENE V
java -jar bin/getPositionGenesInFileGff.jar data/reference/imgt/genesV.txt data/reference/ncbi-imgt/GRCh37-ncbi-gff-filtrado.txt > data/reference/ncbi-imgt/posicao-geneV-IMGT-NCBI-GRCh37.txt

#GENE D
java -jar bin/getPositionGenesInFileGff.jar data/reference/imgt/genesD.txt data/reference/ncbi-imgt/GRCh37-ncbi-gff-filtrado.txt > data/reference/ncbi-imgt/posicao-geneD-IMGT-NCBI-GRCh37.txt

#GENE J
java -jar bin/getPositionGenesInFileGff.jar data/reference/imgt/genesJ.txt data/reference/ncbi-imgt/GRCh37-ncbi-gff-filtrado.txt > data/reference/ncbi-imgt/posicao-geneJ-IMGT-NCBI-GRCh37.txt

#Create script Samtools for get sequence of nucleotides of reference. In this case NCBI - IMGT.

#GENE V
java -jar bin/createScriptSamtools.jar data/reference/ncbi-imgt/posicao-geneV-IMGT-NCBI-GRCh37.txt > data/reference/ncbi-imgt/scriptSamtools.sh

#GENE D
java -jar bin/createScriptSamtools.jar data/reference/ncbi-imgt/posicao-geneD-IMGT-NCBI-GRCh37.txt > data/reference/ncbi-imgt/scriptSamtoolsD.sh

#GENE J
java -jar bin/createScriptSamtools.jar data/reference/ncbi-imgt/posicao-geneJ-IMGT-NCBI-GRCh37.txt > data/reference/ncbi-imgt/scriptSamtoolsJ.sh


#Change for folder reference.
cd data/reference/ncbi-imgt/ 

#Indexer the file .fasta to search (GRCh37) 
#We filter the cromossome 14 this file GRCh37_latest_genomic.fna.gz and create of index with command bellow 
#samtools faidx GRCh37-chromossomo14.fna 
#The sequences of nucleotides of cromossome 14 too can is download of site: https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.25/
#After download use comand above for index

#Command  for change index of cromossomo in the file.
#GENE V
sed -i 's/chr14:/NC_000014.8:/ ; s/chr14.fa/GRCh37-chromossomo14.fna/' scriptSamtools.sh

#GENE D
sed -i 's/chr14:/NC_000014.8:/ ; s/chr14.fa/GRCh37-chromossomo14.fna/' scriptSamtoolsD.sh

#GENE J
sed -i 's/chr14:/NC_000014.8:/ ; s/chr14.fa/GRCh37-chromossomo14.fna/' scriptSamtoolsJ.sh

#Get sequence of gene:
#Link of genome reference NCBI: https://www.ncbi.nlm.nih.gov/projects/genome/guide/human/index.shtml#download

#GENE V
./scriptSamtools.sh > seqGenesVRef-NCBI-IMGT.txt

#GENE D
./scriptSamtoolsD.sh > seqGenesDRef-NCBI-IMGT.txt

#GENE J
./scriptSamtoolsJ.sh > seqGenesJRef-NCBI-IMGT.txt

cd ../../../

echo "Identify ocorency of genes in file .gff"
#===================================================================================================================

#Get sequence of nucleotides of reference IMGT, only for conference ================================================

#Format sequences of genes.
java -jar bin/formatResultSeqGenesSamtools.jar data/reference/ncbi-imgt/seqGenesVRef-NCBI-IMGT.txt > data/reference/ncbi-imgt/seqGenesVRef-NCBI-IMGT-final.txt
java -jar bin/formatResultSeqGenesSamtools.jar data/reference/ncbi-imgt/seqGenesDRef-NCBI-IMGT.txt > data/reference/ncbi-imgt/seqGenesDRef-NCBI-IMGT-final.txt
java -jar bin/formatResultSeqGenesSamtools.jar data/reference/ncbi-imgt/seqGenesJRef-NCBI-IMGT.txt > data/reference/ncbi-imgt/seqGenesJRef-NCBI-IMGT-final.txt

#The command below format the sequence of file FASTA for one line
java -cp bin/formatFileFasta.jar formatfilefasta.FormatFileFastaOneLine data/reference/ncbi-imgt/seqGenesVRef-NCBI-IMGT-final.txt data/reference/ncbi-imgt/seqGenesVRef-NCBI-IMGT-final-fmt.txt
java -cp bin/formatFileFasta.jar formatfilefasta.FormatFileFastaOneLine data/reference/ncbi-imgt/seqGenesDRef-NCBI-IMGT-final.txt data/reference/ncbi-imgt/seqGenesDRef-NCBI-IMGT-final-fmt.txt
java -cp bin/formatFileFasta.jar formatfilefasta.FormatFileFastaOneLine data/reference/ncbi-imgt/seqGenesJRef-NCBI-IMGT-final.txt data/reference/ncbi-imgt/seqGenesJRef-NCBI-IMGT-final-fmt.txt

#This program convert sequence for reverse complementary (equals IMGT/V-QUEST)
java -jar bin/generateSeqCompAndReverse.jar data/reference/ncbi-imgt/seqGenesVRef-NCBI-IMGT-final-fmt.txt > data/reference/ncbi-imgt/seqGenesVRef-NCBI-IMGT-final-fmt-CR.txt
java -jar bin/generateSeqCompAndReverse.jar data/reference/ncbi-imgt/seqGenesDRef-NCBI-IMGT-final-fmt.txt > data/reference/ncbi-imgt/seqGenesDRef-NCBI-IMGT-final-fmt-CR.txt
java -jar bin/generateSeqCompAndReverse.jar data/reference/ncbi-imgt/seqGenesJRef-NCBI-IMGT-final-fmt.txt > data/reference/ncbi-imgt/seqGenesJRef-NCBI-IMGT-final-fmt-CR.txt

echo "Get sequence of nucleotides of reference IMGT, only for conference" 
#===================================================================================================================


#Generate file with position of genes of reference GENCODE (file GFF) ==============================================

#This program filter the file .gff of NCBI. Get the cromossomo 14, this for working with file smaller.
gunzip data/reference/gencodev19/gencode.v19.annotation.gff3.gz
java -jar bin/filterCromossomoFileGff.jar chr14 data/reference/gencodev19/gencode.v19.annotation.gff3 > data/reference/gencodev19/gencode.v19.annotation.txt
gzip data/reference/gencodev19/gencode.v19.annotation.gff3

#Identify ocorency of genes in file .gff
#param1: file with names genesV.txt or D and J of reference IMGT.
#param2: file gff filtered

#GENES V
java -jar bin/getPositionGenesInFileGff.jar data/reference/imgt/genesV.txt data/reference/gencodev19/gencode.v19.annotation.txt > data/reference/gencodev19/posicao-geneV-GenCode-GRCh37.txt

#GENES D
java -jar bin/getPositionGenesInFileGff.jar data/reference/imgt/genesD.txt data/reference/gencodev19/gencode.v19.annotation.txt > data/reference/gencodev19/posicao-geneD-GenCode-GRCh37.txt

#GENES J
java -jar bin/getPositionGenesInFileGff.jar data/reference/imgt/genesJ.txt data/reference/gencodev19/gencode.v19.annotation.txt > data/reference/gencodev19/posicao-geneJ-GenCode-GRCh37.txt


#ADD position start and end gene J (This situetion idenfield in global alligment )
java -jar bin/addNumberPositionRef.jar data/reference/gencodev19/posicao-geneJ-GenCode-GRCh37.txt 2 > data/reference/gencodev19/posicao-geneJ-GenCode-GRCh37-ADD.txt

echo "Generate file with position of genes of reference GENCODE (file GFF)"
#===================================================================================================================

#Get sequence of nucleotides (Samtools) GENCODE and comparize with reference IMGT ==================================
#verify if the aligment is not 100% identity and ajust position of genes GENCODE and aligment again

./runSubVerifyReference.sh posicao-geneV-GenCode-GRCh37.txt seqGeneV V-REGION-fmt.fasta VREGION
./runSubVerifyReference.sh posicao-geneD-GenCode-GRCh37.txt seqGeneD D-REGION-fmt.fasta DREGION
./runSubVerifyReference.sh posicao-geneJ-GenCode-GRCh37-ADD.txt seqGeneJ J-REGION-fmt.fasta JREGION

#Revision gene V
java -jar bin/verifyGlobalAlignment.jar data/reference/gencodev19/seqGeneV-final-fmt-CR-AL-VREGION.txt > data/reference/gencodev19/posicao-geneV-GenCode-GRCh37-Rev.txt

#Revision gene D
java -jar bin/verifyGlobalAlignment.jar data/reference/gencodev19/seqGeneD-final-fmt-CR-AL-DREGION.txt > data/reference/gencodev19/posicao-geneD-GenCode-GRCh37-Rev.txt

#Revision gene J
java -jar bin/verifyGlobalAlignment.jar data/reference/gencodev19/seqGeneJ-final-fmt-CR-AL-JREGION.txt > data/reference/gencodev19/posicao-geneJ-GenCode-GRCh37-Rev.txt

#New Alignment genes V,D and J
./runSubVerifyReference.sh posicao-geneV-GenCode-GRCh37-Rev.txt seqGeneV-Rev V-REGION-fmt.fasta VREGION
./runSubVerifyReference.sh posicao-geneD-GenCode-GRCh37-Rev.txt seqGeneD-Rev D-REGION-fmt.fasta DREGION
./runSubVerifyReference.sh posicao-geneJ-GenCode-GRCh37-Rev.txt seqGeneJ-Rev J-REGION-fmt.fasta JREGION
 
echo "Get sequence of nucleotides (Samtools) GENCODE and comparize with reference IMGT"
#===================================================================================================================

#After process of correction verify if all alignments its corrects =================================================
#If there is error align a file is create in folder error
java -jar bin/verifyErrorGlobalAlignment.jar data/reference/gencodev19/seqGeneV-Rev-final-fmt-CR-AL-VREGION.txt data/reference/error-alignment/ > data/reference/gencodev19/seqGeneV-Rev-final-fmt-CR-AL-VREGION-FF.txt

java -jar bin/verifyErrorGlobalAlignment.jar data/reference/gencodev19/seqGeneD-Rev-final-fmt-CR-AL-DREGION.txt data/reference/error-alignment/ > data/reference/gencodev19/seqGeneD-Rev-final-fmt-CR-AL-DREGION-FF.txt

java -jar bin/verifyErrorGlobalAlignment.jar data/reference/gencodev19/seqGeneJ-Rev-final-fmt-CR-AL-JREGION.txt data/reference/error-alignment/ > data/reference/gencodev19/seqGeneJ-Rev-final-fmt-CR-AL-JREGION-FF.txt

echo "After process of correction verify if all alignments its corrects"
#===================================================================================================================

#create a program for get the new positions of genes ===============================================================
java -jar bin/getPositionGeneFinal.jar data/reference/gencodev19/seqGeneV-Rev-final-fmt-CR-AL-VREGION-FF.txt > data/reference/gencodev19/position-geneV-GenCode-FF.txt

java -jar bin/getPositionGeneFinal.jar data/reference/gencodev19/seqGeneD-Rev-final-fmt-CR-AL-DREGION-FF.txt > data/reference/gencodev19/position-geneD-GenCode-FF.txt

java -jar bin/getPositionGeneFinal.jar data/reference/gencodev19/seqGeneJ-Rev-final-fmt-CR-AL-JREGION-FF.txt > data/reference/gencodev19/position-geneJ-GenCode-FF.txt

echo "create a program for get the new positions of genes"
#===================================================================================================================

echo "Finish!!"
