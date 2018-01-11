class CreateAppUsers < ActiveRecord::Migration
  def change
    create_table :app_users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 32
      t.integer :app_user_type_id, :limit => 2
      t.text :description

      t.timestamps
    end
  end
end
