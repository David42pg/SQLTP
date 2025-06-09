5/ 
SELECT 
    u.id_utilisateur,                            -- Identifiant unique de l'utilisateur
    u.nom,                                      -- Nom de l'utilisateur
    u.prenom,                                   -- Prénom de l'utilisateur
    m.id_materiel,                              -- Identifiant unique du matériel
    m.nom AS nom_materiel,                      -- Nom du matériel (avec alias pour clarté)
    r.id_reservation,                           -- Identifiant unique de la réservation
    r.date_debut AS date_debut_reservation,    -- Date de début de la réservation
    r.date_fin AS date_fin_reservation,         -- Date de fin de la réservation
    d.date_debut AS date_debut_disponibilite,  -- Date de début de disponibilité du matériel
    d.date_fin AS date_fin_disponibilite       -- Date de fin de disponibilité du matériel
FROM 
    reservation r                               -- Table principale : réservation, alias 'r'
JOIN utilisateur u ON r.numero_etudiant = u.id_utilisateur  
    -- Jointure avec la table utilisateur 
    -- pour associer chaque réservation à un utilisateur spécifique
JOIN materiel m ON r.identifiant_materiel = m.id_materiel  
    -- Jointure avec la table matériel 
    -- pour récupérer les détails du matériel réservé
JOIN disponibilite d ON r.id_disponibilite = d.id_disponibilite  
    -- Jointure avec la table disponibilité 
    -- pour connaître les périodes de disponibilité du matériel réservé
WHERE 
    d.date_debut >= '2025-06-01'               -- Filtre pour ne récupérer que les disponibilités 
                                               -- dont la date de début est le 1er juin 2025 ou après
ORDER BY 
    d.date_debut,                              -- Trie les résultats par date de début de disponibilité (ascendant par défaut)
    r.date_debut;                              -- En cas d'égalité, trie par date de début de réservation


