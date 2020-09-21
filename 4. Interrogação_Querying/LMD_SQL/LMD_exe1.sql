-- 1. 
SELECT nr FROM aluno;
-- 2.
SELECT cod, design
FROM cadeira
WHERE curso='AC';
-- 3.
SELECT aluno.nome
FROM aluno, prof
WHERE aluno.nome = prof.nome;
-- 4.
SELECT aluno.nome
FROM aluno
WHERE aluno.nome NOT IN (SELECT nome from prof);
-- 5. 
SELECT nome
FROM aluno
UNION
SELECT nome
FROM prof;
-- 6. 
SELECT Nome 
FROM aluno 
JOIN 
(SELECT nr FROM prova WHERE cod='TS1' INTERSECT SELECT nr FROM aluno) using(nr);

SELECT nome 
FROM (SELECT DISTINCT nr AS prova_nr 
    FROM prova WHERE cod = 'TS1') 
LEFT JOIN aluno ON prova_nr = nr;
-- 7
SELECT nome
FROM aluno
WHERE aluno.nr IN (SELECT nr 
                from prova 
                NATURAL JOIN cadeira 
                WHERE cadeira.curso='IS');
-- 8
SELECT DISTINCT nome FROM Aluno WHERE nr NOT IN
(SELECT nr AS alunonr
FROM Aluno, Cadeira
WHERE curso='IS' AND NOT (cod IN
(SELECT cod
FROM Prova
WHERE nota>=10 AND nr=alunonr))
);


-- Exercice 2 a-g n-p s-x
-- a.
