with
    get_source as (select * from {{ ref("210_031_ZONAGES_SUPRACOMMUNAUX") }}),
    split_data as (
        select distinct
            aav2020,
            taav2017,
            tdaav2017,
            '{{ get_now() }}'::timestamp as inserted_at,
            '{{ get_now() }}'::timestamp as updated_at
        from get_source
    )
select *
from split_data
