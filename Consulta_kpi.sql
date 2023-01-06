SELECT        
       [fi].[Cod_bi]
       ,[b].[Nom_bi]
      ,[b].[Dom_bi]
      ,[b].[Loc_bi]
      ,[b].[Reg_bi]          
	  ,[b].[Esp_bi]  
      ,[m].[Periodo]
      ,[m].[Producto]     
	  ,[pa].[Linea]
	  ,[pa].[Descripcion]
	  ,[fi].[Linea]
	  ,[fi].[Rep]
	  ,[fi].[Distrito]
	  ,[fi].[Frecuencia]
	  ,[fi].[Categoria]
	  ,[pa].[Estado]
	  ,[pa].[Mes]
	  ,[pa].[Pais]
	  ,SUM([m].[Val]) AS Val

  FROM [BDMedicosLuminovaPg].[dbo].[Medicos] AS [m]

  JOIN [BDMedicosLuminovaPg].[dbo].[MedicosBi]  AS [b]
  ON [m].[Cdg_medico]=[b].[Cdg_medico]

  JOIN [BDMedicosLuminovaPg].[dbo].[ParrillaPromocional]  AS [pa]
  ON [m].[Descripcion]=[pa].[Descripcion] AND [b].[Pais]=RIGHT([pa].[Pais],2)

  RIGHT JOIN [BDMedicosLuminovaPg].[dbo].[FicheroMedico]  AS [fi]
  ON [fi].[Cod_bi]=[b].[Cod_bi] AND [fi].[Linea]=[pa].[Linea]
  
  
  WHERE ([m].[Periodo]='MES MOV 11/22' AND [pa].[Mes]='IIICTR2022') AND ( [pa].[Estado]='ACTIVO')
     
        

  GROUP BY 
           [fi].[Cod_bi]
		  ,[b].[Nom_bi]
		  ,[b].[Dom_bi]
		  ,[b].[Loc_bi]
		  ,[b].[Reg_bi]          
		  ,[b].[Esp_bi]  
		  ,[m].[Periodo]
		  ,[m].[Producto]     
		  ,[pa].[Linea]
		  ,[pa].[Descripcion]
		  ,[fi].[Linea]
		  ,[fi].[Rep]
		  ,[fi].[Distrito]
		  ,[fi].[Frecuencia]
		  ,[fi].[Categoria]
		  ,[pa].[Estado]
	      ,[pa].[Mes]
		  ,[pa].[Pais]

ORDER BY [b].[Nom_bi]
