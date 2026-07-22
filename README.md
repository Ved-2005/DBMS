#  Social Media Management System Database
This system simulates a simple backend infrastructure of a social media platform, handling complex relationships between users, posts, comments, likes, and administrative moderation.
##  Project Contents
This repository contains the complete database design, implementation, and analysis:
*   **`schema.pdf` & `ER-Diagram.pdf`**: Visual representations of the database schema and Entity-Relationship model.
*   **`script.sql`**: The Data Definition Language (DDL) scripts to create the database schema, including all tables, primary keys, foreign keys, and constraints.
*   **`data.txt`**: Seed data to populate the database with realistic sample users, admins, posts, comments, likes, shares, saves, reports, and follows.
*   **`queries.sql`**: A collection of SQL queries demonstrating advanced database operations, including analytical queries, aggregations, and multi-table joins.
*   **`BCNF_proof.md`**: A formal mathematical proof verifying that all 11 relations in the database schema strictly adhere to Boyce-Codd Normal Form (BCNF), ensuring optimal data integrity and zero redundancy.
##  Key Features & Capabilities
*   **User Engagement**: Support for creating posts, commenting (including nested replies), liking, sharing, and saving posts.
*   **Social Graph**: Functionality for users to follow and unfollow each other, enabling customized timelines.
*   **Content Moderation**: Reporting system allowing users to flag inappropriate content.
*   **Administrative Controls**: Dedicated tools for administrators to review reports, manage users, and moderate posts.
##  Architectural Decisions: Resolving Circular Dependencies
Because admins are a subset of users, and admins need to manage users and moderate posts, a direct foreign key relationship could have created a problematic circular dependency. 
To solve this and maintain a clean, normalized structure, I implemented two specific junction tables:
1.  **`MANAGES` (Admin_ID, User_ID)**: Decouples the administrative action of managing a user from the core user entities.
2.  **`MODERATES` (Admin_ID, Post_ID)**: Decouples the administrative action of moderating a post from the core post entities.
This design cleanly separates the *identity* of an admin (stored in `ADMIN` and `USERS`) from their *actions* (`MANAGES`, `MODERATES`), ensuring the database remains flexible, avoids circular foreign key constraints, and stays strictly within BCNF.
##  Learning Outcomes
*   Applied advanced relational database design principles and Entity-Relationship modeling.
*   Practiced complex SQL operations: multi-table joins, subqueries, aggregations, and window-like analytical queries.
*   Successfully applied normalization theory to prove the schema is in Boyce-Codd Normal Form (BCNF).
*   Resolved complex architectural challenges, such as circular dependencies, using standard relational design patterns.