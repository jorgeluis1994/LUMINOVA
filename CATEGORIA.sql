----BD_LUMINOVA  AUTHOR JORGE ORTIZ---
-----OBTENER REGION,MERCADO,COD_MEDICO,SUMA
SELECT   
         TB.PAIS
        ,TB.[REG_BI]    
        ,E.[descripcion] AS DESCRIPCION   
        ,TB.COD_BI 
        ,TB.NOM_BI 
        ,E.PX         
        --,SUM(E.PX) as SUMA 
        --,NTILE(5)  AS CATEGORIA       

FROM [BD_LUMINOVA].[dbo].[EXP.LPG_MEDICOS_PX] AS E

    LEFT JOIN PAIS AS P
    ON P.REGION=E.REGION
    
    INNER JOIN [dbo].[MEDICOS_COD_CUP_BI] AS TB
    ON TB.CDG_MEDICO=E.CDG_MEDICO

    WHERE E.PERIODO='TAM 10/22' 
    --AND TB.PAIS='EC' AND TB.REG_BI='CHIMBORAZO' 
--AND E.DESCRIPCION='MDO_MERLIX_TAB'
    --AND TB.REG_BI='CHIMBORAZO'
      

   -- GROUP BY 
      --       TB.REG_BI 
         --   ,E.DESCRIPCION
        --    ,TB.COD_BI
         --   ,TB.NOM_BI
            --,E.PX
            

    ORDER BY E.PX DESC