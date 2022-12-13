SELECT  	 
         TB.COD_BI 
        ,TB.NOM_BI		
		,MR.MDO_RVTE
		,TB.ESP_BI
		,TB.REG_BI
		,E.PERIODO
        ,E.CATEGORIA
        ,SUM(E.PX) as SUMA    

 
FROM [BD_LUMINOVA].[dbo].[EXP.LPG_MEDICOS_PX] AS E

    LEFT JOIN PAIS AS P
    ON P.REGION=E.REGION
    
    INNER JOIN [dbo].[MEDICOS_COD_CUP_BI] AS TB
    ON TB.CDG_MEDICO=E.CDG_MEDICO

	INNER JOIN [dbo].[MDO_RVT_EXP] MR
	ON E.DESCRIPCION=MR.FORM_CONS
	

    WHERE E.MES='10' 
    OR E.PERIODO='YTD MOV 2022'OR E.PERIODO='YTD MOV 2021'
    OR E.PERIODO='CUAT MOV 10/22' OR E.PERIODO='TAM 10/22' 

    
	GROUP BY     
				 TB.COD_BI 
				,TB.NOM_BI 
				,MR.MDO_RVTE
				,TB.ESP_BI
				,TB.REG_BI
				,E.PERIODO
                ,E.CATEGORIA
          
            
    ORDER BY NOM_BI ASC

