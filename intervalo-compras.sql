WITH pedidos_ordenados AS (
    SELECT 
        cliente_id,
        data_pedido,
        ROW_NUMBER() OVER (
            PARTITION BY cliente_id 
            ORDER BY data_pedido ASC
        ) AS ordem_compra,
        LEAD(data_pedido) OVER (
            PARTITION BY cliente_id 
            ORDER BY data_pedido ASC
        ) AS proxima_data_pedido
    FROM pedidos
    WHERE status = 'Entregue'
),

primeira_e_segunda_compra AS (
    SELECT 
        cliente_id,
        data_pedido AS primeira_compra,
        proxima_data_pedido AS segunda_compra,
        (proxima_data_pedido - data_pedido) AS dias_entre_compras
    FROM pedidos_ordenados
    WHERE ordem_compra = 1 
      AND proxima_data_pedido IS NOT NULL
)

SELECT 
    COUNT(DISTINCT cliente_id) AS total_clientes_com_recompra,
    ROUND(AVG(dias_entre_compras), 2) AS media_dias_primeira_para_segunda_compra,
    MIN(dias_entre_compras) AS menor_intervalo_dias,
    MAX(dias_entre_compras) AS maior_intervalo_dias
FROM primeira_e_segunda_compra;
