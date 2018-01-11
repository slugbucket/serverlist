class CreateSupportGroupMembers < ActiveRecord::Migration
  def change
    create_table :support_group_members, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :support_contact_id, :null => false, :limit => 2
      t.integer :support_group_id, :null => false, :limit => 2

      t.timestamps
    end
  end
end
