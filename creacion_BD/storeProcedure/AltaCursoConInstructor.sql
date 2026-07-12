CREATE PROCEDURE sp_AltaCursoConInstructor
    @IDRol INT,
    @Nombre VARCHAR(50),
    @Descripcion VARCHAR(255),
    @DuracionHoras INT,
    @IDInstructor INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Curso (IDRol, nombre, descripcion, duracionhoras)
        VALUES (@IDRol, @Nombre, @Descripcion, @DuracionHoras);

        DECLARE @IDCursoNuevo INT = SCOPE_IDENTITY();

        INSERT INTO CursoInstructor (IDCurso, IDInstructor)
        VALUES (@IDCursoNuevo, @IDInstructor);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
