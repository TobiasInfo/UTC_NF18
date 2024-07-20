CREATE TYPE type_espece AS ENUM (
    'félin', 
    'canidés', 
    'reptiles', 
    'rongeurs', 
    'oiseaux', 
    'autres'
);


CREATE TABLE Client(
    id_client INTEGER,
    nom VARCHAR, 
    prenom VARCHAR,
    date_de_naissance DATE,
    adresse VARCHAR,
    numero_telephone VARCHAR(10),
    PRIMARY KEY (id_client)
);

CREATE TABLE Medicament(
    nom_molecule VARCHAR,
    description_effet VARCHAR,
    PRIMARY KEY (nom_molecule)
);




CREATE TABLE Traitement(
    id_traitement INTEGER,
    date_debut DATE,
    date_fin DATE,
    PRIMARY KEY (id_traitement)
);

CREATE TABLE Personnel (
    id_personnel INTEGER,
    nom VARCHAR, 
    prenom VARCHAR,
    date_de_naissance DATE,
    adresse VARCHAR,
    numero_telephone VARCHAR(10),
    PRIMARY KEY (id_personnel)
);

CREATE TABLE Espece(
    type type_espece,
    PRIMARY KEY (type)
);

CREATE TABLE Assistant (
    id_personnel INTEGER,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    PRIMARY KEY (id_personnel)
);


CREATE TABLE Veterinaire (
    id_personnel INTEGER,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    PRIMARY KEY (id_personnel)
);



CREATE TABLE Animal(
    id_animal INTEGER,
    nom VARCHAR,
    date_de_naissance DATE,
    num_puce INTEGER UNIQUE,
    passeport INTEGER UNIQUE,
    type type_espece NOT NULL,
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (id_animal)
);

CREATE TABLE Observation(
    id_observation int,
    observation VARCHAR,
    id_personnel INTEGER NOT NULL,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    PRIMARY KEY (id_observation)
);

CREATE TABLE Entree(
    saisie TIMESTAMP,
    id_animal INTEGER UNIQUE,
    taille FLOAT,
    poids FLOAT,
    resultat_analyse VARCHAR, 
    procedure VARCHAR,              
    description_procedure VARCHAR,
    id_observation int UNIQUE,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    FOREIGN KEY (id_observation) REFERENCES Observation(id_observation),
    PRIMARY KEY (saisie, id_animal)
);


CREATE TABLE AssocAnimalClient(
    id_client INTEGER,
    id_animal INTEGER,
    date_debut DATE,
    date_fin DATE,
    FOREIGN KEY (id_client) REFERENCES CLient(id_client),
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    PRIMARY KEY (id_client, id_animal)
);

CREATE TABLE AssocAnimalVeterinaire(
    id_personnel INTEGER,
    id_animal INTEGER,
    date_debut DATE,
    date_fin DATE,
    FOREIGN KEY (id_personnel) REFERENCES Veterinaire(id_personnel),
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    PRIMARY KEY (id_personnel, id_animal)
);

CREATE TABLE AssocTraitementMedicament(
    nom_molecule VARCHAR,
    id_traitement INTEGER,
    quantite INTEGER,
    FOREIGN KEY (nom_molecule) REFERENCES Medicament(nom_molecule),
    FOREIGN KEY (id_traitement) REFERENCES Traitement(id_traitement),
    PRIMARY KEY (nom_molecule, id_traitement)
);

CREATE TABLE AssocTraitementEntree(
    saisie TIMESTAMP,
    id_animal INTEGER,
    id_traitement INTEGER,
    FOREIGN KEY (saisie, id_animal) REFERENCES Entree(saisie, id_animal),
    FOREIGN KEY (id_traitement) REFERENCES Traitement(id_traitement),
    PRIMARY KEY (saisie, id_animal, id_traitement)
);

CREATE TABLE AssocTraitementVeterinaire(
    id_personnel INTEGER,
    id_traitement INTEGER,

    FOREIGN KEY (id_personnel) REFERENCES Veterinaire(id_personnel),
    FOREIGN KEY (id_traitement) REFERENCES Traitement(id_traitement),
    PRIMARY KEY (id_personnel, id_traitement)
);

CREATE TABLE AssocEspecePersonnel(
    id_personnel INTEGER,
    type type_espece,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (id_personnel, type)
);

