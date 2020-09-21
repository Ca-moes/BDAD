DROP TRIGGER IF EXISTS gatilho;

CREATE TRIGGER gatilho
AFTER INSERT ON AppearsIn
WHEN New.user NOT IN (SELECT user FROM Likes WHERE Likes.photo = New.photo)
BEGIN
    INSERT INTO Likes VALUES (New.user, New.photo);
END;
