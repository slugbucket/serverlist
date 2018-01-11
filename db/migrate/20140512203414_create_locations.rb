class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.text :description

      t.timestamps
    end
  end
end
