#! /bin/bash

#checking for file input
if [ $# -lt 1 ]; then
	echo "Please include one file when attempting to run this script."; exit; fi
if [ $# -gt 1 ]; then
	echo "Please only include one file when attempting to run this script."; exit; fi

#checking that provided file exists and is a FASTA file
if [ ! -e $1 ]; then
	echo "The provided file does not exist."; exit; fi
if ( $1 ! =~ \.fa ); then
	echo "Please make sure the file input is a FASTA file with .fa extension."; exit; fi

#separating headers and sequences and counting sequences
seq=($(grep -v ">" $1))
name=($(grep ">" $1))
seqnum=`echo ${#seq[@]}`

#sanity check for number of sequences
echo "There are $seqnum sequences."

#creating GCcount.txt file, setting up header array, and putting it into the file
touch GCcount.txt
head=( "Sequence name" "GC Percentage" )
echo ${head[@]} > GCcount.txt

#setting looping variable to 0 in order to correctly pull from arrays
lc=0

for i in ${seq[@]}
    do 
    	#identifying the iteration of the loop
	echo "Run $lc..."
	#using the looping variable to bring in the name of the sequence from the name array that corresponds with the sequence being run through the loop
	lname=${name[$lc]}
	#confirming that the name is correct
	echo "Name: $lname"
	#counting characters in the string
	len=${#i}
	#counting instances of C and G in the sequence
	c=`echo $i | grep -oi C | wc -l`
	g=`echo $i | grep -oi G | wc -l`
	#calculating sum of instances of C and G
	cg=`expr $c + $g`
	#calculating percentage of instances that are C or G
	perc=`echo "scale=2; $cg/$len * 100" | bc`
	#indicating length of sequence and number of instances of C, G, and C+G
	echo "Length: $len; C: $c; G: $g; C+G: $cg"
	namperc=( $lname $perc% )
	echo ${namperc[@]} >> GCcount.txt
	lc=`expr $lc + 1`
    done
    
