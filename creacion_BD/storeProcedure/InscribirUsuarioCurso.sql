CREATE PROCEDURE sp_InscribirUsuarioCurso
    @IDUsuario INT,
    @IDCurso INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Curso WHERE IDCurso = @IDCurso)
    BEGIN
        RAISERROR('El curso indicado no existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM Inscripcion
        WHERE IDUsuario = @IDUsuario AND IDCurso = @IDCurso
    )
    BEGIN
        RAISERROR('El usuario ya esta inscripto en este curso.', 16, 1);
        RETURN;
    END

    INSERT INTO Inscripcion (IDUsuario, IDCurso, fechaInscripcion)
    VALUES (@IDUsuario, @IDCurso, GETDATE());
END;
GO
