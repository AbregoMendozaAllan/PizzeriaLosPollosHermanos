<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Controllers\PublicController;

class Checkout extends PrivateController
{
    public function run(): void
    {
        /*
        1) Mostrar el listado de productos a facturar y los detalles y totales de la proforma.
        2) Al dar click en Pagar
            2.1) Crear una orden de Paypal con los productos de la proforma.
            2.2) Redirigir al usuario a la página de Paypal para que complete el pago.
        */
        $viewData = array();
        if ($this->isPostBack()) {
            $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                "test" . (time() - 10000000),
                "http://localhost:8080/mvc202403/index.php?page=Checkout_Error",
                "http://localhost:8080/mvc202403/index.php?page=Checkout_Accept"
            );

            $PayPalOrder->addItem("Test", "TestItem1", "PRD1", 100, 15, 1, "DIGITAL_GOODS"); //115
            $PayPalOrder->addItem("Test 2", "TestItem2", "PRD2", 50, 7.5, 2, "DIGITAL_GOODS"); // 115
            // Total: 230

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
}
