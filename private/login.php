<?php
require_once '../includes/auth.php';
require_once '../includes/db.php';
require_once '../includes/config.php';

iniciarSesion(); // Si ya está logueado, podría redirigir

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Bikeneke</title>
    <link rel="stylesheet" href="../public/css/estilos.css">
</head>
<body>

<h2>Iniciar sesión</h2>

<?php if (isset($_GET['error'])): ?>
    <p style="color:red;"><?php echo htmlspecialchars($_GET['error']); ?></p>
<?php endif; ?>

<form action="../controllers/loginController.php" method="POST">
    <label for="email">Email:</label>
    <input type="email" name="email" required><br><br>

    <label for="password">Contraseña:</label>
    <input type="password" name="password" required><br><br>

    <button type="submit">Ingresar</button>
</form>

<h3>gestion@bikeneke.com / Password123</h3>

</body>
</html>
