SELECT              
             
             MDO.[LINEA]
			,F.LINEA
            ,MDO.[TIPO]          
            ,MDO.[MDO]           
            ,TB.[COD_BI]
		    ,TB.PAIS
		    ,TB.NOM_BI
            ,TB.[LOC_BI]
			,TB.[DOM_BI]
            ,TB.[REG_BI]
            ,TB.[ESP_BI]
            ,TB.[MATRCULA_BI]
            ,F.[REPRESENTANTE]
			,F.[DISTRITO]
            ,E.PERIODO AS periodo
            ,E.DESCRIPCION AS descripcion
			,E.PRODUCTO

            ,SUM(E.PX) as SUMA 

FROM [BD_LUMINOVA].[dbo].[EXP.LPG_MEDICOS_PX] AS E

			LEFT JOIN PAIS AS P
			ON P.REGION=E.REGION
	
			FULL JOIN [dbo].[MEDICOS_COD_CUP_BI] AS TB
			ON TB.CDG_MEDICO=E.CDG_MEDICO			

			INNER JOIN PARRILLA_PROMOCIONAL AS MDO
			ON MDO.MDO=E.DESCRIPCION 
			
			INNER JOIN FICHERO_CRM AS F
			ON F.NOM_BI=TB.NOM_BI AND MDO.LINEA=F.[LINEA]
           
			
WHERE (((F.MES=10 AND MDO.ESTADO='ACTIVO') AND (E.MES='10' AND MDO.PERIODO='IIICTR2022'))
AND ((E.PERIODO='MES MOV 07/22' OR E.PERIODO='MES MOV 08/22')
OR  (E.PERIODO='MES MOV 09/22' OR E.PERIODO='MES MOV 10/22')))

GROUP BY      
             MDO.[LINEA]
			,F.[LINEA]
            ,MDO.[TIPO]          
            ,MDO.[MDO]           
            ,TB.[COD_BI]
		    ,TB.PAIS
		    ,TB.NOM_BI
            ,TB.[LOC_BI]
			,TB.[DOM_BI]
            ,TB.[REG_BI]
            ,TB.[ESP_BI]
            ,TB.[MATRCULA_BI]
            ,F.[REPRESENTANTE]
			,F.[DISTRITO]
			,E.PRODUCTO           
            ,E.PERIODO
            ,E.DESCRIPCION

     ORDER BY  NOM_BI