#Display the gold turnover in days
CREATE VIEW gold_turnover_summary AS
    SELECT 
        user_name,
        Users_idUsers,
        active_gold_user AS active_gold_user_in_days,
        gold_switch AS no_longer_gold_user_in_days
    FROM
        (SELECT 
            user_name,
                Users_idUsers,
                CASE
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW()) - (golde_invoices * 30)) < 0 THEN TIMESTAMPDIFF(DAY, start_date, NOW())
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW())) > 0 THEN (golde_invoices * 30)
                END AS active_gold_user,
                (golde_invoices * 30) AS gold_invoice,
                CASE
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW()) - (golde_invoices * 30)) < 0 THEN 0
                    WHEN (TIMESTAMPDIFF(DAY, start_date, NOW())) > 0 THEN TIMESTAMPDIFF(DAY, start_date, NOW()) - (golde_invoices * 30)
                END AS gold_switch
        FROM
            (SELECT 
            Users_idUsers,
                COUNT(gold_count.idSubscription) AS golde_invoices,
                start_date
        FROM
            invoices, (SELECT 
            idSubscription, subscription_startdate AS start_date
        FROM
            subscription
        WHERE
            subscription_type = 'g') AS gold_count
        WHERE
            invoices.Subscription_idSubscription = gold_count.idSubscription
        GROUP BY Users_idUsers) AS gold_invoices, users
        WHERE
            gold_invoices.Users_idUsers = users.idUsers) t1