<style>
    h1 {
        text-align: center;
        font-size: 24px;
        margin-bottom: 20px;
    }

    .user-management-container {
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .filter-form {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 20px;
    }

    .filter-form label {
        font-size: 14px;
        font-weight: bold;
        margin-right: 10px;
        padding-left: 10px;
    }

    .filter-form input,
    .filter-form select {
        padding: 8px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 4px;
        flex: 1;
        max-width: 200px;
    }

    .filter-form button {
        padding: 10px 20px;
        font-size: 14px;
        color: #fff;
        background-color: #007bff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.2s ease;
        margin-left: 10px;
    }

    .filter-form button:hover {
        background-color: #0056b3;
    }

    .user-list table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .user-list th,
    .user-list td {
        text-align: left;
        padding: 10px;
        border-bottom: 1px solid #eee;
    }

    .user-list th {
        font-size: 14px;
        text-transform: uppercase;
        background-color: #f4f4f4;
        color: #555;
    }

    .user-list td {
        font-size: 14px;
    }

    .user-list tr:hover td {
        background-color: #f9f9f9;
    }

    .user-list .link {
        color: #007bff;
        text-decoration: none;
        transition: color 0.2s ease;
    }

    .user-list .link:hover {
        color: #0056b3;
    }

    .user-list a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }

    .user-list a:hover {
        text-decoration: underline;
    }

    .user-list td.center {
        text-align: center;
    }

    .add-button {
        display: inline-block;
        margin-top: 10px;
        color: #333;
        background-color: #fff;
        padding: 8px 15px;
        border-radius: 4px;
        border: 2px solid #28a745;
        text-decoration: none;
        font-size: 14px;
        font-weight: bold;
        transition: all 0.2s ease;
        text-align: center;
    }

    .add-button:hover {
        background-color: #28a745;
        color: #fff;
    }
</style>

<div class="user-management-container">
    <h1>Gestión de Usuarios</h1>
    <section class="filter-form">
        <form action="index.php" method="get">
            <input type="hidden" name="page" value="Users_Users">
            <label for="partialName">Nombre:</label>
            <input type="text" name="partialName" id="partialName" value="{{partialName}}" />

            <label for="status">Estado:</label>
            <select name="status" id="status">
                <option value="EMP" {{status_EMP}}>Todos</option>
                <option value="ACT" {{status_ACT}}>Activo</option>
                <option value="INA" {{status_INA}}>Inactivo</option>
            </select>

            <button type="submit">Filtrar</button>
        </form>
    </section>
    <section class="user-list">
        <table>
            <thead>
                <tr>
                    <th>
                        {{ifnot OrderByUsercod}}
                        <a href="index.php?page=Users_Users&orderBy=usercod&orderDescending=0">Código <i class="fas fa-sort"></i></a>
                        {{endifnot OrderByUsercod}}
                        {{if OrderUsercodDesc}}
                        <a href="index.php?page=Users_Users&orderBy=clear&orderDescending=0">Código <i class="fas fa-sort-down"></i></a>
                        {{endif OrderUsercodDesc}}
                        {{if OrderUsercod}}
                        <a href="index.php?page=Users_Users&orderBy=usercod&orderDescending=1">Código <i class="fas fa-sort-up"></i></a>
                        {{endif OrderUsercod}}
                    </th>
                    <th class="left">
                        {{ifnot OrderByUsername}}
                        <a href="index.php?page=Users_Users&orderBy=username&orderDescending=0">Nombre <i class="fas fa-sort"></i></a>
                        {{endifnot OrderByUsername}}
                        {{if OrderUsernameDesc}}
                        <a href="index.php?page=Users_Users&orderBy=clear&orderDescending=0">Nombre <i class="fas fa-sort-down"></i></a>
                        {{endif OrderUsernameDesc}}
                        {{if OrderUsername}}
                        <a href="index.php?page=Users_Users&orderBy=username&orderDescending=1">Nombre <i class="fas fa-sort-up"></i></a>
                        {{endif OrderUsername}}
                    </th>
                    <th>
                        {{ifnot OrderByUseremail}}
                        <a href="index.php?page=Users_Users&orderBy=useremail&orderDescending=0">Correo Electrónico <i class="fas fa-sort"></i></a>
                        {{endifnot OrderByUseremail}}
                        {{if OrderUseremailDesc}}
                        <a href="index.php?page=Users_Users&orderBy=clear&orderDescending=0">Correo Electrónico <i class="fas fa-sort-down"></i></a>
                        {{endif OrderUseremailDesc}}
                        {{if OrderUseremail}}
                        <a href="index.php?page=Users_Users&orderBy=useremail&orderDescending=1">Correo Electrónico <i class="fas fa-sort-up"></i></a>
                        {{endif OrderUseremail}}
                    </th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                {{foreach users}}
                <tr>
                    <td>{{usercod}}</td>
                    <td><a class="link" href="index.php?page=Users_User&mode=DSP&usercod={{usercod}}">{{username}}</a></td>
                    <td>{{useremail}}</td>
                    <td class="center">{{userStatusDsc}}</td>
                    <td class="center">
                        <a href="index.php?page=Users_User&mode=UPD&usercod={{usercod}}">Editar</a>
                        &nbsp;|&nbsp;
                        <a href="index.php?page=Users_User&mode=DEL&usercod={{usercod}}">Eliminar</a>
                    </td>
                </tr>
                {{endfor users}}
            </tbody>
        </table>
    </section>
    <div class="add-user-container">
        <a href="index.php?page=Users_User&mode=INS" class="add-button">Nuevo Usuario</a>
    </div>
    <div class="pagination-container">
        {{pagination}}
    </div>
</div>
