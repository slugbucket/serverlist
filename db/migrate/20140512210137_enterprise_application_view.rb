class EnterpriseApplicationView < ActiveRecord::Migration
  def change
    execute("CREATE VIEW enterprise_application_view AS
    SELECT DISTINCT a1.id AS app_id,
                    ea1.name AS entappname,
                    a1.name AS app_label,
                    at1.name AS app_type,
                    as1.name AS app_status,
                    REPLACE(a1.description,'"','') AS description
    FROM ((application_statuses as1 JOIN
           application_types at1) JOIN
          (applications a1 JOIN
          (application_enterprise_applications aea1 JOIN enterprise_applications ea1) ON
             (((a1.id = aea1.application_id) AND
               (aea1.enterprise_application_id = ea1.id)))))
    WHERE ((at1.id = a1.application_type_id)
       AND (as1.id = a1.application_status_id))
    GROUP BY a1.id
    UNION
    SELECT DISTINCT a1.id AS app_id,
                    a1.name AS entappname,
                    a1.name AS app_label,
                    at1.name AS app_type,
                    as1.name AS app_status,
                    REPLACE(a1.description,'"','') AS description
    FROM ((application_statuses as1 JOIN
           application_types at1) JOIN
          (applications a1 left JOIN
          (application_enterprise_applications aea1 JOIN
           enterprise_applications ea1) ON
          (((a1.id = aea1.application_id) AND (aea1.enterprise_application_id = ea1.id)))))
    WHERE ((at1.id = a1.application_type_id)
       AND (as1.id = a1.application_status_id) AND
     ISNULL(aea1.enterprise_application_id))
    GROUP BY a1.id
    ORDER BY app_type,app_label")
  end
end
