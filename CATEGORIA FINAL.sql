--------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT 
         E.PERIODO
        ,TB.[REG_BI]    
        ,E.[descripcion] AS DESCRIPCION   
        ,TB.COD_BI 
        ,TB.NOM_BI              
        ,SUM(E.PX) as SUMA    
--INTO MEDICOS_0#

 
FROM [BD_LUMINOVA].[dbo].[EXP.LPG_MEDICOS_PX] AS E

    LEFT JOIN PAIS AS P
    ON P.REGION=E.REGION
    
    INNER JOIN [dbo].[MEDICOS_COD_CUP_BI] AS TB
    ON TB.CDG_MEDICO=E.CDG_MEDICO

    WHERE E.MES='10' 
    
    GROUP BY 
         TB.[REG_BI]    
        ,E.[descripcion]  
        ,TB.COD_BI 
        ,TB.NOM_BI
        ,E.PERIODO   
            
    ORDER BY PERIODO,REG_BI,DESCRIPCION,SUMA DESC
----------------------------------------------------------------------------------------------
---CREACION SEGUNDA TABLA TEMPORAL
---CREACION CONTADOR

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
  FROM [BD_LUMINOVA].[dbo].[MEDICOS_0#]
  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI          
           ,SUMA DESC
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
SELECT  
       [PERIODO]
      ,[DESCRIPCION]
      ,[REG_BI]
      ,[COD_BI]
      ,[NOM_BI]
	  ,[NUMERO]
      ,[SUMA]
	  ,SUM(SUMA)OVER(PARTITION BY PERIODO,DESCRIPCION ,REG_BI ORDER BY REG_BI ASC ) AS TOTAL_REGION	  
  
  --INTO MEDICOS_2#
  FROM [BD_LUMINOVA].[dbo].[MEDICOS_1#]

  --WHERE PERIODO='CUAT 04/21'
  ORDER BY 
           PERIODO
		   ,DESCRIPCION 
           ,REG_BI          
           ,SUMA DESC
---------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
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
		  		 
		  
 --INTO MEDICOS_3#  
  FROM [BD_LUMINOVA].[dbo].[MEDICOS_2#]

  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
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
      --INTO MEDICOS_4#
  FROM [BD_LUMINOVA].[dbo].[MEDICOS_3#]
  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
SELECT  [PERIODO]
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
  FROM [BD_LUMINOVA].[dbo].[MEDICOS_4#]

  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC
------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
SELECT [PERIODO]
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
  FROM [BD_LUMINOVA].[dbo].[MEDICOS_5#]

  ORDER BY 
            PERIODO
		   ,DESCRIPCION 
           ,REG_BI
		   ,NUMERO
           ,SUMA DESC





	   
	  