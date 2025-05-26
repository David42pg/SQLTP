1/
-- Simuler un emprunt de matériel en diminuant sa quantité disponible. Elle cible le matériel ayant l'identifiant 4.
UPDATE materiel SET quantite = quantite - 1
WHERE id_materiel = 4;



2/
-- Mettre à jour la quantité de tous les matériels qui sont actuellement empruntés et dont la date de fin de réservation est encore dans plus de 2 jours.
UPDATE materiel SET quantite = quantite - 1
WHERE id_materiel IN (SELECT DISTINCT id_materiel FROM reservation WHERE CURRENT_DATE BETWEEN date_debut AND date_fin
    AND date_fin > CURRENT_DATE + INTERVAL '2 days');
