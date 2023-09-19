/* Creating, Designing, and Modifying Database
   This file presents creating, designing, and modifying database tables,
   in order to create a database schema by inputting primary and foreign keys
 */

-- This procedure starts with assigning the related database
USE usa_debit_credit_transactions;

-- 1. Remove unnecessary columns within card_transactions_fact table
ALTER TABLE card_transactions_fact
DROP COLUMN
    card_brand, card_type, description,
    general_category, mccgeneral_id, month, year,
    name, state;

-- 2. Remove unnecessary columns within user_information table
ALTER TABLE user_information
DROP COLUMN retirement_status;

-- 3. Create connection between card_transactions_fact and user_information tables
ALTER TABLE user_information
ADD PRIMARY KEY (user_id);

ALTER TABLE card_transactions_fact
ADD FOREIGN KEY (user_id) REFERENCES user_information(user_id);

-- 4. Create connection between user_information and gender_info tables
ALTER TABLE gender_info
ADD PRIMARY KEY (gender_id);

ALTER TABLE user_information
ADD FOREIGN KEY (gender_id) REFERENCES gender_info(gender_id);

-- 5. Create connection between user_information and card_information tables
ALTER TABLE card_information
ADD FOREIGN KEY (user_id) REFERENCES user_information(user_id);

-- 6. Create connection between card_information and card_brand_info tables
ALTER TABLE card_brand_info
ADD PRIMARY KEY (brand_id);

ALTER TABLE card_information
ADD FOREIGN KEY (card_brand_id) REFERENCES card_brand_info(brand_id);

-- 7. Create connection between card_transactions_fact and states_info tables
ALTER TABLE states_info
ADD PRIMARY KEY (state_code);

ALTER TABLE card_transactions_fact
ADD FOREIGN KEY (states_code) REFERENCES states_info(state_code);

-- 8. Create connection between states_info and geo_division_info tables
ALTER TABLE geo_division_info
ADD PRIMARY KEY (geo_id);

ALTER TABLE states_info
ADD FOREIGN KEY (geo_division_id) REFERENCES geo_division_info(geo_id);

-- 9. Create connection between geo_division_info and region_info tables
ALTER TABLE region_info
ADD PRIMARY KEY (region_id);

ALTER TABLE geo_division_info
ALTER COLUMN region_id VARCHAR(25);

ALTER TABLE geo_division_info
ADD FOREIGN KEY (region_id) REFERENCES region_info(region_id);

-- 10. Create connection between card_transactions_fact and mccs_code tables
ALTER TABLE mccs_code
ADD PRIMARY KEY (mccode_id);

ALTER TABLE card_transactions_fact
ALTER COLUMN mccode_id INTEGER;

ALTER TABLE card_transactions_fact
ADD FOREIGN KEY (mccode_id) REFERENCES mccs_code(mccode_id);

-- 11. Create connection between mccs_code and general_mccs_code tables
ALTER TABLE general_mccs_code
ADD PRIMARY KEY (mccgeneral_id);

ALTER TABLE mccs_code
ALTER COLUMN mccgeneral_id VARCHAR(250);

UPDATE mccs_code
SET mccgeneral_id = 'MCG48004999'
WHERE mccgeneral_id = 'MCG48004900';

UPDATE general_mccs_code
SET mccgeneral_id = 'MCG00001499'
WHERE mccgeneral_id = 'MCG00011499';

ALTER TABLE mccs_code
ADD FOREIGN KEY (mccgeneral_id) REFERENCES general_mccs_code(mccgeneral_id);
