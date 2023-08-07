with
    get_source as (select * from {{ ref("210_040_LOAD_LIBELLES_SUPRACOMMUNAUX") }}),
    split_data as (
        select distinct
            nivgeo,
            codgeo,
            libgeo,
            nb_com
        from get_source
        where nivgeo = 'BV2012'
    )
select *
from split_data
