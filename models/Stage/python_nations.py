import snowflake.snowpark.functions as sf

def model(dbt,session):
    dbt.config(materialized="table",schema="stgpy",alias="stg_nations")
    tdf = dbt.source("src", "nations")
    df = tdf.groupBy('n_regionkey').agg( sf.count(sf.col('n_nationkey')).alias('TotalNations')) 
    df1 = df.rename(sf.col('N_REGIONKEY'),'Regions')
    # tdf = dbt.ref("stg_nations")
    # df = tdf.groupBy('region_id').agg( sf.count(sf.col('nation_id')).alias('TotalNations')) 
    # df1 = df.rename(sf.col('REGION_ID'),'Regions')
    return df1
