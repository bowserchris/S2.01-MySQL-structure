-- MySQL Script generated by MySQL Workbench
-- Tue Jul 18 09:23:48 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`province` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `pizzeria`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`id`, `province_id`),
  INDEX `fk_city_province_idx` (`province_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_province`
    FOREIGN KEY (`province_id`)
    REFERENCES `pizzeria`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_first` VARCHAR(50) NOT NULL,
  `name_last` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `postal_code` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(12) NOT NULL,
  `city_id` INT NOT NULL,
  `city_province_id` INT NOT NULL,
  PRIMARY KEY (`id`, `city_id`, `city_province_id`),
  INDEX `fk_customer_city1_idx` (`city_id` ASC, `city_province_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_city1`
    FOREIGN KEY (`city_id` , `city_province_id`)
    REFERENCES `pizzeria`.`city` (`id` , `province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT(100) NULL,
  `image` BLOB NULL,
  `price` DECIMAL NOT NULL DEFAULT 0.0,
  `type` ENUM('pizza', 'hamburger', 'drink') NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `pizzeria`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`store` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(12) NOT NULL,
  `city_id` INT NOT NULL,
  `city_province_id` INT NOT NULL,
  PRIMARY KEY (`id`, `city_id`, `city_province_id`),
  INDEX `fk_store_city1_idx` (`city_id` ASC, `city_province_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_city1`
    FOREIGN KEY (`city_id` , `city_province_id`)
    REFERENCES `pizzeria`.`city` (`id` , `province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_first` VARCHAR(45) NOT NULL,
  `name_last` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(12) NOT NULL,
  `phone` VARCHAR(12) NULL,
  `role` ENUM('cook', 'delivery') NULL,
  `store_id` INT NOT NULL,
  `store_city_id` INT NOT NULL,
  `store_city_province_id` INT NOT NULL,
  PRIMARY KEY (`id`, `store_id`, `store_city_id`, `store_city_province_id`),
  INDEX `fk_employee_store1_idx` (`store_id` ASC, `store_city_id` ASC, `store_city_province_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_store1`
    FOREIGN KEY (`store_id` , `store_city_id` , `store_city_province_id`)
    REFERENCES `pizzeria`.`store` (`id` , `city_id` , `city_province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_pickup` ENUM('delivery', 'pick up') NOT NULL COMMENT 'tried boolean for true or false, if true links to delivery table',
  `quantity` INT(50) NULL DEFAULT 0,
  `total_price` DECIMAL NULL DEFAULT 0,
  `customer_id` INT NOT NULL,
  `customer_city_id` INT NOT NULL,
  `customer_city_province_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `employee_store_id` INT NOT NULL,
  `employee_store_city_id` INT NOT NULL,
  `employee_store_city_province_id` INT NOT NULL,
  PRIMARY KEY (`id`, `customer_id`, `customer_city_id`, `customer_city_province_id`, `product_id`, `employee_id`, `employee_store_id`, `employee_store_city_id`, `employee_store_city_province_id`),
  INDEX `fk_orders_customer1_idx` (`customer_id` ASC, `customer_city_id` ASC, `customer_city_province_id` ASC) VISIBLE,
  INDEX `fk_orders_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_orders_employee1_idx` (`employee_id` ASC, `employee_store_id` ASC, `employee_store_city_id` ASC, `employee_store_city_province_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customer1`
    FOREIGN KEY (`customer_id` , `customer_city_id` , `customer_city_province_id`)
    REFERENCES `pizzeria`.`customer` (`id` , `city_id` , `city_province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizzeria`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_employee1`
    FOREIGN KEY (`employee_id` , `employee_store_id` , `employee_store_city_id` , `employee_store_city_province_id`)
    REFERENCES `pizzeria`.`employee` (`id` , `store_id` , `store_city_id` , `store_city_province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_category` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `product_id`),
  INDEX `fk_pizza_category_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizzeria`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
