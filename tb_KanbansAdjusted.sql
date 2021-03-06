if exists (select * from dbo.sysobjects where id = object_id(N'tb_KanbansAdjusted') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure tb_KanbansAdjusted
GO

--exec tb_KanbansAdjusted

CREATE PROCEDURE [dbo].[tb_KanbansAdjusted] 
	
AS

BEGIN

with C as
(select 
[Date] 
,BinKey
,LocationID
,ItemID
,BinQty as YestBinQty
,BinUOM as YesBinUOM
--,OrderQty as YestOrderQty
--,OrderUOM as YestOrderUOM
from tableau.Kanban 
where [Date] >= getdate() -8 )
,
D as
(
select 
DATEPART(WEEK,a.[Date]) as [Week]
,a.[Date]
,C.[Date] as Yesterday
,a.BinKey
,a.LocationID
,dl.LocationName
,a.ItemID
,di.ItemDescription
,convert(int,a.BinQty) as BinQty
,a.BinUOM
,convert(int,C.YestBinQty) as YestBinQty
--,C.YesBinUOM
,a.OrderQty
,a.OrderUOM
--,C.YestOrderQty
--,C.YestOrderUOM
,convert(int,a.BinQty) - convert(int,C.YestBinQty) as BinChange
,a.OrderQty - convert(int,C.YestBinQty) as BinOrderChange
,a.BinCurrentStatus

from tableau.Kanban a
left join C on a.BinKey = C.BinKey and a.[Date]-1 = C.[Date]
left join bluebin.DimItem di on a.ItemID = di.ItemID
left join bluebin.DimLocation dl on a.LocationID = dl.LocationID
where a.[Date] >= getdate() -7
)
select 
[Week]
,[Date],Yesterday
,BinKey
,LocationID
,LocationName
,ItemID
,ItemDescription
,BinQty
,YestBinQty
,BinUOM
,OrderQty
,OrderUOM
, case when BinChange != 0 then 1 else BinChange end as BinChange
, case when BinOrderChange != 0 then 1 else BinOrderChange end as BinOrderChange
,BinCurrentStatus 
from D 
where 
(BinOrderChange != 0 or BinChange != 0)
	and BinUOM = OrderUOM 
		and OrderQty is not null
			and [Date] >= getdate() -7
order by LocationName,ItemDescription,[Date]
END
GO
grant exec on tb_KanbansAdjusted to public
GO