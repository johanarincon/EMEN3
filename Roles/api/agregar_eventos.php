<?php


// Conectar a la base de datos
include_once 'conexion.php';

// Verificar si se envió el formulario para agregar un evento
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['agregar_evento'])) {
    // Obtener los datos del formulario
    $titulo = $_POST['titulo'];
    $descripcion = $_POST['descripcion'];
    $fecha_evento = $_POST['fecha_evento'];
    $menu_id = $_POST['menu_id']; // Obtener el menu_id del formulario (relacionado con la tabla menu)

    // Verificar si el menu_id existe en la tabla menu
    $checkMenuQuery = "SELECT idMenu FROM menu WHERE idMenu = ?";
    $checkMenuStmt = $conn->prepare($checkMenuQuery);
    $checkMenuStmt->bind_param('i', $menu_id);
    $checkMenuStmt->execute();
    $checkMenuStmt->store_result();

    if ($checkMenuStmt->num_rows > 0) {
        // El menu_id existe, proceder a insertar el evento
        $query = "INSERT INTO eventos (titulo, descripcion, fecha_evento, menu_idMenu) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($query);
        $stmt->bind_param('sssi', $titulo, $descripcion, $fecha_evento, $menu_id);
        
        if ($stmt->execute()) {
            echo "<script>alert('Evento agregado con éxito');</script>";
        } else {
            echo "<script>alert('Error al agregar evento: " . $stmt->error . "');</script>";
        }
        $stmt->close();
    } else {
        // El menu_id no existe, mostrar un mensaje de error
        echo "<script>alert('El ID del menú no existe. Por favor, seleccione un menú válido.');</script>";
    }
    $checkMenuStmt->close();
}

// Verificar si se envió el formulario para editar un evento
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['editar_evento'])) {
    // Obtener los datos del formulario de edición
    $evento_id = $_POST['evento_id'];
    $titulo = $_POST['titulo'];
    $descripcion = $_POST['descripcion'];
    $fecha_evento = $_POST['fecha_evento'];
    $menu_id = $_POST['menu_id'];

    // Actualizar el evento en la base de datos
    $query = "UPDATE eventos SET titulo = ?, descripcion = ?, fecha_evento = ?, menu_idMenu = ? WHERE idEvento = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param('ssssi', $titulo, $descripcion, $fecha_evento, $menu_id, $evento_id);

    if ($stmt->execute()) {
        echo "<script>alert('Evento actualizado con éxito');</script>";
    } else {
        echo "<script>alert('Error al actualizar evento: " . $stmt->error . "');</script>";
    }
    $stmt->close();
}

// Verificar si se envió el formulario para eliminar un evento
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['eliminar_evento'])) {
    $evento_id = $_POST['evento_id'];

    // Eliminar el evento de la base de datos
    $query = "DELETE FROM eventos WHERE idEvento = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param('i', $evento_id);

    if ($stmt->execute()) {
        echo "<script>alert('Evento eliminado con éxito');</script>";
    } else {
        echo "<script>alert('Error al eliminar evento: " . $stmt->error . "');</script>";
    }
    $stmt->close();
}

// Obtener los eventos desde la base de datos
$query = "SELECT idEvento, titulo, descripcion, fecha_evento, menu_idMenu FROM eventos";
$eventosResult = $conn->query($query);
?>

<!DOCTYPE html>
<html lang="es">

<head>
<link rel="stylesheet" href="StilyesGeneral.css">
    <meta charset="UTF-8">
    <title>Gestionar Eventos - CRUD</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        button {
            padding: 5px 10px;
            margin: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<h1>Gestionar Eventos - CRUD</h1>

<!-- Formulario para agregar eventos -->
<h2>Agregar Nuevo Evento</h2>
<form method="POST" action="agregar_eventos.php">
    <label for="titulo">Título del Evento:</label>
    <input type="text" name="titulo" id="titulo" required><br><br>

    <label for="descripcion">Descripción:</label>
    <textarea name="descripcion" id="descripcion" required></textarea><br><br>

    <label for="fecha_evento">Fecha y Hora del Evento:</label>
    <input type="datetime-local" name="fecha_evento" id="fecha_evento" required><br><br>

    <label for="menu_id">Seleccione el Menú:</label>
    <select name="menu_id" id="menu_id" required>
        <?php
        // Obtener los menús disponibles de la base de datos
        $menuQuery = "SELECT idMenu, Descripcion FROM menu";
        $menuResult = $conn->query($menuQuery);

        // Mostrar los menús en un select
        while ($row = $menuResult->fetch_assoc()) {
            echo "<option value='" . $row['idMenu'] . "'>" . $row['Descripcion'] . "</option>";
        }
        ?>
    </select><br><br>

    <button type="submit" name="agregar_evento">Agregar Evento</button>
</form>

<!-- Tabla de eventos existentes -->
<h2>Eventos Existentes</h2>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Título</th>
            <th>Descripción</th>
            <th>Fecha y Hora</th>
            <th>Menú</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <?php
        // Mostrar los eventos en la tabla
        while ($evento = $eventosResult->fetch_assoc()) {
            $evento_id = $evento['idEvento'];
            $titulo = $evento['titulo'];
            $descripcion = $evento['descripcion'];
            $fecha_evento = $evento['fecha_evento'];
            $menu_idMenu = $evento['menu_idMenu'];

            // Obtener el nombre del menú
            $menuQuery = "SELECT Descripcion FROM menu WHERE idMenu = ?";
            $menuStmt = $conn->prepare($menuQuery);
            $menuStmt->bind_param('i', $menu_idMenu);
            $menuStmt->execute();
            $menuResult = $menuStmt->get_result();
            $menu = $menuResult->fetch_assoc()['Descripcion'];
            $menuStmt->close();
            
            echo "<tr>
                    <td>$evento_id</td>
                    <td>$titulo</td>
                    <td>$descripcion</td>
                    <td>$fecha_evento</td>
                    <td>$menu</td>
                    <td>
                        <!-- Botón de edición -->
                        <form method='POST' action='agregar_eventos.php' style='display:inline;'>
                            <input type='hidden' name='evento_id' value='$evento_id'>
                            <button type='submit' name='editar_evento'>Editar</button>
                        </form>
                        <!-- Botón de eliminación -->
                        <form method='POST' action='agregar_eventos.php' style='display:inline;'>
                            <input type='hidden' name='evento_id' value='$evento_id'>
                            <button type='submit' name='eliminar_evento'>Eliminar</button>
                        </form>
                    </td>
                </tr>";
        }
        ?>
    </tbody>
</table>

</body>
</html>


