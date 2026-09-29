CREATE TABLE clientes (
    id INT PRIMARY KEY,
    data_cadastro DATE NOT NULL,
    estado VARCHAR(2) NOT NULL
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL
);

INSERT INTO clientes (id, data_cadastro, estado) VALUES
(1, '2024-01-05', 'SP'),
(2, '2024-01-12', 'RJ'),
(3, '2024-01-20', 'MG'),
(4, '2024-02-01', 'SP'),
(5, '2024-02-10', 'PR'),
(6, '2024-02-15', 'SC'),
(7, '2024-03-02', 'SP'),
(8, '2024-03-10', 'RJ');

INSERT INTO pedidos (id, cliente_id, data_pedido, valor_total, status) VALUES
(101, 1, '2024-01-05', 150.00, 'Entregue'),
(102, 1, '2024-02-10', 200.00, 'Entregue'),
(103, 1, '2024-03-15', 120.00, 'Entregue'),
  
(104, 2, '2024-01-12', 80.00,  'Entregue'),
(105, 2, '2024-03-20', 300.00, 'Entregue'),
  
(106, 3, '2024-01-20', 50.00,  'Entregue'),
(107, 4, '2024-02-01', 210.00, 'Entregue'),
  
(108, 4, '2024-03-05', 95.00,  'Entregue'),
(109, 4, '2024-04-10', 180.00, 'Entregue'),
  
(110, 5, '2024-02-10', 500.00, 'Entregue'),
(111, 5, '2024-02-25', 150.00, 'Entregue'),

(112, 6, '2024-02-15', 310.00, 'Entregue'),
(113, 6, '2024-04-18', 220.00, 'Entregue'),

(114, 7, '2024-03-02', 130.00, 'Entregue'),
(115, 7, '2024-04-05', 170.00, 'Entregue'),

(116, 8, '2024-03-10', 90.00,  'Entregue');
