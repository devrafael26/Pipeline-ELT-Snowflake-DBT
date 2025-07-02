![Pipeline Snowflake](https://github.com/devrafael26/Pipeline-ELT-Snowflake-DBT/blob/main/ELT%20Snowflake.png?raw=true)

## 🔧 Como construí esse pipeline?
Comecei com um notebook Python local, onde me conectei ao SQL Server para extrair os dados brutos. A partir daí, estabeleci uma conexão com o Snowflake e criei a tabela de Vendas, onde os dados extraídos foram carregados.
Com os dados já no Snowflake, usei o DBT (Data Build Tool) para aplicar as regras de negócio e transformar os dados. Os modelos do DBT geraram views otimizadas e padronizadas, preparando as informações para análise.
Na etapa final, os dados transformados foram consumidos no Power BI, onde construí dashboard para visualização dos dados.
________________________________________
