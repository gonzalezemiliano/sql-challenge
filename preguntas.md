# Preguntas de entrevista Data Engineer

---

## 🧰 SQL y Performance

1. **¿Cómo escribirías una consulta SQL performante sobre una tabla muy grande?**
   **Respuesta modelo:**

   * Seleccionar sólo las columnas necesarias (`SELECT columna1, columna2` vs `SELECT *`).
   * Filtrar primero con índices (`WHERE fecha BETWEEN …`) para reducir filas.
   * Evitar subconsultas corridas fila‑a‑fila; usar operaciones basadas en conjuntos (`JOIN`, `EXISTS`).
   * Comprobar que los campos usados en filtros y joins tengan índices adecuados.
   * Usar particionado o paginación (`OFFSET/FETCH`) si la tabla es masiva.
   * Revisar el plan de ejecución y ajustar según operadores costosos.

   **Palabras clave:**
   `proyección de columnas`, `set-based`, `uso de índices`, `particionado/segmentación`, `OFFSET/FETCH`, `plan de ejecución`, `costly operators`.

2. **Si una consulta SQL tiene bajo rendimiento, ¿cómo la analizarías para identificar el problema?**
   **Respuesta modelo:**

   1. Obtener el **plan de ejecución** real y compararlo con el estimado.
   2. Detectar operadores caros (Table Scan, Hash Match, Sort).
   3. Revisar estadísticas (`UPDATE STATISTICS`) y niveles de fragmentación.
   4. Usar **DMVs** como `sys.dm_exec_query_stats` y Missing Index DMVs.
   5. Probar versiones alternativas de la consulta (reformular joins, agregar índices, desnormalizar).

   **Palabras clave:**
   `actual vs estimated`, `Table Scan vs Index Seek`, `UPDATE STATISTICS`, `sys.dm_exec_query_stats`, `Missing Index`, `fragmentación`.

3. **¿Qué herramientas o enfoques usarías para medir performance en SQL Server?**
   **Respuesta modelo:**

   * **SQL Server Profiler** o **Extended Events** para capturar tiempos y deadlocks.
   * **Query Store** para comparar planes en el tiempo.
   * **Performance Monitor** (PerfMon) para métricas de CPU, IO y memoria.
   * **Dynamic Management Views** (DMVs) para estadísticas en tiempo real.
   * Pruebas de carga (HammerDB, JMeter) en entornos de staging.

   **Palabras clave:**
   `Extended Events`, `Query Store`, `PerfMon counters`, `sys.dm_exec_requests`, `pruebas de carga`.

4. **¿Qué son los índices en una base de datos y cuándo conviene usarlos?**
   **Respuesta modelo:**

   * Estructuras B‑tree (clustered vs non‑clustered) que aceleran búsquedas y ordenamientos.
   * Útiles cuando hay **filtros frecuentes** (`WHERE`), joins o `ORDER BY` sobre columnas de alta selectividad.
   * **Contra:** degradan DML (INSERT/UPDATE/DELETE) y aumentan almacenamiento.
   * Balancear número de índices: suficientes para lecturas, pero no tantos que ralenticen escrituras.

   **Palabras clave:**
   `clustered vs non‑clustered`, `selectividad alta`, `covering index`, `page splits`, `rebuild/reorganize`.

5. **¿Qué tipos de JOIN existen en SQL? Da un ejemplo práctico de cuándo usar LEFT JOIN vs INNER JOIN.**
   **Respuesta modelo:**

   * **INNER JOIN:** sólo coincidencias.
   * **LEFT JOIN:** todas filas de la izquierda, NULL si no hay match.
   * **RIGHT JOIN**, **FULL JOIN**, **CROSS JOIN**, **SELF JOIN**.
   * **Ejemplo:** para listar *todos* los clientes y sus pedidos (incluso sin pedido): `Clients LEFT JOIN Orders`. Si sólo quiero clientes con pedidos: `Clients INNER JOIN Orders`.

   **Palabras clave:**
   `NULL padding`, `casos de uso reporting vs filtrado`, `CROSS Cartesian`, `alias para SELF JOIN`.

6. **¿Qué son los triggers y las stored procedures? Menciona al menos 3 buenas prácticas para escribirlos.**
   **Respuesta modelo:**

   * **Triggers:** lógica que se ejecuta en DML (INSERT/UPDATE/DELETE).
   * **Stored Procedures:** bloques de código parametrizados, pre‑compilados.
   * **Buenas prácticas:**

     1. **Usar SET NOCOUNT ON** y manejar errores con TRY…CATCH.
     2. **Evitar lógica pesada** dentro de triggers; delegar a SP si es complejo.
     3. **Documentar parámetros** y efectos secundarios; versionar en Git.
     4. Controlar recursión con `TRIGGER_NESTLEVEL()` o `NOT FOR REPLICATION`.
     5. Mantener transacciones cortas para reducir locks.

   **Palabras clave:**
   `SET NOCOUNT`, `TRY CATCH`, `TRIGGER_NESTLEVEL`, `separación de responsabilidades`, `control de versiones`.

