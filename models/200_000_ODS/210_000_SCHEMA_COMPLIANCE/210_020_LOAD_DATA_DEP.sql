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
            iff(
                classe is null,
                classe,
                iff(
                    try_cast(classe as varchar(255)) is not null,
                    classe,
                    '{{ var("err_value") }}'
                )
            ) as classe,
            iff(
                annee is null,
                annee,
                iff(
                    try_cast(annee as varchar(2)) is not null,
                    annee,
                    '{{ var("err_value") }}'
                )
            ) as annee,
            iff(
                codedepartement is null,
                codedepartement,
                iff(
                    try_cast(codedepartement as varchar(3)) is not null,
                    codedepartement,
                    '{{ var("err_value") }}'
                )
            ) as codedepartement,
            iff(
                coderegion is null,
                coderegion,
                iff(
                    try_cast(coderegion as varchar(2)) is not null,
                    coderegion,
                    '{{ var("err_value") }}'
                )
            ) as coderegion,
            iff(
                unitedecompte is null,
                unitedecompte,
                iff(
                    try_cast(unitedecompte as varchar(255)) is not null,
                    unitedecompte,
                    '{{ var("err_value") }}'
                )
            ) as unitedecompte,
            iff(
                millpop is null,
                millpop,
                iff(
                    try_cast(millpop as varchar(2)) is not null,
                    millpop,
                    '{{ var("err_value") }}'
                )
            ) as millpop,
            iff(
                milllog is null,
                milllog,
                iff(
                    try_cast(milllog as varchar(2)) is not null,
                    milllog,
                    '{{ var("err_value") }}'
                )
            ) as milllog,
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
