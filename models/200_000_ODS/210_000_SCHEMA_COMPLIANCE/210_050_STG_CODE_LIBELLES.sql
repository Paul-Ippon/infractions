with
    get_source as (
        select *
        from {{ source("DSA_CODE_LIBELLES", "CODE_LIBELLES") }}
    ),
    check_type as (
        select
            iff(len(variable) > 32, '{{ var("err_value") }}', variable) as variable,
            iff(len(code) > 2, '{{ var("err_value") }}', code) as code,
            iff(len(libelle) > 255, '{{ var("err_value") }}', libelle) as libelle
        from get_source
    )
select *
from check_type
