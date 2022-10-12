CREATE DATABASE grobdb;
\c grobdb
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(50),
    pwd VARCHAR(40),
    credits NUMERIC,
    wins INTEGER,
    defeats INTEGER,
    draw INTEGER
);
CREATE TABLE boards(
    id SERIAL PRIMARY KEY,
    player INTEGER REFERENCES users(id),
    color VARCHAR(10),
    config TEXT,
    history TEXT,
    startDate DATE,
    level INTEGER,
    win BOOLEAN
  
);