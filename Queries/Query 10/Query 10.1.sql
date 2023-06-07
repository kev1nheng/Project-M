#Display the summary for every subscription such as their startdate, end date and the total revenue generated for every type of sbuscriptions

    SELECT 
        idSubscription,
        subscription_startdate,
        end_subscription_date,
        month_passed,
        monthly_free_ad_rev,
        (monthly_free_ad_rev * month_passed) AS total_free_rev_generated
    FROM
        (SELECT 
            t1.idSubscription,
                t1.subscription_startdate,
                t1.end_subscription_date,
                CASE
                    WHEN t1.end_subscription_date = 'active_subs' THEN TIMESTAMPDIFF(MONTH, t1.subscription_startdate, NOW())
                    ELSE TIMESTAMPDIFF(MONTH, t1.subscription_startdate, t1.end_subscription_date)
                END AS month_passed,
                t2.monthly_free_ad_rev
        FROM
            (SELECT 
            idSubscription,
                subscription_startdate,
                CASE
                    WHEN
                        (DATE_ADD(subscription_startdate, INTERVAL 1 MONTH)) IN (SELECT 
                                MIN(invoice_date) AS start_date
                            FROM
                                invoices
                            WHERE
                                Users_idUsers IN (SELECT 
                                        Users_idUsers
                                    FROM
                                        invoices
                                    WHERE
                                        Subscription_idSubscription IN (SELECT 
                                                idSubscription
                                            FROM
                                                subscription
                                            WHERE
                                                subscription_type = 'f')
                                    GROUP BY Users_idUsers)
                            GROUP BY Subscription_idSubscription)
                    THEN
                        DATE_ADD(subscription_startdate, INTERVAL 1 MONTH)
                    ELSE 'active_subs'
                END AS end_subscription_date
        FROM
            subscription
        WHERE
            subscription_type = 'f'
        GROUP BY idSubscription) t1, (SELECT 
            Free_Subscription_idSubscription,
                SUM(daily_ads_price) * 30 AS monthly_free_ad_rev
        FROM
            (SELECT 
            Free_Subscription_idSubscription, Advertisements_idads
        FROM
            free_has_advertisements
        GROUP BY Advertisements_idads) AS free_sub_ads, (SELECT 
            daily_ads_price.idads,
                ad_count * daily_profit AS daily_ads_price
        FROM
            (SELECT 
            Advertisements_idads, COUNT(*) AS ad_count
        FROM
            free_has_advertisements
        GROUP BY Advertisements_idads) AS ad_count, (SELECT 
            idads,
                ROUND((TIME_TO_SEC(ad_duration) / 60 * frequency_per_day) * ad_price_per_min, 2) AS daily_profit
        FROM
            advertisements
        GROUP BY idads) AS daily_ads_price
        WHERE
            daily_ads_price.idads = ad_count.Advertisements_idads) AS daily_ads
        WHERE
            free_sub_ads.Advertisements_idads = daily_ads.idads
        GROUP BY Free_Subscription_idSubscription) t2
        WHERE
            t1.idSubscription = t2.Free_Subscription_idSubscription) t3