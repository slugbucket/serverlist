class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false
      t.integer :application_type_id, :limit => 2
      t.integer :application_status_id, :limit => 2
      t.integer :vendor_id, :limit => 2
      t.integer :support_contact_id, :limit => 2
      t.integer :support_group_id, :limit => 2
      t.text :description
      t.integer :escalation_level_id, :limit => 2
      t.integer :impact_hour_id, :limit => 2
      t.integer :impact_level_id, :limit => 2
      t.integer :dr_shutdown_stage_id, :limit => 2

      t.timestamps
    end
  end
end