---

## 🧪 Testing y Validaciones

7. **¿Cómo verificarías si una migración de datos fue exitosa?**
   **Respuesta modelo:**

   * **Conteo de filas** en origen vs destino.
   * **Checksums o hashes** por particiones.
   * Validar **constraints**: NULLs, claves foráneas, unicidad.
   * Revisar logs de errores y summary reports automáticos.

   **Palabras clave:**
   `row count`, `CHECKSUM_AGG`, `constraints`, `error logs`, `data sampling`.

8. **¿Cómo probarías si una stored procedure o script de carga de datos está funcionando correctamente?**
   **Respuesta modelo:**

   * Crear **ambiente de test** con datos controlados.
   * Desarrollar **pruebas unitarias** (tSQLt) que validen resultados esperados.
   * Usar **transacciones de prueba** y hacer rollback.
   * Revisar **mensajes de retorno** y códigos de error.

   **Palabras clave:**
   `tSQLt`, `unit tests`, `BEGIN TRAN / ROLLBACK`, `asserts`, `mensajes de error`.

9. **¿Cómo detectarías datos duplicados o inconsistencias después de una carga?**
   **Respuesta modelo:**

   * Usar **GROUP BY … HAVING COUNT(\*)>1** sobre llaves naturales.
   * Comparar filas con **DBCC CHECKCONSTRAINTS**.
   * Aplicar **reconciliación** mediante SQL: uniones EXCEPT/MINUS.
   * Ejecutar scripts de validación de integridad (NULLs, rangos inválidos).

   **Palabras clave:**
   `HAVING COUNT`, `EXCEPT`, `DBCC CHECKCONSTRAINTS`, `data profiling`.

10. **¿Qué criterios usarías para una validación cruzada origen vs destino tras una migración?**
    **Respuesta modelo:**

    * **Row counts** por partición (mes, categoría).
    * **Sumatorias y agregaciones** de columnas numéricas.
    * **Muestreo aleatorio** vs consultas de borde (min/max, fechas primeras y últimas).
    * Verificar **metadatos**: tipos de datos, tamaños, nulos.

    **Palabras clave:**
    `row counts by group`, `SUM/AVG/MIN/MAX`, `random sampling`, `metadata comparison`.

---

## 📚 Modelado y Conceptos de Bases de Datos

11. **¿Cuál es la diferencia entre una base de datos relacional y una no relacional?**
    **Respuesta modelo:**

    * **Relacional:** esquema fijo, tablas con filas/columnas, transacciones ACID, SQL.
    * **No relacional:** documentos, grafos, key‑value; esquema flexible, escalabilidad horizontal, eventual consistency.
    * Elegir según **volumen**, **variabilidad** y **tipo de consulta**.

    **Palabras clave:**
    `ACID vs BASE`, `esquema fijo vs flexible`, `sharding`, `modelos (document, key‑value, graph)`.

12. **¿Qué diferencia hay entre una base de datos relacional y un data warehouse?**
    **Respuesta modelo:**

    * **Relacional OLTP:** transacciones diarias, alta concurrencia, normalización.
    * **Data Warehouse OLAP:** análitica, denormalización en star/snowflake schema, cargas batch, agregaciones.

    **Palabras clave:**
    `OLTP vs OLAP`, `normalización`, `star schema`, `ETL batch`, `consistencia vs performance`.

13. **¿Qué son las tablas de hechos y las tablas de dimensiones? Da un ejemplo.**
    **Respuesta modelo:**

    * **Fact table:** eventos medibles (VentasFact: SaleID, DateKey, ProductKey, Amount).
    * **Dimension table:** descripciones (ProductDim: ProductKey, Name, Category).
    * **Ejemplo:** esquema estrella con VentasFact unido a DateDim, ProductDim y CustomerDim.

    **Palabras clave:**
    `grain`, `surrogate key`, `measures vs attributes`, `star schema`, `hierarchy`.

14. **¿Qué son datos estructurados, semiestructurados y no estructurados? Da ejemplos.**
    **Respuesta modelo:**

    * **Estructurados:** tablas SQL, CSV con esquema fijo.
    * **Semiestructurados:** JSON, XML, logs—tienen etiquetas o claves.
    * **No estructurados:** imágenes, audio, video, texto libre.

    **Palabras clave:**
    `schema-on-write vs schema-on-read`, `JSON/XML parsing`, `data lake`, `metadata tags`.

---

## 🧱 Diseño e Integraciones

