select
    '{{ invocation_id }}' as globalrunuuid,
    '{{ run_started_at.astimezone(modules.pytz.timezone("Europe/Paris")).strftime("%Y-%m-%d %H:%M:%S.%f") }}'
    ::timestamp as globalrunstartedat
