with
    get_source as (
        select *
        from {{ ref("210_050_STG_CODE_LIBELLES") }}
    ),
    cast_data as (
        select
            variable::varchar(32) as variable,
            code::varchar(2) as code,
            libelle::varchar(255) as libelle
        from get_source
    )
select *
from cast_data
