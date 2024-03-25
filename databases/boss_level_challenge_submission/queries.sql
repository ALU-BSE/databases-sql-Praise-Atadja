-- 1. Find all distinct genres of tracks.
SELECT DISTINCT GenreId, Name FROM Genre;

-- 2. Find the total number of tracks in each genre.
SELECT GenreId, COUNT(TrackId) AS TotalTracks FROM Track GROUP BY GenreId;

-- 3. Find the total length of all tracks in each genre.
SELECT g.Name AS Genre, SUM(t.Milliseconds) AS TotalMilliseconds
FROM Track t
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name;

-- 4. Find the average length of tracks in each genre.
SELECT g.Name AS Genre, AVG(t.Milliseconds) AS AverageMilliseconds
FROM Track t
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name;

-- 5. Find the longest track in each genre.
SELECT g.Name AS Genre, MAX(t.Milliseconds) AS LongestMilliseconds
FROM Track t
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name;

-- 6. Find the shortest track in each genre.
SELECT g.Name AS Genre, MIN(t.Milliseconds) AS ShortestMilliseconds
FROM Track t
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name;

-- 7. Find all tracks that are longer than the average length of tracks.
SELECT *
FROM Track
WHERE Milliseconds > (SELECT AVG(Milliseconds) FROM Track);

-- 8. Find all tracks that are shorter than the average length of tracks.
SELECT *
FROM Track
WHERE Milliseconds < (SELECT AVG(Milliseconds) FROM Track);

-- 9. Find all albums of a specific artist.
SELECT * FROM Album WHERE ArtistId = (SELECT ArtistId FROM Artist WHERE Name = 'ArtistName');

-- 11. Find all artists who have less than 10 albums.
SELECT ArtistId, Name
FROM Artist
WHERE ArtistId IN (SELECT ArtistId FROM Album GROUP BY ArtistId HAVING COUNT(*) < 10);

-- 12. Find all artists who have exactly 10 albums.
SELECT ArtistId, Name
FROM Artist
WHERE ArtistId IN (SELECT ArtistId FROM Album GROUP BY ArtistId HAVING COUNT(*) = 10);

-- 13. Find all albums that have more than 10 tracks.
SELECT AlbumId, Title
FROM Album
WHERE AlbumId IN (SELECT AlbumId FROM Track GROUP BY AlbumId HAVING COUNT(*) > 10);

-- 14. Find all albums that have less than 10 tracks.
SELECT AlbumId, Title
FROM Album
WHERE AlbumId IN (SELECT AlbumId FROM Track GROUP BY AlbumId HAVING COUNT(*) < 10);

-- 15. Find all albums that have exactly 10 tracks.
SELECT AlbumId, Title
FROM Album
WHERE AlbumId IN (SELECT AlbumId FROM Track GROUP BY AlbumId HAVING COUNT(*) = 10);

-- 16. Find the total length of all tracks in each album.
SELECT a.Title AS AlbumTitle, SUM(t.Milliseconds) AS TotalMilliseconds
FROM Album a
INNER JOIN Track t ON a.AlbumId = t.AlbumId
GROUP BY a.Title;

-- 17. Find the average length of tracks in each album.
SELECT a.Title AS AlbumTitle, AVG(t.Milliseconds) AS AverageMilliseconds
FROM Album a
INNER JOIN Track t ON a.AlbumId = t.AlbumId
GROUP BY a.Title;

-- 18. Find the longest track in each album.
SELECT a.Title AS AlbumTitle, MAX(t.Milliseconds) AS LongestMilliseconds
FROM Album a
INNER JOIN Track t ON a.AlbumId = t.AlbumId
GROUP BY a.Title;

-- 19. Find the shortest track in each album.
SELECT a.Title AS AlbumTitle, MIN(t.Milliseconds) AS ShortestMilliseconds
FROM Album a
INNER JOIN Track t ON a.AlbumId = t.AlbumId
GROUP BY a.Title;
