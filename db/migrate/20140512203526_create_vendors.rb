class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.string :telephone, :limit => 20
      t.text :description

      t.timestamps
    end
  end
end
