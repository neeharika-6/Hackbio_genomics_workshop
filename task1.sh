#!/bin/bash

#Write a simple Bash program where your first name and last name are assigned to different variables, and the script prints out your full name and a 
version where the strings are printed on the same line and a version where the strings are printed on different lines.

firstname="Neeharika"
lastname="Desam"
echo $firstname $lastname
echo $firstname
echo $lastname

#Create a new folder titled your name

mkdir Neeharika

#Create another new directory titled biocomputing and change to that directory with one line of command

mkdir BioComputing && cd BioComputing

#Download these 3 files:
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk

#You have to move the .fna file to the folder titled your name directly. (Do this with one command
mv wildtype.fna ~/Neeharika/

#The gbk file is a duplicate,so delete it.
	
rm wildtype.gbk.1

#The mutant should have “tatatata” while the normal should have just “tata”. Can you confirm if the file is mutant or wild type
grep 'tatatata' ~/Neeharika/wildtype.fna

#If it is mutant, print all the lines that show it is a mutant into a new file

grep 'tatatata'~/Neeharika/wildtype.fna > mutant.txt

#Clear your terminal space and print all the commands you have used today.
	
clear && history

#List the files in the two folders and share a screenshot of your terminal belo
ls Neeharika && ls BioComPuting
exit

#Use the figlet command to draw a graphical representation of your name.

sudo apt-get install figlet

figlet "Team Planck"

mkdir compare

wget https://www.bioinformatics.babraham.ac.uk/training/Introduction%20to%20Unix/unix_intro_data.tar.gz

#Unzip using gunzip command
gunzip unix_intro_data.tar.gx

#Then, untar the .tar file with tar command

tar -xvf unix_intro_data.tar

#Get into seqmonk_genomes/Saccharomyces cerevisiae/EF4 and identify the rRNAs present in Mito.dat.
cd "segmonk_genome/Saccharomyces cerevusiae/EF4"
grep "rRNA" Mito.dat

#Using cp copy Mito.dat into the compare directory. 
cp Mito.dat ~/compare/

#Use nano to effect the following edits:
Change Mito to Mitochondrion in the ID and AC header lines
nano Mito.dat

#Rename the file from Mito.dat to Mitochondrion.txt
mv Mito.dat Mitochondrion.txt

#Calculate the total number of lines in lane8_DD_P4_TTAGGC_L008_R1.fastq.gz
#Print the total number of lines in all fastq.gz files and save it as a new file.
cd FastQ_DATA
wc -l lane DD P4 TTAGGC LOO8 R1.fastq.gz
wc *.fastq.gz|total.txt