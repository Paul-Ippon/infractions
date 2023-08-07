{{ config(alias="FACT_DATA_DEP") }}

with
    get_source as (select * from {{ ref("210_020_LOAD_DATA_DEP") }}),
    get_dim_classe as (select * from {{ ref("DIM_MISC_LIB_INDICATEURS_SCD") }}),
    get_dim_unitedecompte as (
        select * from {{ ref("DIM_MISC_LIB_UNITEDECOMPTE_SCD") }}
    ),
    cast_annee as (
        select
            classe,
            ('20' || annee || '-12-31')::date as annee,
            codedepartement,
            coderegion,
            unitedecompte,
            ('20' || millpop || '-12-31')::date as millpop,
            ('20' || milllog || '-12-31')::date as milllog,
            faits,
            pop,
            log,
            tauxpourmille
        from get_source
    ),
    classe_lib_to_classe_code as (
        select
            get_dim_classe.code as codeclasse,
            cast_annee.annee,
            cast_annee.codedepartement,
            cast_annee.coderegion,
            cast_annee.unitedecompte,
            cast_annee.millpop,
            cast_annee.milllog,
            cast_annee.faits,
            cast_annee.pop,
            cast_annee.log,
            cast_annee.tauxpourmille
        from cast_annee
        inner join get_dim_classe on cast_annee.classe = get_dim_classe.libelle
    ),
    unitedecompte_lib_to_unitedecompte_code as (
        select
            classe_lib_to_classe_code.codeclasse,
            classe_lib_to_classe_code.annee,
            classe_lib_to_classe_code.codedepartement,
            classe_lib_to_classe_code.coderegion,
            get_dim_unitedecompte.code as codeunitedecompte,
            classe_lib_to_classe_code.millpop,
            classe_lib_to_classe_code.milllog,
            classe_lib_to_classe_code.faits,
            classe_lib_to_classe_code.pop,
            classe_lib_to_classe_code.log,
            classe_lib_to_classe_code.tauxpourmille
        from classe_lib_to_classe_code
        inner join
            get_dim_unitedecompte
            on classe_lib_to_classe_code.unitedecompte = get_dim_unitedecompte.libelle
    ),
    add_timestamp as (
        select
            *,
            current_timestamp::timestamp as inserted_at,
            current_timestamp::timestamp as updated_at
        from unitedecompte_lib_to_unitedecompte_code
    )
select *
from add_timestamp
