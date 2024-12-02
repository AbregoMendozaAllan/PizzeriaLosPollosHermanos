<section class="container-m row px-4 py-4">
    <h1>{{FormTitle}}</h1>
</section>
<section class="container-m row px-4 py-4">
    {{with usuario}}
    <form action="index.php?page=Users_User&mode={{~mode}}&usercod={{usercod}}" method="POST"
        class="col-12 col-m-8 offset-m-2">
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="usercodD">Código</label>
            <input class="col-12 col-m-9" readonly disabled type="text" name="usercodD" id="usercodD"
                placeholder="Código" value="{{usercod}}" />
            <input type="hidden" name="mode" value="{{~mode}}" />
            <input type="hidden" name="usercod" value="{{usercod}}" />
            <input type="hidden" name="token" value="{{~user_xss_token}}" />
        </div>
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="useremail">Correo Electrónico</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="useremail" id="useremail"
                placeholder="Correo Electrónico" value="{{useremail}}" />
            {{if useremail_error}}
            <div class="col-12 col-m-9 offset-m-3 error">
                {{useremail_error}}
            </div>
            {{endif useremail_error}}
        </div>
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="username">Nombre de Usuario</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="username" id="username"
                placeholder="Nombre de Usuario" value="{{username}}" />
            {{if username_error}}
            <div class="col-12 col-m-9 offset-m-3 error">
                {{username_error}}
            </div>
            {{endif username_error}}
        </div>
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userpswd">Contraseña</label>
            <input class="col-12 col-m-9" {{~readonly}} type="password" name="userpswd" id="userpswd"
                placeholder="Contraseña" value="{{userpswd}}" />
            {{if userpswd_error}}
            <div class="col-12 col-m-9 offset-m-3 error">
                {{userpswd_error}}
            </div>
            {{endif userpswd_error}}
        </div>
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userfching">Fecha de Ingreso</label>
            <input class="col-12 col-m-9" {{~readonly}} type="datetime-local" name="userfching" id="userfching"
                placeholder="Fecha de Ingreso" value="{{userfching}}" />
        </div>
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="userest">Estado</label>
            <select name="userest" id="userest" class="col-12 col-m-9" {{if ~readonly}} readonly disabled
                {{endif ~readonly}}>
                <option value="ACT" {{userest_act}}>Activo</option>
                <option value="INA" {{userest_ina}}>Inactivo</option>
            </select>
        </div>
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="usertipo">Tipo de Usuario</label>
            <select name="usertipo" id="usertipo" class="col-12 col-m-9" {{if ~readonly}} readonly disabled
                {{endif ~readonly}}>
                <option value="CLI" {{usertipo_cli}}>Cliente</option>
                <option value="ADM" {{usertipo_con}}>Administrador</option>
            </select>
        </div>
        {{endwith usuario}}
        <div class="row my-4 align-center flex-end">
            {{if showCommitBtn}}
            <button class="primary col-12 col-m-2" type="submit" name="btnConfirmar">Confirmar</button>
            &nbsp;
            {{endif showCommitBtn}}
            <button class="col-12 col-m-2" type="button" id="btnCancelar">
                {{if showCommitBtn}}
                Cancelar
                {{endif showCommitBtn}}
                {{ifnot showCommitBtn}}
                Regresar
                {{endifnot showCommitBtn}}
            </button>
        </div>
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