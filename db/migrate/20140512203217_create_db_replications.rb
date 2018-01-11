class CreateDbReplications < ActiveRecord::Migration
  def change
    create_table :db_replications, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.integer :db_repl_type_id, :null => false, :limit => 2
      t.integer :db_repl_host_id, :null => false, :limit => 2
      t.integer :db_repl_src_id, :null => false, :limit => 2
      t.integer :db_repl_target_id, :null => false, :limit => 2
      t.text :description
      t.integer :db_repl_status_id, :limit => 2 
      t.integer :db_repl_freq_id, :limit => 2
      t.integer :application_id, :limit => 2

      t.timestamps
    end
  end
end
