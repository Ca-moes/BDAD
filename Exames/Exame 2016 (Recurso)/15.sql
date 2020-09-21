DROP VIEW IF EXISTS gabfriends;
CREATE VIEW gabfriends AS
    SELECT ID1
    FROM Estudante, Amizade
    WHERE ID2=ID AND nome LIKE 'Gabriel%';

SELECT nome
FROM Estudante, gabfriends
WHERE ID1=ID;