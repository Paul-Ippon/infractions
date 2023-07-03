with
    get_source as (select * from {{ source("DSA_DATA_GLOB", "DATA_GLOB") }}),
    replace_comma as (
        select
            codgeo,
            annee,
            classe,
            unitedecompte,
            valeurpubliee,
            faits,
            replace(tauxpourmille, ',', '.') as tauxpourmille,
            replace(complementinfoval, ',', '.') as complementinfoval,
            replace(complementinfotaux, ',', '.') as complementinfotaux,
            pop,
            millpop,
            replace(log, ',', '.') as log,
            milllog
        from get_source
    ),
    replace_na as (
        select
            codgeo,
            annee,
            classe,
            unitedecompte,
            valeurpubliee,
            iff(faits = 'NA', null, faits) as faits,
            iff(tauxpourmille = 'NA', null, tauxpourmille) as tauxpourmille,
            iff(complementinfoval = 'NA', null, complementinfoval) as complementinfoval,
            iff(
                complementinfotaux = 'NA', null, complementinfotaux
            ) as complementinfotaux,
            pop,
            millpop,
            iff(log = 'NA', null, log) as log,
            milllog
        from replace_comma
    ),
    cast_data as (
        select
            codgeo::varchar(5) as codgeo,
            annee::varchar(2) as annee,
            classe::varchar(255) as classe,
            unitedecompte::varchar(255) as unitedecompte,
            valeurpubliee::varchar(5) as valeurpubliee,
            faits::int as faits,
            tauxpourmille::double as tauxpourmille,
            complementinfoval::double as complementinfoval,
            complementinfotaux::double as complementinfotaux,
            pop::int as pop,
            millpop::tinyint as millpop,
            log::double as log,
            milllog::tinyint as milllog
        from replace_na
    )
select *
from cast_data
