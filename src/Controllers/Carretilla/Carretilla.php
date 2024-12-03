<?php
namespace Controllers\Carretilla;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Carretilla\Carretilla as CarretillaDao;

class Carretilla extends PublicController
{
    public function run(): void
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'delete' && isset($_POST['item_id'])) {
            header('Content-Type: application/json');
            try {
                $itemId = $_POST['item_id'];
                $result = CarretillaDao::deleteCartItem($itemId);
                echo json_encode(['success' => $result]);
            } catch (\Exception $e) {
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
            exit;
        }

        $carretillaDao = CarretillaDao::getCartByUserCod(1);
        $viewCarretilla = [];
        if ($carretillaDao) {
            $viewCarretilla[] = $carretillaDao;
        }
        $viewData = [
            'carretilla' => $viewCarretilla
        ];

        $this->loadCartItems2($viewData);
        Renderer::render('carretilla/carretilla', $viewData);
    }

    private function loadCartItems(array &$viewData): void
    {
        if (!empty($viewData['carretilla'])) {
            $cart = $viewData['carretilla'][0];
            $cartId = $cart['cart_id'];
            $cartItems = CarretillaDao::getCartItemsByCartId($cartId);
            $viewData['cartItems'] = $cartItems;
        } else {
            $viewData['cartItems'] = [];
        }
    }

    private function loadCartItems2(array &$viewData): void
    {
        if (!empty($viewData['carretilla'])) {
            $cart = $viewData['carretilla'][0];
            $cartId = $cart['cart_id'];
            $cartItems = CarretillaDao::getCartItems($cartId);
            $viewData['cartItems'] = $cartItems;
        } else {
            $viewData['cartItems'] = [];
        }
    }
}
