#Display the Total Revenue per user including the amount from subscription as well as advertisements

CREATE VIEW daily_avg_rev_per_user AS
    SELECT 
        ROUND(AVG(daily_free_ad_rev), 2) AS daily_avg_revenue_per_free_user
    FROM
        (SELECT 
            SUM(daily_ads_price) AS daily_free_ad_rev
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
        GROUP BY Free_Subscription_idSubscription) t1