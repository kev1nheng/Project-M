SELECT 
    CASE
        WHEN ISNULL(LTV) = 1 THEN 0.00
    END AS LTV,
    avg_arpu_for_paid_sub_user,
    avg_churn_rate_for_paid_user
FROM
    (SELECT 
        avg_arpu_for_paid_sub_user / avg_churn_rate_for_paid_user AS LTV,
            avg_arpu_for_paid_sub_user,
            ROUND(avg_churn_rate_for_paid_user, 2) AS avg_churn_rate_for_paid_user
    FROM
        (SELECT 
        ROUND(AVG(total_payment), 2) AS avg_arpu_for_paid_sub_user
    FROM
        (SELECT 
        Users_idUsers, SUM(invoice_payment) AS total_payment
    FROM
        (SELECT 
        Users_idUsers, invoice_payment
    FROM
        (SELECT 
        Subscription_idSubscription,
            (invoices_count * subscription_price) AS invoice_payment
    FROM
        (SELECT 
        Subscription_idSubscription,
            COUNT(*) AS invoices_count,
            subscription_price
    FROM
        invoices, subscription
    WHERE
        Subscription_idSubscription NOT IN (SELECT 
                idSubscription
            FROM
                subscription
            WHERE
                subscription_type = 'f')
            AND invoices.Subscription_idSubscription = subscription.idSubscription
            AND YEAR(invoice_date) = YEAR(NOW())
    GROUP BY Subscription_idSubscription) t1) t2, invoices
    WHERE
        invoices.Subscription_idSubscription = t2.Subscription_idSubscription
    GROUP BY t2.Subscription_idSubscription) t3
    GROUP BY t3.Users_idUsers) t4) t5, (SELECT 
        AVG(Churn) AS avg_churn_rate_for_paid_user
    FROM
        (SELECT 
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
    GROUP BY month_name) AS month_now, (SELECT 
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
        month_now.month_name = month_next.month_name) t1) t6) t7


