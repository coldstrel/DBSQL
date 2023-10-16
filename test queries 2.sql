select * from Persons where  knownfortitles LIKE '%tt0214831%' 
OR  knownfortitles LIKE '%tt0214831'  LIMIT 100

Select p.nid, p.primaryname, p.birthyear,p.knownfortitles
FROM titles t
JOIN persons p
ON t.tid LIKE CONCAT('%', p.knownfortitles, '%') LIMIT 1000

Select p.nid, p.primaryname, p.birthyear,p.knownfortitles,  t.tid
FROM titles t
JOIN persons p
ON t.tid =p.knownfortitles
AND p.knownfortitles LIKE CONCAT('%',t.tid,'%') LIMIT 100

select * from persons where nid='nm14013703'


Select p.nid, p.primaryname, p.birthyear,p.knownfortitles,  t.tid
FROM titles t
JOIN persons p
ON p.knownfortitles LIKE '%tt0214831%' 
AND t.tid  LIKE '%tt0214831%' LIMIT 100

t.tid =p.knownfortitles
AND p.knownfortitles LIKE CONCAT('%',t.tid,'%') LIMIT 100

