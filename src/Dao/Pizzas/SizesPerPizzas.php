<?php

namespace Dao\Pizzas;

use Dao\Table;

class SizesPerPizzas extends Table
{
    /**
     * Retrieves all sizes and prices for a given pizza ID.
     *
     * @param int $pizzaId The ID of the pizza.
     * @return array An array of size and price details for the pizza.
     */
    public static function getSizesByPizzaId($pizzaId)
    {
        $sqlstr = '
            SELECT 
                ps.size AS sizeName, 
                psm.price 
            FROM 
                pizza_size_mapping psm
            INNER JOIN 
                pizza_sizes ps ON psm.size_id = ps.id
            WHERE 
                psm.pizza_id = :pizza_id;
        ';
        $sizes = self::obtenerRegistros($sqlstr, ['pizza_id' => $pizzaId]);
        return $sizes;
    }

    /**
     * Retrieves all available sizes.
     *
     * @return array An array of all available sizes.
     */
    public static function getAllSizes()
    {
        $sqlstr = 'SELECT * FROM pizza_sizes;';
        return self::obtenerRegistros($sqlstr, []);
    }

    /**
     * Retrieves a specific size and price for a given pizza ID and size ID.
     *
     * @param int $pizzaId The ID of the pizza.
     * @param string $sizeId The ID of the size.
     * @return array|null Size and price details if available, null otherwise.
     */
    public static function getSizeByPizzaIdAndSizeId($pizzaId, $sizeId)
    {
        $sqlstr = '
            SELECT 
                ps.size AS sizeName, 
                psm.price 
            FROM 
                pizza_size_mapping psm
            INNER JOIN 
                pizza_sizes ps ON psm.size_id = ps.id
            WHERE 
                psm.pizza_id = :pizza_id
                AND psm.size_id = :size_id;
        ';
        return self::obtenerUnRegistro($sqlstr, [
            'pizza_id' => $pizzaId,
            'size_id' => $sizeId
        ]);
    }
}
