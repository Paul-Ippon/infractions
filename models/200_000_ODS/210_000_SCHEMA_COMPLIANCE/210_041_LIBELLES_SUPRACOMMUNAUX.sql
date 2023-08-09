with
    get_source as (
        select *
        from {{ ref("210_040_STG_LIBELLES_SUPRACOMMUNAUX") }}
    ),
    cast_data as (
        select
            nivgeo::varchar(7) as nivgeo,
            codgeo::varchar(9) as codgeo,
            libgeo::varchar(255) as libgeo,
            nb_com::smallint as nb_com
        from get_source
    )
select *
from cast_data
