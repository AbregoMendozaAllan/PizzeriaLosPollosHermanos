<?php
namespace Controllers\Carretilla;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Carretilla\Carretilla as CarretillaDao;

class Carretilla extends PublicController
{
    private $viewData = [];

    public function run(): void
    {
        if ($this->isPostBack()) {
            $postData = $_POST;
            $this->updateCartItems($postData);
            echo '<pre>';
            print_r($postData);
            echo '</pre>';
        }

        $carretillaDao = CarretillaDao::getCartByUserCod(1);
        $viewCarretilla = [];
        if ($carretillaDao) {
            $viewCarretilla[] = $carretillaDao;
        }
        $this->viewData = [
            'carretilla' => $viewCarretilla
        ];

        $this->loadCartItems2($this->viewData);
        Renderer::render('carretilla/carretilla', $this->viewData);
    }

    private function updateCartItems($postData)
    {
        if (isset($postData['cart_items']) && is_array($postData['cart_items'])) {
            foreach ($postData['cart_items'] as $item) {
                if (isset($item['item_id'], $item['quantity'], $item['price'])) {
                    CarretillaDao::updateCartItem($item['item_id'], $item['quantity'], $item['price']);
                }
            }
        }
    }

    private function loadCartItems2(array &$viewData): void
    {
        if (!empty($viewData['carretilla'])) {
            $cart = $viewData['carretilla'][0];
            if (isset($cart['cart_id'])) {
                $cartId = $cart['cart_id'];
                $cartItems = CarretillaDao::getCartItems($cartId);
                $viewData['cartItems'] = $cartItems;
            } else {
                $viewData['cartItems'] = [];
            }
        } else {
            $viewData['cartItems'] = [];
        }
    }
}
