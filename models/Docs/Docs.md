{% docs descripcion_pedidos %}
El modelo original (TPC-H) esta sustentado sobre 8 tablas relacionadas entre si a traves de PK y FK 
A continuacon las tablas ordenadas por cardibnalidad. La caridinalidad de LINEITEM es aproximada
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
 de pasar al modelo y a los marts)

 El esquema inicial es esquema snowflake, puede que para facilitar las consultas y mejorar eficiencia tengamos que migrar a un esquema estrella

{% enddocs %}