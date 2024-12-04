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
    private $modeDscArr = [
        "INS" => "Add to Cart",
        "DEL" => "Deleting %s (%s)",
        "DSP" => "Details for %s (%s)",
        "UPD" => "Updating %s (%s)"
    ];
    private $mode = '';

    private $pizza = [
        "id" => 0,
        "pizza_name" => '',
        "ingredients" => '',
        "description" => '',
        "image_url" => ''
    ];

    private $pizzaSizes = [
        
    ];
    
    public function run():void {
        $this->initForm();
        if($this->isPostBack()) {
            $this->loadFormData();

        }
        $this->generateViewData();
        Renderer::render('gallery\pizzadetails', $this->viewData);
    }

    private function initForm() {
        if(isset($_GET["mode"]) && isset($this->modeDscArr[$_GET["mode"]])) {
            $this->mode = $_GET["mode"];
        } else {
            Site::redirectToWithMsg("index.php?page=Gallery_Gallery", "Error");
            die();
        }
        if($this->mode !== 'INS' && isset($_GET["id"])) {
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
        $this->viewData["mode"] = $this->mode;
        $this->viewData["mode_dsc"] = sprintf(
            $this->modeDscArr[$this->mode], 
            $this->pizza["pizza_name"], 
            $this->pizza["id"]
        );
        $this->viewData["pizza"] = $this->pizza;
        $this->viewData["pizzaSizes"] = $this->pizzaSizes;

        /*echo '<pre>';
        print_r($this->viewData);
        echo '</pre>';*/
    }
    private function loadFormData() {
        $this->pizza["pizza_name"] = $_POST["pizza_name"];
        $this->pizza["ingredients"] = $_POST["ingredients"];
        $this->pizza["description"] = $_POST["description"];
        $this->pizza["image_url"] = $_POST["image_url"];
    }
    /*private function onAction() {
        switch ($this->mode) {
            case 'INS':
                $result = CarretillaDao::insertPizza($this->)
                # code...
                break;
            
            default:
                # code...
                break;
        }
    }*/
}