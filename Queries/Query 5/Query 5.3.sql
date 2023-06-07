#Display the platinum turnover in days

CREATE VIEW platinum_turnover_summary AS
    SELECT 
        user_name,
        Users_idUsers,
        plat_in_service AS active_plat_user_in_days,
        plat_switch AS no_longer_as_platinium_in_days
    FROM
        (SELECT 
            user_name,
                Users_idUsers,
                CASE
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW()) - (plat_invoices * 30)) < 0 THEN TIMESTAMPDIFF(DAY, start_date, NOW())
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW())) > 0 THEN (plat_invoices * 30)
                END AS plat_in_service,
                plat_invoices * 30 AS platinum_invoices,
                CASE
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW()) - (plat_invoices * 30)) < 0 THEN 0
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW())) > 0 THEN TIMESTAMPDIFF(DAY, start_date, NOW()) - (plat_invoices * 30)
                END AS plat_switch
        FROM
            (SELECT 
            Users_idUsers,
                COUNT(plat_count.idSubscription) AS plat_invoices,
                start_date
        FROM
            invoices, (SELECT 
            idSubscription, subscription_startdate AS start_date
        FROM
            subscription
        WHERE
            subscription_type = 'P') AS plat_count
        WHERE
            invoices.Subscription_idSubscription = plat_count.idSubscription
        GROUP BY Users_idUsers) AS platinum_invoices, users
        WHERE
            platinum_invoices.Users_idUsers = users.idUsers) t1