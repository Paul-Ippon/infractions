{{ config(alias="FACT_DATA_GLOB") }}

with
    get_source as (select * from {{ ref("210_100_LOAD_DATA_GLOB") }}),
    get_dim_classe as (select * from {{ ref("DIM_MISC_LIB_INDICATEURS_SCD") }}),
    get_dim_unitedecompte as (
        select * from {{ ref("DIM_MISC_LIB_UNITEDECOMPTE_SCD") }}
    ),
    cast_annee as (
        select
            codgeo,
            ('20' || annee || '-12-31')::date as annee,
            classe,
            unitedecompte,
            valeurpubliee,
            faits,
            tauxpourmille,
            complementinfoval,
            complementinfotaux,
            pop,
            ('20' || millpop || '-12-31')::date as millpop,
            log,
            ('20' || milllog || '-12-31')::date as milllog
        from get_source
    ),
    classe_lib_to_classe_code as (
        select
            cast_annee.codgeo,
            cast_annee.annee,
            get_dim_classe.code as codeclasse,
            cast_annee.unitedecompte,
            cast_annee.valeurpubliee,
            cast_annee.faits,
            cast_annee.tauxpourmille,
            cast_annee.complementinfoval,
            cast_annee.complementinfotaux,
            cast_annee.pop,
            cast_annee.millpop,
            cast_annee.log,
            cast_annee.milllog
        from cast_annee
        inner join get_dim_classe on cast_annee.classe = get_dim_classe.libelle
    ),
    unitedecompte_lib_to_unitedecompte_code as (
        select
            classe_lib_to_classe_code.codgeo,
            classe_lib_to_classe_code.annee,
            classe_lib_to_classe_code.codeclasse,
            get_dim_unitedecompte.code as codeunitedecompte,
            classe_lib_to_classe_code.valeurpubliee,
            classe_lib_to_classe_code.faits,
            classe_lib_to_classe_code.tauxpourmille,
            classe_lib_to_classe_code.complementinfoval,
            classe_lib_to_classe_code.complementinfotaux,
            classe_lib_to_classe_code.pop,
            classe_lib_to_classe_code.millpop,
            classe_lib_to_classe_code.log,
            classe_lib_to_classe_code.milllog
        from classe_lib_to_classe_code
        inner join
            get_dim_unitedecompte
            on classe_lib_to_classe_code.unitedecompte = get_dim_unitedecompte.libelle
    )
select *
from unitedecompte_lib_to_unitedecompte_code
