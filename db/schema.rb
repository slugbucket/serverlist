# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160108091454) do

  create_table "activity_logs", force: true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "act_action"
    t.string   "updated_by"
    t.text     "activity"
    t.datetime "act_tstamp"
  end

  create_table "ad_domains", force: true do |t|
    t.string   "name",                       null: false
    t.text     "description"
    t.boolean  "active",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_db_export_view", id: false, force: true do |t|
    t.string  "dbname",      limit: 32,             null: false
    t.integer "appid",                  default: 0, null: false
    t.string  "appname",                            null: false
    t.text    "description"
    t.string  "instance",    limit: 64,             null: false
    t.string  "appstatus",   limit: 64,             null: false
    t.string  "apptype",     limit: 64,             null: false
  end

  create_table "app_user_applications", id: false, force: true do |t|
    t.integer  "app_user_id",    limit: 2, null: false
    t.integer  "application_id", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_user_types", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_users", force: true do |t|
    t.string   "name",             limit: 32, null: false
    t.integer  "app_user_type_id", limit: 2
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_db_instance_db_names", id: false, force: true do |t|
    t.integer  "application_id",         limit: 2, null: false
    t.integer  "db_instance_db_name_id", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_db_names", id: false, force: true do |t|
    t.integer  "application_id", limit: 2, null: false
    t.integer  "db_name_id",     limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_enterprise_applications", id: false, force: true do |t|
    t.integer  "application_id",            limit: 2, null: false
    t.integer  "enterprise_application_id", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_hosts", id: false, force: true do |t|
    t.integer  "application_id", limit: 2, null: false
    t.integer  "host_id",        limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_statuses", force: true do |t|
    t.string   "name",       limit: 64, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_types", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_warranty_contracts", id: false, force: true do |t|
    t.integer  "application_id",       limit: 2, null: false
    t.integer  "warranty_contract_id", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.string   "name",                            null: false
    t.integer  "application_type_id",   limit: 2
    t.integer  "application_status_id", limit: 2
    t.integer  "vendor_id",             limit: 2
    t.integer  "support_contact_id",    limit: 2
    t.integer  "support_group_id",      limit: 2
    t.text     "description"
    t.integer  "escalation_level_id",   limit: 2
    t.integer  "impact_hour_id",        limit: 2
    t.integer  "impact_level_id",       limit: 2
    t.integer  "dr_shutdown_stage_id",  limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backup_strategies", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backup_strategy_hosts", id: false, force: true do |t|
    t.integer  "backup_strategy_id", limit: 2, null: false
    t.integer  "host_id",            limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cert_types", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certs", force: true do |t|
    t.string   "name",           limit: 128, null: false
    t.text     "description"
    t.integer  "cert_type_id",   limit: 2,   null: false
    t.integer  "vendor_id",      limit: 2,   null: false
    t.date     "expiry"
    t.integer  "application_id", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_cluster_db_servers", id: false, force: true do |t|
    t.integer "db_cluster_id", limit: 2, null: false
    t.integer "db_server_id",  limit: 2, null: false
  end

  create_table "db_clusters", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_instance_db_names", force: true do |t|
    t.integer  "db_instance_id", limit: 2, null: false
    t.integer  "db_name_id",     limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_instances", force: true do |t|
    t.string   "name",          limit: 64, null: false
    t.integer  "db_server_id",  limit: 2,  null: false
    t.integer  "server_app_id", limit: 2,  null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_job_freqs", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_job_statuses", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_job_types", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_names", force: true do |t|
    t.string   "name",           limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "db_instance_id"
  end

  create_table "db_package_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_packages", force: true do |t|
    t.string   "name",                   limit: 64, null: false
    t.text     "description"
    t.integer  "db_package_type_id",     limit: 2,  null: false
    t.integer  "db_instance_id",         limit: 2,  null: false
    t.integer  "db_instance_db_name_id", limit: 2,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_repl_freqs", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_repl_statuses", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_repl_types", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_replications", force: true do |t|
    t.string   "name",              limit: 64, null: false
    t.integer  "db_repl_type_id",   limit: 2,  null: false
    t.integer  "db_repl_host_id",   limit: 2,  null: false
    t.integer  "db_repl_src_id",    limit: 2,  null: false
    t.integer  "db_repl_target_id", limit: 2,  null: false
    t.text     "description"
    t.integer  "db_repl_status_id", limit: 2
    t.integer  "db_repl_freq_id",   limit: 2
    t.integer  "application_id",    limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_scheduled_jobs", force: true do |t|
    t.string   "name",                   limit: 64, null: false
    t.integer  "db_instance_db_name_id",            null: false
    t.integer  "db_job_type_id",         limit: 2,  null: false
    t.integer  "db_job_host_id",         limit: 2,  null: false
    t.text     "description"
    t.integer  "db_job_status_id",       limit: 2,  null: false
    t.integer  "db_job_freq_id",         limit: 2
    t.integer  "app_user_id",            limit: 2
    t.integer  "application_id",         limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_server_hosts", id: false, force: true do |t|
    t.integer "db_server_id", default: 0, null: false
    t.integer "host_id",      default: 0, null: false
  end

  create_table "db_servers", force: true do |t|
    t.string   "name",          limit: 32, null: false
    t.text     "description"
    t.integer  "db_cluster_id", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dr_methods", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dr_shutdown_stages", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enterprise_application_view", id: false, force: true do |t|
    t.integer "app_id",                  default: 0, null: false
    t.string  "entappname",  limit: 128
    t.string  "app_label",                           null: false
    t.string  "app_type",    limit: 64,              null: false
    t.string  "app_status",  limit: 64,              null: false
    t.text    "description"
  end

  create_table "enterprise_applications", force: true do |t|
    t.string   "name",        limit: 128, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "escalation_levels", force: true do |t|
    t.string   "name",       limit: 32, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "host_package_versions", id: false, force: true do |t|
    t.integer "host_id",            null: false
    t.integer "package_version_id", null: false
  end

  add_index "host_package_versions", ["host_id", "package_version_id"], name: "host_package_version_idx", unique: true, using: :btree

  create_table "host_warranty_contracts", id: false, force: true do |t|
    t.integer  "host_id",              limit: 2, null: false
    t.integer  "warranty_contract_id", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", force: true do |t|
    t.string   "name",                limit: 20, default: "hostname", null: false
    t.integer  "location_id",                                         null: false
    t.text     "primary_use"
    t.integer  "ad_domain_id",        limit: 2
    t.integer  "oob_remote_mngmt_id", limit: 2
    t.integer  "operating_system_id", limit: 2
    t.integer  "model_id",            limit: 2
    t.string   "serialnum",           limit: 16, default: "none"
    t.string   "asset_tag",           limit: 16, default: "none"
    t.text     "description"
    t.text     "warranty"
    t.boolean  "active",                         default: true
    t.date     "commissioned"
    t.integer  "service_level_id",    limit: 2
    t.integer  "dr_method_id",        limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hosts", ["location_id"], name: "host_location_fk", using: :btree

  create_table "impact_hours", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impact_levels", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.integer  "vendor_id",   limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oob_remote_mngmts", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operating_systems", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.date     "expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operation_levels", force: true do |t|
    t.string   "name",        limit: 16, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operation_statuses", force: true do |t|
    t.string   "name",        limit: 16, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "package_architectures", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "package_version_releases", id: false, force: true do |t|
    t.integer "release_id",         null: false
    t.integer "package_version_id", null: false
  end

  add_index "package_version_releases", ["package_version_id"], name: "package_version_fk", using: :btree
  add_index "package_version_releases", ["release_id", "package_version_id"], name: "package_version_release_idx", unique: true, using: :btree

  create_table "package_versions", force: true do |t|
    t.string   "name",                    limit: 64,             null: false
    t.integer  "package_id",                                     null: false
    t.integer  "package_architecture_id",            default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_versions", ["name", "package_id"], name: "package_version_package_id_idx", unique: true, using: :btree
  add_index "package_versions", ["package_architecture_id"], name: "package_version_architecture_fk", using: :btree
  add_index "package_versions", ["package_id"], name: "package_fk", using: :btree

  create_table "packages", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["name"], name: "package_name_idx", unique: true, using: :btree

  create_table "releases", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",          limit: 32, null: false
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "server_apps", force: true do |t|
    t.string   "name",                 limit: 64, null: false
    t.text     "description"
    t.integer  "vendor_id",            limit: 2,  null: false
    t.integer  "warranty_contract_id", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_levels", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "username",                        null: false
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["username"], name: "index_sessions_on_username", unique: true, using: :btree

  create_table "sessions_roles", id: false, force: true do |t|
    t.integer "session_id"
    t.integer "role_id"
  end

  add_index "sessions_roles", ["session_id", "role_id"], name: "index_sessions_roles_on_session_id_and_role_id", using: :btree

  create_table "support_contacts", force: true do |t|
    t.string   "name"
    t.string   "email_addr"
    t.string   "telephone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "support_group_members", id: false, force: true do |t|
    t.integer  "support_contact_id", limit: 2, null: false
    t.integer  "support_group_id",   limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "support_groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.string   "telephone",   limit: 20
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warranty_contracts", force: true do |t|
    t.string   "name",             limit: 64, null: false
    t.text     "description"
    t.integer  "vendor_id",        limit: 2
    t.integer  "warranty_type_id", limit: 2
    t.date     "expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warranty_types", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
