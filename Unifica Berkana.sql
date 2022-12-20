CREATE TABLE [Mercado.Em] (
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

CREATE TABLE [Mercado.Marca] (
  [Marca] VARCHAR(50),
  [Producto] VARCHAR(50),
  [Origen] VARCHAR(50)
)
GO

CREATE TABLE [Mercado.Molecula] (
  [Molecula] VARCHAR(50),
  [Producto] VARCHAR(50),
  [Origen] VARCHAR(50)
)
GO

CREATE TABLE [Mercado.ClaseTerapeutica] (
  [ClaseTerapeutica] VARCHAR(50),
  [Codigo] VARCHAR(50)
)
GO

CREATE TABLE [Mercado.FormaFarmaceutica] (
  [Producto] VARCHAR(50),
  [FormaFarmaceutica] VARCHAR(50),
  [FormaFAgrupada] VARCHAR(50)
)
GO

CREATE TABLE [Mercado.UnidadesValores] (
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

CREATE TABLE [Mercado.MercadoRelevante] (
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

CREATE TABLE [Mercado.Laboratorio] (
  [Pais] VARCHAR(50),
  [Laboratorio] VARCHAR(50),
  [SiglaLab] VARCHAR(50),
  [Origen] VARCHAR(50)
)
GO

CREATE TABLE [Mercado.Region] (
  [Region] VARCHAR(50),
  [Provincia] VARCHAR(50),
  [Pais] VARCHAR(50)
)
GO

CREATE TABLE [Mercado.Periodo] (
  [Periodo] VARCHAR(50),
  [Mes] VARCHAR(50)
)
GO
