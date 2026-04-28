SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. SUPPRESSION DES TABLES (si elles existent)
DROP TABLE IF EXISTS `job_category`;
DROP TABLE IF EXISTS `job_application`;
DROP TABLE IF EXISTS `job`;
DROP TABLE IF EXISTS `company`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `country`;

-- 2. CRÉATION DES STRUCTURES
CREATE TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `salary` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `job_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cover_letter` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `job_category` (
  `job_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  KEY `category_id` (`category_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. INSERTION DES DONNÉES
INSERT INTO `country` (`id`, `name`) VALUES (1, 'France'), (2, 'Espagne'), (3, 'Suisse');

INSERT INTO `category` (`id`, `name`) VALUES 
(1, 'Développeur Fullstack'), (2, 'DevOps'), (3, 'Mécanique'), (4, 'Boulangerie'), (5, 'Maçonnerie');

INSERT INTO `company` (`id`, `name`, `country_id`) VALUES 
(1, 'DELL', 1), (2, 'OVH', 1), (3, 'Garage Auto', 1), (4, 'Boulangerie Artisanale', 1);

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`) VALUES 
(1, 'Enzo', 'Martin', 'enzo@mail.com', 'password123');

INSERT INTO `job` (`id`, `title`, `description`, `salary`, `country_id`, `company_id`) VALUES 
(1, 'Développeur Symfony', 'Expert PHP', 38000, 1, 1),
(2, 'Garagiste Expert', 'Réparation moteur', 30000, 1, 3),
(3, 'Boulanger (H/F)', 'Pétrissage traditionnel', 25000, 1, 4);

INSERT INTO `job_category` (`job_id`, `category_id`) VALUES (1, 1), (2, 3), (3, 4);

-- Insertion de candidatures pour tester la table
INSERT INTO `job_application` (`cover_letter`, `user_id`, `job_id`, `created_at`) VALUES 
(
    'Passionné par la mécanique automobile depuis mon plus jeune âge, je souhaite mettre mes compétences de diagnostic au service de votre garage.', 
    1, -- ID de l'utilisateur (Enzo)
    2, -- ID du job (Garagiste Expert)
    NOW()
),
(
    'Boulanger de formation, je suis très intéressé par votre approche artisanale du pétrissage et de la cuisson au feu de bois.', 
    1, -- ID de l'utilisateur (Enzo)
    3, -- ID du job (Boulanger)
    NOW()
);


-- 4. RÉACTIVATION DES CONTRAINTES
ALTER TABLE `company` ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`);
ALTER TABLE `job` ADD CONSTRAINT `job_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`), ADD CONSTRAINT `job_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`);
ALTER TABLE `job_application` ADD CONSTRAINT `job_application_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`), ADD CONSTRAINT `job_application_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
ALTER TABLE `job_category` ADD CONSTRAINT `job_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`), ADD CONSTRAINT `job_category_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;ro