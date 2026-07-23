--- dialect: Snowflake

USE DATABASE RWD_PROD;

USE SCHEMA TEAM_JMDC_202511_CUST_VOC_SCHEMA;

    
-- create vocabulary tables
CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_stage_new (
    concept_id                  BIGINT,-- NOT NULL,
    concept_name                VARCHAR(2000) NOT NULL, --extra length, orignal is 255
    domain_id                   VARCHAR(50) NOT NULL,
    vocabulary_id               VARCHAR(100) NOT NULL,  --extra length, orignal is 20
    concept_class_id            VARCHAR(20) NOT NULL,
    standard_concept            VARCHAR(1),
    concept_code                VARCHAR(2000) NOT NULL,--extra length, orignal is 255
    valid_start_date            DATE NOT NULL,
    valid_end_date              DATE NOT NULL,
    invalid_reason              VARCHAR(1)
);

CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_relationship_stage_new
(
    concept_id_1                BIGINT,-- NOT NULL,
    concept_id_2                BIGINT,-- NOT NULL,
    concept_code_1              VARCHAR(1000),
    concept_code_2              VARCHAR(1000),
    vocabulary_id_1             VARCHAR(100),
    vocabulary_id_2             VARCHAR(100),
    relationship_id             VARCHAR(50) NOT NULL,
    valid_start_date            DATE NOT NULL,
    valid_end_date              DATE NOT NULL,
    invalid_reason              VARCHAR(1)
);

CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_ancestor_stage_new
(
    ancestor_concept_id         INTEGER NOT NULL,
    descendant_concept_id       INTEGER NOT NULL,
    ancestor_concept_code       VARCHAR(255),
    descendant_concept_code     VARCHAR(255),
    ancestor_vocabulary_id      VARCHAR(100),
    descendant_vocabulary_id    VARCHAR(100),
    min_levels_of_separation    INTEGER NOT NULL,
    max_levels_of_separation    INTEGER NOT NULL
);

CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_vocabulary_stage_new
(
    vocabulary_id               VARCHAR(255) NOT NULL,
    vocabulary_name             VARCHAR(255) NOT NULL,
    vocabulary_reference        VARCHAR(255),
    vocabulary_version          VARCHAR(255),
    vocabulary_concept_id       INTEGER --NOT NULL
);


-- create vocabulary tables
CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_stage_old (
    concept_id                  BIGINT NOT NULL,
    concept_name                VARCHAR(2000) NOT NULL,--extra length, orignal is 255
    domain_id                   VARCHAR(50) NOT NULL,
    vocabulary_id               VARCHAR(100) NOT NULL,  --extra length, orignal is 20
    concept_class_id            VARCHAR(20) NOT NULL,
    standard_concept            VARCHAR(1),
    concept_code                VARCHAR(2000) NOT NULL,--extra length, orignal is 255
    valid_start_date            DATE NOT NULL,
    valid_end_date              DATE NOT NULL,
    invalid_reason              VARCHAR(1)
);


CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_relationship_stage_old
(
    concept_id_1                BIGINT,-- NOT NULL,
    concept_id_2                BIGINT,-- NOT NULL,
    concept_code_1              VARCHAR(1000),
    concept_code_2              VARCHAR(1000),
    vocabulary_id_1             VARCHAR(100),
    vocabulary_id_2             VARCHAR(100),
    relationship_id             VARCHAR(50) NOT NULL,
    valid_start_date            DATE NOT NULL,
    valid_end_date              DATE NOT NULL,
    invalid_reason              VARCHAR(1)
);

CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_ancestor_stage_old
(
    ancestor_concept_id         INTEGER NOT NULL,
    descendant_concept_id       INTEGER NOT NULL,
    ancestor_concept_code       VARCHAR(255),
    descendant_concept_code     VARCHAR(255),
    ancestor_vocabulary_id      VARCHAR(100),
    descendant_vocabulary_id    VARCHAR(100),
    min_levels_of_separation    INTEGER NOT NULL,
    max_levels_of_separation    INTEGER NOT NULL
);


CREATE OR REPLACE TABLE TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_vocabulary_stage_old
(
    vocabulary_id               VARCHAR(255) NOT NULL,
    vocabulary_name             VARCHAR(255) NOT NULL,
    vocabulary_reference        VARCHAR(255),
    vocabulary_version          VARCHAR(255),
    vocabulary_concept_id       INTEGER NOT NULL
);


-- upload CSV files
PUT file://D:\EPAM\projects\jmdc\custom_mapping\concept_relationship_stage.csv
    @~/TEAM_JMDC_202511_CUST_VOC_SCHEMA/concept_relationship_stage.csv
;
PUT file://D:\EPAM\projects\jmdc\custom_mapping\concept_stage.csv
    @~/TEAM_JMDC_202511_CUST_VOC_SCHEMA/concept_stage.csv
;
PUT file://D:\EPAM\projects\jmdc\custom_mapping\vocabulary_stage.csv
    @~/TEAM_JMDC_202511_CUST_VOC_SCHEMA/vocabulary_stage.csv
;


COPY INTO TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_relationship_stage_new
FROM @~/TEAM_JMDC_202511_CUST_VOC_SCHEMA/concept_relationship_stage.csv
FILE_FORMAT = (
    TYPE = CSV
    --COMPRESSION = GZIP
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYY-MM-DD'
    EMPTY_FIELD_AS_NULL = TRUE
)
;

COPY INTO TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_concept_stage_new
FROM @~/TEAM_JMDC_202511_CUST_VOC_SCHEMA/concept_stage.csv
FILE_FORMAT = (
    TYPE = CSV
    --COMPRESSION = GZIP
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYY-MM-DD'
    EMPTY_FIELD_AS_NULL = TRUE
)
;

COPY INTO TEAM_JMDC_202511_CUST_VOC_SCHEMA.cdm_vocabulary_stage_new
FROM @~/TEAM_JMDC_202511_CUST_VOC_SCHEMA/vocabulary_stage.csv
FILE_FORMAT = (
    TYPE = CSV
    --COMPRESSION = GZIP
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYY-MM-DD'
    EMPTY_FIELD_AS_NULL = TRUE
)
;
