-- -------------------------------------------------
-- DESCRIPCIÓN DE LAS TABLAS Y SUS CAMPOS
-- -------------------------------------------------

-- Tabla usuario
-- Contiene los datos personales de los clientes.
-- IMPORTANTE: Los campos 'nombre_apellidos', 'direccion', 'codigo_postal', 'localidad', 'email' y 'nif_cif' serán cifrados antes de almacenarse en la base de datos para cumplir con la protección de datos (LOPD/GDPR).

-- Tabla paises
-- Lista de países disponibles para asignar a los clientes.

-- Tabla bicicletas
-- Catálogo de modelos de bicicletas, sus precios y disponibilidad.

-- Tabla tipos
-- Define el tipo de usuario: niño, joven, adulto, senior.

-- Tabla categorias
-- Clasifica las bicicletas por su uso: paseo, montaña, tándem.

-- Tabla tipo_pagos
-- Lista de formas de pago aceptadas.

-- Tabla facturas
-- Registra cada alquiler y su facturación asociada.

-- Tabla administracion
-- Usuarios administradores para acceso al panel de gestión.

-- Tabla tipo_alojamiento
-- Define los tipos de alojamiento posibles (hotel, camping, apartahotel).

-- Tabla alojamientos
-- Lista de hoteles, apartahoteles y campings de Blanes para entrega o recogida de bicicletas.

-- -------------------------------------------------
-- SCRIPT DE CREACIÓN DE TABLAS PARA MARIADB
-- -------------------------------------------------

CREATE TABLE paises (
    id_pais INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_pais)
);

CREATE TABLE tipos (
    id_tipo INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_tipo)
);

CREATE TABLE categorias (
    id_categoria INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_categoria)
);

CREATE TABLE tipo_pagos (
    id_pago INT NOT NULL AUTO_INCREMENT,
    tipo_pago VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_pago)
);

CREATE TABLE tipo_alojamiento (
    id_tipo_alojamiento INT NOT NULL AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_tipo_alojamiento)
);

