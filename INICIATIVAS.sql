--MEDICO CLOPSEUP
SELECT     
       I.Tipo
	  ,I.Division
	  ,B.Pais
	  ,I.Gp
	  ,I.Rep
	  ,I.Gd
	  ,I.Clasificacion
	  ,B.Esp_bi
	  ,B.Cod_bi
	  ,B.Nom_bi
	  ,M.Descripcion
	  ,B.Reg_bi
	  ,B.Dom_bi
	  ,B.Loc_bi
	  ,M.Producto
	  ,RIGHT(M.Producto,3)  AS Lab	  
	  ,I.Inv 
	  ,M.Periodo
	  ,m.Mes
	  
	INTO Iniciativas1#       
        
  FROM [BDMedicosLuminovaPg].[dbo].[Medicos] AS M

  LEFT	 JOIN MedicosBi AS B
  ON M.Cdg_medico=B.Cdg_medico


  INNER JOIN IniciativasFichero AS I
  ON B.Cod_bi=I.Cod_bi AND M.Descripcion=I.Formas


 -- WHERE M.Mes=11 
----------------------------------------------
-----------------------------------------------

SELECT  
       [Tipo] as TIPO
      ,[Division] AS DIVISION
      ,[Pais]  AS PAIS
      ,[Gp]  AS G_P
      ,[Rep] AS REPRESENTANTE
      ,[Gd]  AS G_D
      ,[Clasificacion] AS CLASIFICACION
      ,[Esp_bi] AS ESP_BI
      ,[Cod_bi] AS COD_BI
      ,[Nom_bi] AS NOMBRE_DOCTOR
      ,[Descripcion] AS DESCRIPCION
      ,[Reg_bi] AS REG_BI
      ,[Dom_bi] AS DOM_BI
      ,[Loc_bi] AS LOC_BI
      ,[Producto] AS PRODUCTO
      ,[Lab] AS LAB
	  ,IIF([Lab]='LPG','LPG','RESTO') AS RESTO	
      ,[Inv] AS INVERSION
	  ,Periodo
	  --,Mes
  FROM [BDMedicosLuminovaPg].[dbo].[Iniciativas1#] AS I
  

  WHERE (Periodo IN ('MES MOV 08/21','MES MOV 09/21','MES MOV 10/21','MES MOV 11/21') AND Mes=10)
  OR ((Periodo='YTD MOV 2022' AND Mes=11)OR(Periodo='YTD MOV 2021' AND MES=11))
  OR ((Periodo='TAM 11/21' AND Mes=11)OR(Periodo='TAM 11/22' AND MES=11))
  


 ORDER BY Periodo