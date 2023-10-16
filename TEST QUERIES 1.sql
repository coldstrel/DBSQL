Select p.nid, p.primaryname, p.birthyear,p.knownfortitles,  t.tid
FROM titles t
JOIN persons p
ON p.knownfortitles LIKE '%tt0214831%' 
AND t.tid  LIKE '%tt0214831%' LIMIT 100

select * from persons
select * from movie
select * from ratings

INSERT INTO Movie(SELECT DISTINCT
				  t.tid AS tid,
				  primaryTitle AS title,
				  startYear AS year,
				  runtimeMinutes AS length
				  FROM titles t
				  JOIN Ratings ON t.tid=Ratings.tid
				  WHERE t.ttype='movie' AND Ratings.num_votes >= 10000
				  GROUP BY t.tid, primaryTitle, startYear, runtimeMinutes
				  ORDER BY avg_rating DESC
				  LIMIT 5000
				 )
				 
Select * from titles limit 10

INSERT INTO movie(
select DISTINCT t.tid as tid, primarytitle as title, startyear as year, runtimeminutes as length, r.avg_rating as rating from titles t 
join ratings r 
on t.tid=r.tid 
where t.ttype = 'movie' AND r.num_votes<=10000 
group by t.tid, primarytitle, startyear, runtimeminutes, r.avg_rating
order by avg_rating DESC
LIMIT 5000
)

-- persons PP and principals p
INSERT INTO director (select DISTINCT 
					  pp.nid AS nid,
					  pp.primaryName AS name,
					  pp.birthYear AS birthYear,
					  pp.deathYear AS deathYear
					  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='director'
)
select * from director
select DISTINCT count(pp.birthYear)					  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='director'

select DISTINCT
					 ( pp.nid,
					  pp.primaryName ,
					  pp.birthYear,
					  pp.deathYear)
					  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='director'
order by pp.nid,primaryName ,birthYear,deathYear ASC


select * from director


select * from persons limit 10
select * from persons where knownfortitles LIKE '%tt23720380%'
select * from persons where nid='nm4531113'

select * from principals where nid='nm4531113'




INSERT INTO actor (select distinct (
					  pp.nid AS nid,
					  pp.primaryName AS name ,
					  pp.birthYear AS birthYear,
					  pp.deathYear AS deathYear
				)	  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='actor' or p.category='actress'
				   )
				   
				   
INSERT INTO actor (select DISTINCT 
					  pp.nid AS nid,
					  pp.primaryName AS name,
					  pp.birthYear AS birthYear,
					  pp.deathYear AS deathYear
					  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='actor' or p.category='actress'
)

select * from actor limit 100






