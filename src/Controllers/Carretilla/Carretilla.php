<?php

namespace Controllers\Carretilla;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Carretilla\Carretilla as CarretillaDao;

class Carretilla extends PublicController
{
    public function run(): void
    {
        $carretillaDao = CarretillaDao::getCartByUserCod(1);
        $viewCarretilla = [];
        if ($carretillaDao) { // Verifica si se encontró un carrito
            $viewCarretilla[] = $carretillaDao; // Añade el carrito encontrado al arreglo
        }
        $viewData = [
            'carretilla' => $viewCarretilla
        ];

        // Llama a la nueva función para cargar los items del carrito
        $this->loadCartItems($viewData);

        echo '<pre>';
        print_r($viewData);
        echo '</pre>';

        Renderer::render('carretilla/carretilla', $viewData);
    }

    /**
     * Carga los elementos del carrito en base al cart_id del carrito encontrado.
     *
     * @param array $viewData La referencia al arreglo de datos de la vista.
     */
    private function loadCartItems(array &$viewData): void
    {
        // Verifica si existe un carrito en viewData
        if (!empty($viewData['carretilla'])) {
            // Obtiene el primer carrito encontrado
            $cart = $viewData['carretilla'][0];
            $cartId = $cart['cart_id'];

            // Obtiene los items del carrito usando el cartId
            $cartItems = CarretillaDao::getCartItemsByCartId($cartId);

            // Añade los items del carrito a viewData bajo la llave 'cartItems'
            $viewData['cartItems'] = $cartItems;
        } else {
            // Si no hay carrito, inicializa cartItems como un arreglo vacío
            $viewData['cartItems'] = [];
        }
    }
}
