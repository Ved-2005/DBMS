# BCNF Proof — Social Media Management System

## BCNF Definition
A relation **R** is in **Boyce-Codd Normal Form (BCNF)** if and only if, for every non-trivial functional dependency X -> Y that holds in **R**, **X** is a **superkey** of **R**.

## Table-by-Table Analysis

| Relation | Attributes | Candidate Keys | Functional Dependencies | Determinant is Superkey? | BCNF? |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **USERS** | User_ID (PK), Name, Email (UNIQUE, NOT NULL), Password, Phone, DOB, Bio, Join_Date | {User_ID}, {Email} | User_ID &rarr; Name, Email, Password, Phone, DOB, Bio, Join_Date<br><br>Email &rarr; User_ID, Name, Password, Phone, DOB, Bio, Join_Date | Yes (User_ID is the PK)<br><br>Yes (Email is a candidate key) | Yes |
| **ADMIN** | User_ID (PK, FK) | {User_ID} | None non-trivial | N/A (Satisfied vacuously) | Yes |
| **POST** | Post_ID (PK), User_ID (FK), Content, Caption, Music, Location, Created_At | {Post_ID} | Post_ID &rarr; User_ID, Content, Caption, Music, Location, Created_At | Yes (Post_ID is the PK) | Yes |
| **COMMENT** | Comment_ID (PK), User_ID (FK), Post_ID (FK), Parent_Comment_ID (FK), Content, Commented_At | {Comment_ID} | Comment_ID &rarr; User_ID, Post_ID, Parent_Comment_ID, Content, Commented_At | Yes (Comment_ID is the PK) | Yes |
| **LIKES** | User_ID (PK, FK), Post_ID (PK, FK), Liked_At | {User_ID, Post_ID} | {User_ID, Post_ID} &rarr; Liked_At | Yes (Composite PK is the only candidate key) | Yes |
| **SHARES** | User_ID (PK, FK), Post_ID (PK, FK), Shared_At | {User_ID, Post_ID} | {User_ID, Post_ID} &rarr; Shared_At | Yes (Composite PK is the only candidate key) | Yes |
| **SAVES** | User_ID (PK, FK), Post_ID (PK, FK), Saved_At | {User_ID, Post_ID} | {User_ID, Post_ID} &rarr; Saved_At | Yes (Composite PK is the only candidate key) | Yes |
| **REPORTS** | User_ID (PK, FK), Post_ID (PK, FK), Reported_At, Reason | {User_ID, Post_ID} | {User_ID, Post_ID} &rarr; Reported_At, Reason | Yes (Composite PK is the only candidate key) | Yes |
| **FOLLOWS** | Follower_ID (PK, FK), Followee_ID (PK, FK), Followed_At | {Follower_ID, Followee_ID} | {Follower_ID, Followee_ID} &rarr; Followed_At | Yes (Composite PK is the only candidate key) | Yes |
| **MANAGES** | Admin_ID (FK), User_ID (PK, FK) | {User_ID} | User_ID &rarr; Admin_ID | Yes (User_ID is the PK) | Yes |
| **MODERATES**| Admin_ID (FK), Post_ID (PK, FK) | {Post_ID} | Post_ID &rarr; Admin_ID | Yes (Post_ID is the PK) | Yes |
