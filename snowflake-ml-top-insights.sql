// Creating dataset
CREATE OR REPLACE TABLE input_table(
  ds DATE, metric NUMBER, dim_country VARCHAR, dim_vertical VARCHAR);

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'usa' AS dim_country,
    'tech' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'usa' AS dim_country,
    'auto' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, seq4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'usa' AS dim_country,
    'fashion' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'usa' AS dim_country,
    'finance' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'canada' AS dim_country,
    'fashion' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'canada' AS dim_country,
    'finance' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'canada' AS dim_country,
    'tech' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'canada' AS dim_country,
    'auto' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'france' AS dim_country,
    'fashion' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'france' AS dim_country,
    'finance' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'france' AS dim_country,
    'tech' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 4, 1)) AS ds,
    UNIFORM(1, 10, RANDOM()) AS metric,
    'france' AS dim_country,
    'auto' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

-- Data for the test group

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 8, 1)) AS ds,
    UNIFORM(300, 320, RANDOM()) AS metric,
    'usa' AS dim_country,
    'auto' AS dim_vertica
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

INSERT INTO input_table
  SELECT
    DATEADD(day, SEQ4(), DATE_FROM_PARTS(2020, 8, 1))  AS ds,
    UNIFORM(400, 420, RANDOM()) AS metric,
    'usa' AS dim_country,
    'finance' AS dim_vertical
  FROM TABLE(GENERATOR(ROWCOUNT => 365));

// Creating new view and adding labels to timestamps
CREATE OR REPLACE VIEW input_view AS (
    SELECT
        metric,
        dim_country as country,
        dim_vertical as vertical,
        ds >= '2021-01-01' AS label
    FROM input_table
);

// Creating the model
CREATE OR REPLACE SNOWFLAKE.ML.TOP_INSIGHTS my_insights_model()

// Performing prediction using GET_DRIVERS method
CALL my_insights_model!GET_DRIVERS(
  INPUT_DATA => TABLE(input_view),
  LABEL_COLNAME => 'label',
  METRIC_COLNAME => 'metric'
);