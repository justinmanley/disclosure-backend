CREATE TABLE contributors
SELECT
    CTRIB_NAMT as title,
    CTRIB_NAMF as first_name,
    CTRIB_NAML as last_name,
    CTRIB_NAMS as suffix,
    CTRIB_OCC as occupation,
    CTRIB_EMP as employer,
    CTRIB_CITY as city,
    CTRIB_ST as state,
    CTRIB_ZIP4 as zipcode,
    CMTE_ID as committee_id
FROM RCPT_CD
UNION ALL
SELECT
    LNDR_NAMT as title,
    LNDR_NAMF as first_name,
    LNDR_NAML as last_name,
    LNDR_NAMS as suffix,
    LOAN_OCC as occupation,
    LOAN_EMP as employer,
    LOAN_CITY as city,
    LOAN_ST as state,
    LOAN_ZIP4 as zipcode,
    CMTE_ID as committee_id
FROM LOAN_CD
UNION ALL
SELECT
    ENTY_NAMT as title,
    ENTY_NAMF as first_name,
    ENTY_NAML as last_name,
    ENTY_NAMS as suffix,
    CTRIB_OCC as occupation,
    CTRIB_EMP as employer,
    ENTY_CITY as city,
    ENTY_ST as state,
    ENTY_ZIP4 as zipcode,
    CMTE_ID as committee_id
FROM S497_CD
