class CreateSupportGroups < ActiveRecord::Migration
  def change
    create_table :support_groups, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
