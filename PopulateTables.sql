/****** Script for SelectTopNRows command from SSMS  ******/
Select * from [BBTHardware].[dbo].[Customers]
Select * from [BlueBinHardware].[dbo].[Customer]
SET IDENTITY_INSERT [BlueBinHardware].[dbo].[Customer] ON 
insert into [BlueBinHardware].[dbo].[Customer] (customerid,CustomerName,ShippingAddress,City,State,Zipcode,Notes)
select customerid,CustomerName,ShippingAddress,City,State,Zipcode,Notes from [BBTHardware].[dbo].[Customers] where CustomerName not in (select CustomerName from [BlueBinHardware].[dbo].[Customer])
SET IDENTITY_INSERT [BlueBinHardware].[dbo].[Customer] OFF



Select * from  [BlueBinHardware].[dbo].[Vendor] 
select distinct Vendor from [BBTHardware].[dbo].[Item] 
insert into [BlueBinHardware].[dbo].[Vendor] (VendorName)
select distinct Vendor from [BBTHardware].[dbo].[Item] 
where Vendor not in (select VendorName from [BlueBinHardware].[dbo].[Vendor]) and (Vendor <> '' or Vendor = 'Akro Mils')


SELECT * from [BBTHardware].[dbo].[Item] 
SELECT * from [BlueBinHardware].[dbo].[Item]
insert into [BlueBinHardware].[dbo].[Item] 
select  a.ItemNumber,a.ItemDescription,v.VendorID,a.VendorItemNumber,a.UOM,a.OrderUOM,a.OrderUOMqty,a.BBunitCost
from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Vendor] v on a.Vendor = v.VendorName
where ItemNumber not in (select ItemNumber from [BlueBinHardware].[dbo].[Item])

SELECT * from [BlueBinHardware].[dbo].[ItemCustomerCost]
SELECT * from [BBTHardware].[dbo].[Item]
SELECT * from [BlueBinHardware].[dbo].[Customer]

--Demo
insert into [BlueBinHardware].[dbo].[ItemCustomerCost] (ItemID,CustomerID,CustomUnitCost,IsDefault)
select b.ItemID,(select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'Demo'),a.TJUHUnitCost,1 from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where b.ItemID not in (select ItemID from [BlueBinHardware].[dbo].[ItemCustomerCost] where CustomerID = (select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'Demo'))

--TJUH
insert into [BlueBinHardware].[dbo].[ItemCustomerCost] (ItemID,CustomerID,CustomUnitCost,IsDefault)
select b.ItemID,(select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'TJUH'),a.TJUHUnitCost,1 from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where b.ItemID not in (select ItemID from [BlueBinHardware].[dbo].[ItemCustomerCost] where CustomerID = (select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'TJUH'))

--Caldwell
insert into [BlueBinHardware].[dbo].[ItemCustomerCost] (ItemID,CustomerID,CustomUnitCost,IsDefault)
select b.ItemID,(select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'Caldwell'),a.CaldwellUnitCost,1 from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where b.ItemID not in (select ItemID from [BlueBinHardware].[dbo].[ItemCustomerCost] where CustomerID = (select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'Caldwell'))

--CHOMP
insert into [BlueBinHardware].[dbo].[ItemCustomerCost] (ItemID,CustomerID,CustomUnitCost,IsDefault)
select b.ItemID,(select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'CHOMP'),a.ChompUnitCost,1 from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where b.ItemID not in (select ItemID from [BlueBinHardware].[dbo].[ItemCustomerCost] where CustomerID = (select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'CHOMP'))

--Martin *NotActive*
insert into [BlueBinHardware].[dbo].[ItemCustomerCost] (ItemID,CustomerID,CustomUnitCost,IsDefault)
select b.ItemID,(select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'MHS'),a.VCUUnitCost,1 from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where b.ItemID not in (select ItemID from [BlueBinHardware].[dbo].[ItemCustomerCost] where CustomerID = (select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'MHS'))

--UTMC
insert into [BlueBinHardware].[dbo].[ItemCustomerCost] (ItemID,CustomerID,CustomUnitCost,IsDefault)
select b.ItemID,(select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'UTMC'),a.UTMCUnitCost,1 from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where b.ItemID not in (select ItemID from [BlueBinHardware].[dbo].[ItemCustomerCost] where CustomerID = (select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'UTMC'))

--VCU
insert into [BlueBinHardware].[dbo].[ItemCustomerCost] (ItemID,CustomerID,CustomUnitCost,IsDefault)
select b.ItemID,(select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'VCU'),a.VCUUnitCost,1 from [BBTHardware].[dbo].[Item] a
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where b.ItemID not in (select ItemID from [BlueBinHardware].[dbo].[ItemCustomerCost] where CustomerID = (select CustomerID from [BlueBinHardware].[dbo].[Customer] where CustomerName = 'VCU'))

