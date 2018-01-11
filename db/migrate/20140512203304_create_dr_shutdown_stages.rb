class CreateDrShutdownStages < ActiveRecord::Migration
  def change
    create_table :dr_shutdown_stages, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 32
      t.text :description

      t.timestamps
    end
  end
end
