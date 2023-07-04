-- DATASET SOURCE: https://www.kaggle.com/datasets/lokeshparab/amazon-products-dataset

CREATE OR REPLACE FILE FORMAT CSV_AMAZON_FF
    TYPE = CSV
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    FIELD_DELIMITER = ',';

-- FILES ARE PARTIALLY CORRUPTED, I WILL USE INSERT INSTEAD OF COPY
-- COPY INTO DEV.STAGE.T_AMAZON_PRODUCTS FROM @DEV_AMAZON_STAGE
--     FILE_FORMAT = CSV_AMAZON_FF
--     PATTERN = '.*.csv'
--     MATCH_BY_COLUMN_NAME = 'CASE_INSENSITIVE'
--     ON_ERROR = 'CONTINUE';

INSERT INTO DEV.STAGE.T_AMAZON_PRODUCTS(name, main_category, sub_category, image, link, ratings, no_of_ratings, discount_price, actual_price)
    SELECT
        t.$1 AS NAME,
        t.$2 AS MAIN_CATEGORY,
        t.$3 AS SUB_CATEGORY,
        t.$4 AS IMAGE,
        t.$5 AS LINK,
        t.$6 AS RATINGS,
        t.$7 AS NO_OF_RATINGS,
        t.$8 AS DISCOUNT_PRICE,
        t.$9 AS ACTUAL_PRICE

    FROM @DEV_AMAZON_STAGE (FILE_FORMAT => CSV_AMAZON_FF, PATTERN => '.*.csv') t;