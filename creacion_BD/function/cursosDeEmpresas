CREATE FUNCTION fn_CursosDeEmpresa (@IDEmpresa INT)
RETURNS TABLE
AS
RETURN (
    SELECT C.IDCurso, C.nombre, C.descripcion, C.duracionhoras
    FROM Curso AS C
    INNER JOIN Roles AS R ON R.IDRol = C.IDRol
    WHERE R.IDEmpresa = @IDEmpresa
);
GO
