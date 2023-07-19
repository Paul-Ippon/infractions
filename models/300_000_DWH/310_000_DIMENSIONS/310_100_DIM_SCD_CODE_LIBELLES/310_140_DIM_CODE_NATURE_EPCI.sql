with
    get_source as (select * from {{ ref("210_500_LOAD_CODE_LIBELLES") }}),
    split_data as (
        select distinct
            variable,
            code,
            libelle
        from get_source
        where variable = 'NATURE_EPCI'
    )
select *
from split_data