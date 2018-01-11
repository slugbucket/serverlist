class CreateSessionsRoles < ActiveRecord::Migration
  def change
    create_table :sessions_roles, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :session
      t.references :role
    end
    add_index(:roles, :name)
    add_index(:sessions_roles, [ :session_id, :role_id ])
  end
end
