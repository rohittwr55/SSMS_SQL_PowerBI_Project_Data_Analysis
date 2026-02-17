/*
  We have check all the null value
  unwanted checks
  data standarzztion
  Invalid range
*/

--Inserting clean data into silver table
insert into silver.crm_cust_info
(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)

select 
	cst_id,
	cst_key,
	trim(cst_firstname) as cst_firstname,
	trim(cst_lastname) as cst_lastname,
	case when upper(trim(cst_marital_status)) = 'S' then 'Single'
		 when upper(trim(cst_marital_status)) = 'M' then 'Married'
		 else 'n/a'
	end cst_marital_status,
	case when upper(trim(cst_gndr)) = 'F' then 'Female'
		 when upper(trim(cst_gndr)) = 'M' then 'Male'
		 else 'n/a'
	end cst_gndr,
	cst_create_date
from 
(
	select 
	*,
	ROW_NUMBER() over (partition by cst_id order by cst_create_date desc) as flag 
	from bronze.crm_cust_info
) t where flag =1
----------------
insert into silver.crm_prd_info
(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)

select 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,len(prd_key)) as prd_key,
prd_nm,
isnull(prd_cost,0) as prd_cost,
case 
	when upper(trim(prd_line)) = 'M' then 'Mountain'
	when upper(trim(prd_line)) = 'R' then 'Road'
	when upper(trim(prd_line)) = 'T' then 'Touring'
	when upper(trim(prd_line)) = 'S' then 'Other Sales'
	else 'n/a'
end as prd_line,
cast (prd_start_dt as date) as prd_start_dt,
cast(lead(prd_end_dt) over (partition by prd_key order by prd_start_dt)-1 as date) as prd_end_dt
from bronze.crm_prd_info
--------------------------------

insert into silver.crm_sales_details
(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id	,
	sls_order_dt ,
	sls_ship_dt	,
	sls_due_dt ,
	sls_quantity ,
	sls_price ,
	sls_sales 
)

select 
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	case when sls_order_dt = 0 or LEN(sls_order_dt) !=8 then null
		else cast(cast(sls_order_dt as varchar) as date)
	end as sls_order_dt,
	case when sls_ship_dt = 0 or LEN(sls_ship_dt) !=8 then null
		else cast(cast(sls_ship_dt as varchar) as date)
	end as sls_ship_dt,
	case when sls_due_dt = 0 or LEN(sls_due_dt) !=8 then null
		else cast(cast(sls_due_dt as varchar) as date)
	end as sls_due_dt,
	sls_quantity,
	case when sls_price is null or sls_price <=0
		 then (sls_sales /sls_quantity)
		 else sls_price
	end as sls_price,
	case when sls_sales is null or sls_sales<=0 or sls_sales != sls_quantity * abs(sls_price)
		 then sls_quantity * abs(sls_price)
		 else sls_sales
	end as sls_sales
from bronze.crm_sales_details
-----------------------
insert into silver.erp_CUST_AZ12
(
	cid,
	Bdate,
	Gen
)

select 
	case when CID like 'NAS%' then SUBSTRING(cid, 4, len(cid))
		else cid
	end as cid,
	case when BDATE> GETDATE() then null
		else bdate
	end as bdate,
	case when UPPER(TRIM(gen)) in ('F' , 'FEMALE') then 'Female'
		 when UPPER(TRIM(gen)) in ('M' , 'MALE') then 'Male'
		 else 'n/a'
	end as gen
from bronze.erp_CUST_AZ12

-----------------------
insert into silver.erp_LOC_A101
(
	CID,
	CNTRY
)

select 
	REPLACE(cid,'-','') as CID, 
	case when trim (CNTRY) = 'DE' then 'Germany'
		 when trim (CNTRY) IN ('US', 'USA') then 'United State'
		 when trim (CNTRY) = '' or CNTRY is null then 'n/a'
		 else TRIM(cntry)
	end as CNTRY
from bronze.erp_LOC_A101

-----------------------
insert into silver.erp_PX_CAT_G1V2
(
	ID,
	CAT,
	SUBCAT,
	MAINTENANCE
)

select 
	ID,
	CAT,
	SUBCAT,
	MAINTENANCE
from bronze.erp_PX_CAT_G1V2
