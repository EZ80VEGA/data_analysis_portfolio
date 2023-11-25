##Challenge 1 - Get the 5 oldest users on the platform to ‘reward’ them for being longtime users.

SELECT * FROM users
ORDER BY created_at
LIMIT 5;

##Challenge 2 - What day of the week do most users register on?

SELECT DAYNAME(created_at) AS day,
COUNT(*) AS total
FROM users
GROUP BY DAYNAME(created_at)
ORDER BY total DESC ;

##Challenge 3 - Which users are inactive? Which have not posted a photo

SELECT username, image_url
FROM users
LEFT JOIN photos ON [users.id](http://users.id/) = photos.user_id
WHERE image_url is NULL;

##Challenge 4 - We’re running a new contest to see who can get the most likes in a single photo. Who won?

##Answer 1:

SELECT photo_id, username, COUNT(photo_id) AS photo_likes FROM photos
JOIN likes ON likes.photo_id = [photos.id](http://photos.id/)
JOIN users on photos.user_id = [users.id](http://users.id/)
GROUP BY photo_id
ORDER BY photo_likes DESC
LIMIT 1;

##Answer 2: 

SELECT [photos.id](http://photos.id/),
users.username,
COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
ON likes.photo_id = [photos.id](http://photos.id/)
INNER JOIN users
ON photos.user_id = [users.id](http://users.id/)
GROUP BY [photos.id](http://photos.id/)
ORDER BY total_likes DESC
LIMIT 1;

##Challenge 5 - Our Investors want to know how many times does the average user post?

SELECT
(SELECT COUNT(**) FROM photos) / (SELECT COUNT(**) FROM users) AS avg_post;

##Challenge 6 - What are the five most popular hashtags?

##Answer 1:

SELECT id, tag_name, COUNT(tag_id) AS times_used  FROM tags
JOIN photo_tags ON [tags.id](http://tags.id/) = photo_tags.tag_id
GROUP BY tag_id
ORDER BY times_used
DESC
LIMIT 5 ;

##Answer 2:

SELECT tags.tag_name,
Count(*) AS total
FROM   photo_tags
JOIN tags
ON photo_tags.tag_id = [tags.id](http://tags.id/)
GROUP  BY [tags.id](http://tags.id/)
ORDER  BY total DESC
LIMIT  5;

##Challenge 7 - How many of the users are bots? - The user would have liked all the photos posted.

##Answer 1:

SELECT username,
Count(*) AS num_likes
FROM   users
INNER JOIN likes
ON [users.id](http://users.id/) = likes.user_id
GROUP  BY likes.user_id
HAVING num_likes = (SELECT Count(*)
FROM   photos);

##Answer 2: 

SELECT username, COUNT(user_id) AS times_liked
FROM users
JOIN likes ON likes.user_id = [users.id](http://users.id/)
GROUP BY user_id
ORDER BY times_liked
DESC
LIMIT 20;