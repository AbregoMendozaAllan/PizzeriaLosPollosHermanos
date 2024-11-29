CREATE TABLE pizzas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pizza_name VARCHAR(100) NOT NULL,
    ingredients TEXT,
    description TEXT
);

CREATE TABLE pizza_sizes (
    id CHAR(2) PRIMARY KEY, 
    size VARCHAR(20)
);

CREATE TABLE pizza_size_mapping (
    pizza_id INT,
    size_id CHAR(2),
    price DECIMAL(10,2),
    PRIMARY KEY (pizza_id, size_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(id),
    FOREIGN KEY (size_id) REFERENCES pizza_sizes(id)
);

