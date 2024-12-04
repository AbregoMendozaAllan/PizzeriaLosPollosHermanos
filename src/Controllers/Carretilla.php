<?php
namespace Controllers;

use Dao\Carretilla as CarretillaDao;

/**
 * Carretilla Controller Class
 *
 * This controller handles requests related to the shopping cart.
 */
class Carretilla extends PublicController
{
    private $viewData = [];

    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct();
        $this->viewData = [
            "cartItems" => [],
            "cartEmpty" => true,
            "error" => "",
        ];
    }

    /**
     * Main function to run the controller logic.
     */
    public function run(): void
    {
        try {
            $usercod = \Utilities\Security::getUserId();
            $isAnon = empty($usercod);

            // Check if the user is anonymous or registered
            $cartId = $isAnon ? $_SESSION['anon_cart_id'] ?? null : $_SESSION['user_cart_id'] ?? null;

            if ($cartId) {
                $cartItems = $isAnon 
                    ? CarretillaDao::getCartItemsAnon($cartId) 
                    : CarretillaDao::getCartItems($cartId);

                $this->viewData["cartItems"] = $cartItems;
                $this->viewData["cartEmpty"] = empty($cartItems);
            } else {
                $this->viewData["error"] = "No cart found.";
            }
        } catch (\Exception $ex) {
            $this->viewData["error"] = "An error occurred while retrieving the cart: " . $ex->getMessage();
        }

        // Render the view using Renderer
        \Views\Renderer::render("carretilla/carretilla", $this->viewData);
    }
}
