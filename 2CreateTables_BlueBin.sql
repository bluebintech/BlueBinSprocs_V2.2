

/****** Object:  Table [bluebin].[BlueBinUser]    Script Date: 10/2/2015 8:34:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



if not exists (select * from sys.tables where name = 'BlueBinParMaster')
BEGIN
CREATE TABLE [bluebin].[BlueBinParMaster](
	[ParMasterID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[FacilityID] smallint not null,
	[LocationID] char (10) NOT NULL,
	[ItemID] char (32) NOT NULL,
	[BinSequence] varchar (50) NOT NULL,
	[BinSize] varchar(5) NULL,
	[BinUOM] varchar (10) NULL,
	[BinQuantity] int NULL,
    [LeadTime] smallint NULL,
    [ItemType] varchar (10) NULL,
	[WHLocationID] char(10) null,
	[WHSequence] varchar(50) null,
	[PatientCharge] int not NULL,
	[Updated] int not null,
	[LastUpdated] datetime not null
	
)


END
GO



if not exists (select * from sys.tables where name = 'MasterLog')
BEGIN
CREATE TABLE [bluebin].[MasterLog](
	[MasterLogID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[BlueBinUserID] int NOT NULL,
	[ActionType] varchar (30) NULL,
    [ActionName] varchar (60) NULL,
	[ActionID] int NULL,
	[ActionDateTime] datetime not null
)
END
GO

if not exists (select * from sys.tables where name = 'Config')
BEGIN
CREATE TABLE [bluebin].[Config](
	[ConfigID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[ConfigName] varchar (30) NOT NULL,
	[ConfigValue] varchar (50) NOT NULL,
    [Active] int not null,
	[LastUpdated] datetime not null,
	[ConfigType] varchar(50) not null,
	[Description] varchar(255)
)

insert into bluebin.Config (ConfigName,ConfigValue,ConfigType,Active,LastUpdated,[Description])
VALUES
('GLSummaryAccountID','','Tableau',1,getdate(),''),
('PO_DATE','1/1/2015','Tableau',1,getdate(),''),
('TrainingTitle','Tech','DMS',1,getdate(),''),
('BlueBinHardwareCustomer','Demo','DMS',1,getdate(),''),
('TimeOffset','3','DMS',1,getdate(),''),
('CustomerImage','BlueBin_Logo.png','DMS',1,getdate(),''),
('REQ_LOCATION','BB','Tableau',1,getdate(),''),
('Version','1.2.20151211','DMS',1,getdate(),''),
('PasswordExpires','90','DMS',1,getdate(),''),
('SiteAppURL','BlueBinOperations_Demo','DMS',1,getdate(),''),
('TableaURL','/bluebinanalytics/views/Demo/','Tableau',1,getdate(),''),
('LOCATION','STORE','Tableau',1,getdate(),''),
('MENU-Dashboard','1','DMS',1,getdate(),''),
('MENU-Dashboard-HuddleBoard','1','DMS',1,getdate(),''),
('MENU-Dashboard-Sourcing','1','DMS',1,getdate(),''),
('MENU-Dashboard-SupplyChain','1','DMS',1,getdate(),''),
('MENU-Dashboard-Ops','1','DMS',1,getdate(),''),
('MENU-QCN','1','DMS',1,getdate(),''),
('MENU-Gemba','1','DMS',1,getdate(),''),
('MENU-Hardware','1','DMS',1,getdate(),''),
('MENU-Scanning','1','DMS',1,getdate(),''),
('MENU-Other','1','DMS',1,getdate(),''),
('ADMIN-PARMASTER',0,'DMS',1,getdate(),'')

END
GO


if not exists (select * from sys.tables where name = 'BlueBinResource')
BEGIN
CREATE TABLE [bluebin].[BlueBinResource](
	[BlueBinResourceID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[FirstName] varchar (30) NOT NULL,
	[LastName] varchar (30) NOT NULL,
	[MiddleName] varchar (30) NULL,
    [Login] varchar (30) NULL,
	[Email] varchar (60) NULL,
	[Phone] varchar (20) NULL,
	[Cell] varchar (20) NULL,
	[Title] varchar (50) NULL,
    [Active] int not null,
	[LastUpdated] datetime not null
)
END
GO


if not exists (select * from sys.tables where name = 'BlueBinUser')
BEGIN
CREATE TABLE [bluebin].[BlueBinUser](
	[BlueBinUserID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[UserLogin] varchar (60) NOT NULL,
	[FirstName] varchar (30) NOT NULL,
	[LastName] varchar (30) NOT NULL,
	[MiddleName] varchar (30) NULL,
	[Title] varchar (50) NULL,
    [Email] varchar (60) NULL,
    [Active] int not null,
	[Password] varchar(30) not null,
	[RoleID] int null,
	[LastLoginDate] datetime not null,
	[MustChangePassword] int not null,
	[PasswordExpires] int not null,
	[LastUpdated] datetime not null
)

ALTER TABLE [bluebin].[MasterLog] WITH CHECK ADD FOREIGN KEY([BlueBinUserID])
REFERENCES [bluebin].[BlueBinUser] ([BlueBinUserID])

ALTER TABLE [bluebin].[BlueBinUser] ADD CONSTRAINT U_Login UNIQUE(UserLogin)

END
GO


if not exists (select * from sys.tables where name = 'BlueBinOperations')
BEGIN
CREATE TABLE [bluebin].[BlueBinOperations](
	[OpID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[OpName] varchar (50) NOT NULL,
	[Description] varchar (255) NULL
)

Insert into bluebin.BlueBinOperations (OpName,[Description]) VALUES
('ADMIN-PARMASTER','Give User ability to see Custom BlueBin Par Master'),
('ADMIN-MENU','Give User ability to see the Main Admin Menu'),
('ADMIN-CONFIG','Give User ability to see the Sub Admin Menu Config'),
('ADMIN-USERS','Give User ability to see the Sub Admin Menu User Administration'),
('ADMIN-RESOURCES','Give User ability to see the Sub Admin Menu Resources'),
('ADMIN-TRAINING','Give User ability to see the Sub Admin Menu Training'),
('MENU-Dashboard','Give User ability to see the Dashboard Menu'),
('MENU-QCN','Give User ability to see the QCN Menu'),
('MENU-Gemba','Give User ability to see the Gemba Menu'),
('MENU-Hardware','Give User ability to see the Hardware Menu'),
('MENU-Scanning','Give User ability to see the Scanning Menu'),
('MENU-Other','Give User ability to see the Other Menu'),
('MENU-Dashboard-SupplyChain','Give User ability to see the Supply Chain DB'),
('MENU-Dashboard-Sourcing','Give User ability to see the Sourcing DB'),
('MENU-Dashboard-Ops','Give User ability to see the Op Performance DB'),
('MENU-Dashboard-HuddleBoard','Give User ability to see the Huddle Board')
END
GO


if not exists (select * from sys.tables where name = 'BlueBinRoles')
BEGIN
CREATE TABLE [bluebin].[BlueBinRoles](
	[RoleID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[RoleName] varchar (50) NOT NULL
)

ALTER TABLE [bluebin].[BlueBinUser] WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [bluebin].[BlueBinRoles] ([RoleID])

insert into [bluebin].[BlueBinRoles] (RoleName) VALUES
('User'),
('BlueBelt'),
('BlueBinPersonnel'),
('SuperUser')

END
GO


if not exists (select * from sys.tables where name = 'BlueBinUserOperations')
BEGIN
CREATE TABLE [bluebin].[BlueBinUserOperations](
	[BlueBinUserID] INT NOT NULL,
	[OpID] INT NOT NULL
)

ALTER TABLE [bluebin].[BlueBinUserOperations] WITH CHECK ADD FOREIGN KEY([BlueBinUserID])
REFERENCES [bluebin].[BlueBinUser] ([BlueBinUserID])

END
GO

if not exists (select * from sys.tables where name = 'BlueBinRoleOperations')
BEGIN
CREATE TABLE [bluebin].[BlueBinRoleOperations](
	[RoleID] INT NOT NULL,
	[OpID] INT NOT NULL
)

ALTER TABLE [bluebin].[BlueBinRoleOperations] WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [bluebin].[BlueBinRoles] ([RoleID])

ALTER TABLE [bluebin].[BlueBinRoleOperations] WITH CHECK ADD FOREIGN KEY([OpID])
REFERENCES [bluebin].[BlueBinOperations] ([OpID])

insert into [bluebin].[BlueBinRoleOperations]
select 
RoleID,--(select RoleID from bluebin.BlueBinRoles where RoleName = 'Manager'),
OpID
from  [bluebin].[BlueBinOperations],bluebin.BlueBinRoles 
WHERE OpName like 'ADMIN%' and RoleName in ('SuperUser','BlueBinPersonnel','BlueBelt')

delete from bluebin.BlueBinRoleOperations where OpID = (select OpID from bluebin.BlueBinOperations where OpName = 'ADMIN-CONFIG') and RoleID in (Select RoleID from bluebin.BlueBinRoles where RoleName in ('SuperUser','BlueBelt'))


END
GO
--DROP TABLE [bluebin].[Image]
--select * from  [bluebin].[Image]


if not exists (select * from sys.tables where name = 'Image')
BEGIN
CREATE TABLE [bluebin].[Image](
	[ImageID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[ImageName] varchar(100) not null,
	[ImageType] varchar(10) not NULL,
	[ImageSource] varchar(100) not NULL,
	[ImageSourceID] int not null,	
	[Image] varbinary(max) NOT NULL,
	[Active] int not null,
	[DateCreated] DateTime not null,
	[LastUpdated] DateTime not null

)
END
GO

if not exists (select * from sys.tables where name = 'BlueBinTraining')
BEGIN
CREATE TABLE [bluebin].[BlueBinTraining](
	[BlueBinTrainingID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[BlueBinResourceID] INT NOT NULL,
	[Form3000] varchar(10) not null,
		[Form3001] varchar(10) not null,
			[Form3002] varchar(10) not null,
				[Form3003] varchar(10) not null,
					[Form3004] varchar(10) not null,
						[Form3005] varchar(10) not null,
							[Form3006] varchar(10) not null,
								[Form3007] varchar(10) not null,
									[Form3008] varchar(10) not null,
										[Form3009] varchar(10) not null,
											[Form3010] varchar(10) not null,
	[Active] int not null,
	[BlueBinUserID] int NULL,
	[LastUpdated] datetime not null
)
;
ALTER TABLE [bluebin].[BlueBinTraining] WITH CHECK ADD FOREIGN KEY([BlueBinResourceID])
REFERENCES [bluebin].[BlueBinResource] ([BlueBinResourceID])
;
ALTER TABLE [bluebin].[BlueBinTraining] WITH CHECK ADD FOREIGN KEY([BlueBinUserID])
REFERENCES [bluebin].[BlueBinUser] ([BlueBinUserID])
;
insert into [bluebin].[BlueBinTraining]
select BlueBinResourceID,'No','No','No','No','No','No','No','No','No','No','No',1,NULL,getdate()
from bluebin.BlueBinResource
where BlueBinResourceID not in (select BlueBinResourceID from bluebin.BlueBinTraining)
	and Title in (select ConfigValue from bluebin.Config where ConfigName = 'TrainingTitle')
END
GO

if not exists (select * from sys.tables where name = 'Document')
BEGIN
CREATE TABLE [bluebin].[Document](
	[DocumentID] INT NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	[DocumentName] varchar(100) not null,
	[DocumentType] varchar(30) not NULL,
	[DocumentSource] varchar(100) not NULL,
	--[Document] varbinary(max) NOT NULL,
	[Document] varchar(max) NOT NULL,
	[Active] int not null,
	[DateCreated] DateTime not null,
	[LastUpdated] DateTime not null

)
;
if not exists (select * from bluebin.Document where DocumentSource = 'SOPs')
BEGIN  
insert into bluebin.Document (DocumentName,DocumentType,DocumentSource,Document,Active,DateCreated,LastUpdated) VALUES
('3000 - Replenishing BlueBin Technology Nodes','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3000 - Replenishing BlueBin Technology Nodes.pdf',1,getdate(),getdate()),
('3001 - BlueBin Stage Operations','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3001 - BlueBin Stage Operations.pdf',1,getdate(),getdate()),
('3002 - Filling BBT Orders - Art of Bin Fill','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3002 - Filling BBT Orders - Art of Bin Fill.pdf',1,getdate(),getdate()),
('3003 - Managing BlueBin Stock-Outs','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3003 - Managing BlueBin Stock-Outs.pdf',1,getdate(),getdate()),
('3004 - BlueBin Kanban & Stage Maintenance','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3004 - BlueBin Kanban & Stage Maintenance.pdf',1,getdate(),getdate()),
('3005 - BlueBin Stage Audit Process','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3005 - BlueBin Stage Audit Process.pdf',1,getdate(),getdate()),
('3006 - Stage Audit Form','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3006 - Stage Audit Form.pdf',1,getdate(),getdate()),
('3007 - BlueBIn Daily Health Audit Process','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3007 - BlueBIn Daily Health Audit Process.pdf',1,getdate(),getdate()),
('3008 - BBT Weekly Health Checklist','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3008 - BBT Weekly Health Checklist.pdf',1,getdate(),getdate()),
('3009 - BBT Orange Cone Process','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3009 - BBT Orange Cone Process.pdf',1,getdate(),getdate()),
('3010 - QCN Process','application/pdf','SOPs','D:\BlueBinDocuments\'+(select DB_NAME())+'\SOPs\3010 - QCN Process.pdf',1,getdate(),getdate())
END
;
if not exists (select * from bluebin.Document where DocumentSource = 'FormsSignage')
BEGIN
insert into bluebin.Document (DocumentName,DocumentType,DocumentSource,Document,Active,DateCreated,LastUpdated) VALUES
('NODE SIGNAGE - Main','application/pdf','FormsSignage','D:\BlueBinDocuments\'+(select DB_NAME())+'\FormsSignage\NODE SIGNAGE - Main.pdf',1,getdate(),getdate()),
('QCN Drop','application/pdf','FormsSignage','D:\BlueBinDocuments\'+(select DB_NAME())+'\FormsSignage\QCN Drop.pdf',1,getdate(),getdate()),
('Sequence Worksheet','application/vnd.ms-excel','FormsSignage','D:\BlueBinDocuments\'+(select DB_NAME())+'\FormsSignage\SEQUENCE WORKSHEET.xlsx',1,getdate(),getdate())
END
;
if not exists (select * from bluebin.Document where DocumentSource = 'BeltCertification')
BEGIN
insert into bluebin.Document (DocumentName,DocumentType,DocumentSource,Document,Active,DateCreated,LastUpdated) VALUES
('Belt Certificate Overview','application/ppsx','BeltCertification','D:\BlueBinDocuments\'+(select DB_NAME())+'\BeltCertification\DMS-CERTIFICATION.ppsx',1,getdate(),getdate())
END
;
END
GO

SET ANSI_PADDING OFF
GO



