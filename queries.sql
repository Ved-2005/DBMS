--1 This query identifies the top 3 most influential users based on 
-- the total engagement (likes + shares + saves + comments) 
-- received on all their posts.

SELECT 
    u.User_ID, 
    u.Name,
    COALESCE(SUM(like_counts.total_likes), 0) +
    COALESCE(SUM(share_counts.total_shares), 0) +
    COALESCE(SUM(save_counts.total_saves), 0) +
    COALESCE(SUM(comment_counts.total_comments), 0) AS Total_Engagement
FROM 
    Users u
LEFT JOIN 
    Posts p ON u.User_ID = p.User_ID

-- Subquery: Get total likes per post
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_likes
    FROM User_likes_post
    GROUP BY Post_ID
) like_counts ON p.Post_ID = like_counts.Post_ID

-- Subquery: Get total shares per post
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_shares
    FROM User_shares_post
    GROUP BY Post_ID
) share_counts ON p.Post_ID = share_counts.Post_ID

-- Subquery: Get total saves per post
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_saves
    FROM User_saves_post
    GROUP BY Post_ID
) save_counts ON p.Post_ID = save_counts.Post_ID

-- Subquery: Get total comments per post
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_comments
    FROM User_comments_on_post
    GROUP BY Post_ID
) comment_counts ON p.Post_ID = comment_counts.Post_ID

GROUP BY u.User_ID, u.Name
ORDER BY Total_Engagement DESC
LIMIT 3;




-- 2This query finds users who have only commented on posts 
-- but have never liked, shared, or saved any post.

SELECT DISTINCT u.User_ID, u.Name
FROM Users u
WHERE u.User_ID IN (
    SELECT DISTINCT User_ID FROM User_comments_on_post
)
AND u.User_ID NOT IN (
    SELECT DISTINCT User_ID FROM User_likes_post
)
AND u.User_ID NOT IN (
    SELECT DISTINCT User_ID FROM User_shares_post
)
AND u.User_ID NOT IN (
    SELECT DISTINCT User_ID FROM User_saves_post
);


--3 This query lists the top 5 users whose posts have been 
-- reported the most by other users.

SELECT 
    u.User_ID, 
    u.Name, 
    COUNT(r.Report_ID) AS Total_Reports
FROM 
    Users u
JOIN 
    Posts p ON u.User_ID = p.User_ID
JOIN 
    User_reports_post r ON p.Post_ID = r.Post_ID
GROUP BY 
    u.User_ID, u.Name
ORDER BY 
    Total_Reports DESC
LIMIT 5;


-- 4. Find the top 5 most liked posts along with the user who posted them
SELECT p.Post_ID, u.Name AS Posted_By, COUNT(l.Like_ID) AS Total_Likes
FROM Posts p
JOIN User u ON p.User_ID = u.User_ID
JOIN Like l ON p.Post_ID = l.Post_ID
GROUP BY p.Post_ID, u.Name
ORDER BY Total_Likes DESC
LIMIT 5;

-- 5. Find users who have never posted anything
SELECT u.User_ID, u.Name
FROM User u
LEFT JOIN Posts p ON u.User_ID = p.User_ID
WHERE p.Post_ID IS NULL;

-- 6. Find the most commented post and its author
SELECT p.Post_ID, u.Name AS Posted_By, COUNT(c.Comment_ID) AS Comment_Count
FROM Posts p
JOIN Comment c ON p.Post_ID = c.Post_ID
JOIN User u ON p.User_ID = u.User_ID
GROUP BY p.Post_ID, u.Name
ORDER BY Comment_Count DESC
LIMIT 1;

-- 7. Find mutual followers (users who follow each other)
SELECT f1.Follower_ID AS User1, f1.Followee_ID AS User2
FROM Follow f1
JOIN Follow f2 ON f1.Follower_ID = f2.Followee_ID AND f1.Followee_ID = f2.Follower_ID;

-- 8. Get the number of posts each user has created
SELECT u.User_ID, u.Name, COUNT(p.Post_ID) AS Post_Count
FROM User u
LEFT JOIN Posts p ON u.User_ID = p.User_ID
GROUP BY u.User_ID, u.Name
ORDER BY Post_Count DESC;

-- 9. Find users who joined in the current month
SELECT User_ID, Name, Signup_date
FROM User
WHERE DATE_TRUNC('month', Signup_date) = DATE_TRUNC('month', CURRENT_DATE);

-- 10. List posts that have been reported more than once
SELECT p.Post_ID, COUNT(r.Report_ID) AS Report_Count
FROM Posts p
JOIN Reports r ON p.Post_ID = r.Post_ID
GROUP BY p.Post_ID
HAVING COUNT(r.Report_ID) > 1
ORDER BY Report_Count DESC;

-- 11. Get the top 3 most shared posts with their creators
SELECT p.Post_ID, u.Name AS Posted_By, COUNT(s.Share_ID) AS Total_Shares
FROM Posts p
JOIN Share s ON p.Post_ID = s.Post_ID
JOIN User u ON p.User_ID = u.User_ID
GROUP BY p.Post_ID, u.Name
ORDER BY Total_Shares DESC
LIMIT 3;

-- 12. Find users who have commented on their own posts
SELECT DISTINCT u.User_ID, u.Name
FROM Comment c
JOIN Posts p ON c.Post_ID = p.Post_ID
JOIN User u ON c.User_ID = u.User_ID
WHERE c.User_ID = p.User_ID;

-- 13. Find admins who have taken actions on more than 5 posts
SELECT a.Admin_ID, a.Name, COUNT(ac.Post_ID) AS Action_Count
FROM Admin a
JOIN Admin_controls ac ON a.Admin_ID = ac.Admin_ID
GROUP BY a.Admin_ID, a.Name
HAVING COUNT(ac.Post_ID) > 5
ORDER BY Action_Count DESC;
