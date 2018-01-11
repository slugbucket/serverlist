class Packages < ActiveRecord::Migration
  def change
    create_table :packages, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.text :description
      t.index :name, :unique => true, :name => 'package_name_idx'

      t.timestamps
    end
  end
end
