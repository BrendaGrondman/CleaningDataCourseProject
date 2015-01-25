==================================================================
Human Activity Recognition Using Smartphones Dataset

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


ReadMe:

README.md

	
To obtain tiny data set from full datasource (contains description what the program does): 

run_analysis.R	


Result from run_analysis.R is the following tidy Dataset: 

HumanActivityRecoqnitionTidy.txt


Codebook of the tidy dataset:

CodeBook.md

	
In R you can use this following comment to read the file HumanActivityRecoqnitionTidy.txt from your working directory.

Dataset<-read.table("HumanActivityRecoqnitionTidy.txt", header=TRUE)

