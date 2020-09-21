SELECT E1.nome
FROM Estudante E1, Estudante E2, Amizade A
WHERE E1.ID=A.ID1 AND E2.ID=A.ID2
GROUP BY E1.ID
HAVING count(DISTINCT E2.anoCurricular)=5;