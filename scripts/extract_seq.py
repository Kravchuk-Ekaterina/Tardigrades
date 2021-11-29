import pandas as pd
protein_table = pd.read_csv('../proteins.blastp', sep='\t', comment='#', header=None)
s = 'qseqid sseqid evalue qcovs pident'
protein_table.columns = s.split(' ')

protein = ''
status = False

with open('../protein_1.fasta', 'w') as out:
    with open('../protein.fasta', 'r') as file:
        for line in file:
            if line[0] == '>':
                if line[1:-1] in protein_table.sseqid.values:
                    status = True
                    protein = line
            else:
                if status:
                    out.write(protein)
                    out.write(line)
                    status = False
