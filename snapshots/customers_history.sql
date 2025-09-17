{% snapshot customers_history %}
{{

    config(
        target_schema = 'L1_LANDING',
        unique_key = 'CustomerID',
        strategy = 'timestamp',
        updated_at = 'updated_at'
    )
}}

select * from {{source('landing', 'customers')}}

{%endsnapshot%}