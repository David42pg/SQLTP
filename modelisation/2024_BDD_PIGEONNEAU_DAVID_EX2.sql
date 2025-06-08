SELECT * FROM utilisateur
WHERE nom LIKE 'D%'; -- Sélectionne tous les utilisateurs dont le nom commence par la lettre 'D'

SELECT * FROM materiel
WHERE categorie = 'Accessoires' AND quantite::INTEGER > 15; -- Sélectionne tous les matériels de la catégorie 'Accessoires' dont la quantité est strictement supérieure à 15

SELECT * FROM reservation as r 
where r.date_debut > now() -- Sélectionne toutes les réservations dont la date de début est postérieure à la date et l'heure actuelles
