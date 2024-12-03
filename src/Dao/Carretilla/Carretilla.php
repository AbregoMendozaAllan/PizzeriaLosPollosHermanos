<?php

namespace Dao\Carretilla;

use Dao\Table;

class Carretilla extends Table
{
    // Obtener todos los registros de la tabla `cart`
    public static function getAllCarts()
    {
        $sqlstr = "SELECT * FROM cart;";
        return self::obtenerRegistros($sqlstr, []);
    }

    // Obtener un registro de la tabla `cart` por ID
    public static function getCartById($cartId)
    {
        $sqlstr = "SELECT * FROM cart WHERE cart_id = :cart_id;";
        return self::obtenerUnRegistro($sqlstr, ["cart_id" => $cartId]);
    }

    // Insertar un nuevo registro en la tabla `cart`
    public static function insertCart($userCod)
    {
        $sqlstr = "INSERT INTO cart (usercod) VALUES (:usercod);";
        return self::executeNonQuery($sqlstr, ["usercod" => $userCod]);
    }

    // Eliminar un registro de la tabla `cart` por ID
    public static function deleteCart($cartId)
    {
        $sqlstr = "DELETE FROM cart WHERE cart_id = :cart_id;";
        return self::executeNonQuery($sqlstr, ["cart_id" => $cartId]);
    }

   // Obtener todos los registros de la tabla cart_items por ID de carrito
   public static function getCartItemsByCartId($cartId)
   {
       $sqlstr = "SELECT * FROM cart_items WHERE cart_id = :cart_id;";
       return self::obtenerRegistros($sqlstr, ["cart_id" => $cartId]);
   }

   public static function getCartItems($cartId)
   {
       $sqlstr = "SELECT  c.item_id, c.pizza_id, p.pizza_name, s.size ,c.quantity,  c.price 
                  FROM pizzas as p 
                  INNER JOIN cart_items as c ON c.pizza_id = p.id 
                  INNER JOIN pizza_sizes as s ON c.size_id = s.id 
                  WHERE c.cart_id = :cart_id;";
       return self::obtenerRegistros($sqlstr, ["cart_id" => $cartId]);
   }
   

    //da el parametro del codigo del usuario
    public static function getCartByUserCod($userCod)
    {
        $sqlstr = "SELECT * FROM cart WHERE usercod = :usercod LIMIT 1;";
        return self::obtenerUnRegistro($sqlstr, ["usercod" => $userCod]);
    }

    // Insertar un nuevo item en la tabla `cart_items`
    public static function insertCartItem($cartId, $pizzaId, $sizeId, $quantity, $price)
    {
        $sqlstr = "INSERT INTO cart_items (cart_id, pizza_id, size_id, quantity, price)
                   VALUES (:cart_id, :pizza_id, :size_id, :quantity, :price);";
        return self::executeNonQuery($sqlstr, [
            "cart_id" => $cartId,
            "pizza_id" => $pizzaId,
            "size_id" => $sizeId,
            "quantity" => $quantity,
            "price" => $price
        ]);
    }

    // Actualizar la cantidad y precio de un item en la tabla `cart_items`
    public static function updateCartItem($itemId, $quantity, $price)
    {
        $sqlstr = "UPDATE cart_items
                   SET quantity = :quantity, price = :price
                   WHERE item_id = :item_id;";
        return self::executeNonQuery($sqlstr, [
            "item_id" => $itemId,
            "quantity" => $quantity,
            "price" => $price
        ]);
    }

    // Eliminar un item de la tabla `cart_items`
    public static function deleteCartItem($itemId)
    {
        $sqlstr = "DELETE FROM cart_items WHERE item_id = :item_id;";
        return self::executeNonQuery($sqlstr, ["item_id" => $itemId]);
    }
}
?>
