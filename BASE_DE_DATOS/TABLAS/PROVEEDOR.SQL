CREATE TABLE proveedor (
    id_proveedor SERIAL PRIMARY KEY,
    tipo_identificacion VARCHAR(30),
    numero_documento VARCHAR(30),
    unidad_medida VARCHAR(30),
    razon_social VARCHAR(100) NOT NULL,
    contacto_nombre VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion VARCHAR(150)
);
