CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    numero_factura VARCHAR(50) NOT NULL UNIQUE,
    id_usuario_vendedor INT NOT NULL,
    id_cliente INT, 
    id_turno INT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_pago VARCHAR(50),
    subtotal DECIMAL(12,2) DEFAULT 0.00,
    impuesto_total DECIMAL(12,2) DEFAULT 0.00,
    total_neto DECIMAL(12,2) DEFAULT 0.00,
    FOREIGN KEY (id_usuario_vendedor) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_turno) REFERENCES turno_caja (id_turno)
);
