{% set nodes = [] -%}

{% for node in graph.nodes.values() %}
    {%- if node.config.schema == "ODS" 
    and node.config.materialized == "view" 
    and "ERR" in node.name -%}
        {%- do nodes.append(ref(node.name)) -%}
    {%- endif -%}
{% endfor %}

{%- for node in nodes %}
-- depends_on: {{ node }}
{% endfor %}


{%- for node in nodes %}
    select *
    from {{ node }}
    {% if not loop.last %}
        union all
    {% endif %}
{% endfor %}

