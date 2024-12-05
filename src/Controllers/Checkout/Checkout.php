<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Controllers\PublicController;

class Checkout extends PrivateController
{
    public function run(): void
    {
        $viewData = [];

        if ($this->isPostBack()) {
            $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                "id" . (time() - 10000000),
                "http://localhost:8080/nw/PizzeriaLosPollosHermanos/index.php?page=Checkout_Error",
                "http://localhost:8080/nw/PizzeriaLosPollosHermanos/index.php?page=Checkout_Accept"
            );

            // Cargar los items del carrito
            $paypalItems = $this->loadPayPalItems();

            // Agregar cada item al pedido de PayPal
            foreach ($paypalItems as $item) {
                $PayPalOrder->addItem(
                    $item['name'],
                    $item['description'],
                    $item['pizza_id,size_id'],
                    $item['price'],
                    $item['tax'],
                    $item['quantity'],
                    $item['category']
                );
            }

            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $PayPalRestApi->getAccessToken();
            $response = $PayPalRestApi->createOrder($PayPalOrder);

            $_SESSION["orderid"] = $response->id;
            foreach ($response->links as $link) {
                if ($link->rel == "approve") {
                    \Utilities\Site::redirectTo($link->href);
                }
            }
            die();
        }

        \Views\Renderer::render("paypal/checkout", $viewData);
    }

    private function loadPayPalItems(): array
    {
        // Obtener el carrito del usuario desde la sesión o cualquier fuente confiable
        $cartId = $_SESSION['cart_id'] ?? null;

        if (!$cartId) {
            return []; // Retornar vacío si no hay un carrito en la sesión
        }

        // Obtener todos los items del carrito desde el DAO
        $cartItems = \Dao\Carretilla\Carretilla::getCartItems($cartId);

        // Formatear los items para el pedido de PayPal
        $paypalItems = [];
        foreach ($cartItems as $item) {
            $paypalItems[] = [
                'name' => $item['pizza_name'],
                'description' => $item['description'] ?? '',
                'sku' => $item['pizza_id'] . ',' . $item['size_id'],
                'price' => $item['price'],
                'tax' => $item['price'] * 0.15, // Asumiendo que el 15% es el impuesto
                'quantity' => $item['quantity'],
                'category' => 'pizza'
            ];
        }

        return $paypalItems;
    }
}
