<?php
$host = 'localhost';
$basedatos = 'tienda_bicicletas';
$usuario = 'root';
$contrasena = 'Morato345';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$basedatos;charset=utf8", $usuario, $contrasena);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // Opcional: habilita fetch asociativo por defecto
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Error de conexión a la base de datos: " . $e->getMessage());
}
?>