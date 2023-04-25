-- Question 1

SELECT income
FROM income_data
LIMIT 10

-- Question 2

SELECT *
FROM income_data
LIMIT 10

-- Question 3

SELECT *
FROM income_data
WHERE income > 40000
LIMIT 10

-- Question 4

SELECT *
FROM income_data
WHERE income > 40000
AND income < 60000
LIMIT 10

-- Question 5

SELECT *
FROM income_data
WHERE income > 40000
AND income < 60000
AND `Zip / Population` LIKE '90%'
LIMIT 10

-- Question 6

SELECT *
FROM income_data
WHERE income > 100000
LIMIT 10

-- Question 7

-- Let’s write a query to create a separate column for the zip code

SELECT income,
        `Zip / Population`,
        LEFT(`Zip / Population`,5) AS ZIP
FROM income_data
LIMIT 10

-- Question 8

SELECT income,
        `Zip / Population`,
        LEFT(`Zip / Population`,5) AS income_zip,
        postal_data.zip AS postal_zip,
        city
FROM income_data, postal_data
WHERE LEFT(`Zip / Population`,5) = postal_data.zip
LIMIT 10

-- Question 9

SELECT AVG(income), city
FROM income_data, postal_data
WHERE LEFT(`Zip / Population`,5) = postal_data.zip
GROUP BY city
LIMIT 10

-- Question 10

SELECT AVG(income), city
FROM income_data, postal_data
WHERE LEFT(`Zip / Population`,5) = postal_data.zip
GROUP BY city
ORDER BY AVG(income) DESC
LIMIT 10