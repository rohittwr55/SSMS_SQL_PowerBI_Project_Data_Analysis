-----------------------------------------------------------------------------------------------------------------------
                 --  Golden Layer started
--------------------------------------------------------------------------------------------------------------------
--Creating a golden layer and creating Views so consumer can use them

-----------------------------------------------------------------------------------------------------------------
                                  ----Customer Dimesion created as View
----------------------------------------------------------------------------------------------------------------

create view gold.dim_customer_vw as

select 
ROW_NUMBER() over (order by cst_id) as Customer_key,
CI.cst_id as Customer_ID,
CI.cst_key as Customer_number,
CI.cst_firstname as First_name,
CI.cst_lastname as Last_name,
CI.cst_marital_status as Marital_status,
--We have different different data in gender from CI and CA so the correct value will be from CI table
case when CI.cst_gndr != 'n/a' then CI.cst_gndr --cst_gender is the master table to
	 else COALESCE(ca.gen, 'n/a')
end as Gender,
CI.cst_create_date as Create_date,
CA.BDATE as Birth_date,
LOC.CNTRY as Country
from silver.crm_cust_info as CI
left join silver.erp_CUST_AZ12 as CA
on CI.cst_key = CA.CID 
left join silver.erp_LOC_A101 as LOC
on LOC.CID = CA.CID

--- Check duplicate data in above query
select 
	cst_id, 
	count(*)
from
(
	select 
CI.cst_id,
CI.cst_key,
CI.cst_firstname,
CI.cst_lastname,
CI.cst_marital_status,
CA.BDATE,
CA.GEN,
LOC.CNTRY,
CI.cst_create_date
from silver.crm_cust_info as CI
left join silver.erp_CUST_AZ12 as CA
on CI.cst_key = CA.CID 
left join silver.erp_LOC_A101 as LOC
on LOC.CID = CA.CID
) as t
group by cst_id 
having COUNT(*) >1

-----------------------------------------------------------------------------------------------------------------
                                  ----Product Dimesioncreated as View
----------------------------------------------------------------------------------------------------------------

create view gold.dim_product_vw as
select 
	 ROW_NUMBER() over (order by prd.prd_start_dt, prd.prd_key) as Product_key,
	 prd.prd_id as Product_ID,
	 prd.prd_key as Product_number,
	 prd.prd_nm as Product_name,
	 prd.cat_id as Category_ID,
	 cat.CAT as Category,
	 cat.SUBCAT as SubCategory,
	 cat.MAINTENANCE as Maintainenance,
	 prd.prd_cost as Product_cost,
	 prd.prd_line as Product_line,
	 prd.prd_start_dt as Start_Dates
from silver.crm_prd_info as prd
left join silver.erp_PX_CAT_G1V2 cat
on cat.ID = prd.cat_id

--- Check duplicate data in above query
select prd_id,count(*) from
(
select 
	 prd.prd_id,
	 prd.cat_id,
	 prd.prd_nm,
	 prd.prd_cost,
	 prd.prd_line,
	 prd.prd_start_dt,
	 prd.prd_end_dt,
	 cat.CAT,
	cat.SUBCAT,
	cat.MAINTENANCE
from silver.crm_prd_info as prd
left join silver.erp_PX_CAT_G1V2 cat
on cat.ID = prd.cat_id
) as t
group by prd_id 
having count(*) >1 

-----------------------------------------------------------------------------------------------------------------
                                  ----Sales Fact created as View
----------------------------------------------------------------------------------------------------------------

create view gold.fact_Sales_vw as
select 
	 sl.sls_ord_num as Order_number,
	 dc.Customer_key,
	 dp.Product_key,
	 sl.sls_order_dt as Order_date,
	 sl.sls_ship_dt as Ship_date,
	 sl.sls_due_dt as Due_date,
	 sl.sls_quantity as Quantity,
	 sl.sls_price as Price,
	 sl.sls_sales as Sales
from silver.crm_sales_details as sl
left join gold.dim_product_vw as dp
on sl.sls_prd_key = dp.Product_number
left join gold.dim_customer_vw as dc
on sl.sls_cust_id = dc.customer_id

