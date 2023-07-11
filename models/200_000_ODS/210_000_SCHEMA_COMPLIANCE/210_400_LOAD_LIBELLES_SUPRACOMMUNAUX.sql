with
    get_source as (
        select *
        from {{ source("DSA_LIBELLES_SUPRACOMMUNAUX", "LIBELLES_SUPRACOMMUNAUX") }}
    ),
    cast_data as (
        select
            nivgeo::varchar(7) as nivgeo,
            codgeo::varchar(9) as codgeo,
            libgeo::varchar(255) as libgeo,
            nb_com::varchar(4) as nb_com
        from get_source
    )
select *
from cast_data
