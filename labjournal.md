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

