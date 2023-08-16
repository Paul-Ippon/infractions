with
    get_source as (select * from {{ ref("210_031_ZONAGES_SUPRACOMMUNAUX") }}),
    get_uustatut as (
        select *
        from {{ ref("DIM_CODE_UUSTATUT_SCD") }}
        qualify
            row_number() over (partition by code, libelle order by dbt_valid_from desc)
            = 1
    ),
    get_cateaav as (
        select *
        from {{ ref("DIM_CODE_CATEAAV_SCD") }}
        qualify
            row_number() over (partition by code, libelle order by dbt_valid_from desc)
            = 1
    ),
    get_typo_degre_densite as (
        select *
        from {{ ref("DIM_CODE_TYPO_DEGRE_DENSITE_SCD") }}
        qualify
            row_number() over (partition by code, libelle order by dbt_valid_from desc)
            = 1
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
            ze as ze,
            uu as uu,
            uustatut as uustatut,
            aav as aav,
            cateaav as cateaav,
            bv as bv,
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
            uustatut.dbt_scd_id as uustatut_scd_id,
            aav,
            cateaav.dbt_scd_id as cateaav_scd_id,
            bv,
            typo_degre_densite.code as typo_degre_densite,
            typo_degre_densite.dbt_scd_id as typo_degre_densite_scd_id
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
            '{{ get_now() }}'::timestamp as inserted_at,
            '{{ get_now() }}'::timestamp as updated_at
        from join_code_libelles
    )
select *
from add_timestamp
