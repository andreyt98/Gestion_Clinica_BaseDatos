CREATE TABLE Pacientes(
	Id_Paciente INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(30) NOT NULL,
	Email VARCHAR(30),
	Tel VARCHAR(20) NOT NULL, 
);

CREATE TABLE Especialidad(
	Id_Especialidad INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(30)
);

CREATE TABLE Medicos(
	Id_Medico INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(30) NOT NULL,
	Email VARCHAR(30),
	Id_Especialidad INT NOT NULL,
	Tel VARCHAR(20) NOT NULL,

	CONSTRAINT [Especialidad_FK] FOREIGN KEY (Id_Especialidad) REFERENCES Especialidad (Id_Especialidad)
);


CREATE TABLE Citas(
	Id_Citas INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Id_Paciente INT NOT NULL,
	Id_Medico INT NOT NULL,
	Fecha DATE NOT NULL,
	HoraInicio TIME NOT NULL,
	HoraFinal TIME NOT NULL,

	CONSTRAINT [Paciente_FK] FOREIGN KEY (Id_Paciente) REFERENCES Pacientes (Id_Paciente),
	CONSTRAINT [Medico_FK] FOREIGN KEY (Id_Medico) REFERENCES Medicos (Id_Medico),

	CONSTRAINT [Check_HoraInicio] CHECK (HoraInicio >= '9:00'),
	CONSTRAINT [Check_HoraFinal] CHECK (HoraFinal <= '15:45')
);
