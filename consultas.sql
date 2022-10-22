
--Javierl las 2, 4, 14, 15, 16, 17?
--2) Dar el nombre del proveedor y los productos que él haya provisto,
-- donde por lo menos tenga 3 de sus producto que estén en una o mar órdenes.
------------ REVISAR LOGICA AMIGO DE DANNI
SELECT  S.COMPANYNAME, P.PRODUCTNAME, OD.QUANTITY AS QUANTITY_FOR_ORDER, O.ORDERID
FROM ORDERS O INNER JOIN ORDERDETAILS OD ON O.ORDERID = OD.ORDERID
INNER JOIN PRODUCTS P ON OD.PRODUCTID = P.PRODUCTID
INNER JOIN SUPPLIERS S ON P.SUPPLIERID =  S.SUPPLIERID
WHERE OD.QUANTITY > 3
ORDER BY O.ORDERID, S.COMPANYNAME, P.PRODUCTNAME, OD.QUANTITY DESC;



--4) Dar el nombre de todos los clientes que ha recibido sus paquetes por el
-- transportista “Speedy Express”, y que haya sido atendido por un empleado que no
-- tenga mando.
--*************************************************************************

 ----------------------------MANERA CORRECTA
 SELECT C.COMPANYNAME AS NOMBRE_DEL_CLIENTE, S.COMPANYNAME AS NOMBRE_DEL_TRANSPORTISTA, E.FIRSTNAME ||' '||E.LASTNAME, E.REPORTSTO
FROM EMPLOYEES E INNER JOIN ORDERS O ON E.EMPLOYEEID =  O.EMPLOYEEID 
INNER JOIN SHIPPERS S ON O.SHIPVIA = S.SHIPPERID
INNER JOIN CUSTOMERS C ON O.CUSTOMERID = C.CUSTOMERID
WHERE E.REPORTSTO IS NULL AND
S.COMPANYNAME = 'Speedy Express';







--14) Cree un script que muestre nombre del cliente que haya tenido más pedidos
-- que todos los demás clientes.
--MANERA CORRECTA
--Intentar hacerlo en el WHERE por que al inge no le gusta en el FROM
SELECT *
FROM(
    SELECT C.COMPANYNAME AS NOMBRE_DEL_CLEINTE, COUNT(O.ORDERID) AS TOTAL_DE_ORDENES
    FROM ORDERS O, CUSTOMERS C
    WHERE O.CUSTOMERID =  C.CUSTOMERID
    GROUP BY C.COMPANYNAME
    ORDER BY TOTAL_DE_ORDENES DESC
) TOP_LIST
WHERE ROWNUM = 1;
-------or

SELECT C.CONTACTNAME AS NOMBRE_DEL_CLIENTE, COUNT(O.ORDERID) AS TOTAL_DE_ORDENES
FROM ORDERS O, CUSTOMERS C
WHERE O.CUSTOMERID =  C.CUSTOMERID
GROUP BY C.CONTACTNAME
ORDER BY TOTAL_DE_ORDENES DESC
FETCH FIRST ROW ONLY




