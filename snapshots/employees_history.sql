{% snapshot employees_history %}

  {{
    config(
      strategy='check',
      unique_key='EmployeeId',
      check_cols=['email', 'jobtitle']
    )
  }}

  select * from {{ source('landing', 'employees') }}

{% endsnapshot %}