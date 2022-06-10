#!/bin/bash

#1. Count the number of sequences in DNA.fa
#downloaded the file with wget command and counted using grep command.

wget https://raw.githubusercontent.com/HackBio-Internship/wale-home-tasks/main/DNA.fa
grep -c "^>" DNA.fa

#2. Write a one-line command in Bash to get the total A, T, G & C counts for all the sequences in the file above
#counted using egrep command along with sort and uniq command 

egrep -o "A|T|G|C" DNA.fa | sort | uniq -c

#3. Set up a conda (anaconda, miniconda or mini forge) environment on your terminal.
# setting up the environment

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc

#4. Downloading the softwares for the analysis

sudo apt-get -y install fastp
sudo apt-get -y install fastqc
sudo apt-get -y install bwa
sudo apt-get -y install samtools

#5. Downloaded the datasets from https://github.com/josoga2/yt-dataset/tree/main/dataset

wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Chara_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Chara_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Drysdale_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Drysdale_R2.fastq.gz

#Creating the output folder
mkdir output 

#fastqc

fastqc *.fastq.gz -o output/


#Using fastp

SAMPLES=(
  "ACBarrie"
  "Alsen"
  "Baxter"
  "Chara"
  "Drysdale"
)

for SAMPLE in "${SAMPLES[@]}"; do

  fastp \
    -i "$PWD/${SAMPLE)_R1.fastq.gz" \
    -I "$PWD/${SAMPLE)_R2.fastq.gz" \
    -o "output/${SAMPLE}_R1.fastq.gz" \
    -O "output/${SAMPLE}_R2.fastq.gz" \
    --html "output/${SAMPLE}_fastp.html" 
done

#Implementing (bwa)

#Change directory into the output folder
cd output

#creating the reference genome folder/directory
mkdir references

#Dowload the reference genome into the references folder
wget https://github.com/josoga2/yt-dataset/raw/main/dataset/references/reference.fasta -P references/

SAMPLES=(
  "ACBarrie"
  "Alsen"
  "Baxter"
  "Chara"
  "Drysdale"
)
bwa index references/reference.fasta
mkdir repaired
mkdir alignment_map
for SAMPLE in "${SAMPLES[@]}"; do
    repair.sh in1="output/${SAMPLE}_R1.fastq.gz" in2="output/${SAMPLE}_R2.fastq.gz" out1="repaired/${SAMPLE}_R1_rep.fastq.gz" out2="repaired/${SAMPLE}_R2_rep.fastq.gz" outsingle="repaired/${SAMPLE}_single.fq"
    echo $PWD
    bwa mem -t 1 \
    references/reference.fasta \
    "repaired/${SAMPLE}_R1_rep.fastq.gz" "repaired/${SAMPLE}_R2_rep.fastq.gz" \
  | samtools view -b \
  > "alignment_map/${SAMPLE}.bam" 
done
