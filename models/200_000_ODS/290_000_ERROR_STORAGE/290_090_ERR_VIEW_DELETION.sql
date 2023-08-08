{% set nodes = [] -%}

{% for node in graph.nodes.values() %}
    {%- if node.config.schema == "ODS" 
    and node.config.materialized == "view" 
    and ("ERR" in node.name or "STG" in node.name) -%}
        {%- do nodes.append(node) -%}
    {%- endif -%}
{% endfor %}

{% set query %}
    {%- for node in nodes %}
        drop view if exists {{ node.database }}.{{ node.schema }}.{{ node.alias }};
    {% endfor %}
{% endset %}

{% do run_query(query) %}

select *
from {{ ref("290_010_ERR_STORAGE") }}
limit 1