--15) Dar el nombre del cliente y el nombre del producto con su código, más comprado.
--DE TODAS LAS ORDEENES EL PRODUC MAS VENDIDO  Y PONER EL NOMBRE DEL CUSTOMER`
--MANERA CORRECA
SELECT C.CONTACTNAME, P.PRODUCTNAME, P.PRODUCTID, SUM(OD.QUANTITY) AS CANTIDAD_VENDIDA
FROM CUSTOMERS C INNER JOIN ORDERS O ON C.CUSTOMERID = O.CUSTOMERID
INNER JOIN ORDERDETAILS OD ON O.ORDERID = OD.ORDERID
INNER JOIN PRODUCTS P ON OD.PRODUCTID = P.PRODUCTID
GROUP BY C.CONTACTNAME, P.PRODUCTNAME, P.PRODUCTID
ORDER BY SUM(OD.QUANTITY) DESC
FETCH FIRST 2 ROW ONLY;







--16) Dar el nombre de los 5 clientes quienes más dinero gastaron junto con los cinco
-- clientes que menos gastaron, cree una columna que indique si corresponde a los
-- que más o menos gastaron.
--oracle--oracle
SELECT *
FROM(    
    SELECT C.CONTACTNAME, SUM((OD.Quantity*OD.UnitPrice)-OD.Discount) AS TOTAL, 'Mas Gastaron' AS GASTO 
    FROM customers C INNER JOIN orders O ON O.CUSTOMERID = C.CUSTOMERID 
    INNER JOIN orderdetails OD ON OD.OrderID = O.OrderID 
    GROUP BY C.CONTACTNAME
    ORDER BY SUM(OD.Quantity*OD.UnitPrice)  DESC 
    FETCH FIRST 5 ROW ONLY) mas_gastaron
UNION ALL 
SELECT *
FROM (
    SELECT C1.CONTACTNAME, SUM((OD1.Quantity*OD1.UnitPrice)-OD1.Discount) AS TOTAL, 'Menos Gastaron' AS GASTO 
    FROM customers C1 INNER JOIN orders O1 ON O1.CUSTOMERID = C1.CUSTOMERID 
    INNER JOIN orderdetails OD1 ON OD1.OrderID = O1.OrderID 
    GROUP BY CONTACTNAME  
    ORDER BY SUM((OD1.Quantity*OD1.UnitPrice)-OD1.Discount) ASC 
    FETCH FIRST 5 ROW ONLY) menos_gastaron;



--17) Dar el nombre y apellido del Jefe de los empleados que haya obtenido más ordenes
-- realizadas y que en esas órdenes tuvieron que haber vendido al menos 5
-- productos en cada orden.
--CONSULTAR AL INGE SOBRE LOS CAMIINOS DE LASS RELACIONES
SELECT B.FIRSTNAME||' '|| B.LASTNAME AS NOMBRE_COMPLETO_JEFE, E.FIRSTNAME AS NOMBRE_EMPLEADO, COUNT(O.ORDERID) AS NUMERO_ORDENES
FROM EMPLOYEES B 
INNER JOIN EMPLOYEES E ON B.EMPLOYEEID = E.REPORTSTO
INNER JOIN ORDERS O ON E.EMPLOYEEID = O.EMPLOYEEID
INNER JOIN ORDERDETAILS OD ON O.ORDERID = OD.ORDERID
WHERE OD.QUANTITY > 5
GROUP BY B.FIRSTNAME||' '|| B.LASTNAME, E.FIRSTNAME
ORDER BY NUMERO_ORDENES DESC;


----------------------------------DANI-------------------------------------
----------------------------------DANI-------------------------------------
----------------------------------DANI-------------------------------------

--Daniel te parece si haces las 1, 3, 5, 7,9,11
--1) Dar el nombre de los productos y el nombre de categorías,
--agrupado por categorías y en orden alfabetico.
SELECT C.CATEGORYNAME, P.PRODUCTNAME
FROM CATEGORIES C INNER JOIN PRODUCTS P ON C.CATEGORYID = P.CATEGORYID
ORDER BY C.CATEGORYNAME ASC


-- 3) Dar el nombre del transportista (shippers) y todos sus órdenes que el haya enviado, i
--incluyendo la fecha de requerimiento (requiredate) y la fecha de entrega (shipperdate), o
--ordenados por fecha de entrega.
SELECT S.COMPANYNAME AS NOMBRE_TRANSPORTISTA, O.ORDERID, O.REQUIREDDATE, O.SHIPPEDDATE 
FROM ORDERS O INNER JOIN SHIPPERS S ON O.SHIPVIA = S.SHIPPERID
ORDER BY O.SHIPPEDDATE



--5) Dar el nombre completo del empleado, nombre de la región y nombre del
-- territorio que no haya hecho ninguna orden.
--REVISAR CON CUATE DE DANNI
SELECT E.FIRSTNAME ||' '||E.LASTNAME AS NOMBRE_COMPLETO, R.REGIONDESCRIPTION, T.TERRITORYDESCRIPTION
FROM EMPLOYEES E INNER JOIN EMPLOYEETERRITORIES ET ON E.EMPLOYEEID = ET.EMPLOYEEID
INNER JOIN TERRITORIES T ON ET.TERRITORYID = T.TERRITORYID
INNER JOIN REGION R ON T.REGIONID = R.REGIONID
WHERE E.EMPLOYEEID IN (
                        SELECT EMPLOYEEID
                        FROM EMPLOYEES
                        WHERE EMPLOYEEID IS NULL)
ORDER BY E.FIRSTNAME ||' '||E.LASTNAME;
--No nos muestra ningun resultado pues todos lo empleados tienen ordenes




--7) Dar el nombre y apellido del empleado que realizaron una o más órdenes
--y el conteo de órdenes que tiene por cada empleado y donde tenga uno
-- o más productos de todas las categorías que existe, y que su número de
-- órdenes que haya hecho sea mayor a 2.
--PREGUNTAR MA˜NANA ENL LIVBE


--9) Dar el nombre de los proveedores y su teléfono que haya distribuido
-- el producto con categoría “Seefood”, pero garantizando que por
-- lo menos tenga una orden de pedido, ordenados alfabéticamente por
-- nombre de proveedor.
SELECT S.COMPANYNAME, S.PHONE, C.CATEGORYNAME, OD.QUANTITY
FROM ORDERDETAILS OD INNER JOIN PRODUCTS P ON OD.PRODUCTID = P.PRODUCTID
INNER JOIN CATEGORIES C ON P.CATEGORYID = C.CATEGORYID 
INNER JOIN SUPPLIERS S ON P.SUPPLIERID = S.SUPPLIERID
WHERE OD.QUANTITY > 0 AND
C.CATEGORYNAME = 'Seafood'
ORDER BY S.COMPANYNAME ASC



--11) (Utilizando Inner join y subconsultas), Cree un script, que
-- muestre el código del cliente de todo aquel que haya pedido más
-- de 2 unidades del producto 23
SELECT C.CUSTOMERID, C.CONTACTNAME, OD.QUANTITY
FROM ORDERDETAILS OD INNER JOIN ORDERS O ON OD.ORDERID = O.ORDERID
INNER JOIN CUSTOMERS C ON O.CUSTOMERID = C.CUSTOMERID
WHERE OD.QUANTITY > 2 AND
OD.PRODUCTID IN (
                SELECT OD.PRODUCTID
                FROM ORDERDETAILS OD
                WHERE OD.PRODUCTID = 23
)