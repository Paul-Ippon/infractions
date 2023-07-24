with get_source as (select * from {{ ref("210_700_LOAD_LIBELLES_UNITEDECOMPTE") }})
select *
from get_source
