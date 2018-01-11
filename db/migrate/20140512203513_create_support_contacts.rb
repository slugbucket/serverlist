class CreateSupportContacts < ActiveRecord::Migration
  def change
    create_table :support_contacts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :email_addr
      t.string :telephone

      t.timestamps
    end
  end
end
