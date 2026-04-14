-- Drop existing tables and types if they exist
DROP TYPE IF EXISTS photo_state CASCADE;
DROP TABLE IF EXISTS photos CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create enum for photo states
CREATE TYPE photo_state AS ENUM ('booked', 'sold', 'available');

-- Create users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(60) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    verified TIMESTAMP DEFAULT NULL,
    admin SMALLINT NOT NULL DEFAULT 0,
    collaborator SMALLINT NOT NULL DEFAULT 0
);

-- Create sessions table
CREATE TABLE sessions (
    session_id SERIAL PRIMARY KEY,
    token varchar(44) NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires TIMESTAMPTZ NOT NULL DEFAULT NOW() + interval '7 days',
    user_id INT NOT NULL REFERENCES users(id)
);

-- Create products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    available INT NOT NULL,
    booked INT NOT NULL,
    sold INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL
);

-- Create photos table
CREATE TABLE photos (
    photo_id SERIAL PRIMARY KEY,
    path VARCHAR(255) UNIQUE NOT NULL,
    title VARCHAR(100) UNIQUE NOT NULL,
    original_title VARCHAR(100) UNIQUE NOT NULL,
    year SMALLINT NOT NULL,
    place VARCHAR(100) NOT NULL,
    description TEXT,
    state photo_state NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    booked_by INT REFERENCES users(id)
);