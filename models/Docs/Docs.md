{% docs descripcion_pedidos %}
-------------------  VISTA PREVIA DE LOS DATOS  ---------------

El modelo original (TPC-H) esta sustentado sobre 8 tablas relacionadas entre si a traves de PK y FK 
A continuacon las tablas ordenadas por cardinalidad. La caridinalidad de LINEITEM es aproximada
Ver esquerma y explicación en https://docs.snowflake.com/en/user-guide/sample-data-tpch

- LINEITEM (6M RCD)
- ORDERS (1'5M RCD)
- PARTSUPP (800K RCD)
- PART (200K RCD)
- CUSTOMER (150K RCD)
- SUPPLIER (10K RCD)
- NATION (25 RCD)
- REGION (5 RCD)

RCD == Record

REGION (R_)
 └── PK: REGIONKEY
      │
      └──> NATION (N_)
           ├── PK: NATIONKEY
           ├── FK: REGIONKEY(1:N)────> (R_)
           │
           ├──> CUSTOMER (C_)
           │    ├── PK: CUSTKEY
           │    ├── FK: NATIONKEY(1:N)────> (N_)
           │    │
           │    └──> ORDERS (O_)
           │         ├── PK: ORDERKEY
           │         ├── FK: CUSTKEY(1:N)────> (C_)
           │         │
           │         └──> LINEITEM (L_)
           │              ├── PK: [ORDERKEY + LINENUMBER] (Compuesta)
           │              ├── FK: ORDERKEY ────> (O_)
           │              └── FK: [PARTKEY, SUPPKEY] ────┐
           │                                             │
           └──> SUPPLIER (S_)                            │ (Se unen en LINEITEM)
                ├── PK: SUPPKEY                          │
                ├── FK: NATIONKEY(1:N)────> (N_)         │
                │                                        │
                └──> PARTSUPP (PS_) ─────────────────────┘
                     ^
                     ├── PK: [PARTKEY + SUPPKEY] (Compuesta)
                     ├── FK: PARTKEY(1:N)────> (P_)
                     ├── FK: SUPPKEY(1:N)────> (S_)
                     │
                     └── PART (P_)
                          └── PK: PARTKEY

Todos estos datos se declaran primero en staging (_src_tpch.yml) (se tienen que filtrar y hacer controles de calidad antes
de pasar al modelo y a los marts). Se hacen test de calidad de los datos:

Tests de data primarios
Las PK se fuerzan a ser unicas y no nulas

El esquema inicial es esquema snowflake, puede que para facilitar las consultas y mejorar eficiencia tengamos que migrar a un esquema estrella.
Antes de migrar los datos a estrella, se debe entender bien que son cada data que se va a meter en la Fact_Orders.


--------------------------  ANALISIS PREVIO DE LOS DATOS  --------------------------

La fact orders va a ser una union de order y lineitem (lineitem son los distointos elementos de cada ordren):
De Orders: La logica basica se controla en los generic tests de _src_tpch.yml, basicamente que los datos cumplan las reglas que se 
especifican en estas definiciones

- Se elimina ship priority (al analizar los datos se ve que todos los datos de ship priority son 0, lo que lo hace redundante)
- Clerk es la id del empleado/sistema que procesa la orden
- Orderstatus: 3 valores O, F, P
- Orderpriority: 5 valores -> 1-Urgent --- 5-Low
- Comment: info proporcionada del comprador (al analizar hay información poco relevante o sin sentido)
- Orderdate: 1-1-1992 hasta 2-8-1998 en formato yyyy-mm-dd no hay outliers


De lineitme:
- Orderkey la une a la orden y por extension al comprador...
- Partkey la une al producto vendido
- No se puede prescindir de lineitem ya que es la clave compuesta para cada compra de item, se perderian los distintos descuentos y demás para cada orden
- Supkey: proveedor
- Quantity
- Tax
- Returnflag 3 valores: N R A 
- Linestatus: 2 valores: O F 
- Shipdate
- Commitdate
- Receipdate
- Shipinstruction: (4 VALORES: COLLECT COD, NONE, DELIVER IN PERSON, TAKE BACK RETURN)
- Shipmode: (TRUCK, AIR, RAIL, SHIP, MAIL, FOB, REG AIR)

Singular Tests: (Carpeta de tests)
- Tests de valores aceptados (que la cantidad de la compra > 0)
- Test de precios aceptados (que el precio sea > 0)
- Que la fecha de compra y la fecha d shipping sea coherente

MACROS
Hay multiples funciones que aparecen recurrentemente:
- Pricing (el precio final despues de añadirle promociones y taxes)
- not future (para ver que las fechas no superan la actual)
- is positive -> el cose es superior a cero 

Dentro de matrs se almacenan las dimensiones y la fact table

----------- MODELAJE -------------

-No se ha creado dimension geo, ya que priorizo la velocidad y los bajos joins antes que el almacenaje


{% enddocs %}