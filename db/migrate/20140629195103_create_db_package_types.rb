class CreateDbPackageTypes < ActiveRecord::Migration
  def change
    create_table :db_package_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
