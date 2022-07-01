import sys

def processFile(pathFile):

    fileResultVcf = open(pathFile, "r")
    #The file has no header
    #fileResultVcf.readline()

    #IGHD1-1;14-106385355-ACGGTGGT-A;.;RF;1;243402;4.10843e-06;7822122;E
    for linha in fileResultVcf:
        vec = linha.split(";")
        if vec[3] == "PASS":
            print(linha.strip())

    fileResultVcf.close()

if __name__ == "__main__":
    pathfile = sys.argv[1]
    #pathfile = "/media/fabio/E0AA993DAA9910E0/backup-E-22112021/analise-gnomad-aut/vcfs/resultgroupvcfs/resultTotalVcfGENCODEDREGION.csv"
    processFile(pathfile)






