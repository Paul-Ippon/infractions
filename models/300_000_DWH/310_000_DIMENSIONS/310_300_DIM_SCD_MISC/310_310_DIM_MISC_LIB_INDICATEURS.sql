with get_source as (select * from {{ ref("210_061_LIBELLES_INDICATEURS") }})
select *
from get_source
