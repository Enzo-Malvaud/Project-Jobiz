
-- =============================================================
--  NETTOYAGE
--  On supprime les tables dans l'ordre inverse de leur création
--  pour éviter les conflits entre tables liées.
-- =============================================================

DROP TABLE IF EXISTS job_category;
DROP TABLE IF EXISTS job_application;
DROP TABLE IF EXISTS job;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS country;



-- Pays disponibles sur la plateforme
CREATE TABLE country (
    id   INT          NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- Catégories de métiers (ex : Développeur, Boulanger, Mécanicien...)
CREATE TABLE category (
    id   INT          NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);


-- =============================================================
--  TABLES PRINCIPALES
--  Entités centrales de l'application.
-- =============================================================

-- Entreprises qui publient les offres d'emploi
CREATE TABLE company (
    id         INT          NOT NULL AUTO_INCREMENT,
    name       VARCHAR(255) NOT NULL,
    country_id INT          NOT NULL,
    PRIMARY KEY (id)
);

-- Utilisateurs inscrits sur la plateforme (les candidats)
CREATE TABLE user (
    id         INT          NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255) NOT NULL,
    email      VARCHAR(255) NOT NULL,
    password   VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- Offres d'emploi publiées par les entreprises
CREATE TABLE job (
    id          INT          NOT NULL AUTO_INCREMENT,
    title       VARCHAR(255) NOT NULL,
    description TEXT         NOT NULL,
    salary      INT          NOT NULL,
    country_id  INT          NOT NULL,
    company_id  INT          NOT NULL,
    PRIMARY KEY (id)
);


-- =============================================================
--  TABLES DE RELATION
-- =============================================================

-- Candidatures : relie un utilisateur à une offre d'emploi
-- Contient la lettre de motivation et la date de dépôt
CREATE TABLE job_application (
    id           INT      NOT NULL AUTO_INCREMENT,
    cover_letter TEXT     NOT NULL,
    user_id      INT      NOT NULL,
    job_id       INT      NOT NULL,
    created_at   DATETIME NOT NULL,
    PRIMARY KEY (id)
);

-- Table pivot : une offre peut avoir plusieurs catégories
-- et une catégorie peut regrouper plusieurs offres (Many-to-Many)
CREATE TABLE job_category (
    job_id      INT NOT NULL,
    category_id INT NOT NULL
);


-- =============================================================
--  DONNÉES DE TEST
--  Jeu de données minimal pour tester l'application.
-- =============================================================

-- Pays
INSERT INTO country (id, name) VALUES
    (1, 'France'),
    (2, 'Espagne'),
    (3, 'Suisse');

-- Catégories de métiers
INSERT INTO category (id, name) VALUES
    (1, 'Développeur Fullstack'),
    (2, 'DevOps'),
    (3, 'Mécanique'),
    (4, 'Boulangerie'),
    (5, 'Maçonnerie');

-- Entreprises
INSERT INTO company (id, name, country_id) VALUES
    (1, 'DELL',                   1),
    (2, 'OVH',                    1),
    (3, 'Garage Auto',            1),
    (4, 'Boulangerie Artisanale', 1);

-- Utilisateur de test
INSERT INTO user (id, first_name, last_name, email, password) VALUES
    (1, 'Enzo', 'Martin', 'enzo@mail.com', 'password123');

-- Offres d'emploi
INSERT INTO job (id, title, description, salary, country_id, company_id) VALUES
    (1, 'Développeur Symfony', 'Expert PHP et architecture Symfony 7.',               38000, 1, 1),
    (2, 'Garagiste Expert',    'Diagnostic et réparation moteur toutes marques.',     30000, 1, 3),
    (3, 'Boulanger (H/F)',     'Pétrissage traditionnel et cuisson au feu de bois.', 25000, 1, 4);

-- Association offres <-> catégories
INSERT INTO job_category (job_id, category_id) VALUES
    (1, 1),  -- Développeur Symfony → Développeur Fullstack
    (2, 3),  -- Garagiste Expert    → Mécanique
    (3, 4);  -- Boulanger (H/F)     → Boulangerie

-- Candidatures de l'utilisateur de test
INSERT INTO job_application (cover_letter, user_id, job_id, created_at) VALUES
    (
        'Passionné par la mécanique automobile depuis mon plus jeune âge, je souhaite mettre mes compétences de diagnostic au service de votre garage.',
        1,
        2,
        NOW()
    ),
    (
        'Boulanger de formation, je suis très intéressé par votre approche artisanale du pétrissage et de la cuisson au feu de bois.',
        1,
        3,
        NOW()
    );
