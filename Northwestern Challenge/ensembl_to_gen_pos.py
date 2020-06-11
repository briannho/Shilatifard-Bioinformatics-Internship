#!usr/bin/env python3
import mygene
mg = mygene.MyGeneInfo()

#reading in upreg txt file
ensembl_upreg = []
with open('DrugvDMSO.htseq.01.up.geneList.txt') as updata:
    updata = updata.readlines()
    for gene in updata:
        ensembl_upreg.append(gene.strip())
        
#reading in dnreg txt file
ensembl_dnreg = []
with open('DrugvDMSO.htseq.01.dn.geneList.txt') as dndata:
    dndata = dndata.readlines()
    for gene in dndata:
        ensembl_dnreg.append(gene.strip())

#retrieving genomic positions of genes
upreg = mg.querymany(ensembl_upreg , scopes='ensembl.gene', fields='genomic_pos_hg19', species='human', as_dataframe = True)
downreg = mg.querymany(ensembl_dnreg , scopes='ensembl.gene', fields='genomic_pos_hg19', species='human', as_dataframe = True)

#remove rows with no positions
upreg = upreg.dropna(subset=['genomic_pos_hg19.chr'])
downreg = downreg.dropna(subset=['genomic_pos_hg19.chr'])

#remove rows where genes are from the mitochondria
upreg = upreg[upreg['genomic_pos_hg19.chr'] != 'MT']
downreg = downreg[downreg['genomic_pos_hg19.chr'] != 'MT']
    
#write positions of up-reg genes to txt file
upreg_pos = open('upreg_pos.txt', 'w')

for index, row in upreg.iterrows():
    
    chromosome = str(row['genomic_pos_hg19.chr'])
    start = str(row['genomic_pos_hg19.start'])
    end =str(row['genomic_pos_hg19.end'])
    
    upreg_pos.write('chr' + chromosome + ' ' + start + ' ' + end + '\n')
    #print('chr ' + chromosome + ' ' + start + ' ' + end)
    
upreg_pos.close()

#write positions of up-reg genes to txt file
downreg_pos = open('downreg_pos.txt', 'w')

for index, row in downreg.iterrows():
    
    chromosome = str(row['genomic_pos_hg19.chr'])
    start = str(row['genomic_pos_hg19.start'])
    end =str(row['genomic_pos_hg19.end'])
    
    downreg_pos.write('chr' + chromosome + ' ' + start + ' ' + end + '\n')
    #print('chr ' + chromosome + ' ' + start + ' ' + end)
    
downreg_pos.close()
print('Complete.')