{% snapshot DIM_CODE_UUSTATUT_SCD %}
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
    from {{ source("DWH_DIM_CODE_UUSTATUT", "DIM_CODE_UUSTATUT") }}

{% endsnapshot %}
