CREATE TABLE abono_credito (
    id_abono SERIAL PRIMARY KEY,
    id_cxc INT NOT NULL,
    id_usuario_receptor INT NOT NULL,
    id_turno INT NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto_abonado DECIMAL(12,2) NOT NULL,
    metodo_pago_abono VARCHAR(20),
    FOREIGN KEY (id_cxc) REFERENCES cuenta_por_cobrar (id_cxc),
    FOREIGN KEY (id_usuario_receptor) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_turno) REFERENCES turno_caja (id_turno)
);
