PRAGMA foreign_keys = ON;

SELECT caption
FROM Photo NATURAL JOIN User
Where User.name 
LIKE 'Daniel Ramos' 
AND (julianday(Photo.uploadDate) - julianday(Photo.creationDate) = 2);