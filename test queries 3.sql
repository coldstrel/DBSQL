SELECT * FROM Actor LIMIT 100
select * from titles as t ,Ratings as r where t.ttype='movie'AND r.num_votes >= 10000 LIMIT 100

INSERT INTO Actor(SELECT DISTINCT
				  nid AS nid,
				  primaryName AS name,
				  birthYear AS birthYear,
				  deathYear AS deathYear
				  FROM Persons, Ratings r, Titles t
				  WHERE (r.num_votes, t.ttype) 
				  IN (SELECT r.num_votes, t.ttype
												FROM Ratings as r, Titles as t
												WHERE r.num_votes >= 10000 AND t.ttype='movie'
												ORDER BY avg_rating DESC LIMIT 5000) 
				 )



select * from Actor, Ratings where num_votes >= 10000 order by avg_rating DESC LIMIT 5000

select * from Persons where  knownfortitles LIKE '%tt0214831%' 
OR  knownfortitles LIKE '%tt0214831'  LIMIT 100


select * from Titles where tid='tt0113094' LIMIT 100

select * from persons limit 200

Select p.nid, p.primaryname, p.birthyear, t.tid,p.knownfortitles
FROM titles t
JOIN persons p
ON t.tid = p.knowfortitles LIMIT 100

AND t.tid LIKE '%tt0214831%' 


CONCAT('%', p.knownfortitles, '%')
