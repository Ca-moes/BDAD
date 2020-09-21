DROP VIEW IF EXISTS numAmigos;
CREATE VIEW numAmigos AS
    SELECT ID, count(ID2) as num
    FROM Estudante, Amizade
    WHERE ID=ID1
    GROUP BY ID1
    ORDER BY num DESC;

SELECT nome, anoCurricular
FROM Estudante NATURAL JOIN numAmigos
WHERE num = (SELECT max(num) FROM numAmigos);