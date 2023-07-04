USE DATABASE DEV;
CREATE STAGE IF NOT EXISTS DEV_ECOMM_STAGE
    URL = 'azure://saecommdev.blob.core.windows.net/ecommcsv/'
    STORAGE_INTEGRATION = DEV_STORAGE_INT;

LS @DEV_ECOMM_STAGE;

ALTER STORAGE INTEGRATION DEV_STORAGE_INT SET
    STORAGE_ALLOWED_LOCATIONS = ('azure://saecommdev.blob.core.windows.net/ecommcsv/',
    'azure://saecommdev.blob.core.windows.net/amazonproducts/');

CREATE STAGE IF NOT EXISTS DEV_AMAZON_STAGE
    URL = 'azure://saecommdev.blob.core.windows.net/amazonproducts/'
    STORAGE_INTEGRATION = DEV_STORAGE_INT;
