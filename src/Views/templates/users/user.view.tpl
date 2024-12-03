<style>
  .form-container {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #fff;
  }

  .form-title {
    font-size: 24px;
    margin-bottom: 20px;
    text-align: center;
    color: #333;
  }

  .form-row {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
  }

  .form-label {
    font-weight: bold;
    margin-bottom: 8px;
    color: #555;
  }

  .form-input {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
    transition: border-color 0.3s ease;
  }

  .form-input:focus {
    border-color: #007bff;
    outline: none;
  }

  .form-select {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
    transition: border-color 0.3s ease;
  }

  .form-select:focus {
    border-color: #007bff;
    outline: none;
  }

  .error-message {
    color: #d9534f;
    font-size: 14px;
    margin-top: 4px;
  }

  .button-row {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
  }

  .primary-button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  .primary-button:hover {
    background-color: #0056b3;
  }

  .secondary-button {
    background-color: #6c757d;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  .secondary-button:hover {
    background-color: #5a6268;
  }
</style>

<section class="form-container">
    <h1 class="form-title">{{FormTitle}}</h1>
    {{with usuario}}
    <form action="index.php?page=Users_User&mode={{~mode}}&usercod={{usercod}}" method="POST">
        <div class="form-row">
            <label class="form-label" for="usercodD">Código</label>
            <input class="form-input" readonly disabled type="text" name="usercodD" id="usercodD"
                placeholder="Código" value="{{usercod}}" />
            <input type="hidden" name="mode" value="{{~mode}}" />
            <input type="hidden" name="usercod" value="{{usercod}}" />
            <input type="hidden" name="token" value="{{~user_xss_token}}" />
        </div>
        <div class="form-row">
            <label class="form-label" for="useremail">Correo Electrónico</label>
            <input class="form-input" {{~readonly}} type="text" name="useremail" id="useremail"
                placeholder="Correo Electrónico" value="{{useremail}}" />
            {{if useremail_error}}
            <div class="error-message">
                {{useremail_error}}
            </div>
            {{endif useremail_error}}
        </div>
        <div class="form-row">
            <label class="form-label" for="username">Nombre de Usuario</label>
            <input class="form-input" {{~readonly}} type="text" name="username" id="username"
                placeholder="Nombre de Usuario" value="{{username}}" />
            {{if username_error}}
            <div class="error-message">
                {{username_error}}
            </div>
            {{endif username_error}}
        </div>
        <div class="form-row">
            <label class="form-label" for="userpswd">Contraseña</label>
            <input class="form-input" {{~readonly}} type="password" name="userpswd" id="userpswd"
                placeholder="Contraseña" value="{{userpswd}}" />
            {{if userpswd_error}}
            <div class="error-message">
                {{userpswd_error}}
            </div>
            {{endif userpswd_error}}
        </div>
        <div class="form-row">
            <label class="form-label" for="userfching">Fecha de Ingreso</label>
            <input class="form-input" {{~readonly}} type="datetime-local" name="userfching" id="userfching"
                placeholder="Fecha de Ingreso" value="{{userfching}}" />
        </div>
        <div class="form-row">
            <label class="form-label" for="userest">Estado</label>
            <select name="userest" id="userest" class="form-select" {{if ~readonly}} readonly disabled
                {{endif ~readonly}}>
                <option value="ACT" {{userest_act}}>Activo</option>
                <option value="INA" {{userest_ina}}>Inactivo</option>
            </select>
        </div>
        <div class="form-row">
            <label class="form-label" for="usertipo">Tipo de Usuario</label>
            <select name="usertipo" id="usertipo" class="form-select" {{if ~readonly}} readonly disabled
                {{endif ~readonly}}>
                <option value="CLI" {{usertipo_cli}}>Cliente</option>
                <option value="ADM" {{usertipo_con}}>Administrador</option>
            </select>
        </div>
        {{endwith usuario}}
        <div class="button-row">
            {{if showCommitBtn}}
            <button class="primary-button" type="submit" name="btnConfirmar">Confirmar</button>
            {{endif showCommitBtn}}
            <button class="secondary-button" type="button" id="btnCancelar">
                {{if showCommitBtn}}
                Cancelar
                {{endif showCommitBtn}}
                {{ifnot showCommitBtn}}
                Regresar
                {{endifnot showCommitBtn}}
            </button>
        </div>
    </form>
</section>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const btnCancelar = document.getElementById("btnCancelar");
        btnCancelar.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Users_Users");
        });
    });
</script>
