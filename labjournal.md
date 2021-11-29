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
### Creating blast database and doing a local blast search:
Creating database:
```bash
makeblastdb -in protein.fasta -dbtype prot -out proteins_db
```
Running blastp:
```bash 
blastp -query peptides.fa   -db proteins_db  -out proteins.blastp -outfmt "6 qseqid sseqid evalue qcovs pident" -evalue 0.05  -task blastp-short

```
So we have proteins.blastp file. Using a python script phys_loc.py. It can be found in ./scripts.<br>
The head of the table:
![phys_loc](./images/phys_loc.jpg "phys_loc") <br>
There are 44 proteins in it
