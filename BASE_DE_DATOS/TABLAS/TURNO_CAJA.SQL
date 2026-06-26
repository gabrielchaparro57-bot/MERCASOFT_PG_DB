CREATE TABLE turno_caja (
    id_turno SERIAL PRIMARY KEY,
    id_usuario_cajero INT NOT NULL,
    fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_cierre TIMESTAMP,
    monto_apertura_efectivo DECIMAL(12,2) DEFAULT 0.00,
    monto_cierre_efectivo_esperado DECIMAL(12,2),
    monto_cierre_efectivo_real DECIMAL(12,2),
    descuadre_monto DECIMAL(12,2),
    estado_caja VARCHAR(20),
    FOREIGN KEY (id_usuario_cajero) REFERENCES usuario (id_usuario)
);
