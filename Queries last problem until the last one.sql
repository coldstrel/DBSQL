--Select the most popular directors based on how many movies they directed, stop after the top 25
--directors with the most movies. Also make sure to only return those directors which never appeared
--as an actor in any movie. 

SELECT name, COUNT(movieid)
FROM Director 
JOIN DirectedBy ON directorid=nid
WHERE Director.nid NOT IN (
	SELECT directorID 
	FROM Directedby
	JOIN ActorinMovie ON directorID=actorID
)
GROUP BY name
ORDER BY COUNT desc
LIMIT 25

--Select the top 25 pairs of actors that occur together in a same movie, ordered by the number of
--movies in which they co-occur. 

SELECT movieid, nid, name, actorid
FROM Actor
RIGHT JOIN actorinmovie ON actorid=nid 
ORDER BY movieid


SELECT A.name AS name_actor_1, B.name AS name_actor_2, COUNT(*) AS co_occurrences
FROM ActorinMovie AS A1
JOIN ActorinMovie AS A2 ON A1.movieID = A2.movieID AND A1.actorID < A2.actorID
JOIN Actor AS A ON A1.actorID = A.nid
JOIN Actor AS B ON A2.actorID = B.nid
GROUP BY A.name, B.name
ORDER BY co_occurrences DESC
LIMIT 25;




SELECT name, COUNT(movieid)
FROM Director 
JOIN DirectedBy ON directorid=nid
WHERE Director.nid NOT IN (
	SELECT directorID 
	FROM Directedby
	JOIN ActorinMovie ON directorID=actorID
)
GROUP BY name
ORDER BY COUNT desc
LIMIT 25


WITH ActorDirectorPairs AS (
    SELECT A.actorID AS ActorID, D.directorID AS DirectorID,A.movieID AS movieID
    FROM ActorinMovie AS A
    JOIN DirectedBy AS D ON A.movieID = D.movieID
)
SELECT ActorID, DirectorID, COUNT(DISTINCT movieID) AS co_occurrences
FROM ActorDirectorPairs
GROUP BY ActorID, DirectorID
HAVING COUNT(DISTINCT movieID) >= 4
ORDER BY co_occurrences DESC




