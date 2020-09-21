---
Create Trigger name
Before | After | Instead Of events
[ referencing-variables]
[ For Each Row ]
When ( condition)
action
---

CREATE TRIGGER alineac
AFTER INSERT ON ReparacaoPeca
BEGIN
UPDATE Peca
SET quantidade = quantidade - New.quantidade
WHERE idPeca = New.idPeca;
END;

CREATE TRIGGER alineaa
AFTER INSERT ON Reparacao
WHEN (New.idCliente IS NULL)
BEGIN
UPDATE Reparacao
SET idCliente = (SELECT idCliente FROM Carro WHERE idCarro = New.idCarro)
WHERE idReparacao = New.idReparacao;
END;

CREATE TRIGGER alineab
BEFORE INSERT ON ReparacaoPeca
WHEN New.idPeca NOT IN 
(SELECT idPeca 
FROM PecaModelo 
WHERE idModelo = (SELECT idModelo FROM Carro WHERE idCarro = (SELECT idCarro FROM Reparacao WHERE idReparacao = New.idReparacao)))
OR
New.idPeca IN
(SELECT idPeca
FROM Peca
WHERE quantidade < New.quantidade)
BEGIN
SELECT RAISE(IGNORE);
END;


CREATE TRIGGER Clinica2A
BEFORE INSERT ON ConsultasMarcadas
WHEN New.codmedico NOT IN (
SELECT codigo
FROM Disponibilidade
WHERE dia = New.data AND codigo NOT IN (
SELECT codmedico
FROM ConsultasMarcadas
WHERE data = New.data
GROUP BY codmedico
HAVING COUNT(*) >= (SELECT numdoentes 
FROM HorarioConsultas AS HC, Disponibilidade AS D 
WHERE HC.idhorarioconsulta = D.idhorarioconsulta AND
D.dia = data AND D.codigo = codmedico)))
BEGIN
SELECT RAISE(IGNORE);
END;

CREATE TRIGGER Clinica2B
BEFORE INSERT ON ConsultasMarcadas
WHEN New.horainicio IN (SELECT horainicio
FROM ConsultasMarcadas
WHERE data = New.data AND codmedico = New.codmedico AND horainicio = New.horainicio)
BEGIN
SELECT RAISE(IGNORE);
END;