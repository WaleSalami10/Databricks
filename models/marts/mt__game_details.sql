{{ 
    config
    (
        materialized='table',
        file_format='delta'
    ) 
}}
-- Step 4 of 4: Replace the visitor team IDs with their city names.
SELECT
    game_id,
    home,
    t.team_city AS visitor,
    home_score,
    visitor_score,
    -- Step 3 of 4: Display the city name for each game's winner.
    game_date AS date,
    CASE
        WHEN
            home_score > visitor_score
            THEN
                home
        WHEN
            visitor_score > home_score
            THEN
                t.team_city
    END AS winner
FROM (
    -- Step 2 of 4: Replace the home team IDs with their actual city names.
    SELECT
        game_id,
        t.team_city AS home,
        home_score,
        visitor_team_id,
        visitor_score,
        game_date
    FROM (
    -- Step 1 of 4: Combine data from various tables (for example, game and team IDs, scores, dates).
        SELECT
            g.game_id,
            go.home_team_id,
            gs.home_team_score AS home_score,
            go.visitor_team_id,
            gs.visitor_team_score AS visitor_score,
            g.game_date
        FROM
            default.games AS g,
            default.game_opponents AS go,
            default.game_scores AS gs
        WHERE
            g.game_id = go.game_id
            AND g.game_id = gs.game_id
    ) AS all_ids,
        default.teams AS t
    WHERE
        all_ids.home_team_id = t.team_id
) AS visitor_ids,
    default.teams AS t
WHERE
    visitor_ids.visitor_team_id = t.team_id
ORDER BY game_date DESC
