#!/usr/bin/env ruby
#
# Simple script to attempt to determine the release names of deployed packages
# of the form 201511020546-2.7.0.38.179429 or 201510121059-2.7.0.38.2
# rather than 3.4.1-6.
# Once found, we can populate the release table along with the mapping of
# package_versions to releases.
#
# January 2016
#

require "mysql2"

# Simple method to create an assocation entry between the pckge version
# and release based  on the format of the version name
def add_release_version( dbh, rlsid, pkgid )
  #puts "Deleting existing entry: DELETE FROM package_version_releases WHERE release_id = '#{rlsid}' AND package_version_id = '#{pkgid}'"
  dbh.query( "DELETE FROM package_version_releases WHERE release_id = '#{rlsid}' AND package_version_id = '#{pkgid}'" )
  #puts "Adding new entry with: INSERT INTO package_version_releases(release_id, package_version_id) VALUES( '#{rlsid}', '#{pkgid}')"
  dbh.query( "INSERT INTO package_version_releases(release_id, package_version_id) VALUES( '#{rlsid}', '#{pkgid}')" )
end

# Simple method to add the release record to the database if it does not
# already exist
# params:
#   dbh: datbase connection handle
#   name: name identifier for the package
# returns:
#   integer value of the existing record or newly added release name  
def add_release( dbh, name )

  # Return the release's id value if it is found in the db
  e = get_release(dbh, name )
  return e if e

  stmtb = "INSERT INTO releases(name, description, created_at, updated_at) VALUES('#{name}', 'Package release for #{name}', NOW(), NOW())"
  rsb = dbh.query( stmtb )
  rsa = dbh.query( "SELECT id AS count FROM releases WHERE name = '#{name}'" )
  row = rsa.first
  return row['count']
end

# Simple method to get whether a version of a release already exists in the
# database.
# params:
#   dbh: datbase connection handle
#   name: name identifier for the package
# returns:
#  integer value of the id or nil if no record found
def get_release( dbh, name )
	stmta = "SELECT id, COUNT(id) AS count FROM releases WHERE name = '#{name}'"
	rsa = dbh.query( stmta )
	if rsa.any?
	  rsa.each do |release|
	    c = release['count']
	    return release['id'] unless c == 0
	  end
	end
	return nil
end

begin
  client = Mysql2::Client.new(:host => 'localhost', :username => 'megacorp_dev', :password => '{Dr0w$saP}', :database => 'serverlist_dev' )

  stmta = "SELECT id AS vers_id, name, package_id FROM package_versions"

  rsa = client.query( stmta )
  if rsa.any?
    rsa.each do |pkgver|
      vid  = pkgver['vers_id']
      vers = pkgver['name']
      pkgid = pkgver['package_id']
      puts "Found package version #{vers} for package id #{pkgid}."
      pattern = /^[0-9]{12}-([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*/
      vers.gsub!( pattern ) do
      	puts "Found release name #{$1} for #{vers}."
      	rlsid = add_release( client, $1 )
      	puts "Received #{rlsid} for #{$1}. Adding association."
      	add_release_version( client, rlsid, vid )
      end
    end
  end
end
