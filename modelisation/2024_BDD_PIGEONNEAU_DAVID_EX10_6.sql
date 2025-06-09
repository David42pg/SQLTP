EXPLAIN ANALYZE -- Exécute la requête et affiche un plan détaillé d'exécution avec les temps réels, cela permet d'identifier les étapes lentes ou coûteuses de la requête
SELECT 
    u.id_utilisateur,                           -- Sélectionne l'ID de l'utilisateur
    u.nom,                                     -- Sélectionne le nom de l'utilisateur
    u.prenom,                                  -- Sélectionne le prénom de l'utilisateur
    m.id_materiel,                             -- Sélectionne l'ID du matériel réservé
    m.nom AS nom_materiel,                     -- Sélectionne le nom du matériel (alias pour clarté)
    r.id_reservation,                          -- Sélectionne l'ID de la réservation
    r.date_debut AS date_debut_reservation,   -- Date de début de la réservation
    r.date_fin AS date_fin_reservation,       -- Date de fin de la réservation
    d.date_debut AS date_debut_disponibilite, -- Date de début de disponibilité du matériel
    d.date_fin AS date_fin_disponibilite      -- Date de fin de disponibilité du matériel
FROM 
    reservation r                             -- Table principale : réservation

JOIN utilisateur u ON r.numero_etudiant = u.id_utilisateur  
    -- Jointure avec utilisateur pour récupérer les infos de l'utilisateur via l'ID utilisateur

JOIN materiel m ON r.identifiant_materiel = m.id_materiel  
    -- Jointure avec matériel pour récupérer les infos du matériel réservé

JOIN disponibilite d ON r.id_disponibilite = d.id_disponibilite  
    -- Jointure avec disponibilité pour récupérer la période de disponibilité du matériel réservé

WHERE 
    d.date_debut >= '2025-06-01'             -- Filtre sur les disponibilités à partir du 1er juin 2025

ORDER BY -- Le tri peut être coûteux s'il est fait sur un grand nombre de lignes sans index qui optimise cet ordre.
    d.date_debut,                            -- Tri des résultats par date de début de disponibilité
    r.date_debut;                            -- Puis tri par date de début de réservation en cas d'égalité

-- Le plan d'exécution affiché par EXPLAIN ANALYZE montre comment PostgreSQL lit et combine les données. Il peut indiquer si des scans séquentiels (seq scan) sont utilisés, ce qui peut être lent pour de grandes tables. Un scan séquentiel signifie que la table entière est lue ligne par ligne sans utiliser d'index.
-- Les jointures sont souvent réalisées via des boucles imbriquées (nested loop), hash joins ou merge joins. Les boucles imbriquées sans index sur les colonnes jointes sont coûteuses car elles font une recherche pour chaque ligne.



