DROP VIEW IF EXISTS friends;
CREATE VIEW friends AS
    SELECT ID2 as amigo
    FROM Amizade, Estudante
    WHERE Estudante.nome LIKE 'Miguel Sampaio' AND ID=ID1;

DROP VIEW IF EXISTS friends2;
CREATE VIEW friends2 AS
    SELECT ID2 as amigoamigo
    FROM Amizade, friends
    WHERE ID1=amigo;

DROP VIEW IF EXISTS friends3;
CREATE VIEW friends3 AS
    SELECT ID2 as amigoamigoamigo
    FROM Amizade, friends2
    WHERE ID1=amigoamigo;

SELECT DISTINCT * FROM friends3;