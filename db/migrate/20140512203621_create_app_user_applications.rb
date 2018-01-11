class CreateAppUserApplications < ActiveRecord::Migration
  def change
    create_table :app_user_applications, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :app_user_id, :null => false, :limit => 2
      t.integer :application_id, :null => false, :limit => 2

      t.timestamps
    end
  end
end
