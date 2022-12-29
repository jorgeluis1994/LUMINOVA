--PROCESO RANKING
SELECT   
        
         P.CodPais
		,M.Periodo
		,TB.Cod_bi
        ,TB.Nom_bi		
		,R.Descripcion 
        ,M.Producto
        ,SUM(M.Val) as Suma   

--INTO Rank0#
 
FROM [dbo].[Medicos] AS M

    LEFT JOIN PAIS AS P
    ON P.Region=M.Region
    
    INNER JOIN  [dbo].[MedicosBi]AS TB
    ON TB.Cdg_medico=M.Cdg_medico

	INNER JOIN [dbo].[MercadoRelevante] R
	ON M.Descripcion=R.Form
	

    WHERE M.MES=11 
    
    
	GROUP BY     
				 P.CodPais
			    ,M.Periodo
                ,TB.Cod_bi
                ,TB.Nom_bi		
                ,R.Descripcion
                ,M.Producto
          
            
    ORDER BY TB.Nom_bi ASC
	--------------------------------------------------------
	---------------------------------------------------------
SELECT 
       
	   [CodPais]     
      ,[Periodo]
      ,[Cod_bi]
      ,[Nom_bi]
      ,[Descripcion]
	  ,RIGHT([Producto],3) as SiglaPro
      ,[Producto]
      ,[Suma]
      ,ROW_NUMBER()OVER(PARTITION  BY [Periodo],[Cod_bi],[Nom_bi],[Descripcion] ORDER BY [Periodo],[Cod_bi],[Nom_bi],[Descripcion], [Suma] DESC ) Rk
  
  INTO Rank1# 
  FROM [dbo].[Rank0#]
-----------------------------------------------------------------------------------
---------------------------------------------------------------------------------
SELECT 
      -- CONCAT([Rk],[Periodo],[Cod_bi],[Descripcion]) AS Concatenacion1
	  --,CONCAT([Periodo],[Cod_bi],[Descripcion],[SiglaPro]) AS Concatenacion2	  
	  --,[CodPais]
       [Periodo]
      ,[Cod_bi]
      --,[Nom_bi]
      ,[Descripcion]
      --,[SiglaPro]
      --,[Producto]
      ,SUM([Suma])
      ,SUM([Rk])
	  ,(CASE WHEN Rk=1 THEN [Producto] ELSE '' END ) AS R1
	  ,(CASE WHEN Rk=2 THEN [Producto] ELSE '' END ) AS R2
	  ,(CASE WHEN Rk=3 THEN [Producto] ELSE '' END ) AS R3
	  ,(CASE WHEN Rk=4 THEN [Producto] ELSE '' END ) AS R4
	  ,(CASE WHEN Rk=5 THEN [Producto] ELSE '' END ) AS R5
--INTO RankProducto# 
FROM [BDMedicosLuminovaPg].[dbo].[Rank1#]

 WHERE CodPais='05. CR' AND
    ([Periodo]='CUAT MOV 11/21' 
     OR [Periodo]='CUAT MOV 11/22' 
	 OR [Periodo]='TAM 11/22' 
	 OR [Periodo]='YTD MOV 2021' 
	 OR [Periodo]='YTD MOV 2022')

	 
GROUP BY [Periodo]
        ,[Cod_bi]
		,[Nom_bi]
		,[Descripcion]
		--,Rk
		--,Producto
		

ORDER BY [Periodo]
        ,[Cod_bi]
		,[Nom_bi]
		,[Descripcion]
		--,[Suma] DESC
-------------------------------------------------------------------------
----------------------------------------------------------------------------
SELECT [Concatenacion1]
      ,[Concatenacion2]
      ,[Periodo]
      ,[Cod_bi]
      ,[Descripcion]
      ,[Producto]
      ,[Suma]
      ,[Rk]

INTO PRUEBA#
  FROM [BDMedicosLuminovaPg].[dbo].[RankProducto#]

  --WHERE CodPais='05. CR' AND
  --  ([Periodo]='CUAT MOV 11/21' 
  --   OR [Periodo]='CUAT MOV 11/22' 
	 --OR [Periodo]='TAM 11/22' 
	 --OR [Periodo]='YTD MOV 2021' 
	 --OR [Periodo]='YTD MOV 2022')

  ORDER BY 
         [Periodo]
        ,[Cod_bi]		
		,[Descripcion]
		,[Suma] DESC

  























