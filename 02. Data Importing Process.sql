/* Data Importing Process
   This file demonstrates data importing process using BULK INSERT
 */

-- Begin this process by selecting the database
USE usa_debit_credit_transactions;

-- 1. Data import for card_brand_info table
BULK INSERT card_brand_info
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\card_brand_info.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 2. Data import for card_information table
BULK INSERT card_information
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\card_information.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 3. Data import for card_transactions_fact table
BULK INSERT card_transactions_fact
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\card_transactions_fact.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 4. Data import for gender_info table
BULK INSERT gender_info
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\gender_info.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 5. Data import for general_mccs_code table
BULK INSERT general_mccs_code
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\mcgeneral_code.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 6. Data import for mccs_code table
BULK INSERT mccs_code
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\mccs_code.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 7. Data import for geo_division_info table
BULK INSERT geo_division_info
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\geo_division_info.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 8. Data import for region_info table
BULK INSERT region_info
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\region_info.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 9. Data import for states_info table
BULK INSERT states_info
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\states_info.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );

-- 10. Data import for user_information table
BULK INSERT user_information
FROM
    'D:\Data Analytics\MS SQL Server\US personal debit and credit cards transactions\Dataset\user_information.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
    );