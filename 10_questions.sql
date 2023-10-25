-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE

-----> select p.id,p.name,a.address from people p join address a on p.id=a.id where a.updatedate in(select max(updatedate) from address group by id);



-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE


-----> select p.id,p.name,a.address,a.updatedate from people p join address a on p.id=a.id where a.updatedate in(select max(updatedate) from address group by id);



