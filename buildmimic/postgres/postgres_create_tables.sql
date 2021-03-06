-- -------------------------------------------------------------------------------
--
-- This is a script to generate the MIMIC-III schema and import data for Postgres.
-- 
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - Thursday-August-27-2015   
--------------------------------------------------------

-- Set the correct path to data files before running script.

-- Create the database and schema
CREATE USER MIMIC;
CREATE DATABASE MIMIC OWNER MIMIC;
\c MIMIC;
CREATE SCHEMA MIMICIII;


-- The below command defines the schema where all tables are created
SET search_path TO mimiciii;

-- Restoring the search path to its default value can be accomplished as follows:
--  SET search_path TO "$user",public;


-- -- Example command for importing from a CSV to a table
-- COPY admissions 
--     FROM '/path/to/file/ADMISSIONS_DATA_TABLE.csv' 
--     DELIMITER ',' 
--     CSV HEADER;

--------------------------------------------------------
--  DDL for Table ADMISSIONS
--------------------------------------------------------

  CREATE TABLE ADMISSIONS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ADMITTIME TIMESTAMP(0) NOT NULL, 
	DISCHTIME TIMESTAMP(0) NOT NULL, 
	DEATHTIME TIMESTAMP(0), 
	ADMISSION_TYPE VARCHAR(50) NOT NULL, 
	ADMISSION_LOCATION VARCHAR(50) NOT NULL, 
	DISCHARGE_LOCATION VARCHAR(50) NOT NULL, 
	INSURANCE VARCHAR(255) NOT NULL, 
	LANGUAGE VARCHAR(10), 
	RELIGION VARCHAR(50), 
	MARITAL_STATUS VARCHAR(50), 
	ETHNICITY VARCHAR(200) NOT NULL, 
	DIAGNOSIS VARCHAR(255),
        HAS_IOEVENTS_DATA SMALLINT NOT NULL,
        HAS_CHARTEVENTS_DATA SMALLINT NOT NULL,
	CONSTRAINT adm_rowid_pk PRIMARY KEY (ROW_ID),
    CONSTRAINT adm_hadm_unique UNIQUE (HADM_ID)
   ) ;
   
   
-- Example command for importing from a CSV to a table
COPY ADMISSIONS 
    FROM '/path/to/file/ADMISSIONS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
 
--------------------------------------------------------
--  DDL for Table CALLOUT
--------------------------------------------------------

CREATE TABLE CALLOUT 
    (   ROW_ID INT NOT NULL,
        SUBJECT_ID INT NOT NULL,
        HADM_ID INT NOT NULL,
        SUBMIT_WARDID INT,
        SUBMIT_CAREUNIT VARCHAR(15),
        CURR_WARDID INT,
        CURR_CAREUNIT VARCHAR(15),
        CALLOUT_WARDID INT,
        CALLOUT_SERVICE VARCHAR(10) NOT NULL,
        REQUEST_TELE SMALLINT NOT NULL,
        REQUEST_RESP SMALLINT NOT NULL,
        REQUEST_CDIFF SMALLINT NOT NULL,
        REQUEST_MRSA SMALLINT NOT NULL,
        REQUEST_VRE SMALLINT NOT NULL,
        CALLOUT_STATUS VARCHAR(20) NOT NULL,
        CALLOUT_OUTCOME VARCHAR(20) NOT NULL,
        DISCHARGE_WARDID INT,
        ACKNOWLEDGE_STATUS VARCHAR(20) NOT NULL,
        CREATETIME TIMESTAMP(0) NOT NULL,
        UPDATETIME TIMESTAMP(0) NOT NULL,
        ACKNOWLEDGETIME TIMESTAMP(0),
        OUTCOMETIME TIMESTAMP(0) NOT NULL,
        FIRSTRESERVATIONTIME TIMESTAMP(0),
        CURRENTRESERVATIONTIME TIMESTAMP(0),
        CONSTRAINT callout_rowid_pk PRIMARY KEY (ROW_ID)
        );

