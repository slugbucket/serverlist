#!/usr/bin/env ruby

require "mysql2"

begin
  client = Mysql2::Client.new(:host => 'localhost', :username => 'megacorp_dev', :password => '{Dr0ws$aP}', :database => 'thd-database' )

  # read the list of packages in the file and create host_package_version
  # insert entries
  pkgdir = "nu-packages"

  Dir.foreach(pkgdir) {|srvfile|

    # Get the id of the host from the database
    stmta = "SELECT id FROM hosts WHERE name = '#{srvfile}'"
    rs = client.query( stmta )

    hostid = nil
    if rs.any? then
      rs.each do |hostrow|
        hostid = hostrow['id']

      end
        puts "Creating inventory record of #{hostid} for #{srvfile}."
        # Now get the packages listed in the package file for the host
        # and create the db entries
        File.open( "#{pkgdir}/#{srvfile}" ) do |pkglist|

          pattern = /^(pkg-[a-zA-Z0-9\-_]*)\.(x86_64|noarch)\s+(.*)/
          pkglist.each do |pkg|
            pkg.gsub!( pattern ) do
              puts "Adding package reference for #{$1} of #{$3}."
              stmtb = "SELECT pv1.id AS package_version_id FROM package_versions pv1 INNER JOIN packages p1 ON pv1.package_id = p1.id WHERE p1.name = '#{$1}' AND pv1.name = '#{$3}'"
              rs = client.query( stmtb )
              if rs.any?
                rs.each do |pkgname|
                  puts "Found package id #{pkgname['id']} for #{$1}"
                  pkv = pkgname['package_version_id']
                  stmtc = "INSERT INTO host_package_versions(host_id, package_version_id) VALUES(\'#{hostid}\', \'#{pkv}\');"
                  puts "Inserting record with #{stmtc}."
                  client.query( stmtc )
                end
              end
            end
          end
        end
    end
  }
end
