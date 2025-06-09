-- Relancer la requête avec EXPLAIN ANALYZE 

EXPLAIN ANALYZE
SELECT 
    u.id_utilisateur,
    u.nom,
    u.prenom,
    m.id_materiel,
    m.nom AS nom_materiel,
    r.id_reservation,
    r.date_debut AS date_debut_reservation,
    r.date_fin AS date_fin_reservation,
    d.date_debut AS date_debut_disponibilite,
    d.date_fin AS date_fin_disponibilite
FROM 
    reservation r
JOIN utilisateur u ON r.numero_etudiant = u.id_utilisateur
JOIN materiel m ON r.identifiant_materiel = m.id_materiel
JOIN disponibilite d ON r.id_disponibilite = d.id_disponibilite
WHERE 
    d.date_debut >= '2025-06-01'
ORDER BY 
    d.date_debut,
    r.date_debut;


-- Il est possible d'observer que le temps total d'exécution diminue significativement, cela valide donc l'efficacité des index pour optimiser la requête