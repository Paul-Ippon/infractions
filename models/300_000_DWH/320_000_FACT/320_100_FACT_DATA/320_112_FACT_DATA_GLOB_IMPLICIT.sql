with
    get_source as (select * from {{ ref("320_110_FACT_DATA_GLOB") }}),
    split_data as (
        select 
            codgeo,
            annee,
            codeclasse,
            codeunitedecompte,
            complementinfoval as faits,
            complementinfotaux as tauxpourmille,
            pop,
            millpop,
            log,
            milllog,
            current_timestamp::timestamp as inserted_at,
            current_timestamp::timestamp as updated_at
        from get_source
        where valeurpubliee = 'ndiff'
    )
select *
from split_data
