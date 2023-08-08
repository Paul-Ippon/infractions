{% macro get_now() %}

     {% set get_now = modules.datetime.datetime.now().astimezone(modules.pytz.timezone("Europe/Paris")) %}

    {{ return(get_now) }}

{% endmacro %}