with get_source as (select * from {{ ref("210_071_LIBELLES_UNITEDECOMPTE") }})
select *
from get_source
