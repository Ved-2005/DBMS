-- 1. Admin Table
CREATE TABLE Admin (
    Admin_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Date_of_Birth DATE,
    Email VARCHAR(100) UNIQUE,
    Phone_number VARCHAR(15) UNIQUE,
    Password VARCHAR(100),
    Join_date DATE DEFAULT CURRENT_DATE
);

-- 2. User Table
CREATE TABLE User (
    User_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Phone_number VARCHAR(15) UNIQUE,
    Date_of_Birth DATE,
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Signup_date DATE DEFAULT CURRENT_DATE,
    Bio TEXT
);

-- 3. Posts Table
CREATE TABLE Posts (
    Post_ID SERIAL PRIMARY KEY,
    Content TEXT,
    Caption TEXT,
    Music VARCHAR(100),
    Location VARCHAR(100),
    User_ID INT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE
);

-- 4. Follow Table
CREATE TABLE Follow (
    Follower_ID INT,
    Followee_ID INT,
    Followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Follower_ID, Followee_ID),
    FOREIGN KEY (Follower_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Followee_ID) REFERENCES User(User_ID) ON DELETE CASCADE
);

-- 5. User_engages_with_posts Table
CREATE TABLE User_engages_with_posts (
    User_ID INT,
    Post_ID INT,
    PRIMARY KEY (User_ID, Post_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Post_ID) REFERENCES Posts(Post_ID) ON DELETE CASCADE
);

-- 6. Like Table
CREATE TABLE Like (
    Like_ID SERIAL PRIMARY KEY,
    Liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    User_ID INT,
    Post_ID INT,
    FOREIGN KEY (User_ID, Post_ID) REFERENCES User_engages_with_posts(User_ID, Post_ID) ON DELETE CASCADE
);

-- 7. Save Table
CREATE TABLE Save (
    Save_ID SERIAL PRIMARY KEY,
    Saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    User_ID INT,
    Post_ID INT,
    FOREIGN KEY (User_ID, Post_ID) REFERENCES User_engages_with_posts(User_ID, Post_ID) ON DELETE CASCADE
);

-- 8. Share Table
CREATE TABLE Share (
    Share_ID SERIAL PRIMARY KEY,
    Shared_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    User_ID INT,
    Post_ID INT,
    FOREIGN KEY (User_ID, Post_ID) REFERENCES User_engages_with_posts(User_ID, Post_ID) ON DELETE CASCADE
);

-- 9. Reports Table
CREATE TABLE Reports (
    Report_ID SERIAL PRIMARY KEY,
    Reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    User_ID INT,
    Post_ID INT,
    Reason TEXT,
    FOREIGN KEY (User_ID, Post_ID) REFERENCES User_engages_with_posts(User_ID, Post_ID) ON DELETE CASCADE
);

-- 10. Comment Table
CREATE TABLE Comment (
    Comment_ID SERIAL PRIMARY KEY,
    Commented_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    User_ID INT,
    Post_ID INT,
    Content TEXT,
    FOREIGN KEY (User_ID, Post_ID) REFERENCES User_engages_with_posts(User_ID, Post_ID) ON DELETE CASCADE
);

-- 11. User_replies_on_comments Table
CREATE TABLE User_replies_on_comments (
    Main_comment_ID INT,
    Reply_comment_ID INT,
    PRIMARY KEY (Main_comment_ID, Reply_comment_ID),
    FOREIGN KEY (Main_comment_ID) REFERENCES Comment(Comment_ID) ON DELETE CASCADE,
    FOREIGN KEY (Reply_comment_ID) REFERENCES Comment(Comment_ID) ON DELETE CASCADE
);

-- 12. Admin_controls Table
CREATE TABLE Admin_controls (
    Admin_ID INT,
    User_ID INT,
    Post_ID INT,
    PRIMARY KEY (Admin_ID, User_ID, Post_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID) ON DELETE CASCADE,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Post_ID) REFERENCES Posts(Post_ID) ON DELETE CASCADE
);