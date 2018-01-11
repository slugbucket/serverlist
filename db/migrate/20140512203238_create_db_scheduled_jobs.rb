class CreateDbScheduledJobs < ActiveRecord::Migration
  def change
    create_table :db_scheduled_jobs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64 
      t.integer :db_instance_db_name_id, :null => false, :limit => 4
      t.integer :db_job_type_id, :null => false, :limit => 2
      t.integer :db_job_host_id, :null => false, :limit => 2
      t.text :description
      t.integer :db_job_status_id, :null => false, :limit => 2
      t.integer :db_job_freq_id, :limit => 2
      t.integer :app_user_id, :limit => 2
      t.integer :application_id, :limit => 2

      t.timestamps
    end
  end
end
