--INSERT INTO [dbo].[Mercado.UnidadesValores]	
SELECT       	   
	   R.Region
	  ,R.Provincia
	  ,L.Nombre AS Laboratorio
	  ,P.ClaseTerapeutica
	  ,P.Marca AS Producto	  
	  ,E.Producto AS Presentacion
	  ,P.Molecula
	  ,P.FormaFarmaceutica 
	  ,E.Auditoria
	  ,E.Mes
	  ,CONCAT(20,E.Año) AS Año
	  ,E.Val
	  
  
  FROM [dbo].[Mercado.Em] as E

  LEFT JOIN [dbo].[MercadoRegion] AS R
  ON R.Provincia=E.Apertura

  LEFT JOIN [dbo].[Mercado.Producto] AS P
  ON E.Producto=P.Producto 

  LEFT JOIN [dbo].[MercadoLaboratorioRx] AS L
  ON P.SiglaLab=L.SiglaLab

  WHERE E.Division='REG' AND E.Pais='BKN' 
