INSERT INTO utilisateur (id_utilisateur, nom, prenom, email) -- Insertion des utilisateurs dans la table `utilisateur`
VALUES -- Chaque ligne insère un utilisateur avec son identifiant unique, son nom, prénom et adresse email.
(1, 'Giroud', 'Olivier', 'olivier.giroud@example.com'),
(2, 'Kant', 'Emmanuel', 'emmanuel.kant@example.com'),
(3, 'Dupont', 'Jean', 'jean.dupont@example.com'),
(4, 'Adams', 'John', 'john.adams@example.com'),
(5, 'David', 'Pierre', 'pierre.david@example.com'),
(6, 'Digne', 'Lucas', 'lucas.digne@example.com'),
(7, 'Clauss', 'Jonathan', 'jonathan.clauss@example.com'),
(8, 'Claude', 'Jean', 'jean.claude@example.com'),
(9, 'Kevin', 'Kevin', 'kevin.kevin@example.com'),
(10, 'Didier', 'Deschamps', 'didier.deschamps@example.com');

INSERT INTO materiel (id_materiel, nom, categorie, quantite) -- Insertion des matériels disponibles dans la table `materiel`
VALUES -- Chaque matériel a un identifiant unique, un nom, une catégorie et une quantité disponible.
(1, 'Ordinateur Portable', 'Informatique', 15),
(2, 'Projecteur', 'Audiovisuel', 5),
(3, 'Imprimante Laser', 'Bureau', 8),
(4, 'Tableau Blanc', 'Mobilier', 10),
(5, 'Routeur WiFi', 'Réseau', 12),
(6, 'Casque Audio', 'Accessoires', 20),
(7, 'Souris Sans Fil', 'Accessoires', 25),
(8, 'Caméra de Surveillance', 'Sécurité', 6),
(9, 'Disque Dur Externe', 'Stockage', 18),
(10, 'Clavier Mécanique', 'Accessoires', 22);


INSERT INTO reservation (id_reservation, date_debut, date_fin, id_materiel, id_utilisateur) -- Insertion des réservations de matériel dans la table `reservation`
VALUES -- Chaque ligne représente une réservation : elle associe un utilisateur à un matériel pour une période donnée. 
  -- Les colonnes `id_materiel` et `id_utilisateur` font référence respectivement aux tables `materiel` et `utilisateur`.
(1, '2025-05-20', '2025-05-22', 1, 3), -- Jean Dupont réserve un ordinateur portable
(2, '2025-05-21', '2025-05-23', 5, 7), -- Jonathan Clauss réserve un routeur WiFi
(3, '2025-05-22', '2025-05-25', 2, 1), -- Olivier Giroud réserve un projecteur
(4, '2025-05-24', '2025-05-26', 4, 9), -- Kevin Kevin réserve un tableau blanc
(5, '2025-05-25', '2025-05-27', 8, 2); -- Emmanuel Kant réserve une caméra de surveillance
