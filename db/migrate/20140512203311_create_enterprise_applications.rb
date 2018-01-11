class CreateEnterpriseApplications < ActiveRecord::Migration
  def change
    create_table :enterprise_applications, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 128
      t.text :description

      t.timestamps
    end
  end
end
