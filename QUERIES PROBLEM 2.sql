select * from movie limit 100
select * from director limit 100
select * from actor limit 100

DROP TABLE IF EXISTS movie CASCADE;
DROP TABLE IF EXISTS director CASCADE;
DROP TABLE IF EXISTS actor CASCADE;


CREATE TABLE Movie(
    tid char(10) PRIMARY KEY,
    title varchar(1024),
    year int,
    length int,
    rating numeric
);


CREATE TABLE DirectedBy (
  directorID char(10),
  movieID char(10)
);

CREATE TABLE ActorinMovie (
  actorID char(10),
  movieID char(10)
);

CREATE TABLE Director(
    nid char(10),
    name varchar(128),
    birthYear int,
    deathYear int
);

CREATE TABLE Actor(
    nid char(10),
    name varchar(128),
    birthYear int,
    deathYear int
);

INSERT INTO movie(
select DISTINCT
	t.tid as tid, 
	primarytitle as title, 
	startyear as year, 
	runtimeminutes as length, 
	r.avg_rating as rating 

from titles t 
join ratings r 
on t.tid=r.tid 
where t.ttype = 'movie' AND r.num_votes>=10000 
group by t.tid, primarytitle, startyear, runtimeminutes, r.avg_rating
order by avg_rating DESC
LIMIT 5000
);


INSERT INTO director 
(select DISTINCT 
    pp.nid AS nid,
    pp.primaryName AS name,
    pp.birthYear AS birthYear,
    pp.deathYear AS deathYear					  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='director'
);


INSERT INTO actor (
select DISTINCT 
    pp.nid AS nid,
    pp.primaryName AS name,
    pp.birthYear AS birthYear,
    pp.deathYear AS deathYear	  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='actor' or p.category='actress'
);

selec 
select * from actor limit 200

INSERT INTO directedby 
(select DISTINCT 
    pp.nid AS directorid,
    m.tid AS movieid			  
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='director'
);

INSERT INTO actorinmovie (
select DISTINCT 
    pp.nid AS actorid,
	m.tid as movieid 
from persons pp
join principals p on pp.nid=p.nid
join movie m on  p.tid=m.tid
where p.category='actor' or p.category='actress'
);


select * from directedby limit 2
--- ADD PK to the tables 
ALTER TABLE Movie ADD CONSTRAINT pk_movie  PRIMARY KEY(tid)
ALTER TABLE Actor ADD CONSTRAINT pk_actor  PRIMARY KEY(nid);
ALTER TABLE Director ADD CONSTRAINT pk_diretor  PRIMARY KEY(nid);
ALTER TABLE directedby ADD CONSTRAINT pk_directed  PRIMARY KEY(directorid,movieid);
ALTER TABLE actorinmovie ADD CONSTRAINT pk_actor_movie  PRIMARY KEY(actorid, movieid);

---- Add FK to the tables
ALTER TABLE ActorinMovie ADD CONSTRAINT fk_actor_actor FOREIGN KEY(actorid) REFERENCES Actor(nid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ActorinMovie ADD CONSTRAINT fk_actor_movie FOREIGN KEY(movieID) REFERENCES movie(tid) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE DirectedBy ADD CONSTRAINT fk_director_director FOREIGN KEY(directorid) REFERENCES Director(nid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE DirectedBy ADD CONSTRAINT fk_director_movie FOREIGN KEY(movieID) REFERENCES movie(tid) ON UPDATE CASCADE ON DELETE CASCADE;

SELECT * FROM DIRECTOR WHERE NAME='Steven Spielberg';
---2.B
UPDATE Director SET nid='123456789' WHERE NAME='Steven Spielberg';
SELECT * FROM Director WHERE NAME='Steven Spielberg';
SELECT * FROM DirectedBy WHERE Directorid='123456789';
---- Its updated on both tables

---2.c
SELECT * FROM Actor WHERE name='Robert De Niro';
SELECT * FROM Director WHERE name='Robert De Niro'; --doesnt exists
DELETE FROM Actor WHERE name='Robert De Niro';
SELECT * FROM ActorinMovie WHERE actorid='nm0000134'

---2.d
INSERT INTO ActorinMovie VALUES ('123456789', '987654321')


---2.e
UPDATE DirectedBy SET directorid='999999' WHERE Directorid='123456789';





