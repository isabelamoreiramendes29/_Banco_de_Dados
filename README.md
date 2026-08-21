# Banco de Dados

Exercícios da disciplina de Banco de Dados — MySQL.

## Conteúdo

| Pasta | Assunto |
|---|---|
| `exercicio01/` | Criação do banco `agencia_db` e da tabela `agente`, com `ALTER TABLE` para adicionar, modificar e remover colunas |
| `exercicio02/` | O Caso do Papiro Desaparecido — comandos básicos sobre a tabela `membros_expedicao`: `CREATE TABLE`, `INSERT`, `UPDATE`, `DELETE` e consultas com `WHERE`, `LIKE`, `IN`, `BETWEEN`, `COUNT`, `SUM` e `GROUP BY` |

Cada pasta tem o script `.sql` e, quando existir, o modelo `.mwb` do MySQL Workbench.

## Como executar

Pelo terminal do MySQL:

```bash
mysql -u root -p < exercicio01/EXERCICIO_01.sql
```

Ou pelo MySQL Workbench: abra o arquivo `.sql` e clique no raio (Execute).

Para abrir o diagrama, use **File > Open Model** no Workbench e escolha o arquivo `.mwb`.
