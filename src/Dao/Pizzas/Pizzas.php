<?php

namespace Dao\Pizzas;

use Dao\Table;

class Pizzas extends Table {

    public static function getPizzas() {
        $sqlstr = 'SELECT * FROM pizzas';
        $pizzas = self::obtenerRegistros($sqlstr, []);
        return $pizzas;
    }
}