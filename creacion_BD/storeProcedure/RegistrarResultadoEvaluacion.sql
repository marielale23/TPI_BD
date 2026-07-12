CREATE PROCEDURE sp_RegistrarResultadoEvaluacion
    @IDEvaluacion INT,
    @IDUsuario INT,
    @NotaObtenida INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @NotaObtenida NOT BETWEEN 0 AND 100
    BEGIN
        RAISERROR('La nota debe estar entre 0 y 100.', 16, 1);
        RETURN;
    END

    INSERT INTO ResultadoEvaluacion (IDEvaluacion, IDUsuario, notaObtenida, aprobado)
    VALUES (@IDEvaluacion, @IDUsuario, @NotaObtenida, 0);
END;
GO
