USE [SIAM]
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarLogApp]    Script Date: 11/05/2021 01:50:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	MUS
-- Create date: 11/05/2021
-- Description:	Obtener los logs que cumplan con los parametros enviados.
-- =============================================
CREATE PROCEDURE [dbo].[sp_ObtenerLogApp] 
	@IdColectivoWeb AS bigint, 
	@Tipo  AS char(1)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF (UPPER(@Tipo) <> 'E' AND UPPER(@Tipo) <> 'R')
      BEGIN
        RAISERROR('El parametro @tipo es invalido, favor de enviar parametro valido', 15, 5)
      END

   SELECT id_colectivo_web_generado
           ,tipo
           ,cadena_mensaje
           ,Fecha_alta 
	FROM log_colectivo_web_apps
    WHERE id_colectivo_web_generado = @IdColectivoWeb        
    AND UPPER(tipo) = UPPER(@Tipo) 
          
END TRY
BEGIN CATCH
   DECLARE @Message varchar(MAX) = ERROR_MESSAGE(),
        @Severity int = ERROR_SEVERITY(),
        @State smallint = ERROR_STATE()
    RAISERROR(@Message, @Severity, @State)
END CATCH
