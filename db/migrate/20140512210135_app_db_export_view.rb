class AppDbExportView < ActiveRecord::Migration
  def change
    execute("CREATE VIEW app_db_export_view AS
      SELECT dn1.name AS dbname,
             a1.id AS appid,
             a1.name AS appname,
             REPLACE(a1.description,'\"','') AS description,
             di1.name AS instance,
             as1.name AS appstatus,
             at1.name AS apptype
             FROM ((db_instances di1 JOIN
                ((((db_names dn1 JOIN db_instance_db_names didn1 ON
                  ((dn1.id = didn1.db_name_id))) JOIN
                    application_db_instance_db_names adidn1 ON
                  ((didn1.id = adidn1.db_instance_db_name_id))) JOIN
                    applications a1 ON((adidn1.application_id = a1.id))) JOIN
                    application_statuses as1 ON((a1.application_status_id = as1.id)))) JOIN
                    application_types at1)
    where ((didn1.db_instance_id = di1.id)
               AND (a1.application_type_id = at1.id)) order by dn1.name")
  end
end
