# Tardigrades: labjournal

## 0. Obtaining data
```bash
wget http://kumamushi.org/data/YOKOZUNA-1.scaffolds.fa
```
I renamed the file "tardigrade.fa"

## 4. Functional annotation 
I used https://github.com/tejashree1modak/AUGUSTUS-helpers to obtain protein coding sequences
```bash
bash get-fasta.sh augustus.whole.gff
```
Then I counted the number of sequences:
```bash
grep -c ">" protein.fasta
```
The output: 16435

## 5. Physical localization
peplides.fa is a file containing list of peptides that were associated with the DNA. The data is obtained from tandem mass spectrometry experiments using chromatin fraction. <br>
Creating blast database and doing a local blast search:
```bash
makeblastdb -in protein.fasta -blastdb_version 5 -dbtype prot
blastp -db protein.fasta -query peptides.fa -out results.out
```
So we have results.out file. Using a python script:
```{python}
import pandas as pd
protein_table = pd.read_csv('data/results.out', sep='\t', comment='#', header=None)
s = 'qacc sacc evalue qstart qend sstart send'
protein_table.columns = s.split(' ')
protein_table.head()
```
```{python}
df.shape
```
