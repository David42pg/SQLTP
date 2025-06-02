1/ -- Table pour enregistrer les retours
CREATE TABLE RetourMateriel (
    id_retour SERIAL PRIMARY KEY,                         -- Identifiant unique du retour
    id_reservation INT REFERENCES reservation(id_reservation),  -- Référence à la réservation concernée
    date_retour DATE NOT NULL,                            -- Date de retour effective saisie par l'utilisateur
    retard BOOLEAN DEFAULT FALSE                          -- Indicateur de retard (true si en retard)
);

2/ -- Colonne facultative dans reservation pour historiser le retour
ALTER TABLE reservation ADD COLUMN date_retour_effectif DATE;

3/
-- Fonction pour enregistrer un retour et détecter le retard
CREATE OR REPLACE FUNCTION enregistrer_retour(p_id_reservation INT, p_date_retour DATE)
RETURNS TEXT AS $$
DECLARE
    fin_prev DATE;
    est_en_retard BOOLEAN;
BEGIN
    -- Récupérer la date de fin prévue pour la réservation
    SELECT date_fin INTO fin_prev FROM reservation WHERE id_reservation = p_id_reservation;

    -- Vérifier si le retour est en retard
    est_en_retard := p_date_retour > fin_prev;

    -- Mettre à jour la réservation avec la date de retour
    UPDATE reservation
    SET date_retour_effectif = p_date_retour
    WHERE id_reservation = p_id_reservation;

    -- Insérer l’enregistrement dans la table des retours
    INSERT INTO RetourMateriel (id_reservation, date_retour, retard)
    VALUES (p_id_reservation, p_date_retour, est_en_retard);

    IF est_en_retard THEN
        RETURN 'Retour enregistré avec RETARD';
    ELSE
        RETURN 'Retour enregistré à temps';
    END IF;
END;
$$ LANGUAGE plpgsql;


4/
SELECT
    res.id_reservation,                          -- ID de la réservation
    rm.date_retour,                              -- Date à laquelle le matériel a été retourné
    res.datefin,                                 -- Date prévue de retour
    CASE
        WHEN rm.retard = TRUE THEN
            EXTRACT(DAY FROM rm.date_retour - res.datefin) * 2  -- Pénalité : 2 € par jour de retard
        ELSE 0
    END AS montant_penalite
FROM RetourMateriel rm
JOIN reservation res ON rm.id_reservation = res.id_reservation;

5/
SELECT enregistrer_retour(1, '2025-05-22'); -- correspond à la fin prévue
-- La fonction va mettre à jour la réservation avec cette date de retour effective.