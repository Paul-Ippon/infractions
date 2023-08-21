with
    get_source as (select * from {{ ref("410_110_UNIFY_FACT_GLOB") }}),
    get_freshness as (
        select top 1 annee
        from get_source
        order by to_varchar(updated_at, 'YYYY-MM-DD/HH') desc, annee asc 
    )
select *
from get_freshness
