with
    get_source as (select * from {{ ref("210_400_LOAD_LIBELLES_SUPRACOMMUNAUX") }}),
    split_data as (
        select distinct
            nivgeo,
            codgeo,
            libgeo,
            nb_com
        from get_source
        where nivgeo = 'CV'
    )
select *
from split_data
