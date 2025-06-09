-- Création d'un index sur la colonne 'date_debut' de la table 'disponibilite'
CREATE INDEX idx_disponibilite_date_debut ON disponibilite(date_debut); -- Cet index permet d'accélérer les requêtes qui filtrent sur cette colonne (ex: WHERE date_debut >= ...)

-- Création d'index sur les clés étrangères pour améliorer la performance des jointures, index sur la colonne 'numero_etudiant' dans la table 'reservation'
CREATE INDEX idx_reservation_numero_etudiant ON reservation(numero_etudiant); -- Cela accélère les jointures entre 'reservation' et 'utilisateur' sur cette colonne

-- Index sur la colonne 'identifiant_materiel' dans la table 'reservation'. Permet d'optimiser les jointures entre 'reservation' et 'materiel'
CREATE INDEX idx_reservation_identifiant_materiel ON reservation(identifiant_materiel);

-- Index sur la colonne 'id_disponibilite' dans la table 'reservation'. Optimise les jointures entre 'reservation' et 'disponibilite'
CREATE INDEX idx_reservation_id_disponibilite ON reservation(id_disponibilite);

-- Ces indexes réduisent les scans séquentiels coûteux et ainsi d'améliorer significativement la vitesse des requêtes impliquant ces colonnes

