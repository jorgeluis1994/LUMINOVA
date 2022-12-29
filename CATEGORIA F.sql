---CALCULO CATEGORIA MEDICOS Author:Jorge Ortiz 
--PASO 1--
SELECT  
         M.Periodo
        ,TB.[REG_BI]    
        ,M.[descripcion] AS DESCRIPCION   		
        ,TB.COD_BI 
        ,TB.NOM_BI 
		,TB.Esp_bi
        ,SUM(M.Val) as SUMA 
		
INTO Cat1#
 
FROM  [dbo].[Medicos] AS M

    LEFT JOIN PAIS AS P
    ON P.Region=M.Region
    
    INNER JOIN [dbo].[MedicosBi] AS TB
    ON tb.Cdg_medico=M.Cdg_medico

    WHERE M.MES=11   
	
GROUP BY 
         TB.[REG_BI]    
        ,M.[descripcion]  
        ,TB.COD_BI 
        ,TB.NOM_BI
        ,M.PERIODO 
		,TB.Esp_bi		          
 ORDER BY 
          PERIODO
         ,REG_BI
		 ,DESCRIPCION
		 ,SUMA DESC
--PASO 2--
SELECT  
         ROW_NUMBER()OVER(PARTITION  BY PERIODO,DESCRIPCION,REG_BI ORDER BY SUMA DESC ) NUMERO 
        ,[PERIODO]
        ,[DESCRIPCION]
        ,[REG_BI]      
        ,[COD_BI]
        ,[NOM_BI]     
	    ,SUMA
			
  INTO Cat2# 

  FROM [dbo].[Cat1#]

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
  
  INTO Cat3#
  FROM [dbo].[Cat2#]
 
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
		  
 INTO Cat4#  

FROM [dbo].[Cat3#]

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

  INTO Cat5#

FROM [dbo].[Cat4#]

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

  INTO Cat6#

FROM [dbo].[Cat5#]

ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
--PASO 7--
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

  INTO CatCalculada#
  FROM [dbo].[Cat6#]

  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
--CATEGORIA CALCULADA--
SELECT  
        CONCAT(T.Periodo,T.COD_BI,R.Descripcion) AS CONCATENADO
	   ,T.[COD_BI]    AS CDG_MEDICO
	   ,T.[NOM_BI]	  AS NOMBRE_DOCTOR
       ,R.Descripcion AS DESC_MDO
	   ,T.[Esp_bi]    AS CDG_ESP1
       ,T.[REG_BI]    AS REGION
	   ,T.[Periodo]   AS PERIODO
	   ,C.CATEGORIA
       ,T.[SUMA]      AS SUMA
	   ,P.CodPais
FROM [BDMedicosLuminovaPg].[dbo].[Cat1#] AS T

  INNER JOIN [dbo].[CatCalculada#] AS C
  ON (T.COD_BI=C.COD_BI AND  T.Periodo=C.PERIODO) AND(T.DESCRIPCION=C.DESCRIPCION)

  LEFT JOIN [dbo].[Pais] AS P
  ON T.REG_BI=P.Region

  INNER JOIN [dbo].[MercadoRelevante] R
  ON T.DESCRIPCION=R.Form
   
WHERE P.CodPais='09. CO' 
     AND (C.PERIODO='CUAT MOV 11/21' 
     OR C.PERIODO='CUAT MOV 11/22' 
	 OR C.PERIODO='TAM 11/22' 
	 OR C.PERIODO='YTD MOV 2021' 
	 OR C.PERIODO='YTD MOV 2022')

ORDER BY 
            T.Periodo
		   ,T.DESCRIPCION 
           ,T.REG_BI          
           ,T.SUMA DESC

