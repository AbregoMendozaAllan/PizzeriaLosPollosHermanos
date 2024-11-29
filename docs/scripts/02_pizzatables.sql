CREATE TABLE pizzas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pizza_name VARCHAR(100) NOT NULL,
    ingredients TEXT,
    description TEXT,
    image_url VARCHAR(255)
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

INSERT INTO pizzas (pizza_name, ingredients, description, image_url) VALUES
('Cheese Pizza', 'Tomato, Mozzarella, Cheddar', 'A simple pizza with a blend of mozzarella and cheddar cheeses on a tomato sauce base.', 'public\imgs\pizzas\Cheese.jpeg'),
('Meat Lover\'s', 'Tomato, Mozzarella, Pepperoni, Sausage, Bacon, Ham', 'A hearty pizza loaded with a variety of meats including pepperoni, sausage, bacon, and ham.', 'public\imgs\pizzas\MeatLover.jpeg'),
('Pepperoni Pizza', 'Tomato, Mozzarella, Pepperoni', 'A classic pizza topped with pepperoni slices, mozzarella cheese, and tomato sauce.', 'public\imgs\pizzas\Pepperoni.jpeg'),
('Hawaiian Pizza', 'Tomato, Mozzarella, Ham, Pineapple', 'A tropical pizza with ham and pineapple, a perfect combination of sweet and savory.', 'public\imgs\pizzas\Hawaiian.jpeg');

INSERT INTO pizza_sizes (id, size) VALUES
('SM', 'Small'),
('MD', 'Medium'),
('LG', 'Large');

INSERT INTO pizza_size_mapping (pizza_id, size_id, price) VALUES
(1, 'SM', 8.99),  -- Cheese Pizza - Small
(1, 'MD', 10.99), -- Cheese Pizza - Medium
(1, 'LG', 12.99), -- Cheese Pizza - Large

(2, 'SM', 11.99),  -- Meat Lover's - Small
(2, 'MD', 13.99),  -- Meat Lover's - Medium
(2, 'LG', 15.99),  -- Meat Lover's - Large

(3, 'SM', 9.99),  -- Pepperoni Pizza - Small
(3, 'MD', 11.99), -- Pepperoni Pizza - Medium
(3, 'LG', 13.99), -- Pepperoni Pizza - Large

(4, 'SM', 10.99), -- Hawaiian Pizza - Small
(4, 'MD', 12.99), -- Hawaiian Pizza - Medium
(4, 'LG', 14.99); -- Hawaiian Pizza - Large
