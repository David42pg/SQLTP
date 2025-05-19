SELECT * FROM utilisateur
WHERE nom LIKE 'D%';

SELECT * FROM materiel
WHERE categorie = 'Accessoires' AND quantite::INTEGER > 15;

SELECT * FROM reservation as r 
where r.date_debut > now()