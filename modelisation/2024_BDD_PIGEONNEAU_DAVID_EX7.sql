1/
-- Sélectionne les utilisateurs ayant au moins une réservation enregistrée
SELECT DISTINCT u.* FROM utilisateur u JOIN reservation r ON u.id_utilisateur = r.id_utilisateur;
-- DISTINCT permet d’éviter les doublons si un utilisateur a plusieurs réservations
-- La jointure interne (JOIN) ne retourne que les utilisateurs ayant une correspondance dans la table reservation, le alias "u" rend la requête plus lisible et permet de cibler les colonnes de la table utilisateur
2/
-- Sélectionne les matériels qui n’apparaissent dans aucune réservation
SELECT m.* FROM materiel m LEFT JOIN reservation r ON m.id_materiel = r.id_materiel WHERE r.id_materiel IS NULL;

-- Le LEFT JOIN récupère tous les matériels, qu’ils aient une réservation ou non. La condition WHERE r.id_materiel IS NULL filtre ces lignes pour ne garder que les matériels jamais empruntés
-- Les matériels sans réservation auront des valeurs NULL pour les colonnes de reservation

3/
-- Sélectionner les matériels empruntés plus de 3 fois
SELECT id_materiel FROM reservation
GROUP BY id_materiel HAVING COUNT(*) > 3;  -- GROUP BY regroupe les réservations par id_materiel, COUNT(*) compte le nombre de réservations pour chaque matériel
-- HAVING filtre les groupes dont le total de réservations dépasse 3

4/
-- Affiche le nombre de réservations faites par chaque utilisateur
SELECT u.id_utilisateur, u.nom, u.prenom, COUNT(r.id_reservation) AS nb_emprunts FROM utilisateur u
LEFT JOIN reservation r ON u.id_utilisateur = r.id_utilisateur -- Affiche aussi ceux sans réservation grâce au LEFT JOIN comme à la 2/
GROUP BY u.id_utilisateur, u.nom, u.prenom ORDER BY u.id_utilisateur; -- Trie le résultat par ID utilisateur, pour un affichage organisé
