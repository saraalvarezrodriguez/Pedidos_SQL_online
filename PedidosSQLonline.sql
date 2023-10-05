USE dbgsipp7ucsuwy;
SELECT* FROM PRODUCTO;

/*Obtener el código, nombre y precio de los productos(estos dos últimos en el mismo
campo) que están contenidos en los pedidos que ha tomado nota "Luis" o "María
Luisa". Ordena el listado de mayor a menor valor por fecha del pedido.*/
SELECT PR.Codigo, E.Nombre, CONCAT(PR.Nombre, ' ' , PR.Precio) AS NOMBRE_PRECIO
FROM PRODUCTO PR, PEDIDO P, consta C, EMPLEADO E
WHERE PR.Codigo = C.Codigo_Pr
AND P.Numero= C.Numero_P
AND P.DNI_ETM= E.DNI
AND E.nombre LIKE '%Luis%'
ORDER BY P.Fecha DESC;

/*Obtener por cada repartidor, su nombre, cantidad de pedidos y el tiempo medio
que tardan en entregar los pedidos una vez preparados. Ordenar el listado el
tiempo medio que tardan en entregarlos:*/
SELECT R.nombre, COUNT(*) AS cantidad_repartos,

TIME_FORMAT(AVG(TIMEDIFF(Hora_rep,Hora_pre)),'%T')AS tiempo_entrega

FROM REPARTIDOR R, PEDIDO P

WHERE R.DNI = P.DNI_R

GROUP BY R.DNI

ORDER BY 3;

/*Obtener un listado obteniendo el código, nombre y el precio de los productos
cuyo precios sea el más barato o el más caro de todos.*/
SELECT Codigo, Nombre, precio

FROM PRODUCTO

WHERE precio = (SELECT MAX(precio)

FROM PRODUCTO)

OR precio = (SELECT MIN(precio)

FROM PRODUCTO);

/*Obtener por cada producto , el nombre y código el número total de pedidos en
los que se encuentra teniendo en cuenta que el total de pedidos en los cuales se
encuentre sea superior o igual a dos. Ordena el listado de mayor a menor
número de productos*/
SELECT PR.nombre, PR.codigo, count(P.Numero) as cantidad_pedidos

FROM PEDIDO P, PRODUCTO PR, consta C

WHERE P.numero = C.numero_P

AND PR.codigo = C.codigo_Pr

GROUP BY PR.codigo

HAVING cantidad_pedidos>=2

ORDER BY cantidad_pedidos DESC;

/*Mostrar listado de los empleados (código y NSS en la misma columna) que
han tomado nota de algún pedido y contienen el producto de código 13 y
además el repartidor sea 'Laura'.*/
SELECT E.nombre, CONCAT(E.DNI, ' ' , E.NSS) as Identificación

FROM EMPLEADO E, PEDIDO P, REPARTIDOR R, consta C

WHERE E.DNI = P.DNI_ETM AND R.DNI= P.DNI_R AND P.numero =

C.numero_P

AND R.nombre LIKE '%Laura%'

AND C.codigo_Pr ='13';

/*Obtener el nombre del producto que es menú junto con el código de los
productos que lo componen en aquellos pedidos del mes de septiembre de
2020.*/
SELECT P.numero AS numero_pedido,PR.nombre , PR.codigo,

EC.codigo_P_compuesto as

producto_que_lo_compone, PRODUCTO.nombre as descripción_p_que_lo_compone

FROM PRODUCTO PR, PEDIDO P, esta_compuesto EC, consta C, PRODUCTO PRODUCTO

WHERE PR.codigo=EC.codigo_p AND PR.codigo=C.codigo_PR

AND P.numero=C.numero_P AND PRODUCTO.codigo= EC.codigo_p_compuesto

AND P.fecha BETWEEN '2020-09-01' AND '2020-09-30';


