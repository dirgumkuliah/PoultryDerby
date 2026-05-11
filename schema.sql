-- Poultry Derby Database Schema

CREATE DATABASE IF NOT EXISTS poultry_derby;
USE poultry_derby;

-- User Accounts and Currency
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    gacha_currency INT DEFAULT 100,
    shop_currency INT DEFAULT 0
);

-- Inventory of Poultry owned by users
CREATE TABLE IF NOT EXISTS inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    species ENUM('Turkey', 'Pheasant', 'Duck') NOT NULL,
    name VARCHAR(50) NOT NULL,
    rarity ENUM('Common', 'Rare', 'Legend', 'Secret', 'Hack') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Career History / Log
CREATE TABLE IF NOT EXISTS career_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    poultry_name VARCHAR(50) NOT NULL,
    final_attack INT NOT NULL,
    final_speed INT NOT NULL,
    final_iq INT NOT NULL,
    wins INT NOT NULL,
    losses INT NOT NULL,
    boss_wins INT NOT NULL,
    outcome ENUM('Win', 'Loss') NOT NULL,
    career_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
