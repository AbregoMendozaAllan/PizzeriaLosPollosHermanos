<?php
namespace Controllers\Carretilla;

use Controllers\PrivateController;
use Controllers\PublicController;
use Views\Renderer;
use Dao\Carretilla\Carretilla as CarretillaDao;

class Carretilla extends PublicController
{
    
    public function run(): void
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $postData = $_POST;
            echo '<pre>';
            print_r($this->$postData);
            echo '</pre>';
            header('Content-Type: application/json');
            try {
                if (isset($_POST['action'])) {
                    if ($_POST['action'] === 'delete' && isset($_POST['item_id'])) {
                        $itemId = $_POST['item_id'];
                        $result = CarretillaDao::deleteCartItem($itemId);
                        echo json_encode(['success' => $result]);
                    } elseif ($_POST['action'] === 'update' && isset($_POST['item_id'], $_POST['quantity'], $_POST['price'])) {
                        $itemId = $_POST['item_id'];
                        $quantity = $_POST['quantity'];
                        $price = $_POST['price'];
                        $result = CarretillaDao::updateCartItem($itemId, $quantity, $price);
                        echo json_encode(['success' => $result]);
                    }
                } else {
                    echo json_encode(['success' => false, 'message' => 'Acción no especificada']);
                }
            } catch (\Exception $e) {
                echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
            exit;
        }
        //$userId = \Utilities\Security::getUserId();
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
        } else {
            \Utilities\Site::redirectTo("index.php?page=Sec_Login");

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
