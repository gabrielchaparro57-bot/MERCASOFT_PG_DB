CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    documento_identidad VARCHAR(20),
    nombre_completo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    cupo_credito_maximo DECIMAL(12,2) DEFAULT 0.00,
    saldo_deuda_actual DECIMAL(12,2) DEFAULT 0.00
);
