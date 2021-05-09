--para ejecutar el script
--@C:\SQL\tema5.sql

--Conexion al sistema
CONNECT SYSTEM/admin;

--Si existe el usuario, eliminar
DROP USER matias CASCADE;

--Creacion del usuario
CREATE USER matias IDENTIFIED BY admin DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;

--Asignacion de permisos
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE ANY INDEX, CREATE VIEW, CREATE TRIGGER TO matias;

--desconectar usuario SYSTEM
DISCONNECT;

--Iniciar sesion usuario
CONNECT matias/admin;

--formato fecha
alter session set nls_date_format='dd-mm-yyyy';
--Tabla alumno
CREATE TABLE ALUMNO(
       CODIGO INTEGER,
       CI VARCHAR2(20) NOT NULL,
       PRIMER_NOMBRE VARCHAR2(20) NOT NULL,
       SEGUNDO_NOMBRE VARCHAR2(20),
       PRIMER_APELLIDO VARCHAR2(20) NOT NULL,
       SEGUNDO_APELLIDO VARCHAR2(20),
       FECHA_NACIMIENTO DATE NOT NULL,
       TELEFONO VARCHAR2(15) NOT NULL,
       DIRECCION VARCHAR2(150) NOT NULL,
       EMAIL VARCHAR2(50),
       ESTADO CHAR(1) NOT NULL,
       CONSTRAINT ALUMNO_PK PRIMARY KEY(CODIGO),
       CONSTRAINT ALUMNO_ESTADO CHECK (ESTADO IN('A', 'I'))
);

--secuencia para CODIGO de la tabla ALUMNO
CREATE SEQUENCE ALUMNO_CODIGO_SEQ
       START WITH 1
       INCREMENT BY 1;

--Creando la tabla carrera
CREATE TABLE CARRERA(
       CODIGO INTEGER,
       NOMBRE VARCHAR2(50) NOT NULL,
       FECHA_CREACION DATE NOT NULL,
       NUM_RESOLUCION VARCHAR2(20) NOT NULL,
       DURACION INTEGER NOT NULL,
       ES_ACREDITADA CHAR(1) NOT NULL,
       ESTADO CHAR(1) NOT NULL,
       CONSTRAINT CARRERA_PK PRIMARY KEY(CODIGO),
       CONSTRAINT CARRERA_ES_ACREDITADA CHECK(ES_ACREDITADA IN('S', 'N')),
       CONSTRAINT CARRERA_ESTADO CHECK(ESTADO IN('A', 'C'))
);

--secuencia para CODIGO de la tabla CARRERA
CREATE SEQUENCE CARRERA_CODIGO_SEQ
       START WITH 1
       INCREMENT BY 1;

--creando la tabla ALUMNO_CARRERA
CREATE TABLE ALUMNO_CARRERA(
       COD_ALUMNO INTEGER NOT NULL,
       COD_CARRERA INTEGER NOT NULL,
       FECHA_INGRESO DATE NOT NULL,
       FECHA_EGRESO DATE NOT NULL,
       ESTADO CHAR(1) NOT NULL,
       CONSTRAINT ALUMNO_CARRERA_PK PRIMARY KEY(COD_ALUMNO, COD_CARRERA),
       CONSTRAINT ALUMNO_CARRERA_COD_ALUMNO_FK FOREIGN KEY (COD_ALUMNO) REFERENCES ALUMNO(CODIGO),
       CONSTRAINT ALUMNO_CARRERA_COD_CARRERA_FK FOREIGN KEY (COD_CARRERA) REFERENCES CARRERA(CODIGO),
       CONSTRAINT ALUMNO_CARRERA_ESTADO CHECK(ESTADO IN('T', 'A', 'X', 'C'))
);

--creando la tabla MATERIA
CREATE TABLE MATERIA(
       CODIGO INTEGER,
       NOMBRE VARCHAR2(50) NOT NULL,
       CONSTRAINT MATERIA_PK PRIMARY KEY(CODIGO)
);

--secuencia para CODIGO de la tabla MATERIA
CREATE SEQUENCE MATERIA_CODIGO_SEQ
       START WITH 1
       INCREMENT BY 1;

--creando la tabla carrera_materia
CREATE TABLE CARRERA_MATERIA(
       COD_MATERIA INTEGER NOT NULL,
       COD_CARRERA INTEGER NOT NULL,
       SEMESTRE INTEGER NOT NULL,
       COSTO INTEGER NOT NULL,
       CONSTRAINT CARRERA_MATERIA_PK PRIMARY KEY (COD_MATERIA, COD_CARRERA),
       CONSTRAINT CARRERA_MATERIA_COD_MATERIA_FK FOREIGN KEY (COD_MATERIA) REFERENCES MATERIA(CODIGO),
       CONSTRAINT CARRERA_MATERIA_COD_CARRERA_FK FOREIGN KEY (COD_CARRERA) REFERENCES CARRERA(CODIGO),
       CONSTRAINT CARRERA_SEMESTRE CHECK(SEMESTRE BETWEEN 1 AND 10)
);

--Creando la tabla matriculacion
CREATE TABLE MATRICULACION(
       COD_ALUMNO INTEGER NOT NULL,
       COD_MATERIA INTEGER NOT NULL,
       ANHO INTEGER NOT NULL,
       NUM_SEMESTRE INTEGER NOT NULL,
       FECHA_MATRIC DATE NOT NULL,
       SITUACION CHAR(1) NOT NULL,
       CONSTRAINT MATRICULACION_PK PRIMARY KEY(COD_ALUMNO, COD_MATERIA, NUM_SEMESTRE),
       CONSTRAINT MATRICULACION_COD_ALUMNO_FK FOREIGN KEY(COD_ALUMNO) REFERENCES ALUMNO(CODIGO),
       CONSTRAINT MATRICULACION_COD_MATERIA_FK FOREIGN KEY(COD_MATERIA) REFERENCES MATERIA(CODIGO),
       CONSTRAINT MATRICULACION_NUM_SEMESTRE CHECK(NUM_SEMESTRE BETWEEN 1 AND 2),
       CONSTRAINT MATRICULACION_SITUACION CHECK(SITUACION IN('C', 'X', 'A'))
);
