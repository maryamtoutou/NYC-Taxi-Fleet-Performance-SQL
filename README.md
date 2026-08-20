# 🚕 NYC Yellow Taxi Fleet Performance Analysis

### 📋 Project Objective
Analyzed the January 2022 NYC Yellow Taxi dataset to evaluate daily revenue trends, trip distance efficiency, and driver tipping behavior. The goal was to use Google BigQuery and Power BI to identify operational trends supporting fleet planning and performance decisions.

### 🗂️ Data Source
* **Dataset:** Google BigQuery Public Data (`bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`)

### 🛠️ Tools & Technologies
* **Data Warehouse / SQL Engine:** Google BigQuery
* **Data Visualization:** Microsoft Power BI

### 📊 Key Business Insights
* **Weather Impact on Revenue:** Revenue peaked at over $1.89 million on January 27. A sharp 60% drop occurred on January 29, falling to $596,288. This decline directly correlated with Winter Storm Kenan, which restricted vehicle movement.
* **Revenue Efficiency:** Short trips of less than 2 miles represent 56% of the volume with 1.39 million trips. These trips generate the highest revenue efficiency at $9.55 per mile. Long-haul trips over 7 miles yield just $3.04 per mile.
* **Tipping & Data Quality:** The system fails to record cash tips, systematically showing them as $0.00. For credit card payments on trips over 5 miles, LaGuardia Airport (Location 138) has the highest tip percentage at 23.8%. JFK Airport (Location 132) yields the highest average tip amount at $9.61.

### 💡 Strategic Recommendations
* **Fleet Positioning:** Prioritize fleet positioning for short-haul trips in urban centers to maximize per-mile revenue efficiency. Maintain a strong presence at LaGuardia and JFK airports to capture high-tip, high-ticket fares.
* **Risk Management:** Implement proactive fleet management plans to minimize revenue loss during severe weather events.
* **Data Quality:** Address the data quality issue regarding unrecorded cash tips to accurately track driver earnings.