CREATE TABLE AssocEspeceMedicament(
    nom_molecule VARCHAR,
    type type_espece,
    FOREIGN KEY (nom_molecule) REFERENCES Medicament(nom_molecule),
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (nom_molecule, type)
);





--------------------------ANCIENNE VERSION ------------------------



----------------------------------------------------------------CREATION DES TYPES----------------------------------------------------------------
CREATE TYPE type_espece AS ENUM (
    'félin', 
    'canidés', 
    'reptiles', 
    'rongeurs', 
    'oiseaux', 
    'autres'
);

CREATE TYPE type_entree AS ENUM (
    'taille', 
    'poids', 
    'resultat_analyse', 
    'observation', 
    'véto_observation', 
    'procedure', 
    'description_procedure'
);

CREATE TYPE poste_personnel AS ENUM (
    'vétérinaire', 
    'assistant'
);

----------------------------------------------------------------CREATION DE TABLES----------------------------------------------------------------
CREATE TABLE Client(
    id_client INTEGER,
    nom VARCHAR, 
    prenom VARCHAR,
    date_de_naissance DATE,
    adresse VARCHAR,
    numero_telephone VARCHAR(10),
    PRIMARY KEY (id_client)
);

CREATE TABLE Espece(
    type type_espece,
    PRIMARY KEY (type)
);

CREATE TABLE Personnel(
    id_personnel INTEGER,
    nom VARCHAR, 
    prenom VARCHAR,
    date_de_naissance DATE,
    adresse VARCHAR,
    numero_telephone VARCHAR(10),
    poste poste_personnel,
    PRIMARY KEY (id_personnel)
);

CREATE TABLE Medicament(
    nom_molecule VARCHAR,
    description_effet VARCHAR,
    PRIMARY KEY (nom_molecule)
);

CREATE TABLE Animal(
    id_animal INTEGER,
    nom VARCHAR,
    date_de_naissance DATE,
    num_puce INTEGER UNIQUE,
    passeport INTEGER UNIQUE,
    type type_espece NOT NULL,
    id_client INTEGER NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Client(id_client),
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (id_animal)
);

CREATE TABLE Proprio(
    nom VARCHAR, 
    periode_debut DATE,
    periode_fin DATE,
    id_animal INTEGER,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    PRIMARY KEY (nom, id_animal)
);

CREATE TABLE Veto(
    nom VARCHAR, 
    periode_debut DATE,
    periode_fin DATE,
    id_animal INTEGER,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    PRIMARY KEY (nom, id_animal)
);

CREATE TABLE Dossier(
    id_dossier INTEGER,
    taille FLOAT,
    poids FLOAT,
    resultat_analyse VARCHAR, 
    observation VARCHAR, 
    véto_observation VARCHAR, 
    procedure VARCHAR,              
    description_procedure VARCHAR,
    id_animal INTEGER UNIQUE,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    PRIMARY KEY (id_dossier)
);

CREATE TABLE Traitement(
    id INTEGER,
    date_debut DATE,
    duree INTEGER,
    quantite INTEGER,
    personnel INTEGER UNIQUE,
    id_dossier INTEGER NOT NULL,
    FOREIGN KEY (id_dossier) REFERENCES Dossier(id_dossier),
    FOREIGN KEY (personnel) REFERENCES Personnel(id_personnel),
    PRIMARY KEY (id)
);

CREATE TABLE Entree(
    heure_saisie TIME,
    id_dossier INTEGER,
    date_saisie DATE,
    type type_entree, 
    FOREIGN KEY (id_dossier) REFERENCES Dossier(id_dossier),
    PRIMARY KEY (heure_saisie, id_dossier)
);

CREATE TABLE AssocMedicamentEspece(
    nom_molecule VARCHAR,
    type type_espece,
    FOREIGN KEY (nom_molecule) REFERENCES Medicament(nom_molecule),
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (nom_molecule, type)
);

CREATE TABLE AssocPersonnelEspece(
    id_personnel INTEGER,
    type type_espece,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (id_personnel, type)
);

CREATE TABLE AssocTraitementMedicament(
    nom_molecule VARCHAR,
    traitement INTEGER,
    FOREIGN KEY (nom_molecule) REFERENCES Medicament(nom_molecule),
    FOREIGN KEY (traitement) REFERENCES Traitement(id),
    PRIMARY KEY (nom_molecule, traitement)
);

----------------------------------------------------------------INSERTION DE DONNEES----------------------------------------------------------------

