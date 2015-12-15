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
