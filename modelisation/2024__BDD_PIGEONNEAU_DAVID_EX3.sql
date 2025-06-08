SELECT utilisateur.*, reservation.date_debut, reservation.date_fin
FROM utilisateur JOIN reservation ON utilisateur.id_utilisateur = reservation.id_utilisateur; 
-- Sélectionne tous les utilisateurs ayant fait une réservation, en affichant leurs informations ainsi que les dates de réservation.

SELECT materiel.*FROM materiel
JOIN reservation ON materiel.id_materiel = reservation.id_materiel WHERE reservation.id_utilisateur = 3;
-- Sélectionne tous les matériels réservés par l’utilisateur ayant l’ID 3
