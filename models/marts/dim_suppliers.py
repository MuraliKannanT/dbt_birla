def model(dbt, session):
    
    # Config (equivalent to {{ config(...) }})
    dbt.config(
        materialized="incremental",
        unique_key="supplier_id"
    )

    # Source DataFrames (equivalent to ref())
    supplier_df = dbt.ref("stg_suppliers")
    nation_df = dbt.ref("stg_nations")
    region_df = dbt.ref("stg_regions")

    # Incremental logic
    if dbt.is_incremental:
        max_updated_time = session.sql(f"select max(updated_time) as max_time from {dbt.this}").collect()[0]["MAX_TIME"]
        supplier_df = supplier_df.filter(supplier_df.updated_time > max_updated_time)

    # Joins
    final_df = (
        supplier_df
        .join(nation_df, supplier_df.nation_id == nation_df.nation_id, "left")
        .join(region_df, nation_df.region_id == region_df.region_id, "inner")
        .select(
            supplier_df.supplier_id,
            supplier_df.supplier_name,
            supplier_df.supplier_address,
            nation_df.name.alias("nation"),
            region_df.name.alias("region"),
            supplier_df.phone_number,
            supplier_df.account_balance,
            supplier_df.updated_time
        )
    )

    return final_df