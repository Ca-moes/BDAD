.width 17

SELECT Estudante.nome as Estudante, Curso.nome as Curso
FROM Estudante, Curso
WHERE anoCurricular = 3 AND Estudante.curso=Curso.ID;