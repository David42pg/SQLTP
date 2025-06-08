1/
-- Simuler un emprunt de matériel en diminuant sa quantité disponible. 
UPDATE materiel SET quantite = quantite - 1 -- UPDATE est utilié pour modifier une ou plusieurs lignes dans une table.
WHERE id_materiel = 4; -- Elle cible le matériel ayant l'identifiant 4.



2/
-- Mettre à jour la quantité de tous les matériels qui sont actuellement empruntés et dont la date de fin de réservation est encore dans plus de 2 jours.
UPDATE materiel SET quantite = quantite - 1 -- UPDATE est utilié pour modifier une ou plusieurs lignes dans une table.
WHERE id_materiel IN (SELECT DISTINCT id_materiel FROM reservation -- IN (SELECT...) teste si une valeur est présente dans un ensemble de résultats.
    WHERE CURRENT_DATE BETWEEN date_debut AND date_fin -- Réservation en cours aujourd’hui
    AND date_fin > CURRENT_DATE + INTERVAL '2 days'); -- Réservation se terminant dans plus de 2 jours, INTERVAL '2 days' représente un écart de temps de 2 jours.
