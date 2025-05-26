1/
-- Compter le nombre total de réservations effectuées sur une période précise : du 1er au 31 mai 2025 inclus.
SELECT COUNT(*) AS total_reservations
FROM reservation WHERE date_debut >= '2025-05-01' AND date_fin <= '2025-05-31';

-- Elle utilise la fonction d’agrégation COUNT(*) pour compter toutes les lignes



2/
SELECT COUNT(DISTINCT id_utilisateur) AS utilisateurs_ayant_emprunte
FROM reservation;

-- COUNT(DISTINCT ...) est utiliser pour ne compter chaque utilisateur qu’une seule fois.