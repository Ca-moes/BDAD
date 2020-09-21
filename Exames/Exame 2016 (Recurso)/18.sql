SELECT DISTINCT E1.nome, E2.nome
FROM Estudante E1, Estudante E2, Amizade A
WHERE A.ID1=E1.ID AND A.ID2=E2.ID AND E1.curso<>E2.curso AND E1.ID < E2.ID;