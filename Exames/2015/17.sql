DROP VIEW IF EXISTS friends;
CREATE VIEW friends AS
SELECT user2 AS friend 
FROM User, Friend 
WHERE name = "Daniel Ramos" AND user1 = id;

DROP VIEW IF EXISTS friendFromFriends;
CREATE VIEW friendFromFriends AS
SELECT user2 
FROM friends, Friend 
WHERE user1 = friend;

SELECT DISTINCT caption 
FROM Photo, AppearsIn 
WHERE id = photo 
AND (AppearsIn.user IN (
    SELECT id 
    FROM User 
    WHERE name LIKE 'Daniel Ramos') 
OR AppearsIn.user IN friends 
OR AppearsIn.user IN friendFromFriends);