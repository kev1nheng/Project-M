#Display the RFM score for every users

SELECT 
    user_name,
    idUsers,
    SUM(frequent_payment + value_payment + recent_payment) AS rfm_score
FROM
    (SELECT 
        frequency.Users_idUsers,
            CASE
                WHEN (invoice_count - frequent) > 0 THEN 1
                ELSE 0
            END AS frequent_payment,
            CASE
                WHEN (total_payment - value_payment) > 0 THEN 1
                ELSE 0
            END AS value_payment,
            CASE
                WHEN (recency - recent) > 0 THEN 1
                ELSE 0
            END AS recent_payment
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
    GROUP BY Users_idUsers) AS frequency, (SELECT 
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
    ORDER BY recency DESC) AS recency, (SELECT 
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
    GROUP BY Users_idUsers) AS value_paid_subscription, avg_rfm_analysis_paid_users
    WHERE
        value_paid_subscription.Users_idUsers = recency.Users_idUsers
            AND recency.Users_idUsers = frequency.Users_idUsers
    GROUP BY frequency.Users_idUsers) t2,
    users
WHERE
    t2.Users_idUsers = users.idUsers
GROUP BY idUsers
ORDER BY rfm_score DESC , user_name ASC