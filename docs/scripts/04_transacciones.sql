CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usercod BIGINT(10),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (usercod) REFERENCES usuario(usercod)
);

CREATE TABLE transaction_details (
    transaction_id INT,
    pizza_id INT,
    size_id CHAR(2),
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (transaction_id, pizza_id, size_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(id),
    FOREIGN KEY (pizza_id) REFERENCES pizza_size_mapping(pizza_id),
    FOREIGN KEY (size_id) REFERENCES pizza_size_mapping(size_id)
);
