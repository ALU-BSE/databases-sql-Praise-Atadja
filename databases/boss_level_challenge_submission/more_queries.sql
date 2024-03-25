-- 1. Stored Procedure to find the total number of tracks in each genre:
DELIMITER //
CREATE PROCEDURE TotalTracksPerGenre()
BEGIN
    -- Selects genre name and counts tracks for each genre
    SELECT g.Name AS Genre, COUNT(t.TrackId) AS TotalTracks
    FROM Genre g
    LEFT JOIN Track t ON g.GenreId = t.GenreId
    GROUP BY g.GenreId;
END //
DELIMITER ;

-- 2. Function to find the average length of tracks in each genre:
DELIMITER //
CREATE FUNCTION AvgTrackLengthPerGenre(genre_id INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE avg_length DECIMAL(10,2);
    -- Calculates average track length for a given genre
    SELECT AVG(Milliseconds) INTO avg_length
    FROM Track
    WHERE GenreId = genre_id;
    RETURN avg_length;
END //
DELIMITER ;

-- 3. Trigger to update the Composer field to 'Unknown' before any insert operation on the Tracks table if the Composer field is not provided:
CREATE TRIGGER BeforeInsertTrack
BEFORE INSERT ON Track
FOR EACH ROW
BEGIN
    -- Checks if Composer field is NULL, if yes, sets it to 'Unknown'
    IF NEW.Composer IS NULL THEN
        SET NEW.Composer = 'Unknown';
    END IF;
END;

-- 4. View that shows the track name, album title, and artist name:
CREATE VIEW TrackInfo AS
-- Joins Track, Album, and Artist tables to display track information
SELECT t.Name AS TrackName, a.Title AS AlbumTitle, ar.Name AS ArtistName
FROM Track t
INNER JOIN Album a ON t.AlbumId = a.AlbumId
INNER JOIN Artist ar ON a.ArtistId = ar.ArtistId;

-- 5. Stored Procedure to find all albums of a specific artist:
DELIMITER //
CREATE PROCEDURE AlbumsByArtist(artist_name VARCHAR(255))
BEGIN
    -- Selects album titles by a given artist name
    SELECT a.Title AS AlbumTitle
    FROM Album a
    INNER JOIN Artist ar ON a.ArtistId = ar.ArtistId
    WHERE ar.Name = artist_name;
END //
DELIMITER ;

-- 6. Function to find the total number of albums by a specific artist:
DELIMITER //
CREATE FUNCTION TotalAlbumsByArtist(artist_id INT) RETURNS INT
BEGIN
    DECLARE total_albums INT;
    -- Counts total albums by a given artist ID
    SELECT COUNT(AlbumId) INTO total_albums
    FROM Album
    WHERE ArtistId = artist_id;
    RETURN total_albums;
END //
DELIMITER ;

-- 7. Trigger to update the Title field to 'Untitled' before any insert operation on the Albums table if the Title field is not provided:
CREATE TRIGGER BeforeInsertAlbum
BEFORE INSERT ON Album
FOR EACH ROW
BEGIN
    -- Checks if Title field is NULL, if yes, sets it to 'Untitled'
    IF NEW.Title IS NULL THEN
        SET NEW.Title = 'Untitled';
    END IF;
END;

-- 8. View that shows the album title and the name of its artist:
CREATE VIEW AlbumArtistInfo AS
-- Joins Album and Artist tables to display album information along with artist name
SELECT a.Title AS AlbumTitle, ar.Name AS ArtistName
FROM Album a
INNER JOIN Artist ar ON a.ArtistId = ar.ArtistId;

-- 9. Stored Procedure to find all customers from a specific country:
DELIMITER //
CREATE PROCEDURE CustomersByCountry(country_name VARCHAR(255))
BEGIN
    -- Selects customer names by a given country name
    SELECT FirstName, LastName
    FROM Customer
    WHERE Country = country_name;
END //
DELIMITER ;

-- 10. Function to find the total number of customers from a specific country:
DELIMITER //
CREATE FUNCTION TotalCustomersByCountry(country_name VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE total_customers INT;
    -- Counts total customers by a given country name
    SELECT COUNT(CustomerId) INTO total_customers
    FROM Customer
    WHERE Country = country_name;
    RETURN total_customers;
END //
DELIMITER ;

-- 11. Trigger to update the Country field to 'Unknown' before any insert operation on the Customers table if the Country field is not provided:
CREATE TRIGGER BeforeInsertCustomer
BEFORE INSERT ON Customer
FOR EACH ROW
BEGIN
    -- Checks if Country field is NULL, if yes, sets it to 'Unknown'
    IF NEW.Country IS NULL THEN
        SET NEW.Country = 'Unknown';
    END IF;
END;

--12. View that shows the customer name and their country:
CREATE VIEW CustomerCountryInfo AS
-- Displays customer names along with their countries
SELECT CONCAT(FirstName, ' ', LastName) AS CustomerName, Country
FROM Customer;

--13. Stored Procedure to find all employees who are sales agents:
DELIMITER //
CREATE PROCEDURE SalesAgents()
BEGIN
    -- Selects sales agents' names
    SELECT FirstName, LastName
    FROM Employee
    WHERE Title = 'Sales Support Agent';
END //
DELIMITER ;

--14. Function to find the total number of sales agents:
DELIMITER //
CREATE FUNCTION TotalSalesAgents() RETURNS INT
BEGIN
    DECLARE total_agents INT;
    -- Counts total sales agents
    SELECT COUNT(EmployeeId) INTO total_agents
    FROM Employee
    WHERE Title = 'Sales Support Agent';
    RETURN total_agents;
END //
DELIMITER ;

--15. Trigger to update the Title field to 'Employee' before any insert operation on the Employees table if the Title field is not provided:
CREATE TRIGGER BeforeInsertEmployee
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    -- Checks if Title field is NULL, if yes, sets it to 'Employee'
    IF NEW.Title IS NULL THEN
        SET NEW.Title = 'Employee';
    END IF;
END;

--16. View that shows the employee name and their title:
CREATE VIEW EmployeeTitleInfo AS
-- Displays employee names along with their titles
SELECT CONCAT(FirstName, ' ', LastName) AS EmployeeName, Title
FROM Employee;

--17. Stored Procedure to find all playlists that have more than 10 tracks:
DELIMITER //
CREATE PROCEDURE PlaylistsWithMoreThan10Tracks()
BEGIN
    -- Selects playlists with more than 10 tracks
    SELECT Name
    FROM Playlist
    WHERE PlaylistId IN (SELECT PlaylistId FROM PlaylistTrack GROUP BY PlaylistId HAVING COUNT(TrackId) > 10);
END //
DELIMITER ;

--18. Function to find the average number of tracks in each playlist:
DELIMITER //
CREATE FUNCTION AvgTracksPerPlaylist() RETURNS DECIMAL(10,2)
BEGIN
    DECLARE avg_tracks DECIMAL(10,2);
    -- Calculates the average number of tracks per playlist
    SELECT AVG(track_count) INTO avg_tracks
    FROM (
        SELECT COUNT(TrackId) AS track_count
        FROM PlaylistTrack
        GROUP BY PlaylistId
    ) AS playlist_tracks;
    RETURN avg_tracks;
END //
DELIMITER ;

--19. Trigger to update the Name field to 'Untitled' before any insert operation on the Playlists table if the Name field is not provided:
CREATE TRIGGER BeforeInsertPlaylist
BEFORE INSERT ON Playlist
FOR EACH ROW
BEGIN
    -- Checks if Name field is NULL, if yes, sets it to 'Untitled'
    IF NEW.Name IS NULL THEN
        SET NEW.Name = 'Untitled';
    END IF;
END;

--20. View that shows the playlist name and the number of tracks in it:
CREATE VIEW
