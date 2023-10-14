SELECT COUNT(*), rank
FROM play_characters
GROUP BY rank
HAVING COUNT(*) > 1;