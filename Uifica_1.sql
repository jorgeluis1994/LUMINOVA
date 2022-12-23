/****** Script for SelectTopNRows command from SSMS  ******/---
-----Primera temporal
SELECT 
			U.ClaseTerapeutica
			,RTRIM(LEFT(U.ClaseTerapeutica,5)) AS ATC
			,U.Molecula
--INTO AtcMol#

  FROM [UnificaBerkanaCorp].[dbo].[Mercado.UnidadesValores] AS U

GROUP BY
			  U.ClaseTerapeutica
			 ,U.Molecula
UNION 

SELECT 
			E..ClaseTerapeutica
			,RTRIM(LEFT(U.ClaseTerapeutica,5)) AS ATC
			,U.Molecula
--INTO AtcMol#

  FROM [dbo].[Mercado.Em] AS E

GROUP BY
			  U.ClaseTerapeutica
			 ,U.Molecula
-------------------------------------------------------------------------------
------------------------------------------------------------------------------
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
        M.ClaseTerapeutica
       ,A.ATC
			

  FROM [dbo].[Mercado.MercadoRelevanteMol]AS M
  LEFT JOIN [dbo].[AtcMol#] AS A
  ON M.ClaseTerapeutica=A.ATC
