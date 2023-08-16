{% snapshot DIM_LIB_COM_REG_SCD %}
    {{
        config(
            target_database=target.database,
            target_schema=target.schema + "_DWH",
            unique_key="codgeo",  
            strategy="check",
            check_cols="all"
        )
    }}

    select *
    from {{ source("DWH_DIM_LIB_COM_REG", "DIM_LIB_COM_REG") }}

{% endsnapshot %}
