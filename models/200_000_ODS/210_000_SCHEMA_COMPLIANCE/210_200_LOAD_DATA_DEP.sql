with
    get_source as (select * from {{ source("DSA_DATA_DEP", "DATA_DEP") }}),
    replace_comma as (
        select
            classe,
            annee,
            code_departement,
            code_region,
            unite_de_compte,
            millpop,
            milllog,
            faits,
            pop,
            replace(log, ',', '.') as log,
            replace(tauxpourmille, ',', '.') as tauxpourmille
        from get_source
    ),
    cast_data as (
        select
            classe::varchar(255) as classe,
            annee::varchar(2) as annee,
            code_departement::varchar(3) as code_departement,
            code_region::varchar(2) as code_region,
            unite_de_compte::varchar(255) as unite_de_compte,
            millpop::varchar(2) as millpop,
            milllog::varchar(2) as milllog,
            faits::int as faits,
            pop::int as pop,
            log::double as log,
            tauxpourmille::double as tauxpourmille
        from replace_comma
    )
select *
from cast_data
