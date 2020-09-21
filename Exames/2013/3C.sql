SELECT hostname
FROM Servidor S, Pessoa P
WHERE S.idResponsavel = P.idPessoa AND hostname LIKE 'alu%' AND P.mail = 'joao.almeida@cica.pt' AND
EXISTS (SELECT *
        FROM Servidor S, AplicacaoServidor Q, Bug B
        WHERE S.idServidor = Q.idServidor and B.idAplicacao = Q.idAplicacao);