15. **¿Cómo diseñarías un pipeline para mover datos desde una API REST a un data warehouse?**
    **Respuesta modelo:**

    1. **Extracción:** llamadas paginadas a la API (control de rate limit).
    2. **Staging:** almacenar raw JSON/CSV en S3 o tabla staging.
    3. **Transformación:** limpiar y normalizar con SQL o PySpark.
    4. **Carga:** `COPY` en Redshift o `BULK INSERT` en SQL Server.
    5. **Orquestación:** Airflow / Step Functions con retries y alertas.

    **Palabras clave:**
    `paginación`, `rate limiting`, `staging schema`, `normalización`, `orquestación`, `retry/backoff`.

16. **Si un cliente tiene datos en Salesforce, Zendesk y Redshift sin alineación, ¿qué harías?**
    **Respuesta modelo:**

    * Definir un **diccionario de datos común** (glossary) con entidades clave (CustomerID, TicketID).
    * Realizar **perfilamiento** y mapping de campos.
    * Construir vistas o pipelines de transformación que unifiquen llaves naturales.
    * Validar con reglas de negocio y reconciliación periódica.

    **Palabras clave:**
    `data catalog`, `data profiling`, `field mapping`, `master data management`, `reconciliación`.

17. **¿Cómo identificarías campos clave para hacer un match entre distintas fuentes?**
    **Respuesta modelo:**

    * Analizar **frecuencia** y **unicidad** de cada campo.
    * Evaluar **calidad** (completitud, formato).
    * Priorizar campos con **baja duplicación** y buena **estandarización** (email, documento).
    * En última instancia, combinar múltiples campos (concatenar nombre + fecha).

    **Palabras clave:**
    `cardinalidad`, `calidad de datos`, `campos compuestos`, `pattern matching`, `fuzzy match`.

18. **¿Has trabajado con integraciones entre plataformas? ¿Cómo manejarías una API paginada?**
    **Respuesta modelo:**

    * Leer parámetros de paginación (limit/offset o token).
    * Implementar bucle hasta agotar páginas, guardando `nextPageToken`.
    * Manejar **errores transitorios** y reintentos.
    * Registrar métricas de avance y latencia.

    **Palabras clave:**
    `limit/offset`, `cursor pagination`, `nextPageToken`, `retry logic`, `logging`.

---

## 🧠 Preguntas Escalables

19. **¿Qué pasos seguirías para crear una tabla que almacene actividad de usuarios en una aplicación web?**
    **Respuesta modelo:**

    * Definir el **grain** (una fila por evento click, login, etc.).
    * Elegir **columnas claves**: UserID, Timestamp, EventType, Metadata JSON.
    * Crear índices en UserID y Timestamp.
    * Planificar **retención** o particionado por fecha.
    * Documentar esquema y ejemplos de consulta.

    **Palabras clave:**
    `grain`, `event schema`, `index on timestamp`, `table partitioning`, `TTL/retención`.

20. **Imagina un CSV mal estructurado y con datos inconsistentes. ¿Cómo lo procesarías?**
    **Respuesta modelo:**

    * Pre‑validar con scripts (Python/Pandas) para detectar columnas faltantes, tipos erróneos.
    * Limpiar datos: normalizar fechas, eliminar saltos de línea, unificar codificaciones.
    * Volcar a tabla staging con todos campos como VARCHAR para posterior transformación.
    * Aplicar reglas de negocio y cargar en tabla final validada.

    **Palabras clave:**
    `data profiling`, `Pandas read_csv`, `staging VARCHAR`, `data cleansing`, `error handling`.

21. **¿Cómo diseñarías una consulta que calcule el promedio de ventas mensuales por producto y asegurarías que sea rápida?**
    **Respuesta modelo:**

    ```sql
    SELECT
      ProductID,
      YEAR(SaleDate) AS Año,
      MONTH(SaleDate) AS Mes,
      AVG(Amount) AS PromedioVentas
    FROM SalesFact
    GROUP BY ProductID, YEAR(SaleDate), MONTH(SaleDate);
    ```

    * Indexar **SaleDate** y **ProductID**, o usar un **columnstore index**.
    * Particionar por rango de fecha.

    **Palabras clave:**
    `GROUP BY YEAR/MONTH`, `columnstore index`, `partitioning`, `index on (ProductID, SaleDate)`.

22. **Si un pipeline de carga empieza a fallar intermitentemente, ¿por dónde empezarías a investigar?**
    **Respuesta modelo:**

    1. Revisar **logs de error** y stack traces.
    2. Comprobar **recursos del servidor** (CPU, memoria, disco).
    3. Verificar **conectividad** a orígenes (timeouts, rate limits).
    4. Reproducir localmente con datos de muestra.
    5. Analizar si hay **datos corruptos** o formatos inesperados.

    **Palabras clave:**
    `error logs`, `resource monitoring`, `connectivity tests`, `data sampling`, `retry/backoff`.

---

Estas preguntas y respuestas te permitirán evaluar desde los conceptos básicos hasta escenarios reales de diseño, performance, testing y colaboración en SQL y data engineering. ¡Éxitos en tus entrevistas!
