SELECT avg(users) as Media
FROM (SELECT photo, count(user) as users
        FROM AppearsIn
        WHERE photo IN (SELECT photo
                        FROM Likes
                        GROUP BY photo
                        HAVING count(user)>3)
    GROUP BY photo);