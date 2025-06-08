-- Création de la table des utilisateurs
CREATE TABLE utilisateur (
   id_utilisateur SERIAL PRIMARY KEY,   -- Clé primaire unique, auto-incrémentée (grâce à SERIAL)
   nom VARCHAR(50),                     -- Nom de famille, texte de 50 caractères maximum
   prenom VARCHAR(50),                  -- Prénom, texte de 50 caractères maximum
   email VARCHAR(100)                   -- Adresse email, texte de 100 caractères max
);


-- Création de la table des matériels disponibles
CREATE TABLE materiel (
   id_materiel SERIAL PRIMARY KEY,      -- Clé primaire unique pour identifier chaque matériel
   nom VARCHAR(50),                     -- Nom du matériel (ex : "Ordinateur Portable"), texte de 50 caractères maximum
   categorie VARCHAR(50),               -- Catégorie (ex : "Informatique", "Sécurité", etc.), texte de 50 caractères maximum
   quantite INTEGER                     -- Quantité disponible dans le stock, utilisation de INTEGER car ces champs sont des clés étrangères, ils doivent correspondre aux identifiants (INTEGER) des tables référencées
);


-- Création de la table des réservations
CREATE TABLE reservation (
   id_reservation SERIAL PRIMARY KEY,       -- Clé primaire unique de la réservation
   date_debut DATE,                         -- Date de début de la réservation
   date_fin DATE,                           -- Date de fin de la réservation
   id_materiel INTEGER,                     -- Référence à l’identifiant du matériel
   id_utilisateur INTEGER,                  -- Référence à l’identifiant de l’utilisateur
   FOREIGN KEY (id_materiel) REFERENCES materiel(id_materiel),    -- Contrainte de clé étrangère : lien avec la table materiel
   FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)  -- Lien avec la table utilisateur
);
