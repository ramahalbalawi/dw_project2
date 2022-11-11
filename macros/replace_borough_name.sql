{% macro replace_borough_name(borough) -%} 
    {% if borough == "MANHATTAN" %}
        {% set result = "Manhattan" %}
    {% elif borough == "STATEN ISLAND" %}
        {% set result = "Staten Island" %}
    {% elif borough == "QUEENS" %}
        {% set result = "Queens" %}
    {% elif borough == "BROOKLYN" %}
        {% set result = "Brooklyn" %}
    {% elif borough == "BRONX" %}
        {% set result = "Bronx" %}
    {% endif -%}
    {{ return(result) }}
{%- endmacro %}