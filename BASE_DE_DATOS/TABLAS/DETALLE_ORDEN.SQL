CREATE TABLE detalle_orden (
    id_detalle_orden SERIAL PRIMARY KEY,
    id_orden_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_solicitada INT NOT NULL,
    cantidad_recibida INT,
    precio_costo_pactado DECIMAL(12,2),
    observacion_item VARCHAR(255),
    FOREIGN KEY (id_orden_compra) REFERENCES orden_compra (id_orden_compra) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);
