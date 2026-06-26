CREATE TABLE inventario_stock (
    id_producto INT PRIMARY KEY,
    cantidad_disponible INT DEFAULT 0,
    fecha_ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE
);
