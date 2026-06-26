CREATE TABLE orden_compra (
    id_orden_compra SERIAL PRIMARY KEY,
    numero_orden_unico VARCHAR(50) NOT NULL UNIQUE,
    id_proveedor INT NOT NULL,
    id_usuario_creador INT NOT NULL,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_recepcion TIMESTAMP,
    estado VARCHAR(30),
    total_compra DECIMAL(12,2),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor),
    FOREIGN KEY (id_usuario_creador) REFERENCES usuario (id_usuario)
);
