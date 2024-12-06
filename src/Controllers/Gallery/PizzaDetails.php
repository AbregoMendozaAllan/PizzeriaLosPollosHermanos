<?php

namespace Controllers\Gallery;

use Controllers\PrivateController;
use Views\Renderer;
use Utilities\Site;
use Dao\Pizzas\Pizzas as PizzasDao;
use Dao\Pizzas\SizesPerPizzas as SizesPerPizzasDao;
use Dao\Carretilla\Carretilla as CarretillaDao;

class pizzaDetails extends PrivateController {
    private $viewData = [];
    private $quantity = 1;

    public function run():void {
        $this->initForm();
        if($this->isPostBack()) {
            $postData = $_POST;
            $this->loadCartData($postData);
            /*echo '<pre>';
            print_r($this->cart);
            echo '</pre>';*/
        }
        $this->generateViewData();
        /*echo '<pre>';
        print_r($this->viewData);
        echo '</pre>';*/
        Renderer::render('gallery\pizzadetails', $this->viewData);
    }
    // Init Form
    private function initForm() {    
        if (isset($_GET["id"])) {
            $this->pizza["id"] = $_GET["id"];
            $this->getPizzaDetails();
            $this->getPizzaSizes();
        }
    }
    private function getPizzaDetails() {
        $tmpPizza = PizzasDao::getPizzaById($this->pizza["id"]);
        $this->pizza = $tmpPizza;
    }
    private function getPizzaSizes() {
        $tempPizzaSizes = SizesPerPizzasDao::getSizesByPizzaId($this->pizza["id"]);
        $this->pizzaSizes = $tempPizzaSizes;
    }
    private function generateViewData() {
        $this->viewData["pizza"] = $this->pizza;
        $this->viewData["pizzaSizes"] = $this->pizzaSizes;
        $this->viewData["quantity"] = $this->quantity;
    }
    private function loadCartData($postData)
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
        }
        $pizzaId = $this->pizza["id"] ?? null;
        $sizeId = $postData['pizza_size'] ?? null;
        $quantity = $postData['quantity'] ?? 1;
        $priceData = SizesPerPizzasDao::getPriceByPizzaIdAndSizeId($pizzaId, $sizeId);
        $unitPrice = $priceData['price'] ?? 0.00;
        $totalPrice = $unitPrice * $quantity;
        $insertResult = CarretillaDao::insertCartItem(
            $cart[0]['cart_id'],
            $pizzaId,
            $sizeId,
            $quantity,
            $totalPrice
        );
        if ($insertResult) {
            \Utilities\Site::redirectToWithMsg(
                "index.php?page=Gallery-Gallery",
                "¡La pizza ha sido agregada exitosamente a tu carrito!"
            );
        } else {
            \Utilities\Site::redirectToWithMsg(
                "index.php?page=Gallery-Gallery",
                "Hubo un error al agregar la pizza al carrito. Por favor, intenta de nuevo."
            );
        }
    }    
    private function insertCartItem()
    {
        $cartData = $this->cart;

        if (!empty($cartData)) {
            CarretillaDao::insertCartItem(
                $cartData['cart_id'],
                $cartData['pizza_id'],
                $cartData['pizza_size'],
                $cartData['quantity'],
                $cartData['price']
            );
        }
    }
}

