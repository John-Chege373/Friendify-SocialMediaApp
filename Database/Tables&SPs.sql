create database Friendify;
use Friendify;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(50),
    password  VARCHAR(50),
    bio VARCHAR(500),
    cover_picture_url VARCHAR(255),
    profile_picture_url VARCHAR(255),
    city VARCHAR(500),
);

-- Stored Procedure for InsertUser
CREATE PROCEDURE InsertUser (
    @p_user_id INT,
    @p_username VARCHAR(50),
    @p_email VARCHAR(50),
    @p_password VARCHAR(50),
    @p_bio VARCHAR(500),
    @p_profile_picture_url VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Users (user_id, username, email, [password], bio, profile_picture_url)
    VALUES (@p_user_id, @p_username, @p_email, @p_password, @p_bio, @p_profile_picture_url);
END;

-- InsertUser  Stored Procedure Execution: 
EXEC InsertUser
    @p_user_id = 21,
    @p_username = 'JohnDoee11',
    @p_email = 'john11@example.com',
    @p_password = 'password1234',
    @p_bio = 'This is John Doe11.',
    @p_profile_picture_url = 'https://example.com/profile_picture1.jpg';

select * from Users;
Drop table Users
select* from users;



CREATE TABLE Post (
    post_id INT PRIMARY KEY,
    user_id INT,
    content VARCHAR(255),
    media_url VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

-- Stored Procedure: InsertPost
CREATE PROCEDURE InsertPost (
    @p_post_id INT,
    @p_user_id INT,
    @p_content VARCHAR(255),
    @p_media_url VARCHAR(255)
)
AS
BEGIN
    INSERT INTO [Post] (post_id, user_id, content, media_url)
    VALUES (@p_post_id, @p_user_id, @p_content, @p_media_url);
END;

--  InsertPost Stored Procedure Execution :
DECLARE @post_id INT = 11;
DECLARE @user_id INT = 11;
DECLARE @content VARCHAR(255) = 'This is a post.';
DECLARE @media_url VARCHAR(255) = 'https://example.com/post_media.jpg';

EXEC InsertPost
    @p_post_id = @post_id,
    @p_user_id = @user_id,
    @p_content = @content,
    @p_media_url = @media_url;

    select * from Post;

	
CREATE TABLE Comment (
    comment_id INT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Post (post_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

drop table Comment;
-- Stored Procedure: InsertComment
CREATE PROCEDURE InsertComment (
    @p_comment_id INT,
    @p_post_id INT,
    @p_user_id INT,
    @p_content VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Comment (comment_id, post_id, user_id, content)
    VALUES (@p_comment_id, @p_post_id, @p_user_id, @p_content);
END;

-- Execute Stored Procedure: InsertComment
DECLARE @comment_id INT =11;
DECLARE @post_id INT = 11;
DECLARE @user_id INT = 11;
DECLARE @content VARCHAR(255) = 'This is a comment.';

EXEC InsertComment
    @p_comment_id = @comment_id,
    @p_post_id = @post_id,
    @p_user_id = @user_id,
    @p_content = @content;

	SELECT * FROM Comment

CREATE TABLE Likes (
    like_id INT PRIMARY KEY,
    post_id INT,
    user_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Post (post_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

-- Stored Procedure: InsertLike
CREATE PROCEDURE InsertLike (
    @p_like_id INT,
    @p_post_id INT,
    @p_user_id INT
)
AS
BEGIN
    INSERT INTO [Like] ([like_id], post_id, user_id)
    VALUES (@p_like_id, @p_post_id, @p_user_id);
END;

-- Execute Stored Procedure: InsertLike
DECLARE @like_id INT = 11;
DECLARE @post_id INT = 11;
DECLARE @user_id INT = 11;

EXEC InsertLike
    @p_like_id = @like_id,
    @p_post_id = @post_id,
    @p_user_id = @user_id;

drop table Likes


CREATE TABLE relationships (
    follower_id INT,
    following_id INT,
    FOREIGN KEY (follower_id) REFERENCES Users (user_id),
    FOREIGN KEY (following_id) REFERENCES Users (user_id)
);

-- Stored Procedure: InsertFollower
CREATE PROCEDURE InsertFollower (
    @p_follower_id INT,
    @p_following_id INT
)
AS
BEGIN
    INSERT INTO relationships (follower_id, following_id)
    VALUES (@p_follower_id, @p_following_id);
END;

-- Execute Stored Procedure: InsertFollower
DECLARE @follower_id INT = 21;
DECLARE @following_id INT = 11;

EXEC InsertFollower
    @p_follower_id = @follower_id,
    @p_following_id = @following_id;

	SELECT* FROM relationships

CREATE TABLE Notification (
    notification_id INT PRIMARY KEY,
    user_id INT,
    notification_type VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

-- Stored Procedure: InsertNotification
CREATE PROCEDURE InsertNotification (
    @p_notification_id INT,
    @p_user_id INT,
    @p_notification_type VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Notification (notification_id, user_id, notification_type)
    VALUES (@p_notification_id, @p_user_id, @p_notification_type);
END;

-- Execute Stored Procedure: InsertNotification
DECLARE @notification_id INT = 1;
DECLARE @user_id INT = 11;
DECLARE @notification_type VARCHAR(255) = 'New message received';

EXEC InsertNotification
    @p_notification_id = @notification_id,
    @p_user_id = @user_id,
    @p_notification_type = @notification_type;
	select* from Notification


CREATE TABLE Friend_Request (
    request_id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    status VARCHAR(50),
    created_at TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users (user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users (user_id)
);

-- Stored Procedure: InsertFriendRequest
CREATE PROCEDURE InsertFriendRequest (
    @p_request_id INT,
    @p_sender_id INT,
    @p_receiver_id INT,
    @p_status VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Friend_Request (request_id, sender_id, receiver_id, status)
    VALUES (@p_request_id, @p_sender_id, @p_receiver_id, @p_status);
END;

-- Execute Stored Procedure: InsertFriendRequest
DECLARE @request_id INT = 11;
DECLARE @sender_id INT = 11;
DECLARE @receiver_id INT = 21;
DECLARE @status VARCHAR(50) = 'Pending';

EXEC InsertFriendRequest
    @p_request_id = @request_id,
    @p_sender_id = @sender_id,
    @p_receiver_id = @receiver_id,
    @p_status = @status;

	select* from Friend_Request
CREATE TABLE Media (
    media_id INT PRIMARY KEY,
    post_id INT,
    media_type VARCHAR(50),
    media_url VARCHAR(255),
    FOREIGN KEY (post_id) REFERENCES Post (post_id)
);

-- Stored Procedure: InsertMedia
CREATE PROCEDURE InsertMedia (
    @p_media_id INT,
    @p_post_id INT,
    @p_media_type VARCHAR(50),
    @p_media_url VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Media (media_id, post_id, media_type, media_url)
    VALUES (@p_media_id, @p_post_id, @p_media_type, @p_media_url);
END;

-- Execute Stored Procedure: InsertMedia
DECLARE @media_id INT = 1;
DECLARE @post_id INT = 1;
DECLARE @media_type VARCHAR(50) = 'Image';
DECLARE @media_url VARCHAR(255) = 'https://example.com/image.jpg';

EXEC InsertMedia
    @p_media_id = @media_id,
    @p_post_id = @post_id,
    @p_media_type = @media_type,
    @p_media_url = @media_url;
Drop table Media

CREATE TABLE Settings (
    settings_id INT PRIMARY KEY,
    user_id INT,
    notification_enabled BIT,
    privacy_level VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

-- Stored Procedure: InsertSettings
CREATE PROCEDURE InsertSettings (
    @p_settings_id INT,
    @p_user_id INT,
    @p_notification_enabled BIT,
    @p_privacy_level VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Settings (settings_id, user_id, notification_enabled, privacy_level)
    VALUES (@p_settings_id, @p_user_id, @p_notification_enabled, @p_privacy_level);
END;

-- Execute Stored Procedure: InsertSettings
DECLARE @settings_id INT = 1;
DECLARE @user_id INT = 1;
DECLARE @notification_enabled BIT = 1;
DECLARE @privacy_level VARCHAR(50) = 'High';

EXEC InsertSettings
    @p_settings_id = @settings_id,
    @p_user_id = @user_id,
    @p_notification_enabled = @notification_enabled,
    @p_privacy_level = @privacy_level;


CREATE TABLE Stories (
    story_id INT PRIMARY KEY,
    user_id INT,
    content VARCHAR(255),
    media_url VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

CREATE PROCEDURE CreateStoriesTable
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Stories') AND type in (N'U'))
    BEGIN
        CREATE TABLE Stories (
            story_id INT PRIMARY KEY,
            user_id INT,
            content VARCHAR(255),
            media_url VARCHAR(255),
            created_at DATETIME DEFAULT GETDATE(),
            FOREIGN KEY (user_id) REFERENCES Users (user_id)
        );
        
        PRINT 'Stories table created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Stories table already exists.';
    END
END;

EXEC CreateStoriesTable;



























