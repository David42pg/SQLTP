1/
-- Créer une nouvelle table disponibilite qui contient les périodes pendant lesquelles un matériel est disponible.

CREATE TABLE disponibilite (
    id_disponibilite SERIAL PRIMARY KEY,                  -- Identifiant unique
    id_materiel INT REFERENCES materiel(id_materiel),     -- Lien avec le matériel concerné
    date_debut DATE,                                      -- Début de la période de disponibilité
    date_fin DATE                                         -- Fin de la période de disponibilité
);

2/ -- La table reservation est modifié pour ajouter une référence à la disponibilité utilisée lors de la réservation 
ALTER TABLE reservation
ADD COLUMN id_disponibilite INT REFERENCES disponibilite(id_disponibilite);
);

3/
-- On met une contrainte de type check CREATE TABLE disponibilite (
    id_disponibilite SERIAL PRIMARY KEY,                  -- Identifiant unique
    id_materiel INT REFERENCES materiel(id_materiel),     -- Lien avec le matériel concerné
    date_debut DATE,                                      -- Début de la période de disponibilité
    date_fin DATE,                                         -- Fin de la période de disponibilité
    CONSTRAINT chk_dates CHECK (date_fin > date_debut)    -- Contrainte CHECK pour que date_fin soit après date_debut
);


4/
-- On crée une disponiblité pour essayer pas par pas avant de crée l'implémentation
INSERT INTO disponibilite (id_disponibilite, id_materiel, date_debut, date_fin)
VALUES (1, 1, '2025-06-01', '2025-06-15');

-- La requête suivante est effectuer pour tester si les manipulations précédentes fonctionnent avec le matériel 1 et 3.
SELECT CASE 
        WHEN EXISTS (
            SELECT FROM disponibilite WHERE id_materiel = 3
              AND date_debut <= DATE '2025-06-01'
              AND date_fin >= DATE '2025-06-05'
        )
        THEN 'OK'  -- Le matériel est disponible
        ELSE 'KO'  -- Aucune disponibilité ne couvre cette période
    END AS disponibilite_statut;

-- Il y a bien marqué disponible pour le matériel 1 et indisponible pour le matériel 3
-- Pour ajouter une fonctionnalité qui permettra de vérifier la disponibilité comme précédemment, en plus de réserver :

CREATE OR REPLACE FUNCTION reserver_materiel(
    p_id_utilisateur INT,
    p_id_materiel INT,
    p_date_debut DATE,
    p_date_fin DATE
) RETURNS TEXT AS $$
BEGIN
    -- Vérifier qu'il existe une disponibilité couvrant la période demandée
    IF EXISTS (
        SELECT 1 FROM disponibilite
        WHERE id_materiel = p_id_materiel
          AND date_debut <= p_date_debut
          AND date_fin >= p_date_fin
    ) THEN
        -- Insérer la réservation
        INSERT INTO reservation (date_debut, date_fin, id_materiel, id_utilisateur)
        VALUES (p_date_debut, p_date_fin, p_id_materiel, p_id_utilisateur);
        RETURN 'Réservation réussie.';
    ELSE
        RETURN 'Erreur : matériel indisponible pour cette période.';
    END IF;
END;
$$ LANGUAGE plpgsql;


5/
-- Ajouter une période de disponibilité pour un matériel (exemple : matériel 4 du 1 au 30 juin 2025)
INSERT INTO disponibilite (id_materiel, date_debut, date_fin)
VALUES (4, '2025-06-01', '2025-06-30');

-- Modifier une période de disponibilité existante (id_disponibilite = 2)
UPDATE disponibilite SET date_debut = '2025-06-05', date_fin = '2025-06-25' WHERE id_disponibilite = 2;

-- Supprimer une période de disponibilité (id_disponibilite = 2)
DELETE FROM disponibilite WHERE id_disponibilite = 2;


6/ -- Réalise une réservation du matériel d’ID 4 par l’utilisateur d’ID 1,
    SELECT reserver_materiel(1, 4, '2025-06-05', '2025-06-10');
