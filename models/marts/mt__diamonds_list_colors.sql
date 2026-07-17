SELECT DISTINCT color
FROM {{ ref('mt__diamonds_four_cs') }}
SORT BY color ASC
