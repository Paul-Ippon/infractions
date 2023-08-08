{% set nodes = [] -%}

{% for node in graph.nodes.values() %}
    {%- if node.config.schema == "ODS" 
    and node.config.materialized == "view" 
    and "ERR" in node.name -%}
        {%- do nodes.append(node) -%}
    {%- endif -%}
{% endfor %}

{%- for node in nodes -%}
    select *
    from {{ node.database }}.{{ node.schema }}.{{ node.alias }}
    {%- if not loop.last %}
        union all
    {%- endif %}
{% endfor %}
