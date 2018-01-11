class CreateAdDomains < ActiveRecord::Migration
  def change
    create_table :ad_domains, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false
      t.text :description
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
