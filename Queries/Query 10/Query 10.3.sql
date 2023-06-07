#Display the summary for every subscription such as their startdate, end date and the total revenue generated for every type of sbuscriptions

CREATE VIEW platinum_subscription_summary AS
    SELECT 
        Subscription_idSubscription,
        subscription_startdate,
        end_subscription_platinum,
        TIMESTAMPDIFF(MONTH,
            subscription_startdate,
            end_subscription_platinum) AS month_subscribed,
        subscription_price AS monthly_plat_subs_price,
        (TIMESTAMPDIFF(MONTH,
            subscription_startdate,
            end_subscription_platinum) * subscription_price) AS total_plat_revenue_generated
    FROM
        (SELECT 
            Subscription_idSubscription,
                subscription_startdate,
                subscription_price,
                CASE
                    WHEN
                        MONTH(MAX(invoice_date)) = MONTH(NOW())
                            AND YEAR(MAX(invoice_date)) = YEAR(NOW())
                    THEN
                        'active_subs'
                    WHEN MAX(invoice_date) = subscription_startdate THEN DATE_ADD(MAX(invoice_date), INTERVAL 1 MONTH)
                    ELSE MAX(invoice_date)
                END AS end_subscription_platinum
        FROM
            invoices, subscription
        WHERE
            Subscription_idSubscription IN (SELECT 
                    idSubscription
                FROM
                    subscription
                WHERE
                    subscription_type = 'p')
                AND invoices.Subscription_idSubscription = subscription.idSubscription
        GROUP BY Subscription_idSubscription) t1