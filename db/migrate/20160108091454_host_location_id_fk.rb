class HostLocationIdFk < ActiveRecord::Migration
  def change
    puts "Fixing hosts location_id"
    execute "ALTER TABLE hosts MODIFY COLUMN location_id INT(11) NOT NULL;"
    puts "Setting foreign key for host location_id"
    execute "ALTER TABLE hosts
ADD CONSTRAINT host_location_fk FOREIGN KEY (location_id)
REFERENCES locations (id)
ON DELETE CASCADE
ON UPDATE CASCADE"
  end
end
