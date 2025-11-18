--consulta 1, Listagem completa de vendas
-- Lista todas as vendas realizadas no sistema
-- JOIN com cliente para mostrar o nome do cliente
-- JOIN com usuario para mostrar quem registrou a venda
-- Ordena da venda mais recente para a mais antiga
SELECT
    v.id_venda,
    v.data_venda,
    c.nome_cliente,
    u.nome_completo AS usuario_responsavel,
    v.valor_total_venda,
    v.forma_pagamento,
    v.status_pagamento
FROM venda v
JOIN cliente c   ON c.id_cliente = v.id_cliente
JOIN usuario u   ON u.id_usuario = v.id_usuario
ORDER BY v.data_venda DESC;

--consulta 2, Faturamento Bruto Mensal
-- Calcula o total vendido por mês
-- date_trunc('month') pega apenas mês/ano
-- SUM soma o valor total das vendas de cada mês
-- GROUP BY agrupa por mês
SELECT
    date_trunc('month', data_venda) AS mes,
    SUM(valor_total_venda) AS total_vendido
FROM venda
GROUP BY mes
ORDER BY mes;

--consulta 3, Total de Despesas por Categoria
-- Soma o valor das despesas agrupando por categoria
-- WHERE filtra o período 
-- GROUP BY separa as categorias 
-- ORDER BY mostra a categoria que mais gastou primeiro
SELECT
    categoria,
    SUM(valor_despesa) AS total_despesa
FROM despesa
WHERE data_despesa BETWEEN DATE '2025-01-01' AND DATE '2025-12-31'
GROUP BY categoria
ORDER BY total_despesa DESC;

--consulta 4, Lucro Líquido Mensal (Vendas – Despesas)
-- Subconsulta v, soma total das vendas por dia
-- Subconsulta d, soma total das despesas por dia
-- LEFT JOIN, liga vendas e despesas pela data
-- Cálculo, lucro líquido = total_vendas - total_despesas
SELECT
    v.data_venda,
    v.total_vendas,
    d.total_despesas,
    v.total_vendas - d.total_despesas AS lucro_liquido
FROM
    (
        SELECT 
            data_venda,
            SUM(valor_total_venda) AS total_vendas
        FROM venda
        GROUP BY data_venda
    ) AS v
LEFT JOIN
    (
        SELECT 
            data_despesa,
            SUM(valor_despesa) AS total_despesas
        FROM despesa
        GROUP BY data_despesa
    ) AS d
ON v.data_venda = d.data_despesa
ORDER BY v.data_venda;

--consulta 5, Número de Vendas em um Período
-- Conta quantas vendas foram feitas em cada dia
-- Agrupado por data e ordenado em ordem cronológica
SELECT
    data_venda,
    COUNT(*) AS numero_vendas
FROM venda
GROUP BY data_venda
ORDER BY data_venda;




