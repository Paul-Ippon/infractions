{% snapshot DIM_ZON_COM_EPCI_SCD %}
    {{
        config(
            target_database=target.database,
            target_schema=target.schema + "_DWH",
            unique_key="code_epci",  
            strategy="check",
            check_cols="all"
        )
    }}

    select *
    from {{ source("DWH_DIM_ZON_COM_EPCI", "DIM_ZON_COM_EPCI") }}

{% endsnapshot %}
