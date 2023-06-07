#Display the monthly churn rate for paid subscriber
SELECT 
    month_next.month_name,
    month_next.invoices_count - month_now.invoices_count AS Churn
FROM
    (SELECT 
        MONTHNAME(invoice_date) AS month_name,
            COUNT(*) AS invoices_count
    FROM
        invoices
    WHERE
        Subscription_idSubscription NOT IN (SELECT 
                idSubscription
            FROM
                subscription
            WHERE
                subscription_type = 'f')
            AND YEAR(invoice_date) = YEAR(NOW())
    GROUP BY month_name) AS month_now,
    (SELECT 
        MONTHNAME(DATE_ADD(invoice_date, INTERVAL 1 MONTH)) AS month_name,
            COUNT(*) AS invoices_count
    FROM
        invoices
    WHERE
        Subscription_idSubscription NOT IN (SELECT 
                idSubscription
            FROM
                subscription
            WHERE
                subscription_type = 'f')
            AND YEAR(invoice_date) = YEAR(NOW())
    GROUP BY month_name) AS month_next
WHERE
    month_now.month_name = month_next.month_name