class CreateDbReplFreqs < ActiveRecord::Migration
  def change
    create_table :db_repl_freqs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 32

      t.timestamps
    end
  end
end
