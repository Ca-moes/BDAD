SELECT nome As Nome
FROM Estudante, Amizade
WHERE ID = ID1
GROUP BY ID1
HAVING count(ID2)>3;