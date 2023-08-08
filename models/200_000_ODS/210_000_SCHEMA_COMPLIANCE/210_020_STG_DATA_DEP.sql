with
    get_source as (select * from {{ source("DSA_DATA_DEP", "DATA_DEP") }}),
    replace_comma as (
        select
            classe,
            annee,
            codedepartement,
            coderegion,
            unitedecompte,
            millpop,
            milllog,
            faits,
            pop,
            replace(log, ',', '.') as log,
            replace(tauxpourmille, ',', '.') as tauxpourmille
        from get_source
    ),
    check_type as (
        select
            iff(len(classe) > 255, '{{ var("err_value") }}', classe) as classe,
            iff(len(annee) > 2, '{{ var("err_value") }}', annee) as annee,
            iff(
                len(codedepartement) > 3, '{{ var("err_value") }}', codedepartement
            ) as codedepartement,
            iff(
                len(coderegion) > 2, '{{ var("err_value") }}', coderegion
            ) as coderegion,
            iff(
                len(unitedecompte) > 255, '{{ var("err_value") }}', unitedecompte
            ) as unitedecompte,
            iff(len(millpop) > 2, '{{ var("err_value") }}', millpop) as millpop,
            iff(len(milllog) > 2, '{{ var("err_value") }}', milllog) as milllog,
            iff(
                faits is null,
                faits,
                iff(try_cast(faits as int) is not null, faits, '{{ var("err_value") }}')
            ) as faits,
            iff(
                pop is null,
                pop,
                iff(try_cast(pop as int) is not null, pop, '{{ var("err_value") }}')
            ) as pop,
            iff(
                log is null,
                log,
                iff(try_cast(log as double) is not null, log, '{{ var("err_value") }}')
            ) as log,
            iff(
                tauxpourmille is null,
                tauxpourmille,
                iff(
                    try_cast(tauxpourmille as double) is not null,
                    tauxpourmille,
                    '{{ var("err_value") }}'
                )
            ) as tauxpourmille
        from replace_comma
    )
select *
from check_type
