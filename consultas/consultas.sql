--consulta 1, Listagem completa de vendas
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
SELECT
    date_trunc('month', data_venda) AS mes,
    SUM(valor_total_venda) AS total_vendido
FROM venda
GROUP BY mes
ORDER BY mes;

--consulta 3, Total de Despesas por Categoria
SELECT
    categoria,
    SUM(valor_despesa) AS total_despesa
FROM despesa
WHERE data_despesa BETWEEN DATE '2025-01-01' AND DATE '2025-12-31'
GROUP BY categoria
ORDER BY total_despesa DESC;

--consulta 4, Lucro Líquido Mensal (Vendas – Despesas)
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
SELECT
    data_venda,
    COUNT(*) AS numero_vendas
FROM venda
GROUP BY data_venda
ORDER BY data_venda;




