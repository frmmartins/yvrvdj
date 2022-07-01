import sys

def getAlleleCountGenomeExome(pathfileResultTotal, position):
    fileResultVcf = open(pathfileResultTotal, "r")
    #IGHD1-1;14-106385363-C-T;rs368662342;PASS;14;243598;5.74717e-05;7817852;E
    #IGHD1-1;14-106385363-C-T;rs368662342;PASS;4;31168;1.28337e-04;597392;G
    #Allele count
    countGenome = "0"
    countExome = "0"
    for linha in fileResultVcf:
        vec = linha.split(";")
        if vec[1].strip() == position.strip():
            if vec[8].strip() == "E":
                countExome = vec[4]
            elif vec[8].strip() == "G":
                countGenome = vec[4]

    fileResultVcf.close()
    return ";"+countGenome+";"+countExome

def processFile(pathfileResultGroup, pathfileResultTotal):

    fileResultVcfGroup = open(pathfileResultGroup, "r")
    #Skip header
    fileResultVcfGroup.readline()

    print("gene;position;rs;genome;exome;allelecountgenome;allelecountexome")
    for linha in fileResultVcfGroup:
        vec = linha.split(";")
        print(linha.strip() + getAlleleCountGenomeExome(pathfileResultTotal, vec[1]))

    fileResultVcfGroup.close()

if __name__ == "__main__":
    pathfileResultGroup = sys.argv[1]
    pathfileResultTotal = sys.argv[2]
    #pathfileResultGroup = "/media/fabio/E0AA993DAA9910E0/backup-E-22112021/analise-gnomad-aut/vcfs/resultgroupvcfs/resultTotalVcfGroupGENCODEDREGION.csv"
    #pathfileResultTotal = "/media/fabio/E0AA993DAA9910E0/backup-E-22112021/analise-gnomad-aut/vcfs/resultgroupvcfs/resultTotalVcfGENCODEDREGION.csv"
    processFile(pathfileResultGroup, pathfileResultTotal)
