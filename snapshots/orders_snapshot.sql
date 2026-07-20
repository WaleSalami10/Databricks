{% snapshot orders_snapshot %}

{{
    config(
        target_schema='dbt_snapshots',
        target_database='dbt-dev-catalog',
        unique_key='order_id',
        strategy='check',
        check_cols=['order_total', 'order_cost', 'is_food_order', 'is_drink_order', 'location_id'],
    )
}}

select * from {{ ref('orders') }}

{% endsnapshot %}
