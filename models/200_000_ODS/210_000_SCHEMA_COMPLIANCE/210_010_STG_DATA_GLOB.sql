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
    check_type as (
        select
            iff(len(codgeo) > 5, '{{ var("err_value") }}', codgeo) as codgeo,
            iff(len(annee) > 2, '{{ var("err_value") }}', annee) as annee,
            iff(len(classe) > 255, '{{ var("err_value") }}', classe) as classe,
            iff(
                len(valeurpubliee) > 255, '{{ var("err_value") }}', valeurpubliee
            ) as valeurpubliee,
            iff(
                len(unitedecompte) > 5, '{{ var("err_value") }}', unitedecompte
            ) as unitedecompte,
            iff(
                faits is null,
                faits,
                iff(try_cast(faits as int) is not null, faits, '{{ var("err_value") }}')
            ) as faits,
            iff(
                tauxpourmille is null,
                tauxpourmille,
                iff(
                    try_cast(tauxpourmille as double) is not null,
                    tauxpourmille,
                    '{{ var("err_value") }}'
                )
            ) as tauxpourmille,
            iff(
                complementinfoval is null,
                complementinfoval,
                iff(
                    try_cast(complementinfoval as double) is not null,
                    complementinfoval,
                    '{{ var("err_value") }}'
                )
            ) as complementinfoval,
            iff(
                complementinfotaux is null,
                complementinfotaux,
                iff(
                    try_cast(complementinfotaux as double) is not null,
                    complementinfotaux,
                    '{{ var("err_value") }}'
                )
            ) as complementinfotaux,
            iff(
                pop is null,
                pop,
                iff(try_cast(pop as int) is not null, pop, '{{ var("err_value") }}')
            ) as pop,
            iff(
                millpop is null,
                millpop,
                iff(
                    try_cast(millpop as tinyint) is not null,
                    millpop,
                    '{{ var("err_value") }}'
                )
            ) as millpop,
            iff(
                log is null,
                log,
                iff(try_cast(log as double) is not null, log, '{{ var("err_value") }}')
            ) as log,
            iff(
                milllog is null,
                milllog,
                iff(
                    try_cast(milllog as tinyint) is not null,
                    milllog,
                    '{{ var("err_value") }}'
                )
            ) as milllog
        from replace_na
    )
select *
from check_type
