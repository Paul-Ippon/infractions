with
    get_source as (
        select *
        from {{ source("DSA_LIBELLES_SUPRACOMMUNAUX", "LIBELLES_SUPRACOMMUNAUX") }}
    ),
    check_type as (
        select
            iff(len(nivgeo) > 7, '{{ var("err_value") }}', nivgeo) as nivgeo,
            iff(len(codgeo) > 9, '{{ var("err_value") }}', codgeo) as codgeo,
            iff(len(libgeo) > 255, '{{ var("err_value") }}', libgeo) as libgeo,
            iff(
                nb_com is null,
                nb_com,
                iff(
                    try_cast(nb_com as smallint) is not null,
                    nb_com,
                    '{{ var("err_value") }}'
                )
            ) as nb_com
        from get_source
    )
select *
from check_type
