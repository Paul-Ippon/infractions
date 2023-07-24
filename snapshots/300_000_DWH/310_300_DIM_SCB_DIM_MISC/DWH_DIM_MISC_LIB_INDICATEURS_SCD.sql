{% snapshot DIM_MISC_LIB_INDICATEURS_SCD %}
    {{
        config(
            target_database=target.database,
            target_schema=target.schema + "_DWH",
            unique_key="code",  
            strategy="check",
            check_cols="all"
        )
    }}

    select *
    from {{ source("DWH_DIM_MISC_LIB_INDICATEURS", "DIM_MISC_LIB_INDICATEURS") }}

{% endsnapshot %}
