DROP TRIGGER IF EXISTS gatilho;

CREATE TRIGGER gatilho
AFTER INSERT ON Estudante
BEGIN
    INSERT INTO Amizades VALUES (New.ID, (SELECT E.ID
                                            FROM Estudante E
                                            WHERE New.ID<>E.ID AND New.curso=E.curso));
    INSERT INTO Amizades VALUES ((SELECT E.ID
                                    FROM Estudante E
                                    WHERE New.ID<>E.ID AND New.curso=E.curso), New.ID);
END;