{{
    config(
        materialized='table',
        file_format='delta'
    )
}}
SELECT
    carat,
    cut,
    color,
    clarity
FROM workspace.default.diamonds
