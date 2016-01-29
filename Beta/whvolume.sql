

	
	


WITH AA AS
(	
select 
		LOCATION,
		ITEM,
       SOH_QTY       AS SOHQty,
	   LAST_ISS_COST	AS UnitCost,
	   DATEADD(DAY,(DATEDIFF(DAY,eomonth(getdate()),getdate())),eomonth(getdate())) as MonthEnd
from ITEMLOC 
where 
	(LOCATION in (Select ConfigValue from bluebin.Config where ConfigName = 'LOCATION')) 
	and 
	(SOH_QTY > 0 
	OR 
	(SOH_QTY = 0 and ITEM in (select distinct ITEM from ICTRANS where LOCATION in (Select ConfigValue from bluebin.Config where ConfigName = 'LOCATION'))))
	--AND ITEM in ('0000013','0000018')
),
BB as
(
    SELECT 
		Row_number()
             OVER(
               PARTITION BY a.ITEM
               ORDER BY a.MonthEnd DESC) as [Sequence],
		a.MonthEnd,
		a.ITEM,
		case when a.MonthEnd = DATEADD(DAY,(DATEDIFF(DAY,eomonth(getdate()),getdate())),eomonth(getdate())) then AA.SOHQty else (ISNULL(b.QUANTITY,0)*-1) end as QUANTITY


    --INTO   bluebin.FactWarehouseSnapshot
    FROM   
	(SELECT DISTINCT 
		case when left(Date,11) = left(getdate(),11) then Date else Eomonth(Date) end AS MonthEnd,
		ITEM
		FROM   bluebin.DimDate,AA) a
		LEFT JOIN
		(select 
			ITEM,
			EOMONTH(DATEADD(MONTH, -1, TRANS_DATE)) as MonthEnd,
			--Eomonth(TRANS_DATE) as MonthEnd,
			SUM((QUANTITY)) as QUANTITY 
			FROM   ICTRANS 
			where 
				LOCATION in (Select ConfigValue from bluebin.Config where ConfigName = 'LOCATION')
			group by ITEM,
			--Eomonth(TRANS_DATE),
			EOMONTH(DATEADD(MONTH, -1, TRANS_DATE))) b on a.MonthEnd = b.MonthEnd and a.ITEM = b.ITEM 
		left join AA on a.MonthEnd = AA.MonthEnd and a.ITEM = AA.ITEM
    WHERE  a.MonthEnd <= Getdate()
)


select 
ic.COMPANY AS FacilityKey,
ic.LOCATION as LocationID,
BB.MonthEnd as SnapshotDate,
BB.ITEM,
SUM(BB.QUANTITY) OVER (PARTITION BY BB.ITEM ORDER BY BB.[Sequence]) as SOH,
ic.LAST_ISS_COST  AS UnitCost
--INTO   bluebin.FactWarehouseSnapshot
from BB 
inner join ITEMLOC ic on BB.ITEM = ic.ITEM
where ic.LOCATION in (Select ConfigValue from bluebin.Config where ConfigName = 'LOCATION')


 


/*********************	DROP Temp Tables		******************************/

