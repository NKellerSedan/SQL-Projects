SELECT * FROM dbo.playlist;

-- 1. How many tracks were added each day (confirm that each day had 50 added tracks)

SELECT DISTINCT track_add_date, COUNT(track_add_date) AS 'Num of Tracks Added' FROM playlist
GROUP BY track_add_date;


-- 2. Average, min, max number of tracks on an album

SELECT MIN(number_of_tracks_in_album) AS 'Least Tracks', MAX(number_of_tracks_in_album) AS 'Most Tracks', AVG(number_of_tracks_in_album) AS 'Average Tracks' FROM playlist;


-- 3. Longest, Shortest, average track duration

--Milliseconds
SELECT MIN(track_duration_ms) AS 'Shortest Duration (MS)', MAX(track_duration_ms) AS 'Longest Duration (MS)', AVG(track_duration_ms) AS 'Average Duration (MS)' FROM playlist;


-- 3.5. Display Longest, Shortest, average track duration as Minutes

--Minutes
WITH track_durations(track_duration_ms) AS (
	SELECT CAST(track_duration_ms AS NUMERIC)%(1000*60*60)/(1000*60)
 AS 'Track Minutes' FROM playlist)

SELECT MIN(track_duration_ms) AS 'Shortest Duration', MAX(track_duration_ms) AS 'Longest Duration', AVG(track_duration_ms) AS 'Average Duration' FROM track_durations;


-- 4. top 3 artists with most tracks

SELECT TOP(3) name_of_artists, COUNT(track_name) AS tracks FROM playlist
GROUP BY name_of_artists
ORDER BY tracks DESC;


-- 5. top 3 popular artists and their most popular track

SELECT TOP(3) name_of_artists, SUM(track_popularity) AS "Popularity", track_name AS tracks FROM playlist
GROUP BY name_of_artists, track_name
ORDER BY "Popularity" DESC;


-- 6. comparison between solo artist vs multiple artists

SELECT
	SUM(CASE WHEN multiple_artists_bool = 0 THEN 1 ELSE 0 END) AS 'Solo',
    SUM(CASE WHEN multiple_artists_bool >= 1 THEN 1 ELSE 0 END) AS 'Multiple'  
FROM playlist;


-- 7. top 10 popular tracks

WITH ranking(track_name, track_popularity, Rank) AS  (
SELECT DISTINCT track_name, 
       track_popularity,  
       DENSE_RANK() OVER(PARTITION BY track_name ORDER BY track_popularity DESC) AS Rank
FROM playlist
)

SELECT TOP(10) track_name, track_popularity FROM ranking
WHERE Rank = 1
ORDER BY track_popularity DESC;