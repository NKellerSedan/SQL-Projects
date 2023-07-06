SELECT * FROM dbo.playlist;

-- 1. How many tracks were added each day (confirm that each day had 50 added tracks)

SELECT DISTINCT track_add_date, COUNT(track_add_date) AS 'Num of Tracks Added' FROM playlist
GROUP BY track_add_date;


-- 2. Average, min, max number of tracks on an album

SELECT MIN(number_of_tracks_in_album) AS 'Least Tracks', MAX(number_of_tracks_in_album) AS 'Most Tracks', AVG(number_of_tracks_in_album) AS 'Average Tracks' FROM playlist;


-- 3. Longest, Shortest, average track duration

--Milliseconds
SELECT MIN(track_duration_ms) AS 'Shortest Duration (MS)', MAX(track_duration_ms) AS 'Longest Duration (MS)', AVG(track_duration_ms) AS 'Average Duration (MS)' FROM playlist;
