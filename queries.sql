-- Query all of the entries in the Genre table
SELECT * FROM Genre;

-- Using the INSERT statement, add one of your favorite artists to the Artist table.
INSERT INTO Artist (ArtistId, ArtistName, yearEstablished) 
VALUES(NULL, "Every Time I Die", 1999);

-- Using the INSERT statement, add one, or more, albums by your artist to the Album table.
INSERT INTO Album (AlbumId, Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) 
VALUES (NULL, "Hot Damn!", "01/01/2003", 2915, "Ferret", 
(SELECT ArtistId FROM Artist WHERE ArtistName = "Every Time I Die"),
(SELECT GenreId FROM Genre WHERE Label = "Heavy Metal"));

-- Using the INSERT statement, add some songs that are on that album to the Song table.
INSERT INTO Song (Title, SongLength, ReleaseDate, AlbumId, ArtistId, GenreId)
VALUES (NULL, "Floater", 255, "01/01/2003", 
(SELECT AlbumId FROM Album WHERE Title = "Hot Damn!"), 
(SELECT ArtistId FROM Artist WHERE ArtistName = "Every Time I Die"),
(SELECT GenreId FROM Genre WHERE Label = "Heavy Metal"));

-- Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added. Here is some more info on joins that might help.
SELECT s.Title "Title", al.Title "Album", ar.ArtistName "Artist"
FROM Song s 
LEFT JOIN Album al 
ON al.AlbumId = s.AlbumId
LEFT JOIN Artist ar
ON ar.ArtistId = s.ArtistId 
WHERE ar.ArtistName = "Every Time I Die"; 

-- Reminder: Direction of join matters. Try the following statements and see the difference in results.

-- SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.AlbumId;
-- SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.AlbumId;

-- Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT COUNT(Song.SongId) AS "Song Count", Album.Title AS "Album Title"
FROM Song
JOIN Album
ON Song.AlbumId = Album.AlbumId
GROUP BY Album.Title;

-- Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT COUNT(Song.SongId) AS "Song Count", Artist.ArtistName AS "Artist"
FROM Song
JOIN Artist
ON Song.ArtistId = Artist.ArtistId
GROUP BY Artist.ArtistName;

-- Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT COUNT(Song.SongId) AS "Song Count", Genre.Label AS "Genre"
FROM Song
JOIN Genre
ON Song.GenreId = Genre.GenreId
GROUP BY Genre.Label;

-- Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
SELECT MAX(Album.AlbumLength) AS "Album Length", Album.Title AS "Album Title"
FROM Album;

-- Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
SELECT MAX(Song.SongLength) AS "Song Length", Song.Title AS "Song Title"
FROM Song;

-- Modify the previous query to also display the title of the album.
SELECT MAX(Song.SongLength) AS "Song Length", 
Song.Title AS "Song Title", 
Album.Title AS "Album Title"
FROM Song
JOIN Album
ON Song.AlbumId = Album.AlbumId;
