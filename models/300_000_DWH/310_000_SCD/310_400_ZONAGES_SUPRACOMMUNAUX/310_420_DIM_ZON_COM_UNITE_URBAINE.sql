with
    get_source as (select * from {{ ref("210_031_ZONAGES_SUPRACOMMUNAUX") }}),
    split_data as (
        select distinct
            uu,
            tuu,
            tduu
        from get_source
    )
select *
from split_data
