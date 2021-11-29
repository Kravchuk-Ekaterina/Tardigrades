import pandas as pd
protein_table = pd.read_csv('../proteins.blastp', sep='\t', comment='#', header=None)
s = 'qseqid sseqid evalue qcovs pident'
protein_table.columns = s.split(' ')
print(protein_table.head())
print(protein_table.shape)

