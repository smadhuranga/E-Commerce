-- Create the database
DROP DATABASE IF EXISTS ecommerce;

-- Create the database
CREATE DATABASE IF NOT EXISTS ecommerce;

USE ecommerce;

-- Create the categories table
CREATE TABLE categories (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(255) NOT NULL,
                            description VARCHAR(255) NOT NULL,
                            status ENUM('Active', 'Draft') NOT NULL DEFAULT 'Draft',
                            icon LONGBLOB NOT NULL
);

-- Create the products table
CREATE TABLE products (
                          itemCode INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          unitPrice DECIMAL(10, 2) NOT NULL,
                          description VARCHAR(255) NOT NULL,
                          qtyOnHand INT NOT NULL DEFAULT 0,
                          image LONGBLOB NOT NULL,
                          categoryId INT NOT NULL,
                          FOREIGN KEY (categoryId) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create the users table
CREATE TABLE users (
                       userId INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(255) NOT NULL UNIQUE,
                       email VARCHAR(255) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       role ENUM('Admin', 'Customer') NOT NULL DEFAULT 'Customer',
                       fullName VARCHAR(255),
                       address VARCHAR(255),
                       phoneNumber VARCHAR(255),
                       status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
                       date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       image LONGBLOB
);

-- Create the orders table
CREATE TABLE orders (
                        orderId VARCHAR(20) PRIMARY KEY,
                        date DATE NOT NULL,
                        userId INT NOT NULL,
                        address VARCHAR(255) NOT NULL,
                        city VARCHAR(255) NOT NULL,
                        state VARCHAR(255) NOT NULL,
                        zipCode VARCHAR(255) NOT NULL,
                        status ENUM('Pending', 'Compeleted') NOT NULL DEFAULT 'Pending',
                        subTotal DECIMAL(10, 2) NOT NULL,
                        shipingCost DECIMAL(10, 2) NOT NULL,
                        paymentMethod ENUM('COD', 'Card') NOT NULL DEFAULT 'Card',
                        FOREIGN KEY (userId) REFERENCES users(userId) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create the order_details table
CREATE TABLE order_details (
                               orderId VARCHAR(20) NOT NULL,
                               itemCode INT NOT NULL,
                               quantity INT NOT NULL,
                               FOREIGN KEY (orderId) REFERENCES orders(orderId) ON UPDATE CASCADE ON DELETE CASCADE,
                               FOREIGN KEY (itemCode) REFERENCES products(itemCode) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create the cart table
CREATE TABLE cart (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      userId INT NOT NULL,
                      FOREIGN KEY (userId) REFERENCES users(userId) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create the cart_details table
CREATE TABLE cart_details (
                              cartId INT NOT NULL,
                              itemCode INT NOT NULL,
                              quantity INT NOT NULL,
                              FOREIGN KEY (itemCode) REFERENCES products(itemCode) ON UPDATE CASCADE ON DELETE CASCADE,
                              FOREIGN KEY (cartId) REFERENCES cart(id) ON UPDATE CASCADE ON DELETE CASCADE
);