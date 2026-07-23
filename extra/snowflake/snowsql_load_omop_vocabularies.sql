--- dialect: Snowflake

USE DATABASE RWD_PROD;

USE SCHEMA TEAM_OMOP_VOC_RAW_20250827;


-- create vocabulary tables
CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_concept (
    concept_id                  BIGINT,
    concept_name                VARCHAR(255),
    domain_id                   VARCHAR(20),
    vocabulary_id               VARCHAR(20),
    concept_class_id            VARCHAR(20),
    standard_concept            VARCHAR(1),
    concept_code                VARCHAR(255),
    valid_start_date            DATE,
    valid_end_date              DATE,
    invalid_reason              VARCHAR(1)
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_concept_ancestor
(
    ancestor_concept_id         INTEGER,
    descendant_concept_id       INTEGER,
    min_levels_of_separation    INTEGER,
    max_levels_of_separation    INTEGER
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_concept_class
(
    concept_class_id            VARCHAR(20),
    concept_class_name          VARCHAR(255),
    concept_class_concept_id    INTEGER
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_concept_relationship
(
    concept_id_1                BIGINT,
    concept_id_2                BIGINT,
    relationship_id             VARCHAR(20),
    valid_start_date            DATE,
    valid_end_date              DATE,
    invalid_reason              VARCHAR(1)
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_concept_synonym
(
    concept_id                  INTEGER,
    concept_synonym_name        VARCHAR(1000),
    language_concept_id         INTEGER
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_domain
(
    domain_id                   VARCHAR(20),
    domain_name                 VARCHAR(255),
    domain_concept_id           INTEGER
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_drug_strength
(
    drug_concept_id             INTEGER,
    ingredient_concept_id       INTEGER,
    amount_value                DOUBLE,
    amount_unit_concept_id      INTEGER,
    numerator_value             DOUBLE,
    numerator_unit_concept_id   INTEGER,
    denominator_value           DOUBLE,
    denominator_unit_concept_id INTEGER,
    box_size                    INTEGER,
    valid_start_date            DATE,
    valid_end_date              DATE,
    invalid_reason              VARCHAR(1)
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_relationship
(
    relationship_id             VARCHAR(20),
    relationship_name           VARCHAR(255),
    is_hierarchical             VARCHAR(1),
    defines_ancestry            VARCHAR(1),
    reverse_relationship_id     VARCHAR(20),
    relationship_concept_id     INTEGER
);

CREATE OR REPLACE TABLE TEAM_OMOP_VOC_RAW_20250827.voc_vocabulary
(
    vocabulary_id               VARCHAR(255),
    vocabulary_name             VARCHAR(255),
    vocabulary_reference        VARCHAR(255),
    vocabulary_version          VARCHAR(255),
    vocabulary_concept_id       INTEGER
);


-- upload CSV files
PUT file://D:\EPAM\vocabularies\v20250827\CONCEPT.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/concept.csv.gz
    PARALLEL = 20
;
PUT file://D:\EPAM\vocabularies\v20250827\CONCEPT_ANCESTOR.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/concept_ancestor.csv.gz
    PARALLEL = 20
;
PUT file://D:\EPAM\vocabularies\v20250827\CONCEPT_CLASS.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/concept_class.csv.gz
    PARALLEL = 1
;
PUT file://D:\EPAM\vocabularies\v20250827\CONCEPT_RELATIONSHIP.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/concept_relationship.csv.gz
    PARALLEL = 20
;
PUT file://D:\EPAM\vocabularies\v20250827\CONCEPT_SYNONYM.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/concept_synonym.csv.gz
    PARALLEL = 10
;
PUT file://D:\EPAM\vocabularies\v20250827\DOMAIN.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/domain.csv.gz
    PARALLEL = 1
;
PUT file://D:\EPAM\vocabularies\v20250827\DRUG_STRENGTH.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/drug_strength.csv.gz
    PARALLEL = 10
;
PUT file://D:\EPAM\vocabularies\v20250827\RELATIONSHIP.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/relationship.csv.gz
    PARALLEL = 1
;
PUT file://D:\EPAM\vocabularies\v20250827\VOCABULARY.csv.gz
    @~/TEAM_OMOP_VOC_RAW_20250827/vocabulary.csv.gz
    PARALLEL = 1
;


-- upload CSV files
COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_concept
FROM @~/TEAM_OMOP_VOC_RAW_20250827/concept.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_concept_ancestor
FROM @~/TEAM_OMOP_VOC_RAW_20250827/concept_ancestor.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_concept_class
FROM @~/TEAM_OMOP_VOC_RAW_20250827/concept_class.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_concept_relationship
FROM @~/TEAM_OMOP_VOC_RAW_20250827/concept_relationship.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_concept_synonym
FROM @~/TEAM_OMOP_VOC_RAW_20250827/concept_synonym.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_domain
FROM @~/TEAM_OMOP_VOC_RAW_20250827/domain.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_drug_strength
FROM @~/TEAM_OMOP_VOC_RAW_20250827/drug_strength.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_relationship
FROM @~/TEAM_OMOP_VOC_RAW_20250827/relationship.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);

COPY INTO TEAM_OMOP_VOC_RAW_20250827.voc_vocabulary
FROM @~/TEAM_OMOP_VOC_RAW_20250827/vocabulary.csv.gz
FILE_FORMAT = (
    TYPE = CSV
    COMPRESSION = GZIP
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = NONE
    ESCAPE = '\\'
    SKIP_HEADER = 1
    DATE_FORMAT = 'YYYYMMDD'
    EMPTY_FIELD_AS_NULL = TRUE
);
