
WITH hoursworked AS (
    SELECT 
        emp_id,
        CASE
            WHEN MINUTE(timestamp) >= MINUTE(LAG(timestamp) OVER (PARTITION BY DATE(timestamp), emp_id ORDER BY timestamp)) THEN
                HOUR(timestamp) - HOUR(LAG(timestamp) OVER (PARTITION BY DATE(timestamp), emp_id ORDER BY timestamp))
            ELSE
                HOUR(timestamp) - HOUR(LAG(timestamp) OVER (PARTITION BY DATE(timestamp), emp_id ORDER BY timestamp)) - 1
        END AS workhours
    FROM attendance
    WHERE DAYNAME(timestamp) IN ('Saturday', 'Sunday')
)
SELECT 
    emp_id,
    SUM(workhours) AS hours_worked
FROM hoursworked
WHERE workhours IS NOT NULL
GROUP BY emp_id
ORDER BY hours_worked DESC;
