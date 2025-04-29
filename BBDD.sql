-- -------------------------------------------------
-- DESCRIPCIÓN DE LAS TABLAS Y SUS CAMPOS
-- -------------------------------------------------

-- Tabla usuario:
-- Contiene los datos personales de los clientes.
-- IMPORTANTE: Los campos 'nombre_apellidos', 'direccion', 'codigo_postal', 'localidad', 'email' y 'nif_cif' serán cifrados antes de almacenarse en la base de datos para cumplir con la protección de datos (LOPD/GDPR).

-- Tabla paises:
-- Lista de países disponibles para asignar a los clientes.

-- Tabla bicicletas:
-- Catálogo de modelos de bicicletas, sus precios y disponibilidad.

-- Tabla tipos:
-- Define el tipo de usuario: niño, joven, adulto, senior.

-- Tabla categorias:
-- Clasifica las bicicletas por su uso: paseo, montaña, tándem.

-- Tabla tipo_pagos:
-- Lista de formas de pago aceptadas.

-- Tabla facturas:
-- Registra cada alquiler y su facturación asociada.

-- Tabla gestión:
-- Contiene el usuario gestor de la base de datos.

-- Tabla alojamientos
-- Lista de hoteles, apartahoteles y campings de Blanes para entrega o recogida de bicicletas.

-- -------------------------------------------------
-- SCRIPT DE CREACIÓN DE TABLAS
-- -------------------------------------------------

CREATE TABLE paises (
    id_pais INT AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(100) NOT NULL
);

CREATE TABLE tipos (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL
);

CREATE TABLE tipo_pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    tipo_pago VARCHAR(50) NOT NULL
);

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    codigo_postal VARCHAR(10),
    localidad VARCHAR(100),
    id_pais INT,
    email VARCHAR(100) UNIQUE,
    nif_cif VARCHAR(20) UNIQUE,
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

CREATE TABLE bicicletas (
    id_bicicleta INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    imagen VARCHAR(255),
    id_tipo INT,
    id_categoria INT,
    precio_hora DECIMAL(10,2) NOT NULL,
    precio_dia DECIMAL(10,2) NOT NULL,
    cantidad_disponible INT NOT NULL,
    FOREIGN KEY (id_tipo) REFERENCES tipos(id_tipo),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE facturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
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
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_bicicleta) REFERENCES bicicletas(id_bicicleta),
    FOREIGN KEY (forma_pago) REFERENCES tipo_pagos(id_pago),
    FOREIGN KEY (id_alojamiento) REFERENCES alojamientos(id_alojamiento)
);

CREATE TABLE alojamientos (
    id_alojamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo_alojamiento ENUM('Hotel', 'Apartahotel', 'Camping') NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    codigo_postal VARCHAR(10) DEFAULT '17300',
    localidad VARCHAR(100) DEFAULT 'Blanes',
    provincia VARCHAR(100) DEFAULT 'Girona',
    pais VARCHAR(100) DEFAULT 'España'
);

CREATE TABLE gestion (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,  -- Nombre de usuario (login).
    email VARCHAR(100) NOT NULL UNIQUE,           -- email.
    pass_hash VARCHAR(255) NOT NULL,           -- Hash seguro de la contraseña.
);

-- -------------------------------------------------
-- INSERCIONES INICIALES DE DATOS
-- -------------------------------------------------

INSERT INTO administracion (nombre_usuario, email, pass_hash)
VALUES (
    'admin',
    'gestion@bikeneke.com',
    '$2y$10$G5TGuHOKfyAYLXMXLgIviOHLssFrG1DX/zMbO8Bp84BSHTf5pT46e'
);

-- Insertar categorias
INSERT INTO categorias (categoria) VALUES
('Paseo'),
('Montaña'),
('Tándem');

-- Insertar tipos
INSERT INTO tipos (tipo) VALUES
('Niño'),
('Joven'),
('Adulto'),
('Senior');

-- Insertar tipos de pago
INSERT INTO tipo_pagos (tipo_pago) VALUES
('Metálico'),
('Tarjeta de crédito'),
('Bizum');

-- Insertar alojamientos en Blanes
INSERT INTO alojamientos (nombre, tipo_alojamiento, direccion) VALUES
('Hotel Beverly Park & Spa', 'Hotel', 'Merce Rodoreda, 7'),
('Hotel Horitzo by Pierre & Vacances', 'Hotel', 'Paseo Marítimo S´Abanell 11'),
('Hotel Blaucel', 'Hotel', 'Avenida Villa de Madrid, 27'),
('Hotel Costa Brava', 'Hotel', 'Anselm Clavé, 48'),
('Hotel Stella Maris', 'Hotel', 'Avenida Vila de Madrid, 18'),
('Hotel Pimar & Spa', 'Hotel', 'Paseo S'Abanell 8'),
('Hostal Miranda', 'Hotel', 'Josep Tarradellas, 50'),
('Hotel Boix Mar', 'Hotel', 'Enric Morera, 5'),
('Petit Palau - Adults Only', 'Hotel', 'Lluis Companys, 19'),
('Hotel Esplendid', 'Hotel', 'Avenida Mediterrani, 17'),
('Camping Bella Terra', 'Camping', 'Avinguda Vila de Madrid, s/n'),
('Camping Blanes', 'Camping', 'Carrer Cristòfor Colom, 48'),
('Camping La Masia', 'Camping', 'Carrer Colom, 44'),
('Apartaments AR Blavamar - San Marcos', 'Apartahotel', 'Carrer Josep Tarradellas, 2'),
('Apartamentos Europa Sun', 'Apartahotel', 'Av. Mediterrani, 6');

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
