CREATE TRIGGER tr_EmitirCertificado
ON ResultadoEvaluacion
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Certificado (IDResultado)
    SELECT i.IDResultado
    FROM inserted i
    WHERE i.aprobado = 1
      AND NOT EXISTS (
          SELECT 1 FROM Certificado c WHERE c.IDResultado = i.IDResultado
      );
END;
GO
