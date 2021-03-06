/****** Script for SelectTopNRows command from SSMS  ******/

select * from [qcn].[QCNType]
select * from [qcn].[QCNStatus]
select * from [bluebin].[BlueBinUser]
select * from [bluebin].[BlueBinRoles]
select * from [bluebin].[Config]

Insert into [bluebin].[Config]([ConfigName],[ConfigValue],[Active],[LastUpdated]) VALUES
('CustomerImage','Nemours-logo.png',0,getdate()),
('TimeOffset','4',1,getdate()),
('BlueBinHardwareCustomer','MHS',1,getdate())

insert into [bluebin].[BlueBinRoles] (RoleName) Values ('User'),('Manager'),('BlueBin')  
--
insert into [bluebin].[BlueBinUser] (UserLogin,FirstName,LastName,MiddleName,email,Active,[Password],RoleID,LastLoginDate,LastUpdated) Values
('gbutler@bluebin.com','Gerry','Butler','','gbutler@bluebin.com',1,'12345',(select RoleID from bluebin.BlueBinRoles where RoleName = 'BlueBin'),getdate(),getdate()),
('dhagen@bluebin.com','Derek','Hagan','','dhagan@bluebin.com',1,'12345',(select RoleID from bluebin.BlueBinRoles where RoleName = 'BlueBin'),getdate(),getdate()),
('jratte@bluebin.com','John','Ratte','','jratte@bluebin.com',1,'12345',(select RoleID from bluebin.BlueBinRoles where RoleName = 'BlueBin'),getdate(),getdate()),
('snevins@bluebin.com','Sabrina','Nevins','','snevins@bluebin.com',1,'12345',(select RoleID from bluebin.BlueBinRoles where RoleName = 'BlueBin'),getdate(),getdate()),
('chodge@bluebin.com','Charles','Hodge','','chodge@bluebin.com',1,'12345',(select RoleID from bluebin.BlueBinRoles where RoleName = 'BlueBin'),getdate(),getdate()),
('rswan@bluebin.com','Robb','Swan','','rswan@bluebin.com',1,'12345',(select RoleID from bluebin.BlueBinRoles where RoleName = 'BlueBin'),getdate(),getdate()),
('arusso@bluebin.com','Alex','Russo','','arusso@bluebin.com',1,'12345',(select RoleID from bluebin.BlueBinRoles where RoleName = 'BlueBin'),getdate(),getdate())


insert into [qcn].[QCNType] (Name,Active,LastUpdated) Values('ADD',1,getdate()),('CHANGE',1,getdate()),('REMOVE',1,getdate())
insert into [qcn].[QCNStatus] (Status,Active,LastUpdated) Values('New',1,getdate()),('InReview',1,getdate()),('InProgress',1,getdate()),('Rejected',1,getdate()),('OnHold',1,getdate()),('FutureVersion',1,getdate()),('Completed',1,getdate())





