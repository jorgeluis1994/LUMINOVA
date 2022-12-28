--PASO 1--
SELECT 
         M.Periodo
        ,TB.[REG_BI]    
        ,M.[descripcion] AS DESCRIPCION   
        ,TB.COD_BI 
        ,TB.NOM_BI 
		,TB.Esp_bi
        ,SUM(M.Val) as SUMA    
INTO MEDICOS_0#
 
FROM  [dbo].[Medicos] AS M

    LEFT JOIN PAIS AS P
    ON P.Region=M.Region
    
    INNER JOIN [dbo].[MedicosBi] AS TB
    ON TB.CDG_MEDICO=M.Cdg_medico

    WHERE M.MES=11 
    
    GROUP BY 
         TB.[REG_BI]    
        ,M.[descripcion]  
        ,TB.COD_BI 
        ,TB.NOM_BI
        ,M.PERIODO 
		,TB.Esp_bi
            
    ORDER BY PERIODO,REG_BI,DESCRIPCION,SUMA DESC
--PASO 2--
SELECT 
             ROW_NUMBER()OVER(PARTITION  BY PERIODO,DESCRIPCION,REG_BI ORDER BY SUMA DESC ) NUMERO 
            ,[PERIODO]
            ,[DESCRIPCION]
            ,[REG_BI]      
            ,[COD_BI]
            ,[NOM_BI]     
	        ,SUMA
	            		     	 
  INTO MEDICOS_1# 
  --DROP TABLE MEDICOS_1# 
  FROM [dbo].[MEDICOS_0#]
  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI          
           ,SUMA DESC
--PASO 3--
SELECT  
       [PERIODO]
      ,[DESCRIPCION]
      ,[REG_BI]
      ,[COD_BI]
      ,[NOM_BI]
	  ,[NUMERO]
      ,[SUMA]
	  ,SUM(SUMA)OVER(PARTITION BY PERIODO,DESCRIPCION ,REG_BI ORDER BY REG_BI ASC ) AS TOTAL_REGION	  
  
  INTO MEDICOS_2#
  FROM [dbo].[MEDICOS_1#]

  --WHERE PERIODO='CUAT 04/21'
  ORDER BY 
           PERIODO
		   ,DESCRIPCION 
           ,REG_BI          
           ,SUMA DESC
--PASO 4--
SELECT 
           
		   [PERIODO]
		  ,[DESCRIPCION]
		  ,[REG_BI]
		  ,[COD_BI]
		  ,[NOM_BI]
		  ,[SUMA]
		  ,[NUMERO]
		  ,[TOTAL_REGION]
		  ,SUM(SUMA)OVER( PARTITION  BY PERIODO,DESCRIPCION,REG_BI ORDER BY NUMERO DESC ,SUMA ASC  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ACUMULADO 
		  		 
		  
 INTO MEDICOS_3#  
  FROM [dbo].[MEDICOS_2#]

  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
--PASO 5--

 SELECT 
       
      [PERIODO]
      ,[DESCRIPCION]
      ,[REG_BI]
      ,[COD_BI]
      ,[NOM_BI]
	  ,[NUMERO]
      ,[SUMA]
      ,[TOTAL_REGION]
      ,[ACUMULADO]
      INTO MEDICOS_4#
  FROM [dbo].[MEDICOS_3#]
  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
--PASO 6--
SELECT 
       
	   
	   [PERIODO]
      ,[DESCRIPCION]
      ,[REG_BI]
      ,[COD_BI]
      ,[NOM_BI]
      ,[NUMERO]
      ,[SUMA]
      ,[TOTAL_REGION]
      ,[ACUMULADO]
	  ,(CONVERT(FLOAT,ACUMULADO)/TOTAL_REGION)*100 AS PORCENTAJE_ACUMULA 


  INTO MEDICOS_5#
  FROM [dbo].[MEDICOS_4#]

  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
--PASO 7--FINAL
------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
SELECT 
       [PERIODO]
      ,[DESCRIPCION]
      ,[REG_BI]
      ,[COD_BI]
      ,[NOM_BI]
      ,[NUMERO]
      ,[SUMA]
      --,[TOTAL_REGION]
     -- ,[ACUMULADO]
      ,[PORCENTAJE_ACUMULA]
	  ,IIF( [PORCENTAJE_ACUMULA] >=0 AND [PORCENTAJE_ACUMULA] <=20 ,5,
	   IIF( [PORCENTAJE_ACUMULA] >=20 AND [PORCENTAJE_ACUMULA] <=40 ,4,
	   IIF( [PORCENTAJE_ACUMULA] >=40 AND [PORCENTAJE_ACUMULA] <=60 ,3,
	   IIF( [PORCENTAJE_ACUMULA] >=60 AND [PORCENTAJE_ACUMULA] <=80 ,2,
	   IIF( [PORCENTAJE_ACUMULA] >=80 AND [PORCENTAJE_ACUMULA] <=100 ,1,200))))) AS CATEGORIA

INTO CategoriaCalculada
  FROM [dbo].[MEDICOS_5#]

  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
       CONCAT(T.Periodo,T.REG_BI,T.DESCRIPCION) AS CONCATENADO
	   ,T.[COD_BI] as CDG_MEDICO
	   ,T.[NOM_BI]	  AS NOMBRE_DOCTOR
      ,T.[DESCRIPCION] AS DESC_MDO
	  ,T.[Esp_bi]  AS CDG_ESP1
      ,T.[REG_BI] AS REGION
	  ,T.[Periodo] AS PERIODO
	  ,C.CATEGORIA
      ,T.[SUMA]   AS SUMA
  FROM [BDMedicosLuminovaPg].[dbo].[MEDICOS_0#] AS T
  LEFT JOIN [dbo].[CategoriaCalculada] AS C
  ON (T.COD_BI=C.COD_BI AND  T.Periodo=C.PERIODO) AND(T.DESCRIPCION=C.DESCRIPCION)
   
  ORDER BY 
            T.Periodo
		   ,T.DESCRIPCION 
           ,T.REG_BI          
           ,T.SUMA DESC

