
if exists (select * from dbo.sysobjects where id = object_id(N'sp_SelectScanFacilities') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure sp_SelectScanFacilities
GO

--exec sp_SelectScanFacilities ''
CREATE PROCEDURE sp_SelectScanFacilities


--WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

SELECT DISTINCT 
convert(varchar,(convert(Date,ScanDateTime)),111) as ScanDate
from scan.ScanBatch
WHERE Active = 1 --and convert(Date,ScanDateTime) = @ScanDate 
order by 1 desc

END 
GO
grant exec on sp_SelectScanFacilities to public
GO