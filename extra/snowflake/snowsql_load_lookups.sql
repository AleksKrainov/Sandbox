--- dialect: Snowflake

USE DATABASE RWD_PROD;

USE SCHEMA TEAM_JMDC_202511_ETL_SCHEMA;

    
-- create lookup tables
CREATE OR REPLACE TABLE TEAM_JMDC_202511_ETL_SCHEMA.lk_sig_cd (
    signature_code      STRING,
    description         STRING
);

CREATE OR REPLACE TABLE TEAM_JMDC_202511_ETL_SCHEMA.lk_unit (
    src_unit             STRING,
    src_stnd_unit        STRING,
    voc_unit             STRING,
    ratio                STRING
);


-- upload CSV files
PUT file://D:\EPAM\projects\jmdc\custom_mapping\lk_sig_cd.csv
    @~/TEAM_JMDC_202511_ETL_SCHEMA/lk_sig_cd.csv
;
PUT file://D:\EPAM\projects\jmdc\custom_mapping\lk_unit.csv
    @~/TEAM_JMDC_202511_ETL_SCHEMA/lk_unit.csv
;

COPY INTO TEAM_JMDC_202511_ETL_SCHEMA.lk_sig_cd
FROM @~/TEAM_JMDC_202511_ETL_SCHEMA/lk_sig_cd.csv
FILE_FORMAT = (
    TYPE = CSV
    --COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYY-MM-DD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_JMDC_202511_ETL_SCHEMA.lk_unit
FROM @~/TEAM_JMDC_202511_ETL_SCHEMA/lk_unit.csv
FILE_FORMAT = (
    TYPE = CSV
    --COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYY-MM-DD'
    EMPTY_FIELD_AS_NULL = TRUE
);
