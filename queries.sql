SELECT
    u.User_ID,
    u.Name,
    COALESCE(SUM(lc.total_likes), 0) +
    COALESCE(SUM(sc.total_shares), 0) +
    COALESCE(SUM(sv.total_saves), 0) +
    COALESCE(SUM(cc.total_comments), 0) AS Total_Engagement
FROM Users u
LEFT JOIN Posts p ON u.User_ID = p.User_ID
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_likes FROM Likes GROUP BY Post_ID
) lc ON p.Post_ID = lc.Post_ID
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_shares FROM Shares GROUP BY Post_ID
) sc ON p.Post_ID = sc.Post_ID
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_saves FROM Saves GROUP BY Post_ID
) sv ON p.Post_ID = sv.Post_ID
LEFT JOIN (
    SELECT Post_ID, COUNT(*) AS total_comments FROM Comments GROUP BY Post_ID
) cc ON p.Post_ID = cc.Post_ID
GROUP BY u.User_ID, u.Name
ORDER BY Total_Engagement DESC
LIMIT 3;


SELECT DISTINCT u.User_ID, u.Name
FROM Users u
WHERE u.User_ID IN (
    SELECT DISTINCT User_ID FROM Comments
)
AND u.User_ID NOT IN (
    SELECT DISTINCT User_ID FROM Likes
)
AND u.User_ID NOT IN (
    SELECT DISTINCT User_ID FROM Shares
)
AND u.User_ID NOT IN (
    SELECT DISTINCT User_ID FROM Saves
);


SELECT User_ID, Name FROM Users WHERE User_ID IN (
    SELECT User_ID FROM Likes
    EXCEPT
    SELECT User_ID FROM Comments
);

SELECT
    p.Post_ID,
    p.Caption,
    COUNT(l.User_ID) AS Like_Count
FROM Posts p
JOIN Likes l ON p.Post_ID = l.Post_ID
GROUP BY p.Post_ID, p.Caption
HAVING COUNT(l.User_ID) > (
    SELECT AVG(like_count)
    FROM (SELECT COUNT(*) AS like_count FROM Likes GROUP BY Post_ID) AS avg_likes
);

SELECT
    f1.Follower_ID AS User1_ID,
    u1.Name AS User1_Name,
    f1.Followee_ID AS User2_ID,
    u2.Name AS User2_Name
FROM Follows f1
JOIN Follows f2
    ON f1.Follower_ID = f2.Followee_ID
    AND f1.Followee_ID = f2.Follower_ID
JOIN Users u1 ON f1.Follower_ID = u1.User_ID
JOIN Users u2 ON f1.Followee_ID = u2.User_ID
WHERE f1.Follower_ID < f1.Followee_ID;