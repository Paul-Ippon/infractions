with
    get_source as (select * from {{ ref("210_041_LIBELLES_SUPRACOMMUNAUX") }}),
    split_data as (
        select distinct
            regexp_replace(nivgeo, '\\d{4}', '')::varchar(7) as nivgeo,
            codgeo,
            libgeo,
            nb_com
        from get_source
        where regexp_replace(nivgeo, '\\d{4}', '') = 'ZE'
    )
select *
from split_data
