-- ==============================================================================
-- 0. Creación de la base de datos
-- ==============================================================================
CREATE DATABASE mercasoft;
-- ==============================================================================
-- 1. Creación del Contenedor Lógico (Esquema del Tenant)
-- ==============================================================================
CREATE SCHEMA tenant_tienda_alfa;

-- Apuntamos el entorno de ejecución a nuestro nuevo esquema.
-- Todo lo que se cree a partir de aquí caerá dentro de 'tenant_tienda_alfa'.
SET search_path TO tenant_tienda_alfa;

-- ==============================================================================
-- 2. Tablas de Configuración y Roles
-- ==============================================================================

CREATE TABLE rol (
    id_rol SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

-- ==============================================================================
-- 3. Entidades Principales
-- ==============================================================================

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    id_rol INT NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    intentos_fallidos INT DEFAULT 0,
    bloqueado_hasta TIMESTAMP,
    estado BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_rol) REFERENCES rol (id_rol)
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    documento_identidad VARCHAR(20),
    nombre_completo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    cupo_credito_maximo DECIMAL(12,2) DEFAULT 0.00,
    saldo_deuda_actual DECIMAL(12,2) DEFAULT 0.00
);

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

-- ==============================================================================
-- 4. Catálogo e Inventario
-- ==============================================================================

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

CREATE TABLE inventario_stock (
    id_producto INT PRIMARY KEY,
    cantidad_disponible INT DEFAULT 0,
    fecha_ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE
);

-- ==============================================================================
-- 5. Operaciones de Caja y Logística
-- ==============================================================================

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

-- ==============================================================================
-- 6. Ventas y Cartera Financiera
-- ==============================================================================

CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    numero_factura VARCHAR(50) NOT NULL UNIQUE,
    id_usuario_vendedor INT NOT NULL,
    id_cliente INT, 
    id_turno INT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_pago VARCHAR(50),
    subtotal DECIMAL(12,2) DEFAULT 0.00,
    impuesto_total DECIMAL(12,2) DEFAULT 0.00,
    total_neto DECIMAL(12,2) DEFAULT 0.00,
    FOREIGN KEY (id_usuario_vendedor) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_turno) REFERENCES turno_caja (id_turno)
);

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

CREATE TABLE cuenta_por_cobrar (
    id_cxc SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_venta INT NOT NULL,
    fecha_otorgamiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto_inicial_deuda DECIMAL(12,2) NOT NULL,
    saldo_pendiente DECIMAL(12,2) NOT NULL,
    estado_cuenta VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_venta) REFERENCES venta (id_venta)
);

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

-- ==============================================================================
-- 7. Auditoría Local del Tenant
-- ==============================================================================

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