with
    get_source as (
        select *
        from {{ source("DSA_LIBELLES_INDICATEURS", "LIBELLES_INDICATEURS") }}
    ),
    cast_data as (
        select
            code::varchar(2) as code,
            libelle::varchar(255) as libelle
        from get_source
    )
select *
from cast_data
