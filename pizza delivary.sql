-- PostgreSQL script to create the 'user' and 'orders' tables for the pizza delivery database

-- Set up the database
CREATE DATABASE pizza_delivery;

\c pizza_delivery;

-- Create the 'user' table
CREATE TABLE public."user" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(25) UNIQUE NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    password TEXT,
    is_staff BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT FALSE
);

-- Create the 'orders' table
CREATE TABLE public.orders (
    id SERIAL PRIMARY KEY,
    quantity INTEGER NOT NULL,
    order_status VARCHAR(20) DEFAULT 'PENDING' CHECK (order_status IN ('PENDING', 'IN-TRANSIT', 'DELIVERED')),
    pizza_size VARCHAR(20) DEFAULT 'SMALL' CHECK (pizza_size IN ('SMALL', 'MEDIUM', 'LARGE', 'EXTRA-LARGE')),
    user_id INTEGER NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."user" (id) ON DELETE CASCADE
);

-- Insert sample data (optional)
INSERT INTO public."user" (username, email, password, is_staff, is_active)
VALUES ('admin', 'admin@example.com', 'securepassword', TRUE, TRUE);

INSERT INTO public.orders (quantity, order_status, pizza_size, user_id)
VALUES (2, 'PENDING', 'LARGE', 1);
