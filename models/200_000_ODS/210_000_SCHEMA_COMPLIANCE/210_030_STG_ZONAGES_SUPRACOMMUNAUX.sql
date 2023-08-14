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
            iff(len(ze) > 5, '{{ var("err_value") }}', ze) as ze,
            iff(len(uu) > 5, '{{ var("err_value") }}', uu) as uu,
            iff(len(tuu) > 255, '{{ var("err_value") }}', tuu) as tuu,
            iff(len(tduu) > 255, '{{ var("err_value") }}', tduu) as tduu,
            iff(
                len(uustatut) > 255, '{{ var("err_value") }}', uustatut
            ) as uustatut,
            iff(len(aav) > 3, '{{ var("err_value") }}', aav) as aav,
            iff(len(taav) > 255, '{{ var("err_value") }}', taav) as taav,
            iff(len(tdaav) > 255, '{{ var("err_value") }}', tdaav) as tdaav,
            iff(
                len(cateaav) > 255, '{{ var("err_value") }}', cateaav
            ) as cateaav,
            iff(len(bv) > 5, '{{ var("err_value") }}', bv) as bv,
            iff(
                len(typo_degre_densite) > 255,
                '{{ var("err_value") }}',
                typo_degre_densite
            ) as typo_degre_densite
        from get_source
    )
select *
from check_type
