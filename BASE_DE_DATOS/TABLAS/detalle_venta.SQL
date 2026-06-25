CREATE TABLE detalle_venta (
    id_detalle_venta SERIAL PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario_aplicado DECIMAL(12,2),
    iva_aplicado DECIMAL(5,2),
    subtotal_item DECIMAL(12,2),
    FOREIGN KEY (id_venta) REFERENCES venta (id_venta) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);
