CREATE VIEW vista_CursosConInstructores AS
SELECT
    C.IDCurso,
    C.nombre AS NombreCurso,
    I.nombre + ' ' + I.apellido AS Instructor
FROM Curso AS C
INNER JOIN CursoInstructor AS CI ON CI.IDCurso = C.IDCurso
INNER JOIN Instructor AS I ON I.IDInstructor = CI.IDInstructor;
GO
