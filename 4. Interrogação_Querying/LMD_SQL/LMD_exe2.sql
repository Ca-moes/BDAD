-- Exercice 2 a-g n-p s-x
-- a. 
SELECT *
FROM Peca
WHERE custoUnitario < 10 AND codigo LIKE '%98%';

-- b. 
SELECT * 
FROM Reparacao 
WHERE (dataInicio>='2010-09-01' AND dataFim<='2010-09-30');
