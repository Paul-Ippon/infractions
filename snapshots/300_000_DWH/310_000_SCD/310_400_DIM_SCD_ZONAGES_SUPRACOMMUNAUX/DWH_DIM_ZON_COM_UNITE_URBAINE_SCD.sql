{% snapshot DIM_ZON_COM_UNITE_URBAINE_SCD %}
    {{
        config(
            target_database=target.database,
            target_schema=target.schema + "_DWH",
            unique_key="uu",  
            strategy="check",
            check_cols="all"
        )
    }}

    select *
    from {{ source("DWH_DIM_ZON_COM_UNITE_URBAINE", "DIM_ZON_COM_UNITE_URBAINE") }}

{% endsnapshot %}
