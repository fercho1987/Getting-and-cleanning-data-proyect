/1/
//download files//
created a folder call data in my working directory to save de zip file.
downloaded the zip file
unzip the file in the working directory. 

//read files//
created a list wiht the files in the test folder, knowing that there were 2947 rows I created an empty data.frame with this number of rows, then I used a for loop to 
read all the files into a datatest dataframe (since they have the same number of rows I used cbind function). 

The same steps were used for the train data set, but the empty data.frame was created with 7352 rows. 

//merge data//
since the test and train subjects were different I used the rbind function to created a complete data set (completedata). 

/2/
//Extract mean and standard deviation//
To extract the mean and standard deviation, a new text file was created (featuesmeanstd.txt) from the file features.txt, this new file contains only the variables 
with mean and standard deviation. 

This file was read into R, and from that file I created a vector only with the number of the variable (vectvar). To all the variable numbers two units were added, this was done
because in the completedata set the variables were cbind at column number three. 

Then I created the subdata from the completedata set, taking all the rows, and extracting the columns especify in the vector (vectvar),column 2 where the subject
number is, and column 564 where the activity label is. 

/3/
/names for the activities//
to name each activity I did a for loop to all rows in the data set. The for loop has several if loops, so for every number in the column (labels) the scripts assigns a name of the
corresponding activity. 

I assign the class factor to this new column

/4/
//variables names//
I created a vector with the variables names, this vector contains the names for each column, the first one is for the column subject,and for the others columns I created a vector 
from the featuesmeanstd.txt file with the names of the other variables, and finaly to the last column created in step 3 I assing the name "names_activities"

/5/
//tidy data//
I created a tidy data using the function melt from the library(reshape2), is split by the variables subject and names_activities. Then I used the function dcast to create the final 
tidy data set (finaldata) with the mean for each variable by subject and activities.  



