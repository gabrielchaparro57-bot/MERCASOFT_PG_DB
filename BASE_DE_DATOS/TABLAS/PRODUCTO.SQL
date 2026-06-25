CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    codigo_barras VARCHAR(50) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_proveedor_principal INT,
    stock_minimo INT DEFAULT 0,
    unidad_medida VARCHAR(20),
    ubicacion_tienda VARCHAR(50),
    precio_costo_actual DECIMAL(12,2) DEFAULT 0.00,
    precio_venta DECIMAL(12,2) DEFAULT 0.00,
    iva_porcentaje DECIMAL(5,2) DEFAULT 0.00,
    estado BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_proveedor_principal) REFERENCES proveedor (id_proveedor)
);
