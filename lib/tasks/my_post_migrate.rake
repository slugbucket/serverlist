namespace :db do
  desc "Create basic site users"
  task task_prep_sessions: :environment do
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
    puts "Loading user data from YAML"
    sessions = YAML::load_file("lib/tasks/post_migrate_users.yml")
    puts "Creating session users."
    sessions.each do |s|
      Session.create(:id                  => s.id,
                     :username            => s.username,
                     :sign_in_count       => s.sign_in_count,
                     :current_sign_in_at  => s.current_sign_in_at,
                     :last_sign_in_at     => s.last_sign_in_at,
                     :current_sign_in_ip  => s.current_sign_in_ip,
                     :last_sign_in_ip     => s.last_sign_in_ip,
                     :remember_created_at => s.remember_created_at,
                     :created_at          => s.created_at,
                     :updated_at          => s.updated_at)
      puts "Created session user #{s.username}"
    end
  end

  desc "Create basic roles for managing site content"
  task task_prep_roles: :environment do
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
    puts "Loading user data from YAML"
    roles = YAML::load_file("lib/tasks/post_migrate_roles.yml")
    puts "Creating roles."
    roles.each do |r|
      Role.create(:id         => r.id,
                  :username   => r.name,
                  :created_at => r.created_at,
                  :updated_at => r.updated_at)
      puts "Created role: #{s.username}."
    end
  end

  desc "Create basic roles for managing site content"
  task task_populate_roles: :environment do
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
    puts "Loading user roles from YAML"
    sroles = YAML::load_file("lib/tasks/post_migrate_user_roles.yml")
    uroles.each do |sr|
      SessionsRoles.create(:sesssion_id => sr.id,
                           :role_id     => sr.name)
    end
  end

  desc "Set a default for the application shutdown stage"
  task task_application_shutdown_stage: :environment do
    puts "Setting default application shutdown stage"
    
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
    dss = 'Green'
    d = DrShutdownStage.select(:id).where(:name => dss)
    Application.where(:dr_shutdown_stage_id => nil).each do |app|
      app.update(:dr_shutdown_stage_id => '4')
      puts "Updated #{app.name} with shutdown status #{dss}."
    end
  end
end
