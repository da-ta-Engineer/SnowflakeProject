-- DATASET DOWNLOADED FROM https://www.kaggle.com/datasets/thedevastator/unlock-profits-with-e-commerce-sales-data

LS @DEV_ECOMM_STAGE;

-- azure://saecommdev.blob.core.windows.net/ecommcsv/Amazon Sale Report.csv,68923428,,"Sun, 2 Jul 2023 08:17:18 GMT"


CREATE OR REPLACE FILE FORMAT CSV_ECOMM_FF
    TYPE = CSV
    PARSE_HEADER = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    FIELD_DELIMITER = ',';

CREATE TABLE IF NOT EXISTS DEV.STAGE.T_AMAZON_SALE_REPORT
    USING TEMPLATE (
        SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*)) FROM TABLE(
            INFER_SCHEMA(
              LOCATION => '@DEV_ECOMM_STAGE',
              FILES => 'Amazon Sale Report.csv',
              FILE_FORMAT => 'CSV_ECOMM_FF'
            )
      ));


COPY INTO DEV.STAGE.T_AMAZON_SALE_REPORT FROM @DEV_ECOMM_STAGE
    FILE_FORMAT = CSV_ECOMM_FF
    PATTERN = '.*Amazon Sale Report.csv'
    MATCH_BY_COLUMN_NAME='CASE_INSENSITIVE';




