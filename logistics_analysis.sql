-- Portfolio Project #2: Logistics Delivery Performance Analysis
-- Personal portfolio project using simulated data.
-- Import logistics_delivery_data.csv as a table named: deliveries

-- 1. Delivery volume by warehouse
SELECT warehouse, COUNT(*) AS total_deliveries
FROM deliveries
GROUP BY warehouse
ORDER BY total_deliveries DESC;

-- 2. Delivery status breakdown
SELECT delivery_status, COUNT(*) AS total_orders
FROM deliveries
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- 3. Average delivery delay by warehouse
SELECT warehouse, ROUND(AVG(delay_days), 2) AS avg_delay_days
FROM deliveries
WHERE delivery_status <> 'Cancelled'
GROUP BY warehouse
ORDER BY avg_delay_days DESC;

-- 4. Top 5 destinations by delivery volume
SELECT destination, COUNT(*) AS total_deliveries
FROM deliveries
GROUP BY destination
ORDER BY total_deliveries DESC
LIMIT 5;

-- 5. Average delivery cost by vehicle type
SELECT vehicle_type, ROUND(AVG(delivery_cost_rm), 2) AS avg_delivery_cost_rm
FROM deliveries
GROUP BY vehicle_type
ORDER BY avg_delivery_cost_rm DESC;

-- 6. Total logistics cost by warehouse
SELECT warehouse, ROUND(SUM(delivery_cost_rm), 2) AS total_delivery_cost_rm
FROM deliveries
GROUP BY warehouse
ORDER BY total_delivery_cost_rm DESC;

-- 7. On-time performance by warehouse
SELECT warehouse,
       COUNT(*) AS completed_deliveries,
       SUM(CASE WHEN delay_days = 0 THEN 1 ELSE 0 END) AS on_time_deliveries,
       ROUND(100.0 * SUM(CASE WHEN delay_days = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS on_time_rate_pct
FROM deliveries
WHERE delivery_status <> 'Cancelled'
GROUP BY warehouse
ORDER BY on_time_rate_pct DESC;
