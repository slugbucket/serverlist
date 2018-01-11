class CreateApplicationStatuses < ActiveRecord::Migration
  def change
    create_table :application_statuses, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64

      t.timestamps
    end
  end
end
