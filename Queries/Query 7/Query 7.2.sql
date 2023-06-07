#Display the Total Revenue per user including the amount from subscription as well as advertisements

CREATE VIEW free_sub_turnover AS
    SELECT 
        invoice_count.users_idUsers,
        invoice_count.subscription_idsubscription,
        CASE
            WHEN
                (invoice_count - free_count) = 0
            THEN
                TIMESTAMPDIFF(DAY,
                    subscription_startdate,
                    NOW())
            ELSE 30
        END AS 'daily_free_in_service',
        CASE
            WHEN (invoice_count - free_count) = 1 THEN 30
            WHEN (invoice_count - free_count) > 1 THEN (invoice_count - free_count) * 30
            ELSE 0
        END AS 'not_free (days)'
    FROM
        (SELECT 
            COUNT(*) AS invoice_count,
                Users_idUsers,
                subscription_idsubscription
        FROM
            invoices
        GROUP BY Users_idUsers) AS invoice_count,
        (SELECT 
            Users_idUsers,
                Subscription_idSubscription,
                subscription_startdate,
                free_count
        FROM
            invoices, (SELECT 
            idSubscription,
                subscription_startdate,
                COUNT(*) AS free_count
        FROM
            subscription
        WHERE
            subscription_type = 'f'
        GROUP BY idSubscription) AS free_sub_count
        WHERE
            invoices.Subscription_idSubscription = free_sub_count.idSubscription) AS free_sub_count
    WHERE
        free_sub_count.Users_idUsers = invoice_count.Users_idUsers