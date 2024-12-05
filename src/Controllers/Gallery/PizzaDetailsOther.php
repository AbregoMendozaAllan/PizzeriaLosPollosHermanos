<?php

namespace Controllers\Gallery;

use Controllers\PrivateController;
use Views\Renderer;
use Utilities\Site;
use Dao\Pizzas\Pizzas as PizzasDao;
use Dao\Pizzas\SizesPerPizzas as SizesPerPizzasDao;
use Dao\Carretilla\Carretilla as CarretillaDao;

class pizzaDetails extends PrivateController
{
    private $viewData = [];
    private $modeDscArr = [
        "INS" => "Add to Cart",
        "DEL" => "Deleting %s (%s)",
        "DSP" => "Details for %s (%s)",
        "UPD" => "Updating %s (%s)"
    ];
    private $mode = '';
    private $cart = [];
    private $pizza = [
        "id" => 0,
        "pizza_name" => '',
        "ingredients" => '',
        "description" => '',
        "image_url" => ''
    ];

    private $pizzaSizes = [];
    private $quantity = 1; // Default quantity

    public function run(): void
    {
        $this->initForm();
        if ($this->isPostBack()) {
            $this->loadFormData();
            $this->onAction();  // Process the action (insert pizza to cart)
        }
        $this->generateViewData();
        Renderer::render('gallery\pizzadetails', $this->viewData);
    }

    private function initForm()
    {
        if (isset($_GET["mode"]) && isset($this->modeDscArr[$_GET["mode"]])) {
            $this->mode = $_GET["mode"];
        } else {
            Site::redirectToWithMsg("index.php?page=Gallery_Gallery", "Error");
            die();
        }
    
        if (isset($_GET["id"])) {
            $this->pizza["id"] = $_GET["id"];
            $this->getPizzaDetails();
            $this->getPizzaSizes();
        }
    }

    private function getPizzaDetails()
    {
        $tmpPizza = PizzasDao::getPizzaById($this->pizza["id"]);
        $this->pizza = $tmpPizza;
    }

    private function getPizzaSizes()
    {
        $tempPizzaSizes = SizesPerPizzasDao::getSizesByPizzaId($this->pizza["id"]);
        $this->pizzaSizes = $tempPizzaSizes;
    }

    private function generateViewData()
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["mode_dsc"] = sprintf(
            $this->modeDscArr[$this->mode],
            $this->pizza["pizza_name"],
            $this->pizza["id"]
        );
        $this->viewData["pizza"] = $this->pizza;
        $this->viewData["pizzaSizes"] = $this->pizzaSizes;
        $this->viewData["quantity"] = $this->quantity;
    }

    private function loadFormData()
    {
        // Load pizza and form data into $cart for future insertion
        cart_id
        usercod
        item_id
        $this->cart['pizza_id'] = $this->pizza['id'];
        $this->cart['size_id'] = $_POST["pizza_size"];
        $this->cart['quantity'] = $_POST["quantity"];
        $this->cart['price'] = $_POST["price"];
    }

    private function onAction()
    {
        switch ($this->mode) {
            case 'INS':
                $this->insertPizzaToCart();
                break;

            default:
                Site::redirectToWithMsg("index.php?page=Gallery_Gallery", "Invalid action.");
                break;
        }
    }

    private function insertPizzaToCart()
    {
        $userId = \Utilities\Security::getUserId();
        if (!$userId) {
            Site::redirectToWithMsg("index.php?page=sec_login", "Please log in to add items to the cart.");
            die();
        }

        // Check if the user already has a cart
        $cart = CarretillaDao::getCartByUserCod($userId);
        $cartId = $cart ? $cart['cart_id'] : CarretillaDao::createCart($userId);

        // Insert the pizza item into the cart
        $addItemResult = CarretillaDao::insertCartItem(
            $cartId,
            $this->cart['pizza_id'],
            $this->cart['size_id'],
            $this->cart['quantity'],
            $this->cart['price']
        );

        if ($addItemResult) {
            Site::redirectToWithMsg("index.php?page=Gallery_Cart", "Pizza added to cart successfully.");
        } else {
            Site::redirectToWithMsg("index.php?page=Gallery_Gallery", "Error adding pizza to cart.");
        }
    }
}
