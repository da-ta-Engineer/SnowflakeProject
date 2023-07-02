-- DATASET DOWNLOADED FROM https://www.kaggle.com/datasets/thedevastator/unlock-profits-with-e-commerce-sales-data


LS @DEV_ECOMM_STAGE;

-- azure://saecommdev.blob.core.windows.net/ecommcsv/Amazon Sale Report.csv,68923428,,"Sun, 2 Jul 2023 08:17:18 GMT"
-- azure://saecommdev.blob.core.windows.net/ecommcsv/Cloud Warehouse Compersion Chart.csv,4528,1b7df199654e4424e2e91cd10abd4040,"Sun, 2 Jul 2023 08:17:13 GMT"
-- azure://saecommdev.blob.core.windows.net/ecommcsv/Expense IIGF.csv,496,367cab7e11fc662328cab6220f637acf,"Sun, 2 Jul 2023 08:17:13 GMT"
-- azure://saecommdev.blob.core.windows.net/ecommcsv/International sale Report.csv,3112676,80a86f8fcab2da101f313e0fda4dba0a,"Sun, 2 Jul 2023 08:17:14 GMT"
-- azure://saecommdev.blob.core.windows.net/ecommcsv/May-2022.csv,126617,fdde5f38105541b7429a22cb82bab907,"Sun, 2 Jul 2023 08:17:13 GMT"
-- azure://saecommdev.blob.core.windows.net/ecommcsv/P  L March 2021.csv,135938,d094bf183af91114704ef45049eea838,"Sun, 2 Jul 2023 08:17:13 GMT"
-- azure://saecommdev.blob.core.windows.net/ecommcsv/Sale Report.csv,433643,f5ad4009df19851fde3334259745fb7b,"Sun, 2 Jul 2023 08:17:13 GMT"

CREATE OR REPLACE FILE FORMAT CSV_ECOMM_FF
    TYPE = CSV
    PARSE_HEADER = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    FIELD_DELIMITER = ',';

USE WAREHOUSE DEV_WH;

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

SELECT COUNT(*) FROM DEV.STAGE.T_AMAZON_SALE_REPORT;
-- 128975

ALTER WAREHOUSE DEV_WH SUSPEND;



