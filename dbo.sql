/*
 Navicat Premium Data Transfer

 Source Server         : Sql Server
 Source Server Type    : SQL Server
 Source Server Version : 15002000
 Source Host           : DESKTOP-MN89TOE\SQLEXPRESS:1433
 Source Catalog        : DBVEHICULO
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 15002000
 File Encoding         : 65001

 Date: 11/05/2021 02:11:12
*/


-- ----------------------------
-- Table structure for tb01_vehiculo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[tb01_vehiculo]') AND type IN ('U'))
	DROP TABLE [dbo].[tb01_vehiculo]
GO

CREATE TABLE [dbo].[tb01_vehiculo] (
  [Id] int  IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
  [Marca] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Precio] decimal(18,2)  NULL,
  [Foto] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[tb01_vehiculo] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tb01_vehiculo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[tb01_vehiculo] ON
GO

INSERT INTO [dbo].[tb01_vehiculo] ([Id], [Marca], [Precio], [Foto]) VALUES (N'1', N'Toyota', N'90.90', N'Ningna')
GO

INSERT INTO [dbo].[tb01_vehiculo] ([Id], [Marca], [Precio], [Foto]) VALUES (N'2', N'Hyunday', N'89.65', N'Ningna')
GO

INSERT INTO [dbo].[tb01_vehiculo] ([Id], [Marca], [Precio], [Foto]) VALUES (N'3', N'Jefferson', N'60.78', N'Bien hecho')
GO

INSERT INTO [dbo].[tb01_vehiculo] ([Id], [Marca], [Precio], [Foto]) VALUES (N'4', N'Erwin', N'20.00', N'Vargas')
GO

INSERT INTO [dbo].[tb01_vehiculo] ([Id], [Marca], [Precio], [Foto]) VALUES (N'5', N'Erwin', N'30.67', N'Mayorga')
GO

INSERT INTO [dbo].[tb01_vehiculo] ([Id], [Marca], [Precio], [Foto]) VALUES (N'6', N'Nuevo Carrito', N'344.90', N'Ninguna Foto')
GO

INSERT INTO [dbo].[tb01_vehiculo] ([Id], [Marca], [Precio], [Foto]) VALUES (N'7', N'Samuel', N'783.30', N'Asi no se puede')
GO

SET IDENTITY_INSERT [dbo].[tb01_vehiculo] OFF
GO


-- ----------------------------
-- procedure structure for SpVehiculo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SpVehiculo]') AND type IN ('FN', 'FS', 'FT', 'IF', 'TF'))
	DROP PROCEDURE[dbo].[SpVehiculo]
GO

CREATE PROCEDURE [dbo].[SpVehiculo]
	-- Add the parameters for the stored procedure here
	 @spopc int,
	 @spcod int,
	 @spmarca nvarchar(50),
	 @spprecion decimal(18,2),
	 @spfoto nvarchar(100)
AS
BEGIN
	IF @spopc = 1 -- Consulta de Vehiculos
	BEGIN
		SELECT Id, Marca, Precio, Foto FROM tb01_vehiculo;
	END;

	IF @spopc = 2 -- Guardamos o Actualizamos los vehiculos
	BEGIN
		IF NOT EXISTS (SELECT Id FROM tb01_vehiculo WHERE Id = @spcod)
		BEGIN
			INSERT INTO tb01_vehiculo (Marca, Precio, Foto) VALUES (@spmarca, @spprecion, @spfoto);
		END;
		ELSE
		BEGIN
			UPDATE tb01_vehiculo SET
				Marca=@spmarca,
				Precio=@spprecion,
				Foto=@spfoto
			WHERE Id = @spcod;
		END;
		SELECT Id, Marca, Precio, Foto FROM tb01_vehiculo;
	END;

	IF @spopc = 3 -- Eliminamos los vehiculos
	BEGIN
		DELETE FROM tb01_vehiculo WHERE Id =  @spcod;
		SELECT Id, Marca, Precio, Foto FROM tb01_vehiculo;
	END;
	
END
GO


-- ----------------------------
-- Auto increment value for tb01_vehiculo
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[tb01_vehiculo]', RESEED, 7)
GO


-- ----------------------------
-- Primary Key structure for table tb01_vehiculo
-- ----------------------------
ALTER TABLE [dbo].[tb01_vehiculo] ADD CONSTRAINT [PK_tb01_vehiculo] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

