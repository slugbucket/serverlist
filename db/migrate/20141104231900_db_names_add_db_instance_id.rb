class DbNamesAddDbInstanceId < ActiveRecord::Migration
  def change
    add_column :db_names, :db_instance_id, :integer, :default => nil, :limit => 4
    puts <<-EOF
Run the following query to populate the db_names with the relevant instance_id
UPDATE db_names, db_instance_db_names
  SET db_names.db_instance_id = db_instance_db_names.db_instance_id
  WHERE db_names.id = db_instance_db_names.db_name_id;
EOF
  end
end
