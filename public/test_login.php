<?php
$input_password = "Password123";

// Este es el hash que tienes actualmente en la BD:
$hash_bd = '$2y$10$CxCzQIHXLZ0XS5YPsI1EguRVB0fYLlY34XgMsJnzVYeAJ.axYnjlm';

if (password_verify($input_password, $hash_bd)) {
    echo "✅ Coincide: Login válido";
} else {
    echo "❌ No coincide: Login inválido";
}
