# EXERCISE SHEET 1

Start to download the Databases from the IMDB

- name.basics.tsv.gz
- title.basics.tsv.gz
- title. principals.tsv.gz
- title.ratings.tsv.gz
---

## Problem 1
### PART A
Create a database in pgAdmin (postgreSQL) called "IMDB"

![Alt text][database_create]

[database_create]: image.png

Create a table for each of the datasets we have using the query tool and load the data in the table; we can load using the *import/export data* assistant
![Alt text](image-1.png)

Or by writing the next line of query: 
``` SQL
COPY principals 
FROM 'YTHE PATH OF THE DATA' NULL '\N' HEADER ENCODING 'UTF8'
```

The data needs to be in an accessible path such as the **temp** path

NOTE: As it is a TSV file we need tto import it using the divider as a [tab] and select it a header 

![Alt text](image-2.png)

Once it's all done with the first table we need to replicate this step for the other 3 tables.

NOTE: If the "Import\Export tool" shows us an error regarding the utiity is  not found we have to do the next steps.

![Alt text](image-3.png)

Now we can see the data imported into our tables using the Querie:
```SQL
SELECT * FROM table_name LIMIT 10
```
The LIMIT let us only see a part of the data since there are big data sets and it could take some time to load

![Alt text](image-4.png)

### PART B

Now we have to create an E/R schema as follows:

![Alt text](image-5.png)

And insert the data from the first 4 tables created in **PART A**; we must omit any form of keys and constraints in this step and also we must inlcude the datatypes of the attributes given in the queries from ***PART A***

*TABLE: MOVIE*
```SQL
CREATE TABLE Movie(
    tid char(10),
    title varchar(1024),
    year int,
    length int,
    rating numeric
);
```
***TABLE: DIRECTOR***
```SQL
CREATE TABLE Director(
    nid char(10),
    name varchar(128),
    birthYear int,
    deathYear int
);
```

***TABLE: ACTOR***

```SQL
CREATE TABLE Actor(
    nid char(10),
    name varchar(128),
    birthYear int,
    deathYear int
);
```

### PART C
Load the data from the first 4 tables created in *PART A* into the tables created in *PART B*

1. Load the data into the ***MOVIE*** table
```SQL
INSERT INTO movie(
select DISTINCT t.tid as tid, primarytitle as title, startyear as year, runtimeminutes as length, r.avg_rating as rating from titles t 
join ratings r 
on t.tid=r.tid 
where t.ttype = 'movie' AND r.num_votes<=10000 
group by t.tid, primarytitle, startyear, runtimeminutes, r.avg_rating
order by avg_rating DESC
LIMIT 5000
)
```
Giving us this result:
![Alt text](image-6.png)


We use the ***MOVIE*** table to add the other values to the table director and actor

*For Director Table*
```SQL
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
)
```
![Alt text](image-7.png)

*For Actor Table*

```SQL
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
)
```
![Alt text](image-8.png)

















