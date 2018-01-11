class CreateApplicationEnterpriseApplications < ActiveRecord::Migration
  def change
    create_table :application_enterprise_applications, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :application_id, :null => false, :limit => 2
      t.integer :enterprise_application_id, :null => false, :limit => 2

      t.timestamps
    end
  end
end
