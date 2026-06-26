CREATE TABLE ajuste_inventario (
    id_ajuste SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivo VARCHAR(50),
    cantidad_anterior INT,
    cantidad_nueva INT,
    observaciones TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);
