CREATE TABLE carretilla (
    usercod BIGINT(10) NOT NULL,
    pizza_id INT NOT NULL,
    size_id CHAR(2) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (usercod, pizza_id, size_id),
    FOREIGN KEY (usercod) REFERENCES usuario(usercod),
    FOREIGN KEY (pizza_id, size_id) REFERENCES pizza_size_mapping(pizza_id, size_id)
);

CREATE TABLE carretillaanon (
    anoncod VARCHAR(128) NOT NULL,
    pizza_id INT NOT NULL,
    size_id CHAR(2) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (anoncod, pizza_id, size_id),
    FOREIGN KEY (pizza_id, size_id) REFERENCES pizza_size_mapping(pizza_id, size_id)
);