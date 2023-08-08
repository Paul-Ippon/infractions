with
    get_source as (select * from {{ ref("210_030_LOAD_ZONAGES_SUPRACOMMUNAUX") }}),
    split_data as (
        select distinct
            uu2020,
            tuu2017,
            tduu2017,
            '{{ get_now() }}'::timestamp as inserted_at,
            '{{ get_now() }}'::timestamp as updated_at
        from get_source
    )
select *
from split_data
