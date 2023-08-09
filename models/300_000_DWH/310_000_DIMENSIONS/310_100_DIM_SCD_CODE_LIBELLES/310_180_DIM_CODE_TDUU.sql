with
    get_source as (select * from {{ ref("210_051_CODE_LIBELLES") }}),
    split_data as (
        select distinct
            variable,
            code,
            libelle
        from get_source
        where variable = 'TDUU2017'
    )
select *
from split_data
