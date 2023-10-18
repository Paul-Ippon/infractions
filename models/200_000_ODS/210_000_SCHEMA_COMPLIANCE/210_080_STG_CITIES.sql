with
    get_source as (
        select *
        from {{ source("DSA_CITIES", "CITIES") }}
    ),
    check_type as(
        select
            iff(len(inseecode) > 5, '{{ var("err_value") }}', inseecode) as inseecode,
            iff(len(citycode) > 255, '{{ var("err_value") }}', citycode) as citycode,
            iff(len(zipcode) > 5, '{{ var("err_value") }}', zipcode) as zipcode,
            iff(len(label) > 255, '{{ var("err_value") }}', label) as label,
            iff(
                latitude is null,
                latitude,
                iff(try_cast(latitude as double) is not null, latitude, '{{ var("err_value") }}')
            ) as latitude,
            iff(
                longitude is null,
                longitude,
                iff(try_cast(longitude as double) is not null, longitude, '{{ var("err_value") }}')
            ) as longitude,
            iff(len(departmentname) > 255, '{{ var("err_value") }}', departmentname) as departmentname,
            iff(len(departmentnumber) > 3, '{{ var("err_value") }}', departmentnumber) as departmentnumber,
            iff(len(regionname) > 255, '{{ var("err_value") }}', regionname) as regionname,
            iff(len(regiongeojsonname) > 255, '{{ var("err_value") }}', regiongeojsonname) as regiongeojsonname
        from get_source
    )
select *
from check_type