-- Example command for importing from a CSV to a table
COPY CALLOUT 
    FROM '/path/to/file/CALLOUT_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
    
--------------------------------------------------------
--  DDL for Table CAREGIVERS
--------------------------------------------------------

  CREATE TABLE CAREGIVERS
   (	ROW_ID INT NOT NULL, 
	CGID INT NOT NULL, 
	LABEL VARCHAR(15), 
	DESCRIPTION VARCHAR(30),
	CONSTRAINT cg_rowid_pk  PRIMARY KEY (ROW_ID),
	CONSTRAINT cg_cgid_unique UNIQUE (CGID)
   ) ;

-- Example command for importing from a CSV to a table
COPY CAREGIVERS 
    FROM '/path/to/file/CAREGIVERS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table CHARTEVENTS
--------------------------------------------------------

  CREATE TABLE CHARTEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ICUSTAY_ID INT, 
	ITEMID INT, 
	CHARTTIME TIMESTAMP(0), 
	STORETIME TIMESTAMP(0), 
	CGID INT, 
	VALUE VARCHAR(255), 
	VALUENUM DOUBLE PRECISION, 
	UOM VARCHAR(50), 
	WARNING INT, 
	ERROR INT, 
	RESULTSTATUS VARCHAR(50), 
	STOPPED VARCHAR(50),
	CONSTRAINT chartevents_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY CHARTEVENTS 
    FROM '/path/to/file/CHARTEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table CPTEVENTS
--------------------------------------------------------

  CREATE TABLE CPTEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	COSTCENTER VARCHAR(10) NOT NULL, 
	CHARTDATE TIMESTAMP(0), 
	CPT_CD VARCHAR(10) NOT NULL, 
	CPT_NUMBER INT, 
	CPT_SUFFIX VARCHAR(5), 
	TICKET_ID_SEQ INT, 
	SECTIONHEADER VARCHAR(50), 
	SUBSECTIONHEADER VARCHAR(255), 
	DESCRIPTION VARCHAR(200),
	CONSTRAINT cpt_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY CPTEVENTS 
    FROM '/path/to/file/CPTEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table DATETIMEEVENTS
--------------------------------------------------------

  CREATE TABLE DATETIMEEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ICUSTAY_ID INT, 
	ITEMID INT NOT NULL, 
	CHARTTIME TIMESTAMP(0) NOT NULL, 
	STORETIME TIMESTAMP(0) NOT NULL, 
	CGID INT NOT NULL, 
	VALUE TIMESTAMP(0), 
	UOM VARCHAR(50) NOT NULL, 
	WARNING SMALLINT, 
	ERROR SMALLINT, 
	RESULTSTATUS VARCHAR(50), 
	STOPPED VARCHAR(50),
	CONSTRAINT datetime_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY DATETIMEEVENTS 
    FROM '/path/to/file/DATETIMEEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table DIAGNOSES_ICD
--------------------------------------------------------

  CREATE TABLE DIAGNOSES_ICD
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	SEQUENCE INT, 
	ICD9_CODE VARCHAR(20),
	CONSTRAINT diagnosesicd_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY DIAGNOSES_ICD 
    FROM '/path/to/file/DIAGNOSES_ICD_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table DRGCODES
--------------------------------------------------------

  CREATE TABLE DRGCODES
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	DRG_TYPE VARCHAR(20) NOT NULL, 
	DRG_CODE VARCHAR(20) NOT NULL, 
	DESCRIPTION VARCHAR(255), 
	DRG_SEVERITY SMALLINT, 
	DRG_MORTALITY SMALLINT,
	CONSTRAINT drg_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY DRGCODES 
    FROM '/path/to/file/DRGCODES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_CPT
