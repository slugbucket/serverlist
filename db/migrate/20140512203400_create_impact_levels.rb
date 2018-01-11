class CreateImpactLevels < ActiveRecord::Migration
  def change
    create_table :impact_levels, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 32
      t.text :description

      t.timestamps
    end
  end
end
