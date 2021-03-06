/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [COMPANY]
      ,[REQ_NUMBER]
      ,[REQ_LINE]
      ,[ItemNumber]
      ,[LOCATION]
      ,[TOCOMPANY]
      ,[REQ_LOCATION]
      ,[QTY]
      ,[UOM]
      ,[GL]
      ,[DEPARTMENT]
      ,[UNITPRICE]
      ,[TOTALPRICE]
      ,[CYEAR]
      ,[CMONTH]
      ,[CDAY]
  FROM [Caldwell].[dbo].[Requisition]


  select
  sb.LocationID,
  sl.Line,
  sl.ItemID,
  sl.Qty,

  sb.ScanDateTime
  from scan.ScanBatch sb
  inner join scan.ScanLine sl on sb.ScanBatchID = sl.ScanBatchID
  where LocationID = 'BB-AN' and ItemID = '260102'
  order by sb.ScanDateTime,LocationID,Line

  select
  REQ_LOCATION,
  [REQ_LINE],
  ItemNumber,
  QTY,
   convert(Datetime,(convert(varchar,[CYEAR],4)+'/'+RIGHT(('0'+convert(varchar,[CMONTH],2)),2)+'/'+RIGHT(('0'+convert(varchar,[CDAY],2)),2)),101) as ScanDateTime
   FROM
  [Caldwell].[dbo].[Requisition] where LOCATION = 'BB-AN'  and ItemNumber = '260102'
  order by convert(Datetime,(convert(varchar,[CYEAR],4)+'/'+RIGHT(('0'+convert(varchar,[CMONTH],2)),2)+'/'+RIGHT(('0'+convert(varchar,[CDAY],2)),2)),101),REQ_LOCATION,REQ_LINE
