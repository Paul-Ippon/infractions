with
    get_source as (select * from {{ ref("210_300_LOAD_ZONAGES_SUPRACOMMUNAUX") }}),
    split_data as (
        select distinct
            code_epci,
            nature_epci,
            current_timestamp::timestamp as inserted_at,
            current_timestamp::timestamp as updated_at
        from get_source
    )
select *
from split_data
