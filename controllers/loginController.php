<?php
require_once '../includes/db.php';
require_once '../includes/config.php';

session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    // Consultamos en la tabla administracion
    $stmt = $pdo->prepare("SELECT id_admin, nombre_usuario, email, password_hash FROM administracion WHERE email = ?");
    $stmt->execute([$email]);
    $admin = $stmt->fetch();

    if ($admin && password_verify($password, $admin['password_hash'])) {
        // Guardamos datos en la sesión
        $_SESSION['admin_id'] = $admin['id_admin'];
        $_SESSION['admin_nombre'] = $admin['nombre_usuario'];
        $_SESSION['admin_email'] = $admin['email'];

        // Redirigimos al panel de administración
        header('Location: ../public/admin/dashboard.php');
        exit;
    } else {
        // Credenciales incorrectas
        header('Location: ../public/login.php?error=Credenciales incorrectas');
        exit;
    }
} else {
    // Si no viene por POST, redirigimos al login
    header('Location: ../public/login.php');
    exit;
}
