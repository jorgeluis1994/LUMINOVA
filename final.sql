/****** Script for SelectTopNRows command from SSMS  ******/---
-----Primera temporal Unicos atc mol
SELECT 
			U.ClaseTerapeutica
			,RTRIM(LEFT(U.ClaseTerapeutica,5)) AS ATC
			,U.Molecula
			,u.Auditoria
--INTO AtcMol#

  FROM [UnificaBerkanaCorp].[dbo].[Mercado.UnidadesValores] AS U

  WHERE Auditoria='VALORES' OR Auditoria='CUP_RX'

GROUP BY
			  U.ClaseTerapeutica
			 ,U.Molecula
			 ,u.Auditoria

-------------------------------------------------------------------------------
------------------------------------------------------------------------------

/****** Script for SelectTopNRows command from SSMS  ******/---
-----Segunda temporal Unicos atc ff
SELECT 
			U.ClaseTerapeutica
			,RTRIM(LEFT(U.ClaseTerapeutica,5)) AS ATC
			,U.FormaFarmaceutica
			,u.Auditoria
INTO AtcForma#

  FROM [UnificaBerkanaCorp].[dbo].[Mercado.UnidadesValores] AS U

  WHERE Auditoria='VALORES' OR Auditoria='CUP_RX'

GROUP BY
			  U.ClaseTerapeutica
			 ,U.FormaFarmaceutica
			 ,u.Auditoria

-------------------------------------------------------------------------------
------------------------------------------------------------------------------
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
        M.ClaseTerapeutica
       ,A.ATC
			

  FROM [dbo].[Mercado.MercadoRelevanteMol]AS M
  LEFT JOIN [dbo].[AtcMol#] AS A
  ON M.ClaseTerapeutica=A.ATC