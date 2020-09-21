SELECT nome
FROM Aplicacao A, Bug B
WHERE A.idAplicacao = B.idAplicacao
GROUP BY nome
ORDER BY count(*) DESC
LIMIT 1;