Select * from [BBTHardware].[dbo].[PO]
Select * from [BlueBinHardware].[dbo].[PO]
insert into [BlueBinHardware].[dbo].[PO] 
select a.PO,a.CustomerID,b.VendorID,Total,OrderDate from [BBTHardware].[dbo].[PO] a
inner join [BlueBinHardware].[dbo].[Vendor] b on a.Vendor = b.VendorName
where a.PO not in (select PO from [BlueBinHardware].[dbo].[PO])


Select * from [BBTHardware].[dbo].[POLine]
Select * from [BlueBinHardware].[dbo].[POLine]
insert into [BlueBinHardware].[dbo].[POLine]
select p.POID,a.POLine,b.ItemID,a.Qty,a.Amount from [BBTHardware].[dbo].[Poline] a
Inner join [BlueBinHardware].[dbo].[PO] p on a.PO = p.PO
inner join [BlueBinHardware].[dbo].[Item] b on a.ItemNumber = b.ItemNumber
where a.PO not in (select PO from [BlueBinHardware].[dbo].[PO] where POID in (select POID from [BlueBinHardware].[dbo].[POLine]))


SELECT * from [BBTHardware].[dbo].[VendorInvoice]
SELECT * from [BlueBinHardware].[dbo].[VendorInvoice]
SELECT * from [BlueBinHardware].[dbo].[PO]
SELECT * from [BlueBinHardware].[dbo].[ClientInvoice]
insert into [BlueBinHardware].[dbo].[VendorInvoice]
select a.VendorInvoice,p.POID,v.vendorid,a.CustomerID,a.Subtotal,a.Tax,a.Shipping,a.Total,a.ShipDate,a.ReceiveDate 
from [BBTHardware].[dbo].[VendorInvoice] a
inner join [BlueBinHardware].[dbo].[PO] p on a.PO = p.PO
inner join [BlueBinHardware].[dbo].[Vendor] v on a.vendor = v.VendorName
where a.VendorInvoice not in (select VendorInvoice from [BlueBinHardware].[dbo].[VendorInvoice])

SELECT * from [BBTHardware].[dbo].[VendorInvoiceLine]
SELECT * from [BlueBinHardware].[dbo].[VendorInvoiceLine]
insert into [BlueBinHardware].[dbo].[VendorInvoiceLine]
select vi.VendorInvoiceID,vil.VendorInvoiceLine,i.ItemID,vil.Qty,vil.UnitCost,vil.Amount from [BBTHardware].[dbo].[VendorInvoiceLine] vil
inner join [BlueBinHardware].[dbo].[VendorInvoice] vi on vil.VendorInvoice = vi.VendorInvoice
inner join [BlueBinHardware].[dbo].[Item] i on vil.ItemNumber = i.ItemNumber
where vil.VendorInvoice not in (select VendorInvoice from [BlueBinHardware].[dbo].[VendorInvoice] where VendorInvoiceID in (select VendorInvoiceID from [BlueBinHardware].[dbo].[VendorInvoiceLine]))

Select * from [BBTHardware].[dbo].[ClientInvoice]
Select * from [BlueBinHardware].[dbo].[ClientInvoice]
insert into [BlueBinHardware].[dbo].[ClientInvoice]
select a.ClientInvoice,p.POID,a.CustomerID,A.Subtotal,a.Tax,a.Shipping,a.Total from [BBTHardware].[dbo].[ClientInvoice] a
inner join [BlueBinHardware].[dbo].[PO] p on a.PO = p.PO
where a.ClientInvoice not in (select ClientInvoice from [BlueBinHardware].[dbo].[ClientInvoice])


Select * from [BBTHardware].[dbo].[ClientInvoiceLine]
Select * from [BlueBinHardware].[dbo].[ClientInvoiceLine]
insert into [BlueBinHardware].[dbo].[ClientInvoiceLine]
select ci.ClientInvoiceID,a.ClientInvoiceLine,i.ItemID,a.Qty,a.UnitCost,a.Amount 
from [BBTHardware].[dbo].[ClientInvoiceLine] a
inner join [BlueBinHardware].[dbo].[ClientInvoice] ci on a.clientinvoice = ci.ClientInvoice
inner join [BlueBinHardware].[dbo].[Item] i on a.ItemNumber = i.ItemNumber
where a.ClientInvoice not in (select ClientInvoice from [BlueBinHardware].[dbo].[ClientInvoice] where ClientInvoiceID in (Select ClientInvoiceID from [BlueBinHardware].[dbo].[ClientInvoiceLine]))


/*
SET IDENTITY_INSERT IdentityTable ON 

SET IDENTITY_INSERT IdentityTable OFF
*/
