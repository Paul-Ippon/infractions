with
    get_source as (select * from {{ ref("210_050_LOAD_CODE_LIBELLES") }}),
    split_data as (
        select distinct
            variable,
            code,
            libelle
        from get_source
        where variable = 'TUU2017'
    )
select *
from split_data
