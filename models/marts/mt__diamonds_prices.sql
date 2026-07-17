SELECT
    color,
    avg(price) AS price
FROM workspace.default.diamonds
GROUP BY color
ORDER BY price DESC
