class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 32
      t.references :resource, :polymorphic => true

      t.timestamps
    end
  end
end
