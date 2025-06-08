1/
-- Suppression ciblée d’une réservation précise (réservation avec l'identifiant 5)
DELETE FROM reservation WHERE id_reservation = 5; -- WHERE pour supprimer uniquement cette ligne spécifique


2/
-- Vérification des réservations dont la date de fin est déjà dépassée
SELECT * FROM reservation
WHERE date_fin < CURRENT_DATE; -- CURRENT_DATE représente la date actuelle (sans l'heure)
-- On liste toutes les réservations qui sont "terminées"

-- Supprimer une seule réservation dont la date de retour est passée
DELETE FROM reservation
WHERE id_reservation = (
  SELECT id_reservation FROM reservation WHERE date_fin < CURRENT_DATE -- On sélectionne l’ID d’une réservation expirée (la plus ancienne dans le temps)
  ORDER BY date_fin ASC -- Trie les résultats du plus ancien au plus récent
  LIMIT 1 -- permet de ne prendre qu’un seul enregistrement (le plus ancien).
);


-- Vérification après suppression, la même requête SELECT est utilisé
SELECT * FROM reservation
WHERE date_fin < CURRENT_DATE;
