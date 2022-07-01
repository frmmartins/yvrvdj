#===================================================================================================================
#Script for search sequences of reference (GENCODE) with the Samtools
#parameter 1: name file position gene
#parameter 2: name sequence gene
#parameter 3: name file reference IMGT (V, D or J)
#parameter 4: region reference alignmente
#===================================================================================================================

filePosition="$1"
nameGeneSeq="$2"
fileReference="$3"
region="$4"

java -jar bin/createScriptSamtools.jar data/reference/gencodev19/$filePosition > data/reference/gencodev19/scSamtools$nameGeneSeq".sh"

cd data/reference/gencodev19/ 

./scSamtools$nameGeneSeq".sh" > $nameGeneSeq".txt"

cd ../../../

#Format result of Samtools
java -jar bin/formatResultSeqGenesSamtools.jar data/reference/gencodev19/$nameGeneSeq".txt" > data/reference/gencodev19/$nameGeneSeq"-final.txt"

#Format .fasta sequences in on line
java -cp bin/formatFileFasta.jar formatfilefasta.FormatFileFastaOneLine data/reference/gencodev19/$nameGeneSeq"-final.txt" data/reference/gencodev19/$nameGeneSeq"-final-fmt.txt"
 
#Complement reverse
java -jar bin/generateSeqCompAndReverse.jar data/reference/gencodev19/$nameGeneSeq"-final-fmt.txt" > data/reference/gencodev19/$nameGeneSeq"-final-fmt-CR.txt"
 

#Check alignment V-REGION (IMGT) with sequences of GENCODE, with algorithm "Needleman-Wunsch Global Align Nucleotide Sequences".
#Python 
python3 bin/globalAlignmentOfGenes.py data/reference/gencodev19/$nameGeneSeq"-final-fmt-CR.txt" data/reference/imgt/$fileReference > data/reference/gencodev19/$nameGeneSeq"-final-fmt-CR-AL-"$region".txt"

