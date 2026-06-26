CREATE TABLE cuenta_por_cobrar (
    id_cxc SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_venta INT NOT NULL,
    fecha_otorgamiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto_inicial_deuda DECIMAL(12,2) NOT NULL,
    saldo_pendiente DECIMAL(12,2) NOT NULL,
    estado_cuenta VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_venta) REFERENCES venta (id_venta)
);

