--PRESCRIPCIONES BERKANA CORP 24 MESES FILTRAR LAB DE TABLA MERCADO.PRODUCTO
SELECT 	      
	   M.Producto   AS PRESENTACION
	  ,R.Marca      AS PRODUCTO
	  ,R.SiglaLab   AS LABORATORIO
	  ,M.Descripcion AS SEGMENTO
	  ,M.Localidad    AS CUIDAD
	  ,P.Provincia    AS PROVINCIA
	  ,P.Region     AS REGION
	  ,M.Cdg_medico AS CDG_MEDICO
	  ,M.Nombre AS MEDICO
	  ,M.Domicilio AS DIRECCION
	  ,M.Esp	  	AS ESPECIALIDAD 	    
	  ,CONVERT(VARCHAR(15),CONCAT(CONCAT('20',RTRIM(SUBSTRING(m.Periodo,12,14))),'/',LTRIM(SUBSTRING(m.Periodo, 8,3)),'/01'),2) AS FECHA	  	  
	  ,M.Val RX
	  --,R.Laboratorio
	  --,M.Periodo
 
  FROM [BerkanaFarmaCorp].[dbo].[Medicos] AS M
 
 ----TABLA DE BD UNIFICA
		  
		  LEFT JOIN [Unifica].[dbo].[Mercado.Producto] AS R
		  ON M.Producto=R.Producto 

		  LEFT JOIN [Unifica].[dbo].[MercadoRegion] AS P
		  ON M.Region=P.Provincia

  WHERE ( M.Periodo LIKE 'MES MOV %' AND   R.Laboratorio='BKN_CORP') 


  
