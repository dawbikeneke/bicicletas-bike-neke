<?php
session_start();

function verificarAdmin() {
    if (!isset($_SESSION['admin_id'])) {
        header('Location: ../login.php');
        exit;
    }
}

function iniciarSesion() {
    if (isset($_SESSION['admin_id'])) {
        header('Location: gestion/dashboard.php');
        exit;
    }
}

function cerrarSesion() {
    session_start();
    session_unset();
    session_destroy();
    header('Location: ../login.php');
    exit;
}
