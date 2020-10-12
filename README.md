# Schneider_Project2

## Motivation
This script was written to take a FASTA file and evaluate the percentage of sequences of DNA that are G or C nucleotides.

## Explanation
This script requires a Fasta file as a command line input when being run. So first the script checks for that one file was input when the command was run, followed by a check that the input file exists. The user will receive error messages with instructions if the wrong number of files are input or if the input file does not exist. 

The script separates the headers and sequences from the input FASTA file. It looks for any lines that contain ">" and includes them in the $name array and the remaining lines in the $seq array. It also defines a variable for the number of sequences from the file, $seqnum.

The script creates the output file "GCcount.txt" if it does not already exist. It defines an array, $head for the header of the file and puts it into the previously defined file, removing any other contents of the file that exist.

The script uses a for loop to run the correct number of iterations, one for each sequence. Before the for loop is initiated, a looping variable is set to 0 in order to correctly pull from arrays. For example, in the first run of the loop, we want the first element of the $name array, which is defined as the 0th.

The for loop is written to run one iteration per array element in the $seq array. In the for loop, the script first echos a sanity check with the run number based on the looping variable. The element of the $name array corresponding to the current element of the $seq array being run is stored as a loop variable, $lname, using the looping variable to identify the element. A sanity check is performed to output the name of the sequence that was just defined as $lname. Thhe script counts the total characters in the string, to use as a divisor in the math the loop performs. The script uses grep to find cases of C and G, case insensitive, and counts them using wc. These two numbers are added to find total instances of C or G, and the percent of the length is calculated using bc. A sanity check is performed that outputs the values of $len, $c, $g, and $cg. An array is defined containing the name of the sequence being run and the percent as calculated. This is added to the GCcount.txt file. Finally, the script uses expr to add 1 to the looping variable.

```
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
	#indicating length of sequence and number of instances of C, G, and C+G``
	echo "Length: $len; C: $c; G: $g; C+G: $cg"
	namperc=( $lname $perc% )
	echo ${namperc[@]} >> GCcount.txt
	lc=`expr $lc + 1`
    done
```

## Reflection
- Why do you think that many biologists skip the step of making their code publicly available and adding documentation?
	- Many biologists likely skip publication and documentation of their code because it adds additional steps and complications to the process of writing the script. Biologists who are very busy may feel that it is not worthwhile.
- Why do you think I asked you to write sanity checks into your code? Do you see room for additional sanity checks to be added?
	- The sanity checks helped me while I was writing the code to make sure that the variables I was using were defined correctly, but they also help someone who downloads my code to see what is happening when they run it. Sanity checks also give outputs that allow users to see the results of code as it runs.
- In my experience, loops are the hardest concept for students to learn. Why do you think this is? What struggles did you have when trying to write a loop into your code?
	- I can see why loops are a difficult concept for students to learn. I think that it can be difficult to envision the flow of code, which is why diagrams like the ones in our lecture videos are so helpful. The main difficulty I had when writing my loop was making it run the correct number of iterations. At first, before I defined $seq as an array, I was trying to use numbers to define the iterations, but when I attempted to use $seqnum to make it run the correct number of times, the loop only performed one iteration with the number ID from the variable.

| Sequence Name | GC Percentage |
| ----------- | ----------- |
| >DI245396.1 | 43.00% |
| >DI245395.1 | 42.00% |
| >HW262829.1 | 43.00% |
| >546218138 | 42.00% |
| >X13802.1 | 39.00% |
| >NM_001179558.3 | 51.00% |
| >NM_001178613.2 | 45.00% |
| >AY558240.1 | 51.00% |
| >AB052924.1 | 51.00% |
