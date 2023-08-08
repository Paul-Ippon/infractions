with get_source as (select * from {{ ref("210_060_LOAD_LIBELLES_INDICATEURS") }})
select *
from get_source
