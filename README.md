# Taxi Rides NYC - dbt Project

This dbt project models and analyzes taxi ride data in New York City. It includes staging, core, and aggregated models to provide insights into taxi trips, revenue, and zones.

## Project Structure

The project is organized into the following directories:

- **models/staging**: Contains staging models (`stg_green_tripdata.sql`, `stg_yellow_tripdata.sql`) that clean and prepare raw data for further transformations.
- **models/core**: Contains core models (`fact_trips.sql`, `dim_zones.sql`, `dm_monthly_zone_revenue.sql`) that define the main data structures for analysis.
- **seeds**: Contains seed data (`taxi_zone_lookup.csv`) for taxi zones and their metadata.
- **macros**: Contains reusable SQL macros, such as `get_payment_type_description.sql`.
- **analyses**: Placeholder for analysis files.
- **snapshots**: Placeholder for snapshot files.
- **tests**: Placeholder for custom tests.

## Key Models

### Staging Models
- **stg_green_tripdata**: Prepares data for green taxi trips.
- **stg_yellow_tripdata**: Prepares data for yellow taxi trips.

### Core Models
- **fact_trips**: Combines green and yellow taxi trip data into a unified fact table.
- **dim_zones**: Provides a dimension table for taxi zones, including borough and service zone information.
- **dm_monthly_zone_revenue**: Aggregates monthly revenue and trip metrics by pickup zone and service type.

## Seed Data
- **taxi_zone_lookup.csv**: Contains metadata about taxi zones, including borough, zone name, and service zone.

## Macros
- **get_payment_type_description**: Maps payment type codes to human-readable descriptions.

## Configuration

### dbt Project Configuration
The project is configured in `dbt_project.yml`:
- Models in the `staging` folder are materialized as views.
- Models in the `core` folder are materialized as tables.

### Variables
- `payment_type_values`: Accepted values for the `payment_type` field.

## How to Run the Project

1. Install dbt and set up your environment.
2. Configure your database connection in the `profiles.yml` file.
3. Run the following commands:
   - **Build models**: `dbt build`
   - **Run tests**: `dbt test`
   - **Seed data**: `dbt seed`
4. Explore the results in your database.

## Testing
The project includes tests for:
- Primary keys (`tripid`) to ensure uniqueness and non-null values.
- Relationships between fact tables and dimension tables (e.g., `pickup_locationid` and `taxi_zone_lookup`).
- Accepted values for fields like `payment_type`.

## Resources
- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [dbt Discourse](https://discourse.getdbt.com/)
- [dbt Community](https://getdbt.com/community)
- [dbt Blog](https://blog.getdbt.com/)

## Future Improvements
- Add more tests for data quality.
- Include additional analyses in the `analyses` folder.
- Expand the project to include other taxi services or datasets.

---
This project was created as part of learning dbt and analytics engineering. Special thanks to the instructors and contributors of **DE Zoomcamp** program for their guidance and resources.