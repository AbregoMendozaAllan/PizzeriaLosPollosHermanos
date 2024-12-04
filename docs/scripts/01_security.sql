CREATE TABLE
    `usuario` (
        `usercod` bigint(10) NOT NULL AUTO_INCREMENT,
        `useremail` varchar(80) DEFAULT NULL,
        `username` varchar(80) DEFAULT NULL,
        `userpswd` varchar(128) DEFAULT NULL,
        `userfching` datetime DEFAULT NULL,
        `userpswdest` char(3) DEFAULT NULL,
        `userpswdexp` datetime DEFAULT NULL,
        `userest` char(3) DEFAULT NULL,
        `useractcod` varchar(128) DEFAULT NULL,
        `userpswdchg` varchar(128) DEFAULT NULL,
        `usertipo` char(3) DEFAULT NULL COMMENT 'Tipo de Usuario, Normal, Consultor o Cliente',
        PRIMARY KEY (`usercod`),
        UNIQUE KEY `useremail_UNIQUE` (`useremail`),
        KEY `usertipo` (
            `usertipo`,
            `useremail`,
            `usercod`,
            `userest`
        )
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE
    `roles` (
        `rolescod` varchar(128) NOT NULL,
        `rolesdsc` varchar(45) DEFAULT NULL,
        `rolesest` char(3) DEFAULT NULL,
        PRIMARY KEY (`rolescod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `roles_usuarios` (
        `usercod` bigint(10) NOT NULL,
        `rolescod` varchar(128) NOT NULL,
        `roleuserest` char(3) DEFAULT NULL,
        `roleuserfch` datetime DEFAULT NULL,
        `roleuserexp` datetime DEFAULT NULL,
        PRIMARY KEY (`usercod`, `rolescod`),
        KEY `rol_usuario_key_idx` (`rolescod`),
        CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `funciones` (
        `fncod` varchar(255) NOT NULL,
        `fndsc` varchar(255) DEFAULT NULL,
        `fnest` char(3) DEFAULT NULL,
        `fntyp` char(3) DEFAULT NULL,
        PRIMARY KEY (`fncod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `funciones_roles` (
        `rolescod` varchar(128) NOT NULL,
        `fncod` varchar(255) NOT NULL,
        `fnrolest` char(3) DEFAULT NULL,
        `fnexp` datetime DEFAULT NULL,
        PRIMARY KEY (`rolescod`, `fncod`),
        KEY `rol_funcion_key_idx` (`fncod`),
        CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `bitacora` (
        `bitacoracod` int(11) NOT NULL AUTO_INCREMENT,
        `bitacorafch` datetime DEFAULT NULL,
        `bitprograma` varchar(255) DEFAULT NULL,
        `bitdescripcion` varchar(255) DEFAULT NULL,
        `bitobservacion` mediumtext,
        `bitTipo` char(3) DEFAULT NULL,
        `bitusuario` bigint(18) DEFAULT NULL,
        PRIMARY KEY (`bitacoracod`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8;


INSERT INTO `usuario` 
    (useremail, username, userpswd, userfching, userpswdest, userpswdexp, userest, useractcod, userpswdchg, usertipo)
VALUES 
    ('user@example.com', 'Test User', 'password123', NOW(), 'YES', NOW(), 'ACT', 'activation_code', 'password_change_code', 'NOR'),
    ('consultant@example.com', 'Consultant User', 'password456', NOW(), 'YES', NOW(), 'ACT', 'activation_code', 'password_change_code', 'CON'),
    ('client@example.com', 'Client User', 'password789', NOW(), 'YES', NOW(), 'ACT', 'activation_code', 'password_change_code', 'CLI');


INSERT INTO `roles` (rolescod, rolesdsc, rolesest)
VALUES
    ('ADMIN', 'Administrator Role', 'ACT'),
    ('USER', 'Regular User Role', 'ACT'),
    ('MOD', 'Moderator Role', 'ACT');


INSERT INTO `roles_usuarios` (usercod, rolescod, roleuserest, roleuserfch, roleuserexp)
VALUES
    (1, 'ADMIN', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR)),  -- User 1 as ADMIN
    (2, 'USER', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR)),   -- User 2 as regular USER
    (3, 'MOD', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));    -- User 3 as MODERATOR


INSERT INTO `funciones` (fncod, fndsc, fnest, fntyp)
VALUES
    ('VIEW', 'View Access', 'ACT', 'REG'),
    ('EDIT', 'Edit Access', 'ACT', 'MOD'),
    ('DELETE', 'Delete Access', 'ACT', 'ADM');


INSERT INTO `funciones_roles` (rolescod, fncod, fnrolest, fnexp)
VALUES
    ('ADMIN', 'VIEW', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
    ('USER', 'VIEW', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
    ('MOD', 'EDIT', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
    ('ADMIN', 'DELETE', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO `bitacora` (bitacorafch, bitprograma, bitdescripcion, bitobservacion, bitTipo, bitusuario)
VALUES
    (NOW(), 'System', 'User login attempt', 'Successful login for user 1', 'INF', 1),
    (NOW(), 'System', 'Password Change', 'User 2 changed their password', 'INF', 2),
    (NOW(), 'Admin Panel', 'Role assignment', 'Assigned MOD role to user 3', 'ADM', 3);
