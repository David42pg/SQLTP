CREATE TABLE utilisateur(
   id_utilisateur VARCHAR(50),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   PRIMARY KEY(id_utilisateur)
);

CREATE TABLE materiel(
   id_materiel COUNTER,
   nom VARCHAR(50),
   categorie VARCHAR(50),
   quantite VARCHAR(50),
   PRIMARY KEY(id_materiel)
);

CREATE TABLE reservation(
   id_reservation COUNTER,
   date_debut VARCHAR(50),
   date_fin VARCHAR(50),
   id_materiel INT,
   id_utilisateur VARCHAR(50),
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_materiel) REFERENCES materiel(id_materiel),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);
