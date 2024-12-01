-- Table for Registered Users' Cart
CREATE TABLE cart (
    cart_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usercod BIGINT(10) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usercod) REFERENCES usuario(usercod)
);

-- Table for Anonymous Users' Cart
CREATE TABLE cart_anon (
    cart_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    anoncod VARCHAR(128) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table for Registered Users' Cart Items
CREATE TABLE cart_items (
    item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    pizza_id INT NOT NULL,
    size_id CHAR(2) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (pizza_id, size_id) REFERENCES pizza_size_mapping(pizza_id, size_id)
);

-- Table for Anonymous Users' Cart Items
CREATE TABLE cart_items_anon (
    item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    pizza_id INT NOT NULL,
    size_id CHAR(2) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES cart_anon(cart_id),
    FOREIGN KEY (pizza_id, size_id) REFERENCES pizza_size_mapping(pizza_id, size_id)
);

INSERT INTO cart (usercod, created_at)
VALUES
(1, NOW());

INSERT INTO cart_anon (anoncod, created_at)
VALUES
('anon1234', NOW());

INSERT INTO cart_items (cart_id, pizza_id, size_id, quantity, price, added_at)
VALUES
(1, 1, 'SM', 2, 8.99, NOW()),  -- 2 Cheese Pizzas (Small)
(1, 2, 'MD', 1, 13.99, NOW()); -- 1 Meat Lover's Pizza (Medium)

INSERT INTO cart_items_anon (cart_id, pizza_id, size_id, quantity, price, added_at)
VALUES
(1, 3, 'LG', 1, 13.99, NOW()),  -- 1 Pepperoni Pizza (Large)
(1, 4, 'SM', 1, 10.99, NOW()); -- 1 Hawaiian Pizza (Small)
