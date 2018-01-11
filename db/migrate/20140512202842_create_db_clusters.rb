class CreateDbClusters < ActiveRecord::Migration
  def change
    create_table :db_clusters, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 32

      t.timestamps
    end
  end
end
