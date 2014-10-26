GettingAndCleaningDataProjct
============================

Coursera Getting and Cleaning Data Project


## Understanding the code: Steps

### 1. Read all the variables of X, Y & Subject (both for training & test data)
### 2. Provide meaningful names to each of the columns
### 3. Merge the test data & training data separately
### 4. Merge the test data & training data
### 5. Extract the mean and sd of all the measurements
### 6. Insert a column to give meaning to the activity codes
### 7. Make a matrix (table) of subject ID & Activity Code
### 8. Generate mean and standard deviation for this new table
### 9. Transfer the data into file


## Code Variables Guid

### dat_test_subj_test - raw test data of subject ( read-from-file )
### dat_test_X_test - computed calculations of test data ( read-from-file )
### dat_test_Y_test - activity codes of test data  ( read-from-file )
### dat_test - above three variables merged into a common test table
### dat_train_subj_train - raw training data of subject ( read-from-file )
### dat_train_X_train - computed calculations of training data ( read-from-file )
### dat_train_Y_train - activity codes of training data ( read-from-file )
### dat_train - above three variables merged into a common training table
### dat_merged - data merged from the superset of raw data of training and testing
### mean_for_each_easurement - calculated mean of data merged
### sd_for_each_easurement - calculated sd of data merged
### dat_merged_with_act_details - activity description merged to activity code
### tidy_data_avg_sample_of_each_activity - avg for activity
### tidy_data_avg_subject_all_activity_samples - avg for samples
### tidy_data - final tidy data stored in this variable