<?php

namespace Controllers\Gallery;

use Controllers\PublicController;
use Views\Renderer;


class Gallery extends PublicController
{
    public function run(): void
    {
        $viewData = [
            'pizzas' => [
                [
                    'name' => 'Cheese Pizza',
                    'description' => 'A classic pizza topped with a generous amount of mozzarella cheese and a tangy tomato sauce.',
                    'ingredients' => ['Mozzarella cheese', 'Tomato sauce', 'Olive oil', 'Basil'],
                    'image_url' => 'public\imgs\pizzas\Cheese.jpeg'
                ],
                [
                    'name' => 'Meat Lover\'s Pizza',
                    'description' => 'A pizza loaded with a variety of meats including pepperoni, sausage, and bacon.',
                    'ingredients' => ['Pepperoni', 'Sausage', 'Bacon', 'Mozzarella cheese', 'Tomato sauce'],
                    'image_url' => 'public\imgs\pizzas\MeatLover.jpeg'
                ],
                [
                    'name' => 'Pepperoni Pizza',
                    'description' => 'A popular pizza featuring slices of pepperoni on top of mozzarella cheese and tomato sauce.',
                    'ingredients' => ['Pepperoni', 'Mozzarella cheese', 'Tomato sauce'],
                    'image_url' => 'public\imgs\pizzas\Pepperoni.jpeg'
                ],
                [
                    'name' => 'Hawaiian Pizza',
                    'description' => 'A sweet and savory pizza topped with ham and pineapple, balanced with a rich tomato sauce and mozzarella cheese.',
                    'ingredients' => ['Ham', 'Pineapple', 'Mozzarella cheese', 'Tomato sauce'],
                    'image_url' => 'public\imgs\pizzas\Hawaiian.jpeg'
                ]
            ]
        ];
        
        Renderer::render('gallery/gallery', $viewData);
    }
}