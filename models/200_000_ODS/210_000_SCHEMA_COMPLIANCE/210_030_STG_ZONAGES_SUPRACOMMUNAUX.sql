with
    get_source as (
        select *
        from {{ source("DSA_ZONAGES_SUPRACOMMUNAUX", "ZONAGES_SUPRACOMMUNAUX") }}
    ),
    check_type as (
        select
            iff(len(codgeo) > 5, '{{ var("err_value") }}', codgeo) as codgeo,
            iff(
                len(nom_de_la_commune) > 255,
                '{{ var("err_value") }}',
                nom_de_la_commune
            ) as nom_de_la_commune,
            iff(
                len(code_departement) > 3, '{{ var("err_value") }}', code_departement
            ) as code_departement,
            iff(
                len(code_region) > 2, '{{ var("err_value") }}', code_region
            ) as code_region,
            iff(
                len(code_arrondissement) > 4,
                '{{ var("err_value") }}',
                code_arrondissement
            ) as code_arrondissement,
            iff(
                len(code_canton) > 5, '{{ var("err_value") }}', code_canton
            ) as code_canton,
            iff(len(code_epci) > 9, '{{ var("err_value") }}', code_epci) as code_epci,
            iff(
                len(nature_epci) > 255, '{{ var("err_value") }}', nature_epci
            ) as nature_epci,
            iff(len(ze2020) > 5, '{{ var("err_value") }}', ze2020) as ze2020,
            iff(len(uu2020) > 5, '{{ var("err_value") }}', uu2020) as uu2020,
            iff(len(tuu2017) > 255, '{{ var("err_value") }}', tuu2017) as tuu2017,
            iff(len(tduu2017) > 255, '{{ var("err_value") }}', tduu2017) as tduu2017,
            iff(
                len(uustatut2017) > 255, '{{ var("err_value") }}', uustatut2017
            ) as uustatut2017,
            iff(len(aav2020) > 3, '{{ var("err_value") }}', aav2020) as aav2020,
            iff(len(taav2017) > 255, '{{ var("err_value") }}', taav2017) as taav2017,
            iff(len(tdaav2017) > 255, '{{ var("err_value") }}', tdaav2017) as tdaav2017,
            iff(
                len(cateaav2020) > 255, '{{ var("err_value") }}', cateaav2020
            ) as cateaav2020,
            iff(len(bv2012) > 5, '{{ var("err_value") }}', bv2012) as bv2012,
            iff(
                len(typo_degre_densite) > 255,
                '{{ var("err_value") }}',
                typo_degre_densite
            ) as typo_degre_densite
        from get_source
    )
select *
from check_type
