DROP TRIGGER IF EXISTS Vulneravel;

CREATE TRIGGER Vulneravel
AFTER INSERT ON AplicacaoServidor
WHEN EXISTS (SELECT * FROM  Bug Where New.idAplicacao = Bug.idAplicacao and vulnerabilidade = 'sim')
BEGIN
    UPDATE Servidor SET vulnerabilidade = 'sim' WHERE Servidor.idServidor = New.idServidor;
END;