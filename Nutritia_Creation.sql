# Création de la structure des tables de la base de données Nutritia.

DROP TABLE IF EXISTS AlimentsValeursNutritionnelles;
DROP TABLE IF EXISTS ValeursNutritionnelles;
DROP TABLE IF EXISTS PlatsAliments;
DROP TABLE IF EXISTS Aliments;
DROP TABLE IF EXISTS GroupesAlimentaires;
DROP TABLE IF EXISTS UnitesMesure;
DROP TABLE IF EXISTS MenusPlats;
DROP TABLE IF EXISTS Plats;
DROP TABLE IF EXISTS TypesPlats;
DROP TABLE IF EXISTS Menus;
DROP TABLE IF EXISTS PreferencesMembres;
DROP TABLE IF EXISTS ObjectifsMembres;
DROP TABLE IF EXISTS RestrictionsAlimentairesMembres;
DROP TABLE IF EXISTS Membres;
DROP TABLE IF EXISTS Preferences;
DROP TABLE IF EXISTS Objectifs;
DROP TABLE IF EXISTS RestrictionsAlimentaires;

CREATE TABLE IF NOT EXISTS RestrictionsAlimentaires 
( idRestrictionAlimentaire INT AUTO_INCREMENT
, restrictionAlimentaire VARCHAR(30) NOT NULL UNIQUE
, PRIMARY KEY(idRestrictionAlimentaire)
);

CREATE TABLE IF NOT EXISTS Objectifs 
( idObjectif INT AUTO_INCREMENT
, objectif VARCHAR(30) NOT NULL UNIQUE
, PRIMARY KEY(idObjectif)
);

CREATE TABLE IF NOT EXISTS Preferences 
( idPreference INT AUTO_INCREMENT
, preference VARCHAR(30) NOT NULL UNIQUE
, PRIMARY KEY(idPreference)
);

CREATE TABLE IF NOT EXISTS Membres 
( idMembre INT AUTO_INCREMENT
, nom VARCHAR(30) NOT NULL
, prenom VARCHAR(30) NOT NULL
, taille DOUBLE NOT NULL
, masse DOUBLE NOT NULL
, dateNaissance DATE NOT NULL
, nomUtilisateur VARCHAR(15) NOT NULL
, motPasse VARCHAR(15) NOT NULL
, estAdmin BOOL NOT NULL DEFAULT FALSE
, estBanni BOOL NOT NULL DEFAULT FALSE
, PRIMARY KEY(idMembre)
);

CREATE TABLE IF NOT EXISTS RestrictionsAlimentairesMembres 
( idRestrictionAlimentaireMembre INT AUTO_INCREMENT
, idRestrictionAlimentaire INT NOT NULL
, idMembre INT NOT NULL
, PRIMARY KEY(idRestrictionAlimentaireMembre)
, FOREIGN KEY(idRestrictionAlimentaire)
	REFERENCES RestrictionsAlimentaires(idRestrictionAlimentaire)
, FOREIGN KEY(idMembre)
	REFERENCES Membres(idMembre)
);

CREATE TABLE IF NOT EXISTS ObjectifsMembres 
( idObjectifMembre INT AUTO_INCREMENT
, idObjectif INT NOT NULL
, idMembre INT NOT NULL
, PRIMARY KEY(idObjectifMembre)
, FOREIGN KEY(idObjectif)
	REFERENCES Objectifs(idObjectif)
, FOREIGN KEY(idMembre)
	REFERENCES Membres(idMembre)
);

CREATE TABLE IF NOT EXISTS PreferencesMembres 
( idPreferenceMembre INT AUTO_INCREMENT
, idPreference INT NOT NULL
, idMembre INT NOT NULL
, PRIMARY KEY(idPreferenceMembre)
, FOREIGN KEY(idPreference)
	REFERENCES Preferences(idPreference)
, FOREIGN KEY(idMembre)
	REFERENCES Membres(idMembre)
);

