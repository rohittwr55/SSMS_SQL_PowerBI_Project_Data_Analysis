--Insert data into bronze from csv file to db
truncate table bronze.crm_cust_info;

bulk insert bronze.crm_cust_info
from 'D:\ROHIT MAIN FOLDER\Practice\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

truncate table bronze.crm_prd_info;

bulk insert bronze.crm_prd_info
from 'D:\ROHIT MAIN FOLDER\Practice\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

truncate table bronze.crm_sales_details;

bulk insert bronze.crm_sales_details
from 'D:\ROHIT MAIN FOLDER\Practice\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

truncate table bronze.erp_CUST_AZ12;

bulk insert bronze.erp_CUST_AZ12
from 'D:\ROHIT MAIN FOLDER\Practice\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

truncate table bronze.erp_LOC_A101;

bulk insert bronze.erp_LOC_A101
from 'D:\ROHIT MAIN FOLDER\Practice\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

truncate table bronze.erp_PX_CAT_G1V2;

bulk insert bronze.erp_PX_CAT_G1V2
from 'D:\ROHIT MAIN FOLDER\Practice\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
