CREATE TABLE [Em] (
  [Origen] VARCHAR(50),
  [Pais] VARCHAR(50),
  [Division] VARCHAR(50),
  [Apertura] VARCHAR(50),
  [Producto] VARCHAR(50),
  [Periodo] VARCHAR(50),
  [Val] INT,
  [Auditoria] VARCHAR(50),
  [Laboratorio] VARCHAR(50)
)
GO

CREATE TABLE [Marca] (
  [Marca] VARCHAR(50),
  [Producto] VARCHAR(50),
  [Origen] VARCHAR(50)
)
GO

CREATE TABLE [Molecula] (
  [Molecula] VARCHAR(50),
  [Producto] VARCHAR(50),
  [Origen] VARCHAR(50)
)
GO

CREATE TABLE [ClaseTerapeutica] (
  [ClaseTerapeutica] VARCHAR(50),
  [Codigo] VARCHAR(50)
)
GO

CREATE TABLE [FormaFarmaceutica] (
  [Producto] VARCHAR(50),
  [FormaFarmaceutica] VARCHAR(50),
  [FormaFAgrupada] VARCHAR(50)
)
GO

CREATE TABLE [UnidadesValores] (
  [Region] VARCHAR(50),
  [Provincia] VARCHAR(50),
  [Laboratorio] VARCHAR(50),
  [ClaseTerapeutica] VARCHAR(50),
  [Producto] VARCHAR(50),
  [Presentacion] VARCHAR(50),
  [Molecula] VARCHAR(50),
  [FormaFarmaceutica] VARCHAR(50),
  [Periodo] VARCHAR(50),
  [Val] INT,
  [Auditoria] VARCHAR(50)
)
GO

CREATE TABLE [MercadoRelevante] (
  [MercadoRelevante] VARCHAR(50),
  [ClaseTerapeutica] VARCHAR(50),
  [FormaFarmaceutica] VARCHAR(50),
  [Molecula] VARCHAR(50),
  [Auditoria] VARCHAR(50),
  [Linea] VARCHAR(50),
  [Laboratorio] VARCHAR(50),
  [Division] VARCHAR(50),
  [Origen] VARCHAR(50)
)
GO

CREATE TABLE [Laboratorio] (
  [Pais] VARCHAR(50),
  [Laboratorio] VARCHAR(50),
  [SiglaLab] VARCHAR(50),
  [Origen] VARCHAR(50)
)
GO

CREATE TABLE [Region] (
  [Region] VARCHAR(50),
  [Provincia] VARCHAR(50),
  [Pais] VARCHAR(50)
)
GO

CREATE TABLE [Periodo] (
  [Periodo] VARCHAR(50),
  [Mes] VARCHAR(50)
)
GO
