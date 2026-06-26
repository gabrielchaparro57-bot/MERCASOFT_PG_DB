CREATE TABLE log_auditoria (
    id_log BIGSERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    operacion_tipo VARCHAR(50),

    tabla_afectada VARCHAR(50),
    registro_id INT,
    valor_anterior TEXT,
    valor_nuevo TEXT,
    direccion_ip VARCHAR(45),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);
