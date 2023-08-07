{%- set dict = m_format_ods_error("210_020_LOAD_DATA_DEP").items() %}

select
    {% for key, value in dict %}
        {{ value }} as {{ key }} {% if not loop.last %}, {% endif %}
    {% endfor %}
