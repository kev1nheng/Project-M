#Display the number of months since a customer has begun using the music streaming service

SELECT 
    invoices.Users_idUsers,
    TIMESTAMPDIFF(MONTH,
        subscription.subscription_startdate,
        MAX(invoice_date)) AS Month_since_subscribed,
    COUNT(invoices.Users_idUsers) AS Month_invoices_payed
FROM
    subscription,
    invoices
WHERE
    idSubscription = invoices.Subscription_idSubscription
GROUP BY Users_idUsers