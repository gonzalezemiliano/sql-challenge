# Challenge Tecnico de SQL

**Objetivos:** 

* Realizar consultas en SQL, interactuando con una base de datos alojada en un servidor de base de datos PostgreSQL. 

En este challenge vamos a partir de una base de datos de películas con datos [obtenidos del sitio IMDB]()

**Entrega:** Realizar todas las actividades que se describen en este notebook. Si es necesario, se pueden agregar más celdas tanto de tipo markdown como código. Entregar el notebook modificado que refleje el trabajo realizado por el grupo, incluyendo respuestas, explicaciones y el código generado.

## Esquema y carga de datos

Antes de poder realizar consultas vamos a crear el esquema relacional y cargar datos.
Esto lo realizaremos sobre una instancia local de PostgreSQL. 

## Creación de la base de datos y carga en un servidor local

Utilizaremos el comando `psql` para crear el esquema y cargar los datos.

Primero ejecutamos el script de creación de la base.

ATENCION: ejecutar las instrucciones a continuación en una línea de comandos por fuera del notebook para habilitar el modo interactivo y poder ingresar la constraseña.

1- crear el esquema

`psql -U postgres -f movies_schema.sql`

2- cargar los datos

`psql -U postgres -f movies_data.sql movies`

3- crear restricciones

`psql -U postgres -f movies_constraints.sql movies`