INSERT INTO Client VALUES ('0001', 'DUPOND', 'Jean', '1998-10-05', '10 Rue du Général de Gaule 60000 BEAUVAIS', '0623564387');
INSERT INTO Client VALUES ('0002', 'DURAND', 'Paul', '1995-12-08', '21 Rue du Général 38400 Saint-Martin_dhères', '0623698487');
INSERT INTO Client VALUES ('0003', 'CHAN', 'Ines', '2004-04-02', '54 Avenue de la Gare 60000 BEAUVAIS', '0623784529');

INSERT INTO Espece VALUES ('félin');
INSERT INTO Espece VALUES ('oiseaux');
INSERT INTO Espece VALUES ('reptiles');

INSERT INTO Personnel VALUES ('0001', 'LEJEUNE', 'Martin', '1985-12-06', '12 Clos des roses 60200 Compiègne', '0756439851', 'vétérinaire');
INSERT INTO Personnel VALUES ('0002', 'LEBLAN', 'Marie', '1995-05-01', '44 Rue du général 60200 Compiègne', '0756875851', 'assistant');
INSERT INTO Personnel VALUES ('0003', 'LENOIR', 'Paul', '1995-12-06', '56 Avenue UTC 60200 Compiègne', '0789649851', 'assistant');

INSERT INTO Medicament VALUES ('Doliprane', 'Ce médicament permet de limiter les maux de tete');
INSERT INTO Medicament VALUES ('Medo2', 'Ce médicament permet de reduire les risques de cancer');

INSERT INTO Animal VALUES ('0001', 'moustache' , '2015-12-06', '1234', '4321', 'félin', '0001');
INSERT INTO Animal VALUES ('0002', 'Pero', '2012-11-12', '5678', '8765', 'oiseaux', '0002');
INSERT INTO Animal VALUES ('0003', 'croco', '2018-02-07', '1289', '9821', 'reptiles', '0003');

INSERT INTO Proprio VALUES ('DUPOND', '1996-12-02', '1997-08-24', 0001);
INSERT INTO Proprio VALUES ('LEBLAN', '1997-08-24', '1997-08-24', 0002);
INSERT INTO Proprio VALUES ('LEBLAN', '1994-05-11', '2020-01-01', 0003);

INSERT INTO Veto VALUES ('LEJEUNE', '2005-02-17','2007-04-15', 1);
INSERT INTO Veto VALUES ('LEJEUNE', '2016-12-24','2017-11-27', 2);
INSERT INTO Veto VALUES ('LEJEUNE', '2019-02-24', '2021-07-17', 3);

INSERT INTO Dossier VALUES (0001, 1.4, 12.4, 'Analyse satifaisant', 'Rien a declarer', 'LEJEUNE', 'RDV dans 1 an', 'RDV de controle', 0001);

INSERT INTO Traitement VALUES (0001, '2019-02-24', 12, 4, 0003, 0001);

INSERT INTO Entree VALUES ('12:52:45',0001,'2019-02-24', 'taille');
INSERT INTO Entree VALUES ('12:54:45',0001,'2019-02-24', 'poids');
INSERT INTO Entree VALUES ('12:55:25',0001,'2019-02-24', 'resultat_analyse');
INSERT INTO Entree VALUES ('12:56:23',0001,'2019-02-24', 'observation');
INSERT INTO Entree VALUES ('12:57:12',0001,'2019-02-24', 'véto_observation');
INSERT INTO Entree VALUES ('12:58:56',0001,'2019-02-24', 'procedure');
INSERT INTO Entree VALUES ('12:59:12',0001,'2019-02-24', 'description_procedure');


INSERT INTO AssocMedicamentEspece VALUES ('Doliprane', 'oiseaux');
INSERT INTO AssocMedicamentEspece VALUES ('Doliprane', 'reptiles');
INSERT INTO AssocMedicamentEspece VALUES ('Medo2', 'félin');

INSERT INTO AssocPersonnelEspece VALUES ('0001', 'oiseaux');
INSERT INTO AssocPersonnelEspece VALUES ('0002', 'reptiles');
INSERT INTO AssocPersonnelEspece VALUES ('0003', 'oiseaux');
INSERT INTO AssocPersonnelEspece VALUES ('0003', 'félin');

INSERT INTO AssocTraitementMedicament VALUES ('Doliprane', 0001);
INSERT INTO AssocTraitementMedicament VALUES ('Medo2', 0001);
