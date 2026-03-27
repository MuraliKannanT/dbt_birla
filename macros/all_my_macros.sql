{% macro add_ten (incol) %}

({{ incol }} * .10) + {{ incol }}

{% endmacro %}

{% macro money() -%}
::decimal(16,4)
{%- endmacro %}

