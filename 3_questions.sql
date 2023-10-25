--3.1 Select all warehouses.


------> select*from warehouses;


--3.2 Select all boxes with a value larger than $150.


------> select*from boxes where value>150;


--3.3 Select all distinct contents in all the boxes.


------> select distinct contents from  boxes;


--3.4 Select the average value of all the boxes.


------> select avg(value) from  boxes;


--3.5 Select the warehouse code and the average value of the boxes in each warehouse.


------> select w.code , avg (value) from warehouses w join boxes b on w.code=b.warehouse group by b.warehouse;


--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.


------> select warehouse from boxes where value>(select avg(value) from boxes);


--3.7 Select the code of each box, along with the name of the city the box is located in.


------> SELECT b.Code AS BoxCode, w.Location AS City
FROM Boxes b
JOIN Warehouses w ON b.Warehouse = w.Code;


--3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).


------> SELECT w.Code AS WarehouseCode, w.Location AS City, COUNT(b.Code) AS BoxCount
FROM Warehouses w
LEFT JOIN Boxes b ON w.Code = b.Warehouse
GROUP BY w.Code, w.Location;


--3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).


------> select code from warehouses where capacity < (select count(*) from boxes where warehouses = warehouses.code);



--3.10 Select the codes of all the boxes located in Chicago.


------> SELECT Code AS BoxCode
FROM Boxes
WHERE Warehouse IN (SELECT Code FROM Warehouses WHERE Location = 'Chicago');


--3.11 Create a new warehouse in New York with a capacity for 3 boxes.


------> INSERT INTO Warehouses (Code, Location, Capacity) VALUES (6, 'New York', 3);


--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.


------> INSERT INTO Boxes (Code, Contents, Value, Warehouse) VALUES ('H5RT', 'Papers', 200, 2);


--3.13 Reduce the value of all boxes by 15%.


------> UPDATE Boxes
SET Value = Value * 0.85;


--3.14 Remove all boxes with a value lower than $100.


------> DELETE FROM Boxes
WHERE Value < 100;


-- 3.15 Remove all boxes from saturated warehouses.


------> DELETE FROM Boxes
WHERE Warehouse IN (
    SELECT w.Code
    FROM Warehouses w
    INNER JOIN (
        SELECT Warehouse, SUM(Value) AS TotalValue
        FROM Boxes
        GROUP BY Warehouse
        HAVING TotalValue > w.Capacity
    ) s ON w.Code = s.Warehouse
);


-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice


------> ALTER TABLE Boxes
ADD INDEX idx_Warehouse (Warehouse);


-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice


------> SHOW INDEXES FROM Boxes;


-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
------> DROP INDEX idx_Warehouse ON Boxes; 

