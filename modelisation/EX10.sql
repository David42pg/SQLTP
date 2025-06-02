Un index

SELECT u.nom, r.datedebut, r.datefin
FROM reservation r
JOIN utilisateur u ON r.id_utilisateur = u.id_utilisateur
WHERE r.id_materiel = 42
ORDER BY r.datedebut DESC
LIMIT 10;
