# Layoff-Data-Pipeline-SQL-based-Data-Cleaning-Deduplication-and-Standardization

##Project Overview
This project focuses on transforming and cleaning layoff data to ensure accuracy, consistency, and usability. The dataset includes various fields such as company information, industry, layoff percentages, and dates. Key steps include handling null values, standardizing data formats, and removing duplicates to produce a clean, reliable dataset.

Table of Contents
Project Structure
Features
Data Cleaning Process
Key SQL Operations
How to Run
Sample Queries
Future Improvements
Project Structure
layoffs_stagingdata: Raw data loaded here for preliminary cleaning and analysis.
layoff_New: A cleaned, deduplicated table derived from layoffs_stagingdata.
layoff_New2: A further refined table with standardized columns, final deduplication, and optimized for reporting.
Features
Data Cleansing: Set NULL values for missing or incorrectly formatted fields, remove extraneous whitespace, and apply uniform data formats.
Deduplication: Use SQL's ROW_NUMBER() function to identify and remove duplicate entries based on key attributes.
Date Standardization: Convert date fields from text to a consistent date format, enhancing usability and reliability.
Industry Normalization: Standardize industry names to prevent inconsistent labeling across records.
Data Cleaning Process
Handling Null Values: Replace values labeled as 'NULL' with actual NULL to allow accurate data processing.
Removing Duplicate Records:
Applied ROW_NUMBER() to identify duplicate entries in layoff_New.
Used Common Table Expressions (CTEs) to streamline deduplication and ensure only unique records remain.
Date Field Formatting:
Converted text-based dates to a DATE format using STR_TO_DATE().
Modified the date column to enforce correct data types and prevent errors.
Trimming and Standardizing Text:
Trimmed whitespace from company names and other text fields.
Normalized industry names, replacing variations with standard terms (e.g., changing "Crypto Trading" to "Crypto").
Removing Invalid Rows: Deleted rows with both total_laid_off and percentage_laid_off as NULL for data integrity.


Key SQL Operations
Data Deduplication:

SELECT *, 
  ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, date) AS row_num
FROM layoff_New
Setting NULL Values:

UPDATE layoffs_stagingdata
SET percentage_laid_off = NULL
WHERE percentage_laid_off = 'NULL';
How to Run
Load Raw Data: Import the initial dataset into layoffs_stagingdata.
Run the SQL Queries: Execute the provided SQL scripts in sequence to clean, deduplicate, and transform the data.
Review the Final Data: Check layoff_New2 for the cleaned, deduplicated, and standardized dataset.

Future Improvements
Automate Data Loading: Set up an automated pipeline for loading data into layoffs_stagingdata.
Data Validation: Implement validation checks for new data to ensure consistency with the cleaned dataset.
Error Logging: Add error logging for handling issues like failed updates or invalid data entries.
License
This project is open-source and available under the MIT License.
