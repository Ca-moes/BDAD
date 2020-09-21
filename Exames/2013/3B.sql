Select hostname, B.descricao, P.nome 
From Servidor S, AplicacaoServidor Q, Aplicacao A, Bug B, Pessoa P
Where S.idServidor = Q.idServidor and Q.idAplicacao = A.idAplicacao and B.idAplicacao = A.idAplicacao and S.idResponsavel = P.idPessoa
and B.vulnerabilidade = 'sim'
Order by hostname; 