# Nashville Housing Data Cleaning and Analysis

This project focuses on cleaning and analyzing the Nashville Housing dataset using SQL. The dataset contains information about property sales, including addresses, sale dates, and sale prices.

## Steps
1. **Data Cleaning**:
   - Standardized date formats.
   - Populated missing property addresses.
   - Split addresses into individual columns (address, city, state).
   - Standardized categorical values (e.g., 'y' to 'yes').
   - Removed duplicate rows.

2. **Exploratory Analysis**:
   - Analyzed trends in property sales.
   - Identified key insights from the cleaned data.

## SQL Techniques Used
- `STR_TO_DATE` for date conversion.
- `SUBSTRING` and `LOCATE` for splitting strings.
- `ROW_NUMBER()` for identifying duplicates.
- `CASE` for standardizing values.
- `ALTER TABLE` for schema modifications.

## How to Use
1. Clone the repository.
2. Run the SQL scripts in your preferred SQL environment.
3. Explore the cleaned dataset and analysis.
