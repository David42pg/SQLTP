1/ -- Table pour enregistrer les retours
CREATE TABLE RetourMateriel (
    id_retour SERIAL PRIMARY KEY,                         -- Identifiant unique du retour
    id_reservation INT REFERENCES reservation(id_reservation),  -- Référence à la réservation concernée
    date_retour DATE NOT NULL,                            -- Date de retour effective saisie par l'utilisateur
    retard BOOLEAN DEFAULT FALSE                          -- Indicateur de retard (true si en retard), type BOOLEAN, c'est-à-dire qu'il ne peut prendre que deux valeurs possibles : TRUE ou FALSE
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

    est_en_retard := p_date_retour > fin_prev;     -- Vérifier si le retour est en retard

    -- Mettre à jour la réservation avec la date de retour
    UPDATE reservation SET date_retour_effectif = p_date_retour WHERE id_reservation = p_id_reservation;

    -- Insérer l’enregistrement dans la table des retours
    INSERT INTO RetourMateriel (id_reservation, date_retour, retard) VALUES (p_id_reservation, p_date_retour, est_en_retard);

    IF est_en_retard THEN -- Condition IF pour vérifier si le matériel est rendu en retard
        RETURN 'Retour enregistré avec RETARD'; -- Si la variable est_en_retard est vraie, on retourne un message indiquant un retour en retard
    ELSE
        RETURN 'Retour enregistré à temps'; -- Sinon, on retourne un message indiquant un retour dans les temps
    END IF;
END;


4/
SELECT
    res.id_reservation,                          -- ID de la réservation
    rm.date_retour,                              -- Date à laquelle le matériel a été retourné
    res.datefin,                                 -- Date prévue de retour
    CASE
    WHEN rm.retard = TRUE THEN              -- Condition : si un retard est signalé (valeur TRUE)
            EXTRACT(DAY FROM rm.date_retour - res.datefin) * 2  -- Calcul de la pénalité en euros, on calcule le nombre de jours de retard (date_retour - datefin), 2 € par jour de retard
        ELSE 0 END AS montant_penalite           -- Sinon, pas de pénalité, donc 0
FROM RetourMateriel rm                            -- Table des retours effectifs du matériel
JOIN reservation res ON rm.id_reservation = res.id_reservation;
-- Jointure pour récupérer les informations de réservation correspondantes à chaque retour


5/
SELECT enregistrer_retour(1, '2025-05-22'); -- correspond à la fin prévue
-- La fonction va mettre à jour la réservation avec cette date de retour effective.
