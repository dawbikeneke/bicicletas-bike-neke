<?php
require_once '../../includes/auth.php';
require_once '../../includes/db.php';
require_once '../../includes/config.php';
require_once '../../includes/header.php';
require_once '../../includes/navbar.php';

verificarAdmin();
?>

<h1>Bienvenido, <?php echo htmlspecialchars($_SESSION['admin_nombre']); ?></h1>
<p>Este es el panel de administración de Bikeneke.</p>



<?php require_once '../../includes/footer.php'; ?>
