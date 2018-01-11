class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.text :description
      t.date :expiry

      t.timestamps
    end
  end
end
