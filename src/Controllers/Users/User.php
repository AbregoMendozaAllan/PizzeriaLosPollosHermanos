<?php

namespace Controllers\Users;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Users\Users as UsersDao;
use Utilities\Site;
use Utilities\Validators;

class User extends PublicController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de %s %s",
        "INS" => "Nuevo Usuario",
        "UPD" => "Editar %s %s",
        "DEL" => "Eliminar %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $usuario = [
        "usercod" => 0,
        "useremail" => "",
        "username" => "",
        "userpswd" => "",
        "userfching" => "",
        "userpswdest" => "",
        "userpswdexp" => "",
        "userest" => "",
        "useractcod" => "",
        "userpswdchg" => "",
        "usertipo" => ""
    ];
    private $user_xss_token = "";

    public function run(): void
    {
        try {
            $this->getData();
            if ($this->isPostBack()) {
                if ($this->validateData()) {
                    $this->handlePostAction();
                }
            }
            $this->setViewData();
            Renderer::render("users/user", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Users_Users",
                $ex->getMessage()
            );
        }
    }

    private function getData(): void
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $this->readonly = $this->mode === "DEL" ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $this->usuario = UsersDao::getUserById(intval($_GET["usercod"]));
                if (!$this->usuario) {
                    throw new \Exception("No se encontró el Usuario", 1);
                }
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad inválida", 1);
        }
    }

    private function validateData(): bool
    {
        $errors = [];
        $this->user_xss_token = $_POST["user_xss_token"] ?? "";
        $this->usuario["usercod"] = intval($_POST["usercod"] ?? "");
        $this->usuario["useremail"] = strval($_POST["useremail"] ?? "");
        $this->usuario["username"] = strval($_POST["username"] ?? "");
        $this->usuario["userpswd"] = strval($_POST["userpswd"] ?? "");
        $this->usuario["userfching"] = strval($_POST["userfching"] ?? "");
        $this->usuario["userpswdest"] = strval($_POST["userpswdest"] ?? "");
        $this->usuario["userpswdexp"] = strval($_POST["userpswdexp"] ?? "");
        $this->usuario["userest"] = strval($_POST["userest"] ?? "");
        $this->usuario["useractcod"] = strval($_POST["useractcod"] ?? "");
        $this->usuario["userpswdchg"] = strval($_POST["userpswdchg"] ?? "");
        $this->usuario["usertipo"] = strval($_POST["usertipo"] ?? "");

        if (Validators::IsEmpty($this->usuario["useremail"])) {
            $errors["useremail_error"] = "El correo electrónico es requerido";
        }

        if (Validators::IsEmpty($this->usuario["username"])) {
            $errors["username_error"] = "El nombre de usuario es requerido";
        }

        if (Validators::IsEmpty($this->usuario["userpswd"])) {
            $errors["userpswd_error"] = "La contraseña es requerida";
        }

        if (!in_array($this->usuario["userest"], ["ACT", "INA"])) {
            $errors["userest_error"] = "El estado del usuario es inválido";
        }

        if (count($errors) > 0) {
            foreach ($errors as $key => $value) {
                $this->usuario[$key] = $value;
            }
            return false;
        }
        return true;
    }

    private function handlePostAction(): void
    {
        switch ($this->mode) {
            case "INS":
                $this->handleInsert();
                break;
            case "UPD":
                $this->handleUpdate();
                break;
            case "DEL":
                $this->handleDelete();
                break;
            default:
                throw new \Exception("Modo inválido", 1);
                break;
        }
    }

    private function handleInsert(): void
    {
        $result = UsersDao::insertUser(
            $this->usuario["useremail"],
            $this->usuario["username"],
            //$this->usuario["userpswd"],
            $_POST["userpswd"] ?? "",
            $this->usuario["userfching"],
            $this->usuario["userpswdest"],
            $this->usuario["userpswdexp"],
            $this->usuario["userest"],
            $this->usuario["useractcod"],
            $this->usuario["userpswdchg"],
            $this->usuario["usertipo"]
        );
        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Users_Users",
                "Usuario creado exitosamente"
            );
        }
    }

    private function handleUpdate(): void
    {
        $result = UsersDao::updateUser(
            $this->usuario["usercod"],
            $this->usuario["useremail"],
            $this->usuario["username"],
            $this->usuario["userpswd"],
            $this->usuario["userfching"],
            $this->usuario["userpswdest"],
            $this->usuario["userpswdexp"],
            $this->usuario["userest"],
            $this->usuario["useractcod"],
            $this->usuario["userpswdchg"],
            $this->usuario["usertipo"]
        );
        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Users_Users",
                "Usuario actualizado exitosamente"
            );
        }
    }

    private function handleDelete(): void
    {
        $result = UsersDao::deleteUser($this->usuario["usercod"]);
        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Users_Users",
                "Usuario eliminado exitosamente"
            );
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["user_xss_token"] = $this->user_xss_token;
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->usuario["usercod"],
            $this->usuario["username"]
        );
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;

        $userestKey = "userest_" . strtolower($this->usuario["userest"]);
        $this->usuario[$userestKey] = "selected";

        $this->viewData["usuario"] = $this->usuario;
    }
}
