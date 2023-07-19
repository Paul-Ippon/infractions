with
    get_source as (select * from {{ ref("210_300_LOAD_ZONAGES_SUPRACOMMUNAUX") }}),
    get_uustatut as (
        select * from {{ ref("DIM_CODE_UUSTATUT_SCD") }} where dbt_valid_to is null
    ),
    get_cateaav as (
        select * from {{ ref("DIM_CODE_CATEAAV_SCD") }} where dbt_valid_to is null
    ),
    get_typo_degre_densite as (
        select *
        from {{ ref("DIM_CODE_TYPO_DEGRE_DENSITE_SCD") }}
        where dbt_valid_to is null
    ),
    split_dimension as (
        select distinct
            codegeo,
            nom_de_la_commune,
            code_departement,
            code_region,
            code_arrondissement,
            code_canton,
            code_epci,
            ze2020 as ze,
            uu2020 as uu,
            uustatut2017 as uustatut,
            aav2020 as aav,
            cateaav2020 as cateaav,
            bv2012 as bv,
            typo_degre_densite
        from get_source
    ),
    join_code_libelles as (
        select
            codegeo,
            nom_de_la_commune,
            code_departement,
            code_region,
            code_arrondissement,
            code_canton,
            code_epci,
            ze,
            uu,
            uustatut.code as uustatut,
            aav,
            cateaav.code as cateaav,
            bv,
            typo_degre_densite.code as typo_degre_densite
        from split_dimension source
        left join get_uustatut uustatut on source.uustatut = uustatut.libelle
        left join get_cateaav cateaav on source.cateaav = cateaav.libelle
        left join
            get_typo_degre_densite typo_degre_densite
            on source.typo_degre_densite = typo_degre_densite.libelle
    ),
    add_timestamp as (
        select
            *,
            current_timestamp::timestamp as inserted_at,
            current_timestamp::timestamp as updated_at
        from join_code_libelles
    )
select *
from add_timestamp
