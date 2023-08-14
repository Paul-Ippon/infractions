with
    get_source as (select * from {{ ref("210_051_CODE_LIBELLES") }}),
    split_data as (
        select distinct
            regexp_replace(variable, '\\d{4}', '')::varchar(32) as variable,
            code,
            libelle
        from get_source
        where regexp_replace(variable, '\\d{4}', '') = 'TUU'
    )
select *
from split_data
