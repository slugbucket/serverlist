class CreateModels < ActiveRecord::Migration
  def change
    create_table :models, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.text :description
      t.integer :vendor_id, :limit => 2

      t.timestamps
    end
  end
end
