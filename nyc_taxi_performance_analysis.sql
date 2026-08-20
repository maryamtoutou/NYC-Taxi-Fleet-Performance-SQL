/*
  =============================================================================
  NYC YELLOW TAXI FLEET PERFORMANCE ANALYSIS (JAN 2022)
  Objective: Evaluate daily revenue trends, categorize trip distance efficiency, 
  and analyze driver tipping behavior based on payment methods.
  =============================================================================
*/

-- ============================================================================
-- 1. Daily Revenue Performance & Cumulative Total
-- Insight: Tracks daily revenue and running totals to spot external anomalies 
-- (e.g., the 60% revenue drop during Winter Storm Kenan).
-- ============================================================================
WITH dates AS (
    SELECT 
        DISTINCT DATE(pickup_datetime) AS pickup_date, 
        SUM(total_amount) AS total_amount
    FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
    WHERE pickup_datetime BETWEEN '2022-01-01 00:00:00 UTC' AND '2022-01-31 23:59:00 UTC'
    GROUP BY pickup_date
)
SELECT 
    pickup_date, 
    total_amount, 
    SUM(total_amount) OVER(ORDER BY pickup_date) AS cumulitive_total_amount 
FROM dates;

-- ============================================================================
-- 2. Trip Distance & Revenue Efficiency
-- Insight: Classifies trips to prove that short trips yield the highest 
-- revenue per mile ($9.55/mile) compared to long-haul trips.
-- ============================================================================
SELECT 
    COUNT(trip_distance) AS number_of_trips,
    AVG(trip_distance) AS avg_trip_distance,
    AVG(fare_amount) AS avg_fare_amount,
    AVG(total_amount) AS avg_total_amount,
    AVG(SAFE_DIVIDE(fare_amount, trip_distance)) AS avg_fare_per_mile,
    CASE
        WHEN trip_distance < 2 THEN 'Short'
        WHEN trip_distance BETWEEN 2 AND 7 THEN 'Medium'
        WHEN trip_distance > 7 THEN 'Long_haul'
    END AS trip_distance_category
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE pickup_datetime BETWEEN '2022-01-01 00:00:00 UTC' AND '2022-01-31 23:59:00 UTC'
GROUP BY trip_distance_category
ORDER BY number_of_trips DESC;

-- ============================================================================
-- 3. Payment Method & Driver Tipping Behavior
-- Insight: Filters out bad data (cash tips = $0) and identifies top locations 
-- (LGA and JFK airports) for the highest tipping percentages and amounts.
-- ============================================================================
SELECT 
    CASE 
        WHEN payment_type = '1' THEN 'Credit Card'
        WHEN payment_type = '2' THEN 'Cash'  
    END AS payment_type,
    AVG(tip_amount) AS avg_tip_amount,
    AVG(SAFE_DIVIDE(tip_amount, fare_amount)) AS avg_tip_percentage,
    pickup_location_id,
    COUNT(pickup_location_id) AS numbre_of_location
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE pickup_datetime BETWEEN '2022-01-01 00:00:00 UTC' AND '2022-01-31 23:59:00 UTC'  
  AND payment_type IN ('1','2')
  AND fare_amount > 0
  AND trip_distance > 5
GROUP BY payment_type, pickup_location_id 
HAVING numbre_of_location > 10000
ORDER BY avg_tip_percentage DESC
LIMIT 5;
