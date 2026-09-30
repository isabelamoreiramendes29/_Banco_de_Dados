# Banco de Dados

Exercícios da disciplina de Banco de Dados — MySQL.

## Conteúdo

| Pasta | Assunto |
|---|---|
| `exercicio01/` | Criação do banco `agencia_db` e da tabela `agente`, com `ALTER TABLE` para adicionar, modificar e remover colunas |
| `exercicio02/` | O Caso do Papiro Desaparecido — comandos básicos sobre a tabela `membros_expedicao`: `CREATE TABLE`, `INSERT`, `UPDATE`, `DELETE` e consultas com `WHERE`, `LIKE`, `IN`, `BETWEEN`, `COUNT`, `SUM` e `GROUP BY` |
| `eav1/` | Diagramas Entidade-Relacionamento da avaliação 1, feitos no draw.io |
| `exercicio03/` | RunTracker — modelagem no MySQL Workbench de uma plataforma de corridas de rua: provas, arenas, atletas, inscrições, kits e ficha médica, com relacionamentos 1:1, 1:N e N:M. Contém o modelo `.mwb` e um script `.sql` de referência |
| `exercicio04/` | Grande Prêmio de Interlagos — duas tabelas relacionadas por `FOREIGN KEY`, com `CHECK`, `ENUM`, `UPDATE`, `DELETE` e consultas com `IN`, `LIKE`, `COUNT`, `AVG`, `GROUP BY`, `ORDER BY` e `LIMIT` |
| `exercicio05/` | Locadora de filmes — Modelo Relacional feito no MySQL Workbench a partir de um DER: atributo composto (`NomeCli`), atributo multivalorado (`Telefone`), relacionamentos 1:N e N:M e participação total nas chaves estrangeiras |

Cada pasta tem o script `.sql` e, quando existir, o modelo `.mwb` do MySQL Workbench.

### Diagramas da `eav1/`

| Arquivo | Modelo |
|---|---|
| `EAV1_IsabelaMoreria.drawio` | Clínica — `Paciente`, `Consulta` e `Médico`, com os relacionamentos `Realiza`, `Possui` e `Participa` |
| `EAV1_Q2_IsabelaMoreira.drawio` | Empresa — `Departamentos`, `Empregado`, `Projetos` e `Dependente`, com `Gerencia`, `Controla` e `Supervisiona` |

Para abrir, entre em [app.diagrams.net](https://app.diagrams.net) e use **File > Open From > Device**.

## Como executar

Pelo terminal do MySQL:

```bash
mysql -u root -p < exercicio01/EXERCICIO_01.sql
```

Ou pelo MySQL Workbench: abra o arquivo `.sql` e clique no raio (Execute).

Para abrir o diagrama, use **File > Open Model** no Workbench e escolha o arquivo `.mwb`.
