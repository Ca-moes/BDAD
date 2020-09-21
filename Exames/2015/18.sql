DELETE 
FROM Photo
WHERE uploadDate < "2010-01-10" 
AND id IN (
    SELECT A.photo 
    FROM AppearsIn A
    GROUP BY A.photo 
    HAVING count(user)<2
    );