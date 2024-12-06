<?php
// Conectar a la base de datos
include('../Modelo/Conexion.php');

// Obtener el ID del evento
if (isset($_GET['id'])) {
    $idEvento = $_GET['id'];

    // Consultar el evento a editar
    $query = "SELECT * FROM eventos WHERE idEvento = $idEvento";
    $resultado = $conn->query($query);
    $evento = $resultado->fetch_assoc();
}

// Editar evento
if (isset($_POST['editar'])) {
    $idEvento = $_POST['idEvento'];
    $titulo = $_POST['titulo'];
    $descripcion = $_POST['descripcion'];
    $fecha_evento = $_POST['fecha_evento'];

    $query = "UPDATE eventos SET titulo = '$titulo', descripcion = '$descripcion', 
              fecha_evento = '$fecha_evento' WHERE idEvento = $idEvento";
    $conn->query($query);

    header('Location: index_admin.php');
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Evento</title>
</head>
<body>

<h1>Editar Evento</h1>

<form method="POST" action="">
    <input type="hidden" name="idEvento" value="<?php echo $evento['idEvento']; ?>">
    <input type="text" name="titulo" value="<?php echo $evento['titulo']; ?>" required>
    <textarea name="descripcion" required><?php echo $evento['descripcion']; ?></textarea>
    <input type="datetime-local" name="fecha_evento" value="<?php echo date('Y-m-d\TH:i', strtotime($evento['fecha_evento'])); ?>" required>
    <button type="submit" name="editar">Editar Evento</button>
</form>

</body>
</html>
