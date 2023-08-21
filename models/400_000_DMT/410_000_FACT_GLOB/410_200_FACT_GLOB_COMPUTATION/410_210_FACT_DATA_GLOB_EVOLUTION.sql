with
    get_source as (select * from {{ ref("410_110_UNIFY_FACT_GLOB") }}),
    get_freshness as (select * from {{ ref("410_120_CHECK_DWH_FRESHNESS") }}),
    compute_evol_data_glob as (
        select
            past_year.datatype as datatype_debut_annee,
            curr_year.datatype as datatype_fin_annee,
            past_year.codgeo,
            dateadd('day', 1, past_year.annee) as debut_annee,
            curr_year.annee as fin_annee,
            past_year.codeclasse,
            past_year.codeunitedecompte,
            past_year.faits as faits_debut_annee,
            curr_year.faits as faits_fin_annee,
            faits_fin_annee - faits_debut_annee as faits_evolution,
            past_year.tauxpourmille as tauxpourmille_debut_annee,
            curr_year.tauxpourmille as tauxpourmille_fin_annee,
            tauxpourmille_fin_annee
            - tauxpourmille_debut_annee as tauxpourmille_evolution
        from get_source as past_year
        inner join
            get_source as curr_year
            on past_year.codgeo = curr_year.codgeo
            and dateadd('year', 1, past_year.annee) = curr_year.annee
            and past_year.codeclasse = curr_year.codeclasse
        where fin_annee >= (select * from get_freshness)
    ),
    add_timestamp as (
        select
            *,
            '{{ get_now() }}'::timestamp as inserted_at,
            '{{ get_now() }}'::timestamp as updated_at
        from compute_evol_data_glob

    )
select *
from add_timestamp