--------------------------------------------------------

  CREATE TABLE D_CPT
   (	ROW_ID INT NOT NULL, 
	CATEGORY SMALLINT NOT NULL, 
	SECTIONRANGE VARCHAR(100) NOT NULL, 
	SECTIONHEADER VARCHAR(50) NOT NULL, 
	SUBSECTIONRANGE VARCHAR(100) NOT NULL, 
	SUBSECTIONHEADER VARCHAR(255) NOT NULL, 
	CODESUFFIX VARCHAR(5), 
	MINCODEINSUBSECTION INT NOT NULL, 
	MAXCODEINSUBSECTION INT NOT NULL,
    	CONSTRAINT dcpt_ssrange_unique UNIQUE (SUBSECTIONRANGE), 
    	CONSTRAINT dcpt_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY D_CPT 
    FROM '/path/to/file/D_CPT_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_ICD_DIAGNOSES
--------------------------------------------------------

  CREATE TABLE D_ICD_DIAGNOSES
   (	ROW_ID INT NOT NULL, 
	ICD9_CODE VARCHAR(10) NOT NULL, 
	SHORT_TITLE VARCHAR(50) NOT NULL, 
	LONG_TITLE VARCHAR(255) NOT NULL,
    	CONSTRAINT d_icd_diag_code_unique UNIQUE (ICD9_CODE),
    	CONSTRAINT d_icd_diag_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY D_ICD_DIAGNOSES 
    FROM '/path/to/file/D_ICD_DIAGNOSES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_ICD_PROCEDURES
--------------------------------------------------------

  CREATE TABLE D_ICD_PROCEDURES
   (	ROW_ID INT NOT NULL, 
	ICD9_CODE VARCHAR(10) NOT NULL, 
	SHORT_TITLE VARCHAR(50) NOT NULL, 
	LONG_TITLE VARCHAR(255) NOT NULL,
    	CONSTRAINT d_icd_proc_code_unique UNIQUE (ICD9_CODE),
    	CONSTRAINT d_icd_proc_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY D_ICD_PROCEDURES 
    FROM '/path/to/file/D_ICD_PROCEDURES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_ITEMS
--------------------------------------------------------

  CREATE TABLE D_ITEMS
   (	ROW_ID INT NOT NULL, 
	ITEMID INT NOT NULL, 
	LABEL VARCHAR(200), 
	ABBREVIATION VARCHAR(100), 
	DBSOURCE VARCHAR(20), 
	LINKSTO VARCHAR(50), 
	CODE VARCHAR(20), 
	CATEGORY VARCHAR(100), 
	UNITNAME VARCHAR(100), 
	PARAM_TYPE VARCHAR(30), 
	LOWNORMALVALUE DOUBLE PRECISION, 
	HIGHNORMALVALUE DOUBLE PRECISION,
    	CONSTRAINT ditems_itemid_unique UNIQUE (ITEMID),
    	CONSTRAINT ditems_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY D_ITEMS 
    FROM '/path/to/file/D_ITEMS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_LABITEMS
--------------------------------------------------------

  CREATE TABLE D_LABITEMS
   (	ROW_ID INT NOT NULL, 
	ITEMID INT NOT NULL, 
	LABEL VARCHAR(100) NOT NULL, 
	FLUID VARCHAR(100) NOT NULL, 
	CATEGORY VARCHAR(100) NOT NULL, 
	LOINC_CODE VARCHAR(100),
    	CONSTRAINT dlabitems_itemid_unique UNIQUE (ITEMID),
    	CONSTRAINT dlabitems_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY D_LABITEMS 
    FROM '/path/to/file/D_LABITEMS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table ICUSTAYEVENTS
--------------------------------------------------------

  CREATE TABLE ICUSTAYEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ICUSTAY_ID INT NOT NULL, 
	DBSOURCE VARCHAR(20) NOT NULL, 
	FIRST_CAREUNIT VARCHAR(20) NOT NULL, 
	LAST_CAREUNIT VARCHAR(20) NOT NULL,
	FIRST_WARDID SMALLINT NOT NULL,
	LAST_WARDID SMALLINT NOT NULL,
	INTIME TIMESTAMP(0) NOT NULL, 
	OUTTIME TIMESTAMP(0), 
	LOS DOUBLE PRECISION,
    	CONSTRAINT icustay_icustayid_unique UNIQUE (ICUSTAY_ID),
    	CONSTRAINT icustay_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY ICUSTAYEVENTS 
    FROM '/path/to/file/ICUSTAYEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
    
--------------------------------------------------------
--  DDL for Table IOEVENTS
--------------------------------------------------------

  CREATE TABLE IOEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ICUSTAY_ID INT, 
	STARTTIME TIMESTAMP(0), 
	ENDTIME TIMESTAMP(0), 
	ITEMID INT, 
	VOLUME DOUBLE PRECISION, 
	VOLUMEUOM VARCHAR(30), 
	RATE DOUBLE PRECISION, 
	RATEUOM VARCHAR(30), 
	STORETIME TIMESTAMP(0), 
	CGID BIGINT, 
	ORDERID BIGINT, 
	LINKORDERID BIGINT, 
	ORDERCATEGORYNAME VARCHAR(100), 
	SECONDARYORDERCATEGORYNAME VARCHAR(100), 
	ORDERCOMPONENTTYPEDESCRIPTION VARCHAR(200), 
	ORDERCATEGORYDESCRIPTION VARCHAR(50), 
	PATIENTWEIGHT DOUBLE PRECISION, 
	TOTALVOLUME DOUBLE PRECISION, 
	TOTALVOLUMEUOM VARCHAR(50), 
	STATUSDESCRIPTION VARCHAR(30), 
	STOPPED VARCHAR(30), 
	NEWBOTTLE INT, 
	ISOPENBAG SMALLINT, 
	CONTINUEINNEXTDEPT SMALLINT, 
	CANCELREASON SMALLINT, 
	COMMENTS_STATUS VARCHAR(30), 
	COMMENTS_TITLE VARCHAR(100), 
	COMMENTS_DATE TIMESTAMP(0), 
	ORIGINALCHARTTIME TIMESTAMP(0), 
	ORIGINALAMOUNT DOUBLE PRECISION, 
	ORIGINALAMOUNTUOM VARCHAR(30), 
	ORIGINALROUTE VARCHAR(30), 
	ORIGINALRATE DOUBLE PRECISION, 
	ORIGINALRATEUOM VARCHAR(30), 
	ORIGINALSITE VARCHAR(30),
	CONSTRAINT ioevents_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY IOEVENTS 
    FROM '/path/to/file/IOEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table LABEVENTS
--------------------------------------------------------

  CREATE TABLE LABEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ITEMID INT NOT NULL, 
	CHARTTIME TIMESTAMP(0), 
	VALUE VARCHAR(200), 
	VALUENUM DOUBLE PRECISION, 
	UOM VARCHAR(20), 
	FLAG VARCHAR(20),
	CONSTRAINT labevents_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY LABEVENTS 
    FROM '/path/to/file/LABEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table MICROBIOLOGYEVENTS
--------------------------------------------------------

  CREATE TABLE MICROBIOLOGYEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	CHARTDATE TIMESTAMP(0), 
	CHARTTIME TIMESTAMP(0), 
	SPEC_ITEMID INT, 
	SPEC_TYPE_CD VARCHAR(10), 
	SPEC_TYPE_DESC VARCHAR(100), 
	ORG_ITEMID INT, 
	ORG_CD INT, 
	ORG_NAME VARCHAR(100), 
	ISOLATE_NUM SMALLINT, 
	AB_ITEMID INT, 
	AB_CD INT, 
	AB_NAME VARCHAR(30), 
	DILUTION_TEXT VARCHAR(10), 
	DILUTION_COMPARISON VARCHAR(20), 
	DILUTION_VALUE DOUBLE PRECISION, 
	INTERPRETATION VARCHAR(5),
	CONSTRAINT micro_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY MICROBIOLOGYEVENTS 
    FROM '/path/to/file/MICROBIOLOGYEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table NOTEEVENTS
--------------------------------------------------------

  CREATE TABLE NOTEEVENTS
   (	ROW_ID INT NOT NULL, 
	RECORD_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	CHARTDATE TIMESTAMP(0), 
	CATEGORY VARCHAR(50), 
	DESCRIPTION VARCHAR(255), 
	CGID INT, 
	ISERROR CHAR(1), 
	TEXT TEXT,
	CONSTRAINT noteevents_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY NOTEEVENTS 
    FROM '/path/to/file/NOTEEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table PATIENTS
--------------------------------------------------------

  CREATE TABLE PATIENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	GENDER VARCHAR(5) NOT NULL, 
	DOB TIMESTAMP(0) NOT NULL, 
	DOD TIMESTAMP(0), 
	DOD_HOSP TIMESTAMP(0), 
	DOD_SSN TIMESTAMP(0), 
	HOSPITAL_EXPIRE_FLAG VARCHAR(5) NOT NULL,
    	CONSTRAINT pat_subid_unique UNIQUE (SUBJECT_ID),
    	CONSTRAINT pat_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY PATIENTS 
    FROM '/path/to/file/PATIENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table PRESCRIPTIONS
--------------------------------------------------------

  CREATE TABLE PRESCRIPTIONS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ICUSTAY_ID INT, 
	STARTTIME TIMESTAMP(0), 
	ENDTIME TIMESTAMP(0), 
	DRUG_TYPE VARCHAR(100) NOT NULL, 
	DRUG VARCHAR(100) NOT NULL, 
	DRUG_NAME_POE VARCHAR(100), 
	DRUG_NAME_GENERIC VARCHAR(100), 
	FORMULARY_DRUG_CD VARCHAR(120), 
	GSN VARCHAR(200), 
	NDC VARCHAR(120), 
	PROD_STRENGTH VARCHAR(120), 
	DOSE_VAL_RX VARCHAR(120), 
	DOSE_UNIT_RX VARCHAR(120), 
	FORM_VAL_DISP VARCHAR(120), 
	FORM_UNIT_DISP VARCHAR(120), 
	ROUTE VARCHAR(120),
	CONSTRAINT prescription_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY PRESCRIPTIONS 
    FROM '/path/to/file/PRESCRIPTIONS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table PROCEDURES_ICD
--------------------------------------------------------

  CREATE TABLE PROCEDURES_ICD
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	PROC_SEQ_NUM INT NOT NULL, 
	ICD9_CODE VARCHAR(20) NOT NULL,
	CONSTRAINT proceduresicd_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY PROCEDURES_ICD 
    FROM '/path/to/file/PROCEDURES_ICD_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table SERVICES
--------------------------------------------------------

  CREATE TABLE SERVICES
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	TRANSFERTIME TIMESTAMP(0) NOT NULL, 
	PREV_SERVICE VARCHAR(20), 
	CURR_SERVICE VARCHAR(20),
	CONSTRAINT services_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY SERVICES 
    FROM '/path/to/file/SERVICES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
 
--------------------------------------------------------
--  DDL for Table TRANSFERS
--------------------------------------------------------

  CREATE TABLE TRANSFERS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ICUSTAY_ID INT, 
	DBSOURCE VARCHAR(20) NOT NULL, 
	EVENTTYPE VARCHAR(20), 
	PREV_CAREUNIT VARCHAR(20), 
	CURR_CAREUNIT VARCHAR(20), 
	PREV_WARDID SMALLINT,
	CURR_WARDID SMALLINT,
	INTIME TIMESTAMP(0), 
	OUTTIME TIMESTAMP(0), 
	LOS DOUBLE PRECISION,
	CONSTRAINT transfers_rowid_pk PRIMARY KEY (ROW_ID)
   ) ;

-- Example command for importing from a CSV to a table
COPY TRANSFERS 
    FROM '/path/to/file/TRANSFERS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
