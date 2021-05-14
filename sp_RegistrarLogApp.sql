USE [SIAM]
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarLogApp]    Script Date: 11/05/2021 03:25:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	MUS
-- Create date: 11/05/2021
-- Description:	Almacena en log la respuesta de la autorizacion de un colectivo.
-- =============================================
CREATE PROCEDURE [dbo].[sp_RegistrarLogApp] 
	@IdColectivoWeb AS bigint, 
	@Tipo  AS char(1),
	@cadenaMensaje AS varchar(1000)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF (UPPER(@Tipo) <> 'E' AND UPPER(@Tipo) <> 'R')
      BEGIN
        RAISERROR('El parametro @tipo es invalido, favor de enviar parametro valido', 15, 5)
      END

   IF (@cadenaMensaje = '' OR LEN(@cadenaMensaje) < 1)
      BEGIN
        RAISERROR('El parametro @cadenaMensaje no puede ser vacio, favor de enviar parametro valido', 16, 5)
      END

  IF (LEN(@cadenaMensaje) > 1000)
      BEGIN
        RAISERROR('El parametro @cadenaMensaje sobre pasa el tamaño, favor de enviar parametro valido', 16, 5)
      END

    -- Insert statements for procedure here
	INSERT INTO log_colectivo_web_apps
           (id_colectivo_web_generado
           ,tipo
           ,cadena_mensaje
           ,Fecha_alta)
     VALUES
           (@IdColectivoWeb
           ,UPPER(@Tipo)
           ,@cadenaMensaje
           ,GETDATE())
END TRY
BEGIN CATCH
   DECLARE @Message varchar(MAX) = ERROR_MESSAGE(),
        @Severity int = ERROR_SEVERITY(),
        @State smallint = ERROR_STATE()
    RAISERROR(@Message, @Severity, @State)
END CATCH
