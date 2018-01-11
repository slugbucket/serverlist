class CreateOperationStatuses < ActiveRecord::Migration
  def change
    create_table :operation_statuses, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 16
      t.text :description

      t.timestamps
    end
  end
end
