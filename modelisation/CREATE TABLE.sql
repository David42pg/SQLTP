CREATE TABLE utilisateur (
   id_utilisateur SERIAL PRIMARY KEY,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(100)
);

CREATE TABLE materiel (
   id_materiel SERIAL PRIMARY KEY,
   nom VARCHAR(50),
   categorie VARCHAR(50),
   quantite INTEGER
);

CREATE TABLE reservation (
   id_reservation SERIAL PRIMARY KEY,
   date_debut DATE,
   date_fin DATE,
   id_materiel INTEGER,
   id_utilisateur INTEGER,
   FOREIGN KEY (id_materiel) REFERENCES materiel(id_materiel),
   FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);
