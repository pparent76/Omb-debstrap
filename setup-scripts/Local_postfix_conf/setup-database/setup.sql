CREATE DATABASE IF NOT EXISTS  postfix;
GRANT ALL ON postfix.* TO 'own-mailbox'@'localhost'IDENTIFIED BY 'own-mailbox';
USE postfix;

CREATE TABLE IF NOT EXISTS `transport` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `transportation` varchar(2048) NOT NULL,
  `address` varchar(1024) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;
