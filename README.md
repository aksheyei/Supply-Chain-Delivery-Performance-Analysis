# 📦 Supply Chain Delivery Performance Analysis (OTIF)

### **Executive Summary**
FreshKart Supply Chain Pvt Ltd is experiencing a critical operational decline, with **On-Time In-Full (OTIF) performance dropping to ~28.7%**. This analysis identifies that 41% of orders are delayed and only 52% are fulfilled in-full, primarily driven by logistics inefficiencies and stock-outs of high-demand products. Using **SQL for data engineering** and **Power BI for diagnostic analytics**, I developed a performance monitoring system to identify root causes and provide a roadmap for operational recovery.

### **1. Problem Statement**
FreshKart is facing poor delivery performance, leading to low customer satisfaction and operational inefficiencies. The primary objectives of this analysis were:
*   To identify the root causes behind the **41% delay rate**.
*   To determine why nearly half of all orders fail the **"In-Full" fulfillment** criteria.
*   To pinpoint specific geographic and product-based bottlenecks affecting the supply chain.

### **2. Data Understanding & Tech Stack**
*   **Tech Stack:** SQL (Data Querying), Power BI (Visualization), and Excel (Validation).
*   **Key Files in Repository:**
    *   `FRESHKART_SQL_SCRIPT.sql`: Contains the logic for KPI calculation and data preparation.
    *   `FeshKat-Dashboard.pbix`: The interactive Power BI report for stakeholder review.

### **3. Analysis Workflow (The STAR Approach)**
*   **Situation:** OTIF metrics were declining month-over-month (March to May), threatening customer retention.
*   **Task:** Analyze order-level data to identify the specific cities and products driving these failures.
*   **Action:** 
    *   Performed **KPI Analysis** (OTIF, On-Time %, Fill Rate) using SQL.
    *   Conducted **City-Level Analysis**, identifying Vadodara as a major delay point.
    *   Executed **Product-Level Analysis** to identify high-demand stock-out patterns.
*   **Result:** Identified that logistics delays and inventory gaps in "Hero" products (Ghee, Butter, Biscuits) are the primary drivers of performance failure.

### **4. Key Insights (The "So What?")**
*   **Critical Delivery Gap:** The current OTIF rate of **~28.7%** indicates a systemic failure in meeting customer promises.
*   **The Vadodara Bottleneck:** This city consistently shows the highest delivery delays, indicating local distribution issues.
*   **Fulfillment Crisis:** High-demand staples like **Ghee, Butter, and Biscuits** face frequent stock-outs, preventing "In-Full" delivery.

## 📊 Dashboard Preview

## Operation Summary

<p align="center">
  <img src="Operation%20summary.png" alt="Operation Summary Dashboard" width="900">
</p>

### **5. Actionable Recommendations**
*   **Logistics Optimization:** Optimize delivery routes and implement real-time tracking, with a priority focus on **Vadodara**.
*   **Inventory Resilience:** Maintain **safety stock** for high-demand products (Ghee, Butter, Biscuits) and improve replenishment planning.
*   **Proactive Monitoring:** Transition to **weekly KPI monitoring** and performance reviews to catch delays before they impact the monthly OTIF.

### **6. Conclusion**
By addressing last-mile logistics delays and inventory shortages through data-driven planning, FreshKart can significantly improve its OTIF performance and overall customer satisfaction.
```



