CREATE TRIGGER tr_ImpedirCertificadoInvalido
ON Certificado
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN ResultadoEvaluacion re ON re.IDResultado = i.IDResultado
        WHERE re.aprobado = 0
    )
    BEGIN
        RAISERROR('No se puede emitir un certificado para un resultado no aprobado.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
