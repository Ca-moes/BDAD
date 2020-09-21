SELECT DISTINCT Estudante.nome as nome, Estudante.anoCurricular as "Ano Curricular"
FROM Estudante, Amizade
WHERE Estudante.ID = Amizade.ID1 AND NOT EXISTS 
    (SELECT * FROM Amizade A, Estudante E 
    WHERE Estudante.ID = A.ID1 AND A.ID2 = E.ID AND Estudante.anoCurricular <> E.anoCurricular )
ORDER BY Estudante.anoCurricular ASC, Estudante.nome ASC;