CREATE TABLE usuario (
    id INT NOT NULL AUTO_INCREMENT,
    nombre_apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    codigo_postal VARCHAR(10),
    localidad VARCHAR(100),
    id_pais INT,
    email VARCHAR(100) UNIQUE,
    nif_cif VARCHAR(20) UNIQUE,
    PRIMARY KEY (id),
    CONSTRAINT fk_usuario_pais FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

CREATE TABLE bicicletas (
    id_bicicleta INT NOT NULL AUTO_INCREMENT,
    modelo VARCHAR(100) NOT NULL,
    imagen VARCHAR(255),
    id_tipo INT,
    id_categoria INT,
    precio_hora DECIMAL(10,2) NOT NULL,
    precio_dia DECIMAL(10,2) NOT NULL,
    cantidad_disponible INT NOT NULL,
    PRIMARY KEY (id_bicicleta),
    CONSTRAINT fk_bicicleta_tipo FOREIGN KEY (id_tipo) REFERENCES tipos(id_tipo),
    CONSTRAINT fk_bicicleta_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE alojamientos (
    id_alojamiento INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    id_tipo_alojamiento INT NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    codigo_postal VARCHAR(10) DEFAULT '17300',
    localidad VARCHAR(100) DEFAULT 'Blanes',
    provincia VARCHAR(100) DEFAULT 'Girona',
    pais VARCHAR(100) DEFAULT 'España',
    PRIMARY KEY (id_alojamiento),
    CONSTRAINT fk_alojamiento_tipo FOREIGN KEY (id_tipo_alojamiento) REFERENCES tipo_alojamiento(id_tipo_alojamiento)
);

CREATE TABLE administracion (
    id_admin INT NOT NULL AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_admin)
);

CREATE TABLE facturas (
    id INT NOT NULL AUTO_INCREMENT,
    numero_factura VARCHAR(20) NOT NULL UNIQUE,
    fecha DATE NOT NULL,
    id_usuario INT NOT NULL,
    id_bicicleta INT NOT NULL,
    fecha_entrega DATE NOT NULL,
    fecha_recogida DATE NOT NULL,
    numero_horas INT,
    cargo_transporte DECIMAL(10,2) DEFAULT 0.00,
    iva_cuota DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    forma_pago INT NOT NULL,
    factura_impresa VARCHAR(255),
    id_alojamiento INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_factura_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    CONSTRAINT fk_factura_bicicleta FOREIGN KEY (id_bicicleta) REFERENCES bicicletas(id_bicicleta),
    CONSTRAINT fk_factura_pago FOREIGN KEY (forma_pago) REFERENCES tipo_pagos(id_pago),
    CONSTRAINT fk_factura_alojamiento FOREIGN KEY (id_alojamiento) REFERENCES alojamientos(id_alojamiento)
);

-- -------------------------------------------------
-- INSERCIONES INICIALES DE DATOS
-- -------------------------------------------------

INSERT INTO categorias (categoria) VALUES
('Paseo'),
('Montaña'),
('Tándem');

INSERT INTO tipos (tipo) VALUES
('Niño'),
('Joven'),
('Adulto'),
('Senior');

INSERT INTO tipo_pagos (tipo_pago) VALUES
('Metálico'),
('Tarjeta de crédito'),
('Bizum');

INSERT INTO tipo_alojamiento (descripcion) VALUES
('Hotel'),
('Camping'),
('Apartahotel');

INSERT INTO administracion (nombre_usuario, email, password_hash)
VALUES ('admin', 'gestion@bikeneke.com', '$2y$10$G5TGuHOKfyAYLXMXLgIviOHLssFrG1DX/zMbO8Bp84BSHTf5pT46e');

INSERT INTO alojamientos (nombre, id_tipo_alojamiento, direccion) VALUES
('Hotel Beverly Park & Spa', 1, 'Merce Rodoreda, 7'),
('Hotel Horitzo by Pierre & Vacances', 1, 'Paseo Marítimo S´Abanell 11'),
('Hotel Blaucel', 1, 'Avenida Villa de Madrid, 27'),
('Hotel Costa Brava', 1, 'Anselm Clavé, 48'),
('Hotel Stella Maris', 1, 'Avenida Vila de Madrid, 18'),
('Hotel Pimar & Spa', 1, "Paseo S'Abanell 8"),
('Hostal Miranda', 1, 'Josep Tarradellas, 50'),
('Hotel Boix Mar', 1, 'Enric Morera, 5'),
('Petit Palau - Adults Only', 1, 'Lluis Companys, 19'),
('Hotel Esplendid', 1, 'Avenida Mediterrani, 17'),
('Camping Bella Terra', 2, 'Avinguda Vila de Madrid, s/n'),
('Camping Blanes', 2, 'Carrer Cristòfor Colom, 48'),
('Camping La Masia', 2, 'Carrer Colom, 44'),
('Apartaments AR Blavamar - San Marcos', 3, 'Carrer Josep Tarradellas, 2'),
('Apartamentos Europa Sun', 3, 'Av. Mediterrani, 6');

-- Insertar paises
INSERT INTO paises (pais) VALUES
('Afganistán'), ('Albania'), ('Alemania'), ('Andorra'), ('Angola'),
('Antigua y Barbuda'), ('Arabia Saudita'), ('Argelia'), ('Argentina'), ('Armenia'),
('Australia'), ('Austria'), ('Azerbaiyán'), ('Bahamas'), ('Bangladesh'),
('Barbados'), ('Baréin'), ('Bélgica'), ('Belice'), ('Benín'),
('Bielorrusia'), ('Birmania'), ('Bolivia'), ('Bosnia y Herzegovina'), ('Botsuana'),
('Brasil'), ('Brunéi'), ('Bulgaria'), ('Burkina Faso'), ('Burundi'),
('Bután'), ('Cabo Verde'), ('Camboya'), ('Camerún'), ('Canadá'),
('Catar'), ('Chad'), ('Chile'), ('China'), ('Chipre'),
('Colombia'), ('Comoras'), ('Corea del Norte'), ('Corea del Sur'), ('Costa de Marfil'),
('Costa Rica'), ('Croacia'), ('Cuba'), ('Dinamarca'), ('Dominica'),
('Ecuador'), ('Egipto'), ('El Salvador'), ('Emiratos Árabes Unidos'), ('Eritrea'),
('Eslovaquia'), ('Eslovenia'), ('España'), ('Estados Unidos'), ('Estonia'),
('Etiopía'), ('Filipinas'), ('Finlandia'), ('Fiyi'), ('Francia'),
('Gabón'), ('Gambia'), ('Georgia'), ('Ghana'), ('Granada'),
('Grecia'), ('Guatemala'), ('Guyana'), ('Guinea'), ('Guinea-Bisáu'),
('Guinea Ecuatorial'), ('Haití'), ('Honduras'), ('Hungría'), ('India'),
('Indonesia'), ('Irak'), ('Irán'), ('Irlanda'), ('Islandia'),
('Islas Marshall'), ('Islas Salomón'), ('Israel'), ('Italia'), ('Jamaica'),
('Japón'), ('Jordania'), ('Kazajistán'), ('Kenia'), ('Kirguistán'),
('Kiribati'), ('Kuwait'), ('Laos'), ('Lesoto'), ('Letonia'),
('Líbano'), ('Liberia'), ('Libia'), ('Liechtenstein'), ('Lituania'),
('Luxemburgo'), ('Madagascar'), ('Malasia'), ('Malaui'), ('Maldivas'),
('Malí'), ('Malta'), ('Marruecos'), ('Mauricio'), ('Mauritania'),
('México'), ('Micronesia'), ('Moldavia'), ('Mónaco'), ('Mongolia'),
('Montenegro'), ('Mozambique'), ('Namibia'), ('Nauru'), ('Nepal'),
('Nicaragua'), ('Níger'), ('Nigeria'), ('Noruega'), ('Nueva Zelanda'),
('Omán'), ('Países Bajos'), ('Pakistán'), ('Palaos'), ('Panamá'),
('Papúa Nueva Guinea'), ('Paraguay'), ('Perú'), ('Polonia'), ('Portugal'),
('Reino Unido'), ('República Centroafricana'), ('República Checa'), ('República Democrática del Congo'),
('República Dominicana'), ('Ruanda'), ('Rumanía'), ('Rusia'), ('Samoa'),
('San Cristóbal y Nieves'), ('San Marino'), ('San Vicente y las Granadinas'),
('Santa Lucía'), ('Santo Tomé y Príncipe'), ('Senegal'), ('Serbia'), ('Seychelles'),
('Sierra Leona'), ('Singapur'), ('Siria'), ('Somalia'), ('Sri Lanka'),
('Suazilandia'), ('Sudáfrica'), ('Sudán'), ('Sudán del Sur'), ('Suecia'),
('Suiza'), ('Surinam'), ('Tailandia'), ('Tanzania'), ('Tayikistán'),
('Timor Oriental'), ('Togo'), ('Tonga'), ('Trinidad y Tobago'), ('Túnez'),
('Turkmenistán'), ('Turquía'), ('Tuvalu'), ('Ucrania'), ('Uganda'),
('Uruguay'), ('Uzbekistán'), ('Vanuatu'), ('Vaticano'), ('Venezuela'),
('Vietnam'), ('Yemen'), ('Yibuti'), ('Zambia'), ('Zimbabue');
