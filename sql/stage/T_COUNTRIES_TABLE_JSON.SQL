-- DATASET SOURCE: https://www.kaggle.com/datasets/rajkumarpandey02/2023-world-population-by-country?select=countries-table.json

CREATE TABLE IF NOT EXISTS DEV.STAGE.T_COUNTRIES_TABLE_JSON(
    JSON VARIANT
);