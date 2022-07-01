import matplotlib.pyplot as plt
import numpy as np
import sys

pathfile = sys.argv[1]
#pathfile = "/media/fabio/01D6C9B552D2D260/analise-gnomad-aut/vcfs/resultgroupvcfs/groupGeneCountGenomeExomeGENCODEDREGION.csv"

fileseq = open(pathfile, "r")

#not use the first line
fileseq.readline()

genes = []
values = []

#gene;countgenome;countexome
#IGHD3-16;10;62
for linha in fileseq:
    vec = linha.strip().split(";")
    genes.append(vec[0])
    values.append(int(vec[1]) + int(vec[2]))

#Close file
fileseq.close()

font = {'family': 'serif',
        'color':  'darkred',
        'weight': 'normal',
        'size': 10,
        }

x = np.arange(len(genes))  # the label locations
width = 0.35  # the width of the bars

fig, ax = plt.subplots()
rects1 = ax.bar(genes, values, width, label='Men')

# Add some text for labels, title and custom x-axis tick labels, etc.
plt.xticks(rotation=90, fontsize=6)
plt.xlabel('Gene name')
plt.ylabel('Number of variants')
#ax.set_xticklabels(genes)

def autolabel(rects):
    """Attach a text label above each bar in *rects*, displaying its height."""
    number_bar = 0
    for rect in rects:
        #bar represent on gene

        #height = rect.get_height()
        height = values[number_bar]
        number_bar = number_bar + 1
        ax.annotate('{}'.format(height),
                    xy=(rect.get_x(), height),
                    xytext=(0, 3),  # 3 points vertical offset
                    textcoords="offset points",
                    ha='center', va='bottom')

#offset pixels
#'top', 'bottom', 'center', 'baseline', 'center_baseline'

autolabel(rects1)
fig.tight_layout()
plt.show()

#fig.savefig('path.png')










