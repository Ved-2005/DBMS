CREATE INDEX idx_users_email ON Users(Email);

CREATE INDEX idx_users_name ON Users(Name);

CREATE INDEX idx_posts_user_id ON Posts(User_ID);

CREATE INDEX idx_follow_follower ON Follows(Follower_ID);

CREATE INDEX idx_follow_followee ON Follows(Followee_ID);

CREATE INDEX idx_likes_post_id ON Likes(Post_ID);

CREATE INDEX idx_comments_user_id ON Comments(User_ID);

CREATE INDEX idx_saves_post_id ON Saves(Post_ID);

CREATE INDEX idx_shares_post_id ON Shares(Post_ID);

CREATE INDEX idx_reports_post_id ON Reports(Post_ID);

CREATE INDEX idx_admin_controls_admin ON Admin_Controls(Admin_ID);

CREATE INDEX idx_replies_main_comment ON Comment_Replies(Main_Comment_ID);
