SELECT hostname, nome
FROM Servidor JOIN Pessoa
WHERE Servidor.idResponsavel = Pessoa.idPessoa AND vulneravel='sim';