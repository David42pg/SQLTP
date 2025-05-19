SELECT utilisateur.*, reservation.date_debut, reservation.date_fin
FROM utilisateur JOIN reservation ON utilisateur.id_utilisateur = reservation.id_utilisateur;

SELECT materiel.*FROM materiel
JOIN reservation ON materiel.id_materiel = reservation.id_materiel WHERE reservation.id_utilisateur = 3;
