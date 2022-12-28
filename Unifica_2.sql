--UNI VAL  RX
SELECT     
           M.Division
	      ,M.Linea
		  ,CASE
		        WHEN ([MercadoRelevante] = 'MDO_FEMOREL'   OR   (Producto='ACIBERKAN' OR Producto='ACIBERKAN HYG')) THEN 'RESTO'
				WHEN ([MercadoRelevante] = 'MDO_ACIBERKAN' OR   (Producto='FEMOREL'   OR Producto='FEMOREL ELE')) THEN 'RESTO'
				WHEN ([MercadoRelevante] = 'MDO_BISTENZID' OR  ((Producto='CARDIC 3'  OR Producto='CARDIC 3 HYG') OR (Producto='VALCARDIO PLUS' OR Producto='VALCARDIO PLUS HYG') )) THEN 'RESTO'
				WHEN Laboratorio = 'BERKANAFARMA' THEN 'BKN'
				WHEN Laboratorio = 'HYGGE PHARMA' THEN 'BKN'
				WHEN Laboratorio = 'ELEA' THEN 'BKN'
			ELSE 'RESTO'
            END AS LABORA	
		  --,IIF([MercadoRelevante] = 'MDO_ROSLIPID' OR Producto='ACIBERKAN' OR Producto='ACIBERKAN HYG' ,'RESTO','f') as prueba
		  ,M.MercadoRelevante AS MDO_RVTE
		  ,U.[Region] AS REGION
		  ,U.[Provincia] AS PROVINCIA
		  ,U.[Laboratorio] AS LABORATORIO
		  ,U.[Producto] AS MARCA
		  ,U.[Presentacion] AS ITEM
		  ,RTRIM(LEFT(U.[ClaseTerapeutica],5)) AS ATC4		 		  
		  ,U.[Molecula] AS MOLECULA
		  ,U.[FormaFarmaceutica] AS FF
		  ,U.[Auditoria]		  AS MEDIDA	 	      
		  ,P.Periodo		  AS PERIODO
		  ,SUM(U.Val) AS SUMA_VALOR			  		  			

FROM [Mercado.UnidadesValores] AS U

		RIGHT JOIN [Mercado.Relavante] AS M 
		ON (M.ClaseTerapeutica=U.ClaseTerapeutica AND  M.Molecula=U.Molecula) 
			AND ( M.FormaFarmaceutica=U.FormaFarmaceutica)	 

		INNER JOIN  [Mercado.Periodo]   AS P
		ON (U.Año=P.Año AND U.Mes=P.Mes)

WHERE VAL !=0 

GROUP BY
           U.[Region]
		  ,U.[Provincia]
		  ,U.[Laboratorio]
		  ,U.[ClaseTerapeutica]
		  ,U.[Producto]
		  ,U.[Presentacion]
		  ,U.[Molecula]
		  ,U.[FormaFarmaceutica]
		  ,U.[Auditoria]	  
	      ,M.MercadoRelevante
	      ,M.Division
	      ,M.Linea
		  ,P.Periodo

ORDER BY Periodo