USE calaccess_raw;
CREATE TABLE donors
SELECT
    TRIM(BOTH ' ' FROM CONCAT_WS(' ', CTRIB_NAMT, CTRIB_NAMF, CTRIB_NAML, CTRIB_NAMS)) AS name,
    CTRIB_OCC as occupation,
    CTRIB_EMP as employer,
    TRIM(BOTH ' ' FROM CONCAT_WS(' ', CTRIB_CITY, CTRIB_ST, CTRIB_ZIP4)) AS address,
    CMTE_ID as committee_id
FROM RCPT_CD
UNION ALL
SELECT
    TRIM(BOTH ' ' FROM CONCAT_WS(' ', LNDR_NAMT, LNDR_NAMF, LNDR_NAML, LNDR_NAMS)) AS name,
    LOAN_OCC as occupation,
    LOAN_EMP as employer,
    TRIM(BOTH ' ' FROM CONCAT_WS(' ', LOAN_CITY, LOAN_ST, LOAN_ZIP4)) AS address,
    CMTE_ID as committee_id
FROM LOAN_CD
UNION ALL
SELECT
    TRIM(BOTH ' ' FROM CONCAT_WS(' ', ENTY_NAMT, ENTY_NAMF, ENTY_NAML, ENTY_NAMS)) AS name,
    CTRIB_OCC as occupation,
    CTRIB_EMP as employer,
    TRIM(BOTH ' ' FROM CONCAT_WS(' ', ENTY_CITY, ENTY_ST, ENTY_ZIP4)) AS address,
    CMTE_ID as committee_id
FROM S497_CD;
ALTER TABLE donors
    ADD COLUMN donor_id INT NOT NULL AUTO_INCREMENT FIRST,
    ADD PRIMARY KEY (donor_id);
-- Dedupe requires missing values to be represented by NULL, rather than the empty string.
-- Allows the listed columns to contain NULL values.
ALTER TABLE donors
    MODIFY name VARCHAR(268) NULL,
    MODIFY occupation VARCHAR(60) NULL,
    MODIFY employer VARCHAR(200) NULL,
    MODIFY address VARCHAR(44) NULL,
    MODIFY committee_id VARCHAR(9) NULL;
UPDATE donors
SET
    -- Nullify empty strings for dedupe.
    name = CASE name WHEN '' THEN NULL ELSE name END,
    occupation = CASE occupation WHEN '' THEN NULL ELSE occupation END,
    employer = CASE employer WHEN '' THEN NULL ELSE employer END,
    address = CASE address WHEN '' THEN NULL ELSE address END,
    committee_id = CASE committee_id WHEN '' THEN NULL ELSE committee_id END;  
