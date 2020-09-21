DROP TRIGGER IF EXISTS newbug;

CREATE TRIGGER newbug
AFTER INSERT ON Bug
WHEN New.vulnerabilidade = 'sim'
BEGIN
    UPDATE Bug SET prioridade = 1 WHERE New.idBug = Bug.idBug;
    UPDATE Servidor SET vulnerabilidade = 'sim' WHERE Servidor.idAplicacao = (SELECT idServidor FROM AplicacaoServidor Q WHERE New.idAplicacao = Q.idAplicacao);
END;