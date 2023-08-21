with
    get_source_explicit as (select * from {{ ref("330_111_FACT_DATA_GLOB_EXPLICIT") }}),
    get_source_implicit as (select * from {{ ref("330_112_FACT_DATA_GLOB_IMPLICIT") }}),
    unify_fact_glob as (
        select 'EXPLICIT' as datatype, *
        from get_source_explicit
        union
        select 'IMPLICIT' as datatype, *
        from get_source_implicit
    )
select *
from unify_fact_glob