CREATE TABLE IF NOT EXISTS Menus 
( idMenu INT AUTO_INCREMENT
, idMembre INT NOT NULL
, dateMenu DATETIME NOT NULL
, PRIMARY KEY(idMenu)
, FOREIGN KEY(idMembre)
	REFERENCES Membres(idMembre)
);

CREATE TABLE IF NOT EXISTS TypesPlats
( idTypePlat INT AUTO_INCREMENT
, typePlat VARCHAR(15) UNIQUE
, PRIMARY KEY(idTypePlat)
);

CREATE TABLE IF NOT EXISTS Plats
( idPlat INT AUTO_INCREMENT
, idMembre INT NOT NULL
, idTypePlat INT NOT NULL
, nom VARCHAR(50) NOT NULL UNIQUE
, imageUrl VARCHAR(100)
, note DOUBLE
, PRIMARY KEY(idPlat)
, FOREIGN KEY(idMembre)
	REFERENCES Membres(idMembre)
, FOREIGN KEY(idTypePlat)
	REFERENCES TypesPlats(idTypePlat)
);

CREATE TABLE IF NOT EXISTS MenusPlats
( idMenuPlat INT AUTO_INCREMENT
, idMenu INT NOT NULL
, idPlat INT NOT NULL
, PRIMARY KEY(idMenuPlat)
, FOREIGN KEY(idMenu)
	REFERENCES Menus(idMenu)
, FOREIGN KEY(idPlat)
	REFERENCES Plats(idPlat)
);

CREATE TABLE IF NOT EXISTS UnitesMesure
( idUniteMesure INT AUTO_INCREMENT
, uniteMesure VARCHAR(15) NOT NULL UNIQUE
, symbole VARCHAR(3) NOT NULL UNIQUE
, PRIMARY KEY(idUniteMesure)
);

CREATE TABLE IF NOT EXISTS GroupesAlimentaires
( idGroupeAlimentaire INT AUTO_INCREMENT
, groupeAlimentaire VARCHAR(30) NOT NULL UNIQUE
, PRIMARY KEY(idGroupeAlimentaire)
);

CREATE TABLE IF NOT EXISTS Aliments
( idAliment INT AUTO_INCREMENT
, idUniteMesure INT NOT NULL
, idGroupeAlimentaire INT NOT NULL
, nom VARCHAR(30) NOT NULL UNIQUE
, mesure INT NOT NULL
, PRIMARY KEY(idAliment)
, FOREIGN KEY(idUniteMesure)
	REFERENCES UnitesMesure(idUniteMesure)
, FOREIGN KEY(idGroupeAlimentaire)
	REFERENCES GroupesAlimentaires(idGroupeAlimentaire)
);

CREATE TABLE IF NOT EXISTS PlatsAliments
( idPlatAliment INT AUTO_INCREMENT
, idPlat INT NOT NULL
, idAliment INT NOT NULL
, quantite DOUBLE NOT NULL
, PRIMARY KEY(idPlatAliment)
, FOREIGN KEY(idPlat) 
	REFERENCES Plats(idPlat)
, FOREIGN KEY(idAliment)
	REFERENCES Aliments(idAliment)
);

CREATE TABLE IF NOT EXISTS ValeursNutritionnelles
( idValeurNutritionnelle INT AUTO_INCREMENT
, idUniteMesure INT NOT NULL
, valeurNutritionnelle VARCHAR(15) NOT NULL UNIQUE
, PRIMARY KEY(idValeurNutritionnelle)
, FOREIGN KEY(idUniteMesure)
	REFERENCES UnitesMesure(idUniteMesure)
);

CREATE TABLE IF NOT EXISTS AlimentsValeursNutritionnelles
( idAlimentValeurNutritionnelle INT AUTO_INCREMENT
, idAliment INT NOT NULL
, idValeurNutritionnelle INT NOT NULL
, quantite DOUBLE NOT NULL
, PRIMARY KEY(idAlimentValeurNutritionnelle)
, FOREIGN KEY(idAliment)
	REFERENCES Aliments(idAliment)
, FOREIGN KEY(idValeurNutritionnelle)
	REFERENCES ValeursNutritionnelles(idValeurNutritionnelle)
);