WITH cohort_inicial AS (
    SELECT 
        id AS cliente_id,
        DATE_TRUNC('month', data_cadastro)::DATE AS mes_cohort
    FROM clientes
),
compras_mensais AS (
    SELECT DISTINCT
        p.cliente_id,
        DATE_TRUNC('month', p.data_pedido)::DATE AS mes_compra
    FROM pedidos p
    WHERE p.status = 'Entregue'
),

atividade_cohort AS (
    SELECT 
        c.mes_cohort,
        c.cliente_id,
        (
            EXTRACT(YEAR FROM cm.mes_compra) * 12 + EXTRACT(MONTH FROM cm.mes_compra)
        ) - (
            EXTRACT(YEAR FROM c.mes_cohort) * 12 + EXTRACT(MONTH FROM c.mes_cohort)
        ) AS mes_index
    FROM cohort_inicial c
    LEFT JOIN compras_mensais cm 
        ON c.cliente_id = cm.cliente_id
),
tamanho_cohort AS (
    SELECT 
        mes_cohort,
        COUNT(DISTINCT cliente_id) AS total_clientes
    FROM cohort_inicial
    GROUP BY mes_cohort
)

SELECT 
    t.mes_cohort,
    t.total_clientes AS tamanho_cohort,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN a.mes_index = 0 THEN a.cliente_id END) / t.total_clientes, 
        2
    ) AS retencao_m0_pct,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN a.mes_index = 1 THEN a.cliente_id END) / t.total_clientes, 
        2
    ) AS retencao_m1_pct,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN a.mes_index = 2 THEN a.cliente_id END) / t.total_clientes, 
        2
    ) AS retencao_m2_pct,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN a.mes_index = 3 THEN a.cliente_id END) / t.total_clientes, 
        2
    ) AS retencao_m3_pct
FROM tamanho_cohort t
JOIN atividade_cohort a 
    ON t.mes_cohort = a.mes_cohort
GROUP BY 
    t.mes_cohort, 
    t.total_clientes
ORDER BY 
    t.mes_cohort ASC;
