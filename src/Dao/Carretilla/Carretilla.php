<?php

namespace Dao\Carretilla;

use Dao\Table;

class Carretilla extends Table
{
    // Método para obtener los detalles de una carretilla específica de un usuario específico con estado "pendiente"
    public static function obtenerDetallesCarretilla($usercod, $carretilla_id)
    {
        $sqlstr = 'SELECT 
                        c.carretilla_id,
                        u.username AS usuario,
                        p.pizza_name AS pizza,
                        ps.size AS tamano,
                        dc.quantity AS cantidad,
                        dc.precio_unitario,
                        (dc.quantity * dc.precio_unitario) AS total
                   FROM 
                        carretilla c
                   JOIN 
                        usuario u ON c.usercod = u.usercod
                   JOIN 
                        detalle_carrito dc ON c.carretilla_id = dc.carretilla_id
                   JOIN 
                        pizzas p ON dc.pizza_id = p.id
                   JOIN 
                        pizza_sizes ps ON dc.size_id = ps.id
                   WHERE 
                        c.estado = "pendiente"
                        AND c.usercod = :usercod
                        AND c.carretilla_id = :carretilla_id;';
        $params = ["usercod" => $usercod, "carretilla_id" => $carretilla_id];
        return self::obtenerRegistros($sqlstr, $params);
    }

    // Método para insertar un nuevo carrito
    public static function agregarCarretilla($carretilla)
    {
        unset($carretilla['carretilla_id']); // Eliminar el ID si está presente, ya que es autogenerado
        unset($carretilla['added_at']);      // Fecha se generará automáticamente
        $sqlstr = 'INSERT INTO carretilla (usercod, estado, added_at)
                   VALUES (:usercod, :estado, NOW());';
        return self::executeNonQuery($sqlstr, $carretilla);
    }

    // Método para insertar un nuevo detalle en el carrito
    public static function agregarDetalleCarrito($detalle)
    {
        unset($detalle['detalle_id']); // Eliminar el ID si está presente, ya que es autogenerado
        $sqlstr = 'INSERT INTO detalle_carrito 
                   (carretilla_id, pizza_id, size_id, quantity, precio_unitario)
                   VALUES (:carretilla_id, :pizza_id, :size_id, :quantity, :precio_unitario);';
        return self::executeNonQuery($sqlstr, $detalle);
    }
}