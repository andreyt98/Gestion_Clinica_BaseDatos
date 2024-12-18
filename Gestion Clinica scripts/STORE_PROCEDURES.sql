USE [Gestion_Clinica]

GO
------SP PARA OBTENER DATOS-------
--Obtener Pacientes
CREATE PROCEDURE ObtenerPacientes
AS
BEGIN
	SELECT * FROM Pacientes;
END;
GO

EXEC ObtenerPacientes;
GO

-- Obtener Especialidades
CREATE PROCEDURE ObtenerEspecialidad
AS
BEGIN
	SELECT * FROM Especialidad;
END;
GO

EXEC ObtenerEspecialidad;
GO

--Obtener Medicos
CREATE PROCEDURE ObtenerMedicos
AS
BEGIN
	SELECT * FROM Medicos;
END;
GO

EXEC ObtenerMedicos;
GO

--Obtener Citas
CREATE PROCEDURE ObtenerCitas
AS
BEGIN
	SELECT * FROM Citas;
END;
GO

EXEC ObtenerCitas;
GO


------SP PARA GUARDAR DATOS-------

--Guardar Pacientes
CREATE PROCEDURE GuardarPaciente @CedulaPaciente VARCHAR(30), @Nombre VARCHAR(30), @Email VARCHAR(30), @Tel VARCHAR(20)
AS
BEGIN
	INSERT INTO Pacientes (CedulaPaciente, Nombre, Email, Tel) VALUES (@CedulaPaciente,@Nombre, @Email, @Tel);
END
GO

--Guardar Especialidad
CREATE PROCEDURE GuardarEspecialidad @Nombre VARCHAR(30)
AS
BEGIN
	INSERT INTO Especialidad ( Nombre ) VALUES (@Nombre);
END

GO

--Guardar Medicos
CREATE PROCEDURE GuardarCita @CED_PacienteCita VARCHAR(30),@Id_MedicoCita INT,  @Id_Paciente INT, @Id_Medico INT, @Fecha DATE, @HoraInicio TIME, @HoraFinal TIME
AS
BEGIN
IF @Fecha < CAST(GETDATE() AS DATE) THROW 50003, 'La fecha seleccionada no puede ser anterior a la actual',1;
IF @HoraInicio > @HoraFinal THROW 50002, 'La hora de inicio no puede ser mayor que la hora de fin de cita',1;

IF EXISTS(SELECT 1 FROM Pacientes WHERE CedulaPaciente = @CED_PacienteCita)
	BEGIN
		IF EXISTS(SELECT 1 FROM Citas WHERE Id_Medico = @Id_MedicoCita) AND
			EXISTS(
			SELECT 1 FROM Citas WHERE
			(@HoraInicio BETWEEN HoraInicio AND HoraFinal) OR (@HoraFinal BETWEEN HoraInicio AND HoraFinal) 
			OR
			(HoraInicio BETWEEN @HoraInicio AND @HoraFinal) OR (HoraFinal BETWEEN @HoraInicio AND @HoraFinal)		
		)
	
			THROW 50001, 'La hora seleccionada tiene conflictos con registros existentes',1;
			
		ELSE

			BEGIN
				INSERT INTO Citas (Id_Paciente, Id_Medico, Fecha,HoraInicio, HoraFinal) VALUES (@Id_Paciente,@Id_Medico, @Fecha,@HoraInicio, @HoraFinal ) ;				
			END;		
	END

ELSE
	THROW 50000, 'Paciente no registrado en la base de datos',1;
END
GO