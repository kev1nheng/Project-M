#Display the RFM score for every users

CREATE VIEW avg_rfm_analysis_paid_users AS
    SELECT 
        AVG(invoice_count) AS frequent,
        AVG(recency) AS recent,
        AVG(total_payment) AS value_payment
    FROM
        (SELECT 
            Users_idUsers, COUNT(*) AS invoice_count
        FROM
            invoices
        WHERE
            Subscription_idSubscription NOT IN (SELECT 
                    idSubscription
                FROM
                    subscription
                WHERE
                    subscription_type = 'f')
        GROUP BY Users_idUsers) AS frequency,
        (SELECT 
            Users_idUsers, MAX(invoice_date) AS recency
        FROM
            invoices
        WHERE
            Subscription_idSubscription NOT IN (SELECT 
                    idSubscription
                FROM
                    subscription
                WHERE
                    subscription_type = 'f')
        GROUP BY Users_idUsers
        ORDER BY recency DESC) AS recency,
        (SELECT 
            Users_idUsers, SUM(paid_invoice) AS total_payment
        FROM
            (SELECT 
            Users_idUsers,
                Subscription_idSubscription,
                COUNT(Subscription_idSubscription) AS sub_count,
                COUNT(Subscription_idSubscription) * subscription_price AS paid_invoice
        FROM
            invoices, subscription
        WHERE
            Subscription_idSubscription NOT IN (SELECT 
                    idSubscription
                FROM
                    subscription
                WHERE
                    subscription_type = 'f')
                AND invoices.Subscription_idSubscription = idSubscription
        GROUP BY Subscription_idSubscription) t1
        GROUP BY Users_idUsers) AS value_paid_subscription
    WHERE
        value_paid_subscription.Users_idUsers = recency.Users_idUsers
            AND recency.Users_idUsers = frequency.Users_idUsers