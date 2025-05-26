1/
-- Sélectionne les utilisateurs ayant au moins une réservation enregistrée
SELECT DISTINCT u.* FROM utilisateur u
JOIN reservation r ON u.id_utilisateur = r.id_utilisateur;

2/
-- Sélectionne les matériels qui n’apparaissent dans aucune réservation
SELECT m.* FROM materiel m
LEFT JOIN reservation r ON m.id_materiel = r.id_materiel WHERE r.id_materiel IS NULL;

-- Le LEFT JOIN permet de récupérer tous les matériels. Le IS NULL filtre uniquement ceux jamais empruntés.

3/
-- Sélectionner les matériels empruntés plus de 3 fois
SELECT id_materiel FROM reservation
GROUP BY id_materiel HAVING COUNT(*) > 3;

4/
SELECT u.id_utilisateur, u.nom, u.prenom, COUNT(r.id_reservation) AS nb_emprunts FROM utilisateur u
LEFT JOIN reservation r ON u.id_utilisateur = r.id_utilisateur
-- Affiche aussi ceux sans réservation grâce au LEFT JOIN comme à la 2/

GROUP BY u.id_utilisateur, u.nom, u.prenom ORDER BY u.id_utilisateur;