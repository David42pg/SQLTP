1/
-- Suppression ciblée d’une réservation précise
DELETE FROM reservation WHERE id_reservation = 5;


2/
-- Pour vérifier avant 
SELECT * FROM reservation
WHERE date_fin < CURRENT_DATE;

-- Supprimer une seule réservation dont la date de retour est passée
DELETE FROM reservation
WHERE id_reservation = (
  SELECT id_reservation
  FROM reservation
  WHERE date_fin < CURRENT_DATE
  ORDER BY date_fin ASC
  LIMIT 1
);


-- Pour vérifier après 
SELECT * FROM reservation
WHERE date_fin < CURRENT_DATE;
