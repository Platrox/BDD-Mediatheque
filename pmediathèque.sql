--Cette base de données contient les tables suivantes:
--• utilisateurs: contient les informations sur les utilisateurs de la médiathèque, comme leur
--nom, prénom, adresse, téléphone et adresse e-mail.
--• Livres: contient les informations sur les éléments disponibles à la médiathèque,
--comme les livres, les CD et les DVD. Cette table contient également des champs pour
--le titre, l'auteur, le nombre de pages ou de pistes, la durée, le genre et le format.
--• copies: contient les informations sur les exemplaires de chaque élément, comme le
--numéro de série, l'état, la date d'achat et le prix.
--• emprunts: contient les informations sur les emprunts effectués par les
--utilisateurs, comme la date de début, la date de fin et la date de retour. Cette table
--contient également des champs pour indiquer si l'exemplaire est en retard ou non,
--ainsi que les frais éventuels.
--• reservations: contient les informations sur les réservations effectuées par les
--utilisateurs, comme la date de réservation et la date de disponibilité prévue. Cette
--table contient également des champs pour indiquer si la réservation est en cours ou
--annulée.
--Voici un exemple de script SQL pour créer ces tables:
--sql
CREATE TABLE utilisateurs (
 id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 address VARCHAR(100) NOT NULL,
 phone VARCHAR(20),
 email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE livres (
 id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(100) NOT NULL,
 author VARCHAR(100) NOT NULL,
 pages INT,
 tracks INT,
 duration TIME,
 genre VARCHAR(50),
 format VARCHAR(50) NOT NULL
);

CREATE TABLE copies (
 id INT PRIMARY KEY AUTO_INCREMENT,
 item_id INT NOT NULL,
 serial_number VARCHAR(50) NOT NULL UNIQUE,
 status ENUM('available', 'borrowed', 'reserved') DEFAULT
'available',
 purchase_date DATE NOT NULL,
 price DECIMAL(8, 2) NOT NULL,
 FOREIGN KEY (item_id) REFERENCES Livres(id) ON DELETE
CASCADE
);

CREATE TABLE emprunts (
 id INT PRIMARY KEY AUTO_INCREMENT,
 user_id INT NOT NULL,
 copy_id INT NOT NULL,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 return_date DATE,
 is_late BOOLEAN DEFAULT FALSE,
 late_fees DECIMAL(8, 2) DEFAULT 0.0,
 FOREIGN KEY (user_id) REFERENCES utilisateurs(id) ON DELETE
CASCADE,
 FOREIGN KEY (copy_id) REFERENCES copies(id) ON DELETE
CASCADE
);

CREATE TABLE reservations (
 id INT PRIMARY KEY AUTO_INCREMENT,
 user_id INT NOT NULL,
 copy_id INT NOT NULL,
 reservation_date DATE NOT NULL,
 available_date DATE NOT NULL,
 is_active BOOLEAN DEFAULT TRUE,
 FOREIGN KEY (user_id) REFERENCES utilisateurs(id) ON DELETE
CASCADE,
 FOREIGN KEY (copy_id) REFERENCES copies(id) ON DELETE
CASCADE
);