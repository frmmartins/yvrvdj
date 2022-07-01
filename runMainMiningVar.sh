#!/bin/bash

#============================================================================================
#Filtering variants of file VCF.
#parameter 1: File with position for filter
#parameter 2: Name file result output 
#parameter 3: File with sequence nucleotides rev-final-fmt.txt, seq original of reference .fna
#============================================================================================

filePosition="$1"
nameFileOutput="$2"
fileSeqReference="$3"

#The program clear data for execute =========================================================
echo "Clear data"

rm vcfs/scriptGetVariants.sh
rm vcfs/resultfiltervcfs/*

echo "Remove file scriptGetVariants.sh and crear folder resultfiltervcfs"
#============================================================================================


#Create and execute command TABIX for get variants ===========================================
java -jar bin/filterFileVcf.jar $filePosition vcfs/ vcfs/resultfiltervcfs/ > vcfs/scriptGetVariants.sh

./vcfs/scriptGetVariants.sh

echo "Create and execute command TABIX for get variants"
#============================================================================================


#Process result VCF =========================================================================
#java -jar bin/processVcf.jar vcfs/resultfiltervcfs/ > vcfs/resultgroupvcfs/resultTotalVcf$nameFileOutput.csv
java -jar bin/processVcf.jar vcfs/resultfiltervcfs/ > vcfs/resultgroupvcfs/resultTotalVcfTmp$nameFileOutput.csv

#Remove not PASS
python3 bin/removeNotPASS.py vcfs/resultgroupvcfs/resultTotalVcfTmp$nameFileOutput.csv > vcfs/resultgroupvcfs/resultTotalVcf$nameFileOutput.csv 

echo "Process result TABIX and create file resultTotal"
#============================================================================================


#Group variants =============================================================================
java -jar bin/groupVariantGenomeExome.jar vcfs/resultgroupvcfs/resultTotalVcf$nameFileOutput.csv > vcfs/resultgroupvcfs/resultTotalVcfGroup$nameFileOutput.csv

#Crieate file with detail
python3 bin/getDetailresultTotalVcfGroup.py vcfs/resultgroupvcfs/resultTotalVcfGroup$nameFileOutput.csv vcfs/resultgroupvcfs/resultTotalVcf$nameFileOutput.csv  > vcfs/resultgroupvcfs/resultTotalVcfGroupDetail$nameFileOutput.csv

echo "Group variants genome and exome"
#============================================================================================


#Group variants for gene and count genome and exome =========================================
java -jar bin/groupVariantGeneCountGenomeExome.jar vcfs/resultgroupvcfs/resultTotalVcf$nameFileOutput.csv > vcfs/resultgroupvcfs/groupGeneCountGenomeExome$nameFileOutput.csv

echo "Group variants for gene and count genome and exome"
#============================================================================================


#Position variants in sequence of reference with result create file with variants for genes =
java -jar bin/positionVariantInSeqRef.jar vcfs/resultgroupvcfs/resultTotalVcfGroup$nameFileOutput.csv $fileSeqReference 1 > vcfs/resultseqvariants/seqvar$nameFileOutput-Final.txt

echo "Position variants in sequence of reference with result create file with variants for genes"
#============================================================================================


#Generate file with the variants sequences, reverse complementary ===========================
java -jar bin/generateSeqCompAndReverse.jar vcfs/resultseqvariants/seqvar$nameFileOutput-Final.txt > vcfs/resultseqvariants/seqvar$nameFileOutput-Final-CR.txt 

echo "Generate file with the variants sequences, reverse complementary"
#============================================================================================

echo "Finish!!"


#Create graphics basic with information of variants found.
#Eixo x = number of variantes 
#Eixo y = name of gene

#Not will inlcude in script

#===========================================================================================

