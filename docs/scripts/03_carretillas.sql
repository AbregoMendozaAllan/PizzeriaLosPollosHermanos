CREATE TABLE carretilla (
    carretilla_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
    usercod BIGINT(10) NOT NULL,
    pizza_id INT NOT NULL,
    size_id CHAR(2) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    estado ENUM('pendiente', 'procesado', 'cancelado') NOT NULL DEFAULT 'pendiente',
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usercod) REFERENCES usuario(usercod),
    FOREIGN KEY (pizza_id, size_id) REFERENCES pizza_size_mapping(pizza_id, size_id)
);

CREATE TABLE detalle_carrito (
    detalle_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    carretilla_id BIGINT NOT NULL, 
    ingrediente_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (carretilla_id) REFERENCES carretilla(carretilla_id),
    FOREIGN KEY (ingrediente_id) REFERENCES ingredientes(ingrediente_id)
);