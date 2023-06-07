-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Project_M
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Project_M
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project_M` DEFAULT CHARACTER SET utf8 ;
USE `Project_M` ;

-- -----------------------------------------------------
-- Table `Project_M`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Address` (
  `idAddress` INT NOT NULL,
  `address_city` VARCHAR(45) NULL,
  `address_country` VARCHAR(45) NULL,
  `address_postalcode` VARCHAR(45) NULL,
  `address_street_name` VARCHAR(255) NULL,
  `address_streetnum` VARCHAR(45) NULL,
  `address_appartnum` VARCHAR(45) NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Users` (
  `idUsers` INT NOT NULL,
  `user_name` VARCHAR(45) NULL,
  `user_emaill` VARCHAR(45) NULL,
  `Address_idAddress` INT NOT NULL,
  PRIMARY KEY (`idUsers`),
  INDEX `fk_Users_Address_idx` (`Address_idAddress` ASC),
  CONSTRAINT `fk_Users_Address`
    FOREIGN KEY (`Address_idAddress`)
    REFERENCES `Project_M`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Subscription` (
  `idSubscription` INT NOT NULL,
  `subscription_type` VARCHAR(1) NOT NULL,
  `subscription_startdate` DATE NULL,
  `subscription_price` DECIMAL(4,2) NULL,
  PRIMARY KEY (`idSubscription`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Invoices` (
  `idInvoice` INT NOT NULL,
  `invoice_date` DATE NULL,
  `Users_idUsers` INT NOT NULL,
  `Subscription_idSubscription` INT NOT NULL,
  PRIMARY KEY (`idInvoice`),
  INDEX `fk_Invoice_Users1_idx` (`Users_idUsers` ASC),
  INDEX `fk_Invoice_Subscription1_idx` (`Subscription_idSubscription` ASC),
  CONSTRAINT `fk_Invoice_Users1`
    FOREIGN KEY (`Users_idUsers`)
    REFERENCES `Project_M`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoice_Subscription1`
    FOREIGN KEY (`Subscription_idSubscription`)
    REFERENCES `Project_M`.`Subscription` (`idSubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Platinum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Platinum` (
  `Subscription_idSubscription` INT NOT NULL,
  `lyrics_access` VARCHAR(1) NOT NULL,
  `music_video_access` VARCHAR(1) NOT NULL,
  INDEX `fk_Platinum_Subscription1_idx` (`Subscription_idSubscription` ASC),
  PRIMARY KEY (`Subscription_idSubscription`),
  CONSTRAINT `fk_Platinum_Subscription1`
    FOREIGN KEY (`Subscription_idSubscription`)
    REFERENCES `Project_M`.`Subscription` (`idSubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Advertisements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Advertisements` (
  `idads` INT NOT NULL,
  `ad_name` VARCHAR(45) NOT NULL,
  `ad_duration` TIME NOT NULL,
  `ad_price_per_min` VARCHAR(45) NOT NULL,
  `ad_sponsor` VARCHAR(45) NOT NULL,
  `frequency_per_day` INT NULL,
  PRIMARY KEY (`idads`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Playlist` (
  `idPlaylist` INT NOT NULL,
  `Playlist_name` VARCHAR(45) NULL,
  `Playlist_quantity` INT NULL,
  PRIMARY KEY (`idPlaylist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Song` (
  `idSong` INT NOT NULL,
  `song_genre` VARCHAR(45) NULL,
  `song_name` VARCHAR(45) NULL,
  `song_releasedate` VARCHAR(45) NULL,
  PRIMARY KEY (`idSong`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Artist` (
  `idArtist` INT NOT NULL,
  `artist_name` VARCHAR(45) NULL,
  `artist_country` VARCHAR(45) NULL,
  PRIMARY KEY (`idArtist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Album` (
  `idAlbum` INT NOT NULL,
  `album_name` VARCHAR(45) NULL,
  `album_releasedate` DATE NULL,
  PRIMARY KEY (`idAlbum`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Playlist_has_Song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Playlist_has_Song` (
  `Playlist_idPlaylist` INT NOT NULL,
  `Song_idSong` INT NOT NULL,
  `song_played` TIMESTAMP NULL,
  PRIMARY KEY (`Playlist_idPlaylist`, `Song_idSong`),
  INDEX `fk_Playlist_has_Song_Song1_idx` (`Song_idSong` ASC),
  INDEX `fk_Playlist_has_Song_Playlist1_idx` (`Playlist_idPlaylist` ASC),
  CONSTRAINT `fk_Playlist_has_Song_Playlist1`
    FOREIGN KEY (`Playlist_idPlaylist`)
    REFERENCES `Project_M`.`Playlist` (`idPlaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_has_Song_Song1`
    FOREIGN KEY (`Song_idSong`)
    REFERENCES `Project_M`.`Song` (`idSong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Song_has_Artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Song_has_Artist` (
  `Song_idSong` INT NOT NULL,
  `Artist_idArtist` INT NOT NULL,
  PRIMARY KEY (`Song_idSong`, `Artist_idArtist`),
  INDEX `fk_Song_has_Artist_Artist1_idx` (`Artist_idArtist` ASC),
  INDEX `fk_Song_has_Artist_Song1_idx` (`Song_idSong` ASC),
  CONSTRAINT `fk_Song_has_Artist_Song1`
    FOREIGN KEY (`Song_idSong`)
    REFERENCES `Project_M`.`Song` (`idSong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Song_has_Artist_Artist1`
    FOREIGN KEY (`Artist_idArtist`)
    REFERENCES `Project_M`.`Artist` (`idArtist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Song_has_Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Song_has_Album` (
  `Song_idSong` INT NOT NULL,
  `Album_idAlbum` INT NOT NULL,
  PRIMARY KEY (`Song_idSong`, `Album_idAlbum`),
  INDEX `fk_Song_has_Album_Album1_idx` (`Album_idAlbum` ASC),
  INDEX `fk_Song_has_Album_Song1_idx` (`Song_idSong` ASC),
  CONSTRAINT `fk_Song_has_Album_Song1`
    FOREIGN KEY (`Song_idSong`)
    REFERENCES `Project_M`.`Song` (`idSong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Song_has_Album_Album1`
    FOREIGN KEY (`Album_idAlbum`)
    REFERENCES `Project_M`.`Album` (`idAlbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Free`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Free` (
  `Subscription_idSubscription` INT NOT NULL,
  `ad_access` VARCHAR(1) NOT NULL,
  INDEX `fk_Free_Subscription1_idx` (`Subscription_idSubscription` ASC),
  PRIMARY KEY (`Subscription_idSubscription`),
  CONSTRAINT `fk_Free_Subscription1`
    FOREIGN KEY (`Subscription_idSubscription`)
    REFERENCES `Project_M`.`Subscription` (`idSubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Free_has_Advertisements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Free_has_Advertisements` (
  `Free_Subscription_idSubscription` INT NOT NULL,
  `Advertisements_idads` INT NOT NULL,
  PRIMARY KEY (`Free_Subscription_idSubscription`, `Advertisements_idads`),
  INDEX `fk_Free_has_Advertisement1_Advertisement1_idx` (`Advertisements_idads` ASC),
  INDEX `fk_Free_has_Advertisement1_Free1_idx` (`Free_Subscription_idSubscription` ASC),
  CONSTRAINT `fk_Free_has_Advertisement1_Free1`
    FOREIGN KEY (`Free_Subscription_idSubscription`)
    REFERENCES `Project_M`.`Free` (`Subscription_idSubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Free_has_Advertisement1_Advertisement1`
    FOREIGN KEY (`Advertisements_idads`)
    REFERENCES `Project_M`.`Advertisements` (`idads`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Users_has_Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Users_has_Playlist` (
  `Users_idUsers` INT NOT NULL,
  `Playlist_idPlaylist` INT NOT NULL,
  PRIMARY KEY (`Users_idUsers`, `Playlist_idPlaylist`),
  INDEX `fk_Users_has_Playlist_Playlist1_idx` (`Playlist_idPlaylist` ASC),
  INDEX `fk_Users_has_Playlist_Users1_idx` (`Users_idUsers` ASC),
  CONSTRAINT `fk_Users_has_Playlist_Users1`
    FOREIGN KEY (`Users_idUsers`)
    REFERENCES `Project_M`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Playlist_Playlist1`
    FOREIGN KEY (`Playlist_idPlaylist`)
    REFERENCES `Project_M`.`Playlist` (`idPlaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_M`.`Gold`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_M`.`Gold` (
  `Subscription_idSubscription` INT NOT NULL,
  `lyrics_access` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`Subscription_idSubscription`),
  INDEX `fk_Gold_Subscription1_idx` (`Subscription_idSubscription` ASC),
  CONSTRAINT `fk_Gold_Subscription1`
    FOREIGN KEY (`Subscription_idSubscription`)
    REFERENCES `Project_M`.`Subscription` (`idSubscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Project_M`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (400, 'Montreal', 'Canada', 'H4P 1P4', 'Cote-St-Catherine', '2221', '303');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (401, 'Toronto', 'Canada', 'H3P 1D2', 'Murcel', '3233', '220');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (402, 'Paris', 'France', '75016', ' Rue De Bourgogne', '1001', '');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (403, 'Ottawa', 'Canada', 'D2P 1E5', 'Wellington Street', '233', '506');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (404, 'New York', 'United States', '10048', 'Wall Street', '5025', '');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (405, 'Boston', 'United States', '20137', 'Bakersfield Street', '3212', '');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (406, 'Strasbourg', 'France', '39602', 'Rue Du Village', '5444', '707');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (407, 'Vancouver', 'Canada', 'K3B 1D9', 'Borgen Street', '6788', '');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (408, 'Detroit', 'United States', '48217', 'St Jacob Street', '776', '');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (409, 'Shanghai', 'China', '200011', 'Qishun Road', '55', '320');
INSERT INTO `Project_M`.`Address` (`idAddress`, `address_city`, `address_country`, `address_postalcode`, `address_street_name`, `address_streetnum`, `address_appartnum`) VALUES (410, 'Tokyo', 'Japan', '100 6035', 'Konida Street', '1337', '554');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Users`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3031, 'Boris Pajal', 'gideongagnon26@gmail.com', 400);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3032, 'Mike Tylon', 'miketylon33@gmail.com', 401);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3033, 'Ben Dover', 'bendover69@yahoo.com', 402);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3034, 'Jake Robin', 'jetlee_bing@yahoo.com', 403);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3035, 'Chloe Roche', 'Chloe_xox33@gmail.com', 404);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3036, 'Merik Merros', 'Merros44@gmail.com', 405);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3037, 'Yann Dugles', 'YannDugles@gmail.com', 406);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3038, 'Ralph Younes', 'ry993@gmail.com', 407);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3039, 'Emma Lang', 'emma_lang3034@gmail.com', 408);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3040, 'Jimmy Jang', 'jimjang@yahoo.com', 409);
INSERT INTO `Project_M`.`Users` (`idUsers`, `user_name`, `user_emaill`, `Address_idAddress`) VALUES (3041, 'Yinny Benji', 'yinny_binny420@gmail.com', 410);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Subscription`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (100, 'G', '2018-12-23', 13.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (101, 'G', '2019-01-22', 13.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (102, 'P', '2019-01-23', 16.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (103, 'P', '2019-04-25', 16.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (104, 'G', '2019-05-25', 13.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (105, 'P', '2019-05-28', 16.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (106, 'G', '2019-06-28', 13.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (107, 'P', '2019-07-24', 16.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (108, 'F', '2019-10-20', 0);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (109, 'F', '2019-10-26', 0);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (110, 'G', '2019-10-27', 13.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (111, 'F', '2019-10-29', 0);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (112, 'G', '2019-10-30', 13.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (113, 'G', '2019-11-20', 13.99);
INSERT INTO `Project_M`.`Subscription` (`idSubscription`, `subscription_type`, `subscription_startdate`, `subscription_price`) VALUES (114, 'G', '2019-11-21', 13.99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Invoices`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9000, '2018-12-23', 3034, 100);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9001, '2019-01-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9002, '2019-02-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9003, '2019-03-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9004, '2019-04-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9005, '2019-05-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9006, '2019-06-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9007, '2019-07-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9008, '2019-08-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9009, '2019-09-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9010, '2019-10-22', 3033, 101);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9011, '2019-01-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9012, '2019-02-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9013, '2019-03-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9014, '2019-04-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9015, '2019-05-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9016, '2019-06-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9017, '2019-07-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9018, '2019-08-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9019, '2019-09-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9020, '2019-10-23', 3034, 102);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9021, '2019-04-25', 3036, 103);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9022, '2019-05-25', 3036, 104);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9023, '2019-06-25', 3036, 104);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9024, '2019-07-25', 3036, 104);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9025, '2019-08-25', 3036, 104);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9026, '2019-09-25', 3036, 104);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9027, '2019-10-25', 3036, 104);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9028, '2019-05-28', 3039, 105);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9029, '2019-06-28', 3039, 106);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9030, '2019-07-28', 3039, 106);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9031, '2019-08-28', 3039, 106);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9032, '2019-09-28', 3039, 106);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9033, '2019-10-28', 3039, 106);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9034, '2019-07-24', 3035, 107);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9035, '2019-08-24', 3035, 107);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9036, '2019-09-24', 3035, 107);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9037, '2019-10-24', 3035, 107);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9038, '2019-10-20', 3031, 108);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9039, '2019-10-26', 3037, 109);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9040, '2019-10-27', 3038, 110);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9041, '2019-10-29', 3040, 111);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9042, '2019-10-30', 3041, 112);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9043, '2019-11-20', 3031, 113);
INSERT INTO `Project_M`.`Invoices` (`idInvoice`, `invoice_date`, `Users_idUsers`, `Subscription_idSubscription`) VALUES (9044, '2019-11-21', 3032, 114);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Platinum`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Platinum` (`Subscription_idSubscription`, `lyrics_access`, `music_video_access`) VALUES (102, 'Y', 'Y');
INSERT INTO `Project_M`.`Platinum` (`Subscription_idSubscription`, `lyrics_access`, `music_video_access`) VALUES (105, 'Y', 'Y');
INSERT INTO `Project_M`.`Platinum` (`Subscription_idSubscription`, `lyrics_access`, `music_video_access`) VALUES (103, 'Y', 'Y');
INSERT INTO `Project_M`.`Platinum` (`Subscription_idSubscription`, `lyrics_access`, `music_video_access`) VALUES (107, 'Y', 'Y');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Advertisements`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1000, '7ups\'s Refreshing', '00:00:45', ' 75.00 ', 'Dr. Peppers', 6);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1001, 'X-Sports', '00:01:45', ' 299.99 ', 'Red Bull', 4);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1002, 'Dodge Escape', '00:02:45', ' 399.99 ', 'Ford', 3);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1003, 'Avenger: End Games ', '00:03:45', ' 450.99 ', 'Walt Disney Motion Pictures', 1);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1004, 'Kit - Kat', '00:00:45', ' 75.00 ', 'Nestle', 7);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1005, 'Violet Evergarden', '00:01:45', ' 299.99 ', 'Kyoto Animation', 12);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1006, 'Sonic the hedgehog', '00:02:45', ' 399.99 ', 'Paramount', 2);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1007, 'The King\'s Man', '00:03:45', ' 450.99 ', 'Walt Disney Motion Pictures', 4);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1008, 'Doritos', '00:00:45', ' 75.00 ', 'Doritos', 3);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1009, 'The Crown, S3 trailer', '00:01:45', ' 299.99 ', 'Netflix', 2);
INSERT INTO `Project_M`.`Advertisements` (`idads`, `ad_name`, `ad_duration`, `ad_price_per_min`, `ad_sponsor`, `frequency_per_day`) VALUES (1010, 'Rick and Morty,season 4 premiere', '00:02:45', ' 399.99 ', 'Adult Swim', 13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Playlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (500, 'Summer Breeze', 99);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (510, 'Cozy Vibes', 151);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (520, 'Rap Essentials', 67);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (530, 'Jazz Classics', 43);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (540, 'Country Hits', 44);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (550, 'LaFlame', 71);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (560, 'Smoke Study', 247);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (570, 'R&B Chill', 222);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (580, 'Sleepy', 171);
INSERT INTO `Project_M`.`Playlist` (`idPlaylist`, `Playlist_name`, `Playlist_quantity`) VALUES (590, 'Kpop', 112);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Song`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (800, 'R&B', 'OTW', '2019-06-04');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (810, 'R&B', 'You For You', '2018-11-09');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (820, 'Rap', 'Baguettes in the face', '2019-06-12');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (830, 'Jazz', 'Belem', '2019-04-04');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (840, 'Country', 'Old Town Road', '2019-05-05');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (850, 'Rap', 'Can\'t Say', '2019-01-29');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (860, 'Pop', '7 rings', '2017-01-15');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (870, 'R&B', 'Better', '2016-12-12');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (880, 'Electronic', 'Pianola', '2018-08-23');
INSERT INTO `Project_M`.`Song` (`idSong`, `song_genre`, `song_name`, `song_releasedate`) VALUES (890, 'Pop', 'Kick it', '2018-09-22');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Artist`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (600, '6LACK', 'United States');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (610, 'anders', 'Canada');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (620, 'Gunna', 'United States');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (630, 'DAO', 'United States');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (640, 'Lil Nas X', 'United States');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (650, 'Travis Scott', 'United States');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (660, 'Ariana Grande', 'United States');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (670, 'Khalid', 'United States');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (680, 'Lonov', 'China');
INSERT INTO `Project_M`.`Artist` (`idArtist`, `artist_name`, `artist_country`) VALUES (690, 'BLACKPINK', 'Korea');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Album`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (700, 'OTW', '2019-10-11');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (710, '669', '2018-12-10');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (720, 'Perfect Ten', '2019-08-23');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (730, 'Belem', '2019-08-22');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (740, '7 EP', '2019-07-09');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (750, 'Astroworld', '2019-04-16');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (760, 'thank u, next', '2017-03-30');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (770, 'Free Spirit', '2017-02-13');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (780, 'Rooftops', '2018-08-30');
INSERT INTO `Project_M`.`Album` (`idAlbum`, `album_name`, `album_releasedate`) VALUES (790, 'Kill This Love', '2018-10-10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Playlist_has_Song`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (500, 800, '2019-11-13 02:28:00 ');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (510, 810, '2019-11-21 15:12:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (520, 820, '2019-10-08 03:10:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (530, 830, '2019-09-30 21:00:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (540, 840, '2019-10-11 11:11:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (550, 850, '2019-10-01 14:48:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (560, 860, '2019-10-26 20:55:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (570, 870, '2019-10-27 22:30:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (580, 880, '2019-10-28 17:21:00');
INSERT INTO `Project_M`.`Playlist_has_Song` (`Playlist_idPlaylist`, `Song_idSong`, `song_played`) VALUES (590, 890, '2019-10-29 11:41:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Song_has_Artist`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (800, 600);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (810, 610);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (820, 620);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (830, 630);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (840, 640);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (850, 650);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (860, 660);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (870, 670);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (880, 680);
INSERT INTO `Project_M`.`Song_has_Artist` (`Song_idSong`, `Artist_idArtist`) VALUES (890, 690);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Song_has_Album`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (800, 700);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (810, 710);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (820, 720);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (830, 730);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (840, 740);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (850, 750);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (860, 760);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (870, 770);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (880, 780);
INSERT INTO `Project_M`.`Song_has_Album` (`Song_idSong`, `Album_idAlbum`) VALUES (890, 790);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Free`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Free` (`Subscription_idSubscription`, `ad_access`) VALUES (108, 'Y');
INSERT INTO `Project_M`.`Free` (`Subscription_idSubscription`, `ad_access`) VALUES (109, 'Y');
INSERT INTO `Project_M`.`Free` (`Subscription_idSubscription`, `ad_access`) VALUES (111, 'Y');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Free_has_Advertisements`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (108, 1005);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (108, 1009);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (108, 1006);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (111, 1000);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (111, 1010);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (109, 1005);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (111, 1007);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (111, 1008);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (108, 1002);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (109, 1003);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (109, 1004);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (109, 1001);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (111, 1002);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (108, 1003);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (111, 1004);
INSERT INTO `Project_M`.`Free_has_Advertisements` (`Free_Subscription_idSubscription`, `Advertisements_idads`) VALUES (109, 1010);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Users_has_Playlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3031, 500);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3032, 510);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3033, 520);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3034, 530);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3035, 540);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3036, 550);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3037, 560);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3038, 570);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3039, 580);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3040, 590);
INSERT INTO `Project_M`.`Users_has_Playlist` (`Users_idUsers`, `Playlist_idPlaylist`) VALUES (3041, 590);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project_M`.`Gold`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project_M`;
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (100, 'Y');
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (101, 'Y');
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (104, 'Y');
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (106, 'Y');
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (110, 'Y');
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (112, 'Y');
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (113, 'Y');
INSERT INTO `Project_M`.`Gold` (`Subscription_idSubscription`, `lyrics_access`) VALUES (114, 'Y');

COMMIT;
