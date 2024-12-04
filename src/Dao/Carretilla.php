<?php

namespace Dao;

/**
 * Carretilla class for managing the shopping cart.
 * This class extends the Table class and uses the Dao::getConn() method for database connectivity.
 */
class Carretilla extends Table
{
    // Create a new cart for a registered user
    public static function createCart($usercod)
    {
        $sqlstr = "INSERT INTO cart (usercod) VALUES (:usercod)";
        $params = ["usercod" => $usercod];
        return self::executeNonQuery($sqlstr, $params) ? self::getConn()->lastInsertId() : false;
    }

    // Create a new cart for an anonymous user
    public static function createCartAnon($anoncod)
    {
        $sqlstr = "INSERT INTO cart_anon (anoncod) VALUES (:anoncod)";
        $params = ["anoncod" => $anoncod];
        return self::executeNonQuery($sqlstr, $params) ? self::getConn()->lastInsertId() : false;
    }

    // Insert a new pizza item into the registered user's cart
    public static function insertPizza($cart_id, $pizza_id, $size_id, $quantity, $price)
    {
        $sqlstr = "
            INSERT INTO cart_items (cart_id, pizza_id, size_id, quantity, price)
            VALUES (:cart_id, :pizza_id, :size_id, :quantity, :price)
        ";
        $params = [
            "cart_id" => $cart_id,
            "pizza_id" => $pizza_id,
            "size_id" => $size_id,
            "quantity" => $quantity,
            "price" => $price
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    // Insert a new pizza item into the anonymous user's cart
    public static function insertPizzaAnon($cart_id, $pizza_id, $size_id, $quantity, $price)
    {
        $sqlstr = "
            INSERT INTO cart_items_anon (cart_id, pizza_id, size_id, quantity, price)
            VALUES (:cart_id, :pizza_id, :size_id, :quantity, :price)
        ";
        $params = [
            "cart_id" => $cart_id,
            "pizza_id" => $pizza_id,
            "size_id" => $size_id,
            "quantity" => $quantity,
            "price" => $price
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    // Update the quantity of a pizza in the registered user's cart
    public static function updatePizza($item_id, $quantity)
    {
        $sqlstr = "UPDATE cart_items SET quantity = :quantity WHERE item_id = :item_id";
        $params = [
            "quantity" => $quantity,
            "item_id" => $item_id
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    // Update the quantity of a pizza in the anonymous user's cart
    public static function updatePizzaAnon($item_id, $quantity)
    {
        $sqlstr = "UPDATE cart_items_anon SET quantity = :quantity WHERE item_id = :item_id";
        $params = [
            "quantity" => $quantity,
            "item_id" => $item_id
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    // Delete a pizza from the registered user's cart
    public static function deletePizza($item_id)
    {
        $sqlstr = "DELETE FROM cart_items WHERE item_id = :item_id";
        $params = ["item_id" => $item_id];
        return self::executeNonQuery($sqlstr, $params);
    }

    // Delete a pizza from the anonymous user's cart
    public static function deletePizzaAnon($item_id)
    {
        $sqlstr = "DELETE FROM cart_items_anon WHERE item_id = :item_id";
        $params = ["item_id" => $item_id];
        return self::executeNonQuery($sqlstr, $params);
    }

    // Check if a registered user's cart is empty
    public static function isCartEmpty($cart_id)
    {
        $sqlstr = "SELECT COUNT(*) AS total FROM cart_items WHERE cart_id = :cart_id";
        $params = ["cart_id" => $cart_id];
        $result = self::obtenerUnRegistro($sqlstr, $params);
        return isset($result["total"]) && $result["total"] == 0;
    }

    // Check if an anonymous user's cart is empty
    public static function isCartAnonEmpty($cart_id)
    {
        $sqlstr = "SELECT COUNT(*) AS total FROM cart_items_anon WHERE cart_id = :cart_id";
        $params = ["cart_id" => $cart_id];
        $result = self::obtenerUnRegistro($sqlstr, $params);
        return isset($result["total"]) && $result["total"] == 0;
    }

    // Retrieve all items in a registered user's cart
    public static function getCartItems($cart_id)
    {
        $sqlstr = "SELECT * FROM cart_items WHERE cart_id = :cart_id";
        $params = ["cart_id" => $cart_id];
        return self::obtenerRegistros($sqlstr, $params);
    }

    // Retrieve all items in an anonymous user's cart
    public static function getCartItemsAnon($cart_id)
    {
        $sqlstr = "SELECT * FROM cart_items_anon WHERE cart_id = :cart_id";
        $params = ["cart_id" => $cart_id];
        return self::obtenerRegistros($sqlstr, $params);
    }
}
