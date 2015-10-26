# controller generator
  rails g scaffold_controller MyController <property>
  #OR
  rails g controller

# model generator
  rails g model <singular_model_name> <column_name>:<data_type>:<index> <tbl_name>:references ...
  #data_type        MySQL           Postgres                SQLite3
    :primary_key
    :string[{255}]                    #  varchar(255)    character varying(255)  varchar(255)
    :text[{30}]                       #  text            text                    text
    :integer[{11}]                    #  int(11)         integer                 integer
    :float                            #  float           float                   float
    :decimal                          #  decimal         decimal                 decimal
    :datetime                         #  datetime        timestamp               datetime
    :timestamps                       #  datetime        timestamp               datetime
    :time                             #  time            time                    datetime
    :date                             #  date            date                    date
    :binary                           #  blob            bytea                   blob
    :boolean                          #  tinyint         boolean                 boolean
    :references[{polymorphic}]:index  #  int(11)         integer                 integer     #foreign key
  #index
    rails g model user email:index location_id:integer:index
    #unique index
    rails g model user pseudo:string:uniq

  # STI (single table inheritance):
  rails g model admin --parent user

  #namespaced model, useful for multi module application
    rails g model admin/user

#migration generator
rails g migration add_<column_name>_to_<table> <column_name>:<data_type> <column_name>:<data_type> ...
rails g migration add_description_to_products description:string
