#!/usr/bin/env python
# coding: utf-8

# In[ ]:


pip install pyodbc snowflake-connector-python pandas


# CONECTANDO AO AQL SERVER

# In[4]:


import pyodbc
import pandas as pd

# Conexão com o SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=LAPTOP-NV4PR600;'
                      'DATABASE=MY_DB;'
                      'Trusted_Connection=yes')


query = "SELECT * FROM RETAIL_SALES"

df_sales = pd.read_sql(query, conn)

conn.close()


# In[7]:


display(df_sales)


# CONECTANDO AO SNOWFLAKE

# In[16]:


import snowflake.connector

# Conexão com o Snowflake
sf_conn = snowflake.connector.connect(
    user='EngDataRafa',
    password='Engdatarafapy10',
    account='pwpmdlb-qo19745',
    warehouse='MY_WAREHOUSE',
    database='MY_DB',
    schema='MY_SCHEMA'
)


cur = sf_conn.cursor() 

cur.execute("SELECT CURRENT_VERSION()")

result = cur.fetchone()
print(result)


cur.close()
sf_conn.close()  


# CRIANDO A TABELA NO SNOWFLAKE

# In[36]:


import snowflake.connector

# Conexão com o Snowflake
sf_conn = snowflake.connector.connect(
    user='EngDataRafa',
    password='Engdatarafapy10',
    account='pwpmdlb-qo19745',
    warehouse='MY_WAREHOUSE',
    database='MY_DB',
    schema='MY_SCHEMA'
)

cur = sf_conn.cursor()

# Criando a tabela
cur.execute("""
    CREATE OR REPLACE TABLE RETAIL_SALES (
        Transaction_ID INT PRIMARY KEY,          
        Date DATE NOT NULL,                  
        Customer_ID VARCHAR(50),                           
        Gender VARCHAR(10),                       
        Age INT,                                  
        Product_Category VARCHAR(100) NOT NULL,   
        Quantity INT NOT NULL,                    
        Price_per_Unit DECIMAL(10,2) NOT NULL,    
        Total_Amount DECIMAL(10,2) NOT NULL       
    )
""")


cur.close()
print("Tabela criada com sucesso")

sf_conn.close()


# CARREGANDO OS DADOS NA TABELA NO SNOWFLAKE

# In[38]:


import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
import pandas as pd

sf_conn = snowflake.connector.connect(
    user='EngDataRafa',
    password='Engdatarafapy10',
    account='pwpmdlb-qo19745',
    warehouse='MY_WAREHOUSE',
    database='MY_DB',
    schema='MY_SCHEMA'
)
# Abaixo faço alguns tratamentos de conversão de data, extrair a data sem a hora e padronização de nomes das colunas.

df_sales['DATE'] = pd.to_datetime(df_sales['DATE'], unit='ms')

df_sales['DATE'] = df_sales['DATE'].dt.date

df_sales.columns = [col.upper() for col in df_sales.columns]

try:
    success, num_chunks, num_rows, error_msg = write_pandas(
        sf_conn,
        df_sales,  
        'RETAIL_SALES' 
    )

    if success:
        print(f"Dados carregados com sucesso! {num_rows} linhas carregadas.")
    else:
        print(f"Erro ao carregar dados: {error_msg}")

except Exception as e:
    print(f"Erro ao carregar dados: {e}")


# In[ ]:




