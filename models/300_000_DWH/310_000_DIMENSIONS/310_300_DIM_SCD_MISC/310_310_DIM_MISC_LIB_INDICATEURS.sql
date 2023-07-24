with get_source as (select * from {{ ref("210_600_LOAD_LIBELLES_INDICATEURS") }})
select *
from get_source
