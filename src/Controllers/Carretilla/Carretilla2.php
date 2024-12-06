<?php

namespace Controllers\Carretilla;

use Controllers\PrivateController;
use Views\Renderer;
use Utilities\Site;
use Dao\Carretilla\Carretilla as CarretillaDao;

class Carretilla2 extends PrivateController
{
    private $viewData = [];
    public function run(): void
    {
        $this->generateViewData();
        echo '<pre>';
        print_r($this->viewData);
        echo '</pre>';
        Renderer::render('carretilla\carretilla2', $this->viewData);
    }

    private function generateViewData()
    {
        $userID = \Utilities\Security::getUserId();
        $cart = CarretillaDao::getCartByUserCod($userID);
        if (empty($cart)) {
            $cartID = CarretillaDao::createCart($userID);
            $cart = [
                [
                    'cart_id' => $cartID,
                ]
            ];
        } else {
            $cartID = $cart[0]['cart_id'];
        }
        $this->viewData["usercod"] = $userID;
        $this->viewData["cartid"] = $cartID;
        $this->viewData["cartitems"] = CarretillaDao::getCartItemsByCartId($cartID);
    }

}


