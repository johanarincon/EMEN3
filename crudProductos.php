<?php
require_once '../Controlador/controladorProducto.php';




$controlador = new controladorProductos();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['agregar'])) {
        $precio = $_POST['precio'];
        $disponibilidad = $_POST['disponibilidad'];
        $cantidad = $_POST['cantidad'];
        $controlador->agregarProducto($precio, $disponibilidad, $cantidad);
    } elseif (isset($_POST['editar'])) {
        $id = $_POST['idProducto']; 
        $precio = $_POST['precio'];
        $disponibilidad = $_POST['disponibilidad'];
        $cantidad = $_POST['cantidad'];
        $controlador->editarProducto($id, $precio, $disponibilidad, $cantidad);
    } elseif (isset($_POST['eliminar'])) {
        $id = $_POST['idProducto'];
        $controlador->eliminarProducto($id);
    }
}

$productos = $controlador->listarProductos();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>CRUD Productos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

  <link rel="stylesheet" type="text/css" href="CSS/crudProductos.css">
</head>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #c8992d, #3e3d3f, #000000);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: #333;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #000000;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 2px solid #e74c3c;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .btn {
            margin-right: 10px;
        }

        table {
            margin-top: 20px;
        }

        th, td {
            text-align: center;
        }

        th {
            background-color: #f8f9fa;
            color: #343a40;
        }

        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Gestión de Productos</h2>

    <form method="POST">
        <input type="hidden" name="idProducto" id="idProducto" value="">
        <div class="form-group">
            <label for="precio">Precio</label>
            <input type="number" step="0.01" class="form-control" name="precio" required>
        </div>
        <div class="form-group">
            <label for="disponibilidad">Disponibilidad</label>
            <input type="number" class="form-control" name="disponibilidad" required>
        </div>
        <div class="form-group">
            <label for="cantidad">Cantidad</label>
            <input type="number" class="form-control" name="cantidad" required>
        </div>
        <button type="submit" name="agregar" class="btn btn-primary">Agregar Producto</button>
        <button type="submit" name="editar" class="btn btn-warning">Editar Producto</button>
    </form>

    <h3>Lista de Productos</h3>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Precio</th>
            <th>Disponibilidad</th>
            <th>Cantidad</th>
            <th>Actualizar</th>
            <th>Eliminar</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($productos as $producto): ?>
            <tr>
                <td><?php echo $producto['idProducto']; ?></td>
                <td><?php echo number_format($producto['Precio'], 2); ?></td>
                <td><?php echo $producto['Disponibilidad']; ?></td>
                <td><?php echo $producto['Cantidad']; ?></td>
                <td>
                    <button class="btn btn-info" onclick="editarProducto(<?php echo $producto['idProducto']; ?>, '<?php echo $producto['Precio']; ?>', '<?php echo $producto['Disponibilidad']; ?>', '<?php echo $producto['Cantidad']; ?>')">Editar</button>
                </td>
                <td>
                    <form method="POST" style="display:inline;">
                        <input type="hidden" name="idProducto" value="<?php echo $producto['idProducto']; ?>">
                        <button type="submit" name="eliminar" class="btn btn-danger">Eliminar</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

<script>
    function editarProducto(id, precio, disponibilidad, cantidad) {
        document.getElementById('idProducto').value = id;
        document.querySelector('input[name="precio"]').value = precio;
        document.querySelector('input[name="disponibilidad"]').value = disponibilidad;
        document.querySelector('input[name="cantidad"]').value = cantidad;
    }
</script>

</body>
</html>
