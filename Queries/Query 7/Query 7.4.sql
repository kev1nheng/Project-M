#Display the Total Revenue per user including the amount from subscription as well as advertisements

    SELECT 
        user_name,
        Users_idUsers,
        total_revenue_of_paid_subscription,
        Ad_rev,
        (total_revenue_of_paid_subscription + Ad_rev) AS total_revenue
    FROM
        (SELECT 
            t1.user_name,
                t1.Users_idUsers,
                ROUND(SUM(t1.paid_subs_revenue), 2) AS 'total_revenue_of_paid_subscription',
                CASE
                    WHEN ISNULL(t2.ad_rev) = 1 THEN 0.00
                    ELSE t2.ad_rev
                END AS Ad_rev
        FROM
            (SELECT 
            COUNT(Subscription_idSubscription),
                user_name,
                Users_idUsers,
                Subscription_idSubscription,
                subscription_price,
                COUNT(Subscription_idSubscription) * subscription_price AS paid_subs_revenue
        FROM
            users, invoices, subscription
        WHERE
            users.idUsers = invoices.Users_idUsers
                AND idSubscription = Subscription_idSubscription
        GROUP BY Subscription_idSubscription) t1
        LEFT OUTER JOIN (SELECT 
            free_sub_turnover.users_idusers,
                free_sub_turnover.subscription_idsubscription,
                (daily_free_ad_rev * daily_free_in_service) AS ad_rev
        FROM
            daily_free_ads_summary, free_sub_turnover
        WHERE
            daily_free_ads_summary.Free_Subscription_idSubscription = free_sub_turnover.subscription_idsubscription) t2 ON t1.Users_idUsers = t2.Users_idUsers
        GROUP BY Users_idUsers) t3