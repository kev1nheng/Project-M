#Display the summary for every subscription such as their startdate, end date and the total revenue generated for every type of sbuscriptions

CREATE VIEW gold_subscription_summary AS
    SELECT 
        Subscription_idSubscription,
        subscription_startdate,
        end_subscription_gold,
        month_subscribed,
        (monthly_gold_subs_price * month_subscribed) AS total_gold_revenue_generated
    FROM
        (SELECT 
            Subscription_idSubscription,
                subscription_startdate,
                end_subscription_gold,
                CASE
                    WHEN ISNULL(month_subscribed) = 1 THEN 0
                    ELSE month_subscribed
                END AS month_subscribed,
                monthly_gold_subs_price
        FROM
            (SELECT 
            Subscription_idSubscription,
                subscription_startdate,
                end_subscription_gold,
                TIMESTAMPDIFF(MONTH, subscription_startdate, end_subscription_gold) AS month_subscribed,
                subscription_price AS monthly_gold_subs_price
        FROM
            (SELECT 
            Subscription_idSubscription,
                subscription_startdate,
                invoice_date,
                subscription_price,
                CASE
                    WHEN
                        (MONTH(end_subscription_gold) = MONTH(NOW()))
                            AND DAY(invoice_date) > DAY(NOW())
                    THEN
                        'active_sub'
                    ELSE end_subscription_gold
                END AS end_subscription_gold
        FROM
            (SELECT 
            Subscription_idSubscription,
                subscription_startdate,
                invoice_date,
                subscription_price,
                CASE
                    WHEN
                        MONTH(MAX(invoice_date)) = MONTH(NOW())
                            AND YEAR(MAX(invoice_date)) = YEAR(NOW())
                    THEN
                        'active_subs'
                    WHEN MAX(invoice_date) = subscription_startdate THEN DATE_ADD(MAX(invoice_date), INTERVAL 1 MONTH)
                    ELSE MAX(invoice_date)
                END AS end_subscription_gold
        FROM
            invoices, subscription
        WHERE
            Subscription_idSubscription IN (SELECT 
                    idSubscription
                FROM
                    subscription
                WHERE
                    subscription_type = 'g')
                AND invoices.Subscription_idSubscription = subscription.idSubscription
        GROUP BY Subscription_idSubscription) t1
        GROUP BY Subscription_idSubscription) t2) t3) t4