<?php

namespace Controllers\Gallery;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Pizzas\Pizzas as PizzasDao;

class Gallery extends PublicController
{
    public function run(): void
    {
        $pizzasDao = PizzasDao::getPizzas();
        $viewPizzas = [];
        foreach ($pizzasDao as $pizza) {
            $viewPizzas[] = $pizza;
        }
        $viewData = [
            'pizzas' => $viewPizzas
        ];
        Renderer::render('gallery/gallery', $viewData);
    }
}