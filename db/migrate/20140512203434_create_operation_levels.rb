class CreateOperationLevels < ActiveRecord::Migration
  def change
    create_table :operation_levels, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 16
      t.text :description

      t.timestamps
    end
  end
end
