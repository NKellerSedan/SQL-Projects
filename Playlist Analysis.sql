SELECT * FROM dbo.playlist;

-- 1. How many tracks were added each day (confirm that each day had 50 added tracks)

SELECT DISTINCT track_add_date, COUNT(track_add_date) AS 'Number of Tracks Added' FROM playlist
GROUP BY track_add_date