--CREATE TABLE "Medicos"
--(
--  IdMedico int IDENTITY(1,1)
--, nombre VARCHAR(100)
--, domicilio VARCHAR(100)
--, localidad VARCHAR(100)
--, cdg_region BIGINT
--, region VARCHAR(100)
--, cdg_postal BIGINT
--, matricula BIGINT
--, cdg_esp1 VARCHAR(20)
--, cdg_esp2 VARCHAR(20)
--, rep VARCHAR(50)
--, cdg_zonapostal BIGINT
--, categoria BIGINT
--, descripcion VARCHAR(100)
--, ptotal_mer BIGINT
--, periodo VARCHAR(20)
--, prod VARCHAR(100)
--, val BIGINT
--, cdg_medico BIGINT
--)

CREATE TABLE FicheroMedico
(
  IdMedico int IDENTITY(1,1)
, lab_atc VARCHAR(10)
, stio BIGINT
, codigo_interno BIGINT
, nombre_doctor VARCHAR(100)
, nombre_cup VARCHAR(100)
, domicilio VARCHAR(150)
, categoria BIGINT
, representante VARCHAR(30)
, mv_q VARCHAR(50)
, vm_rx_mdo VARCHAR(100)
, vm_sector VARCHAR(50)
, vh_ciudad VARCHAR(50)
, region VARCHAR(20)
, cedula VARCHAR(50)
, clinica_hospital VARCHAR(50)
, cod_cup VARCHAR(20)
, cdg_med1 VARCHAR(20)
, vm_quintil VARCHAR(10)
, frecuencia VARCHAR(20)
, mm VARCHAR(20)
, cdg_esp1 VARCHAR(10)
, provincia VARCHAR(50)
, ciudad VARCHAR(50)
, sector VARCHAR(50)
, vm_recetario VARCHAR(50)
, sede_gira VARCHAR(20)
, linea_act VARCHAR(20)
)