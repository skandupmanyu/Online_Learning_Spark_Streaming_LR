#USE DATABASE
USE ONLINE_LEARNING_DB;

#INSERT DATA
INSERT INTO DATA_TABLE (X1, Y) (
SELECT X1, Y FROM MASTER_DATA_TABLE_REGIME_1
ORDER BY RAND()
LIMIT 10
);
