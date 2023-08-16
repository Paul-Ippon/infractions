{% snapshot DIM_ZON_COM_AIRE_ATTRACTIVITE_SCD %}
    {{
        config(
            target_database=target.database,
            target_schema=target.schema + "_DWH",
            unique_key="aav",  
            strategy="check",
            check_cols="all"
        )
    }}

    select *
    from {{ source("DWH_DIM_ZON_COM_AIRE_ATTRACTIVITE", "DIM_ZON_COM_AIRE_ATTRACTIVITE") }}

{% endsnapshot %}
