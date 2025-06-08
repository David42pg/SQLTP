1/ 
-- Suppression des contraintes pour pouvoir TRUNCATE
alter table reservation drop constraint reservation_numeroetudiant_fkey;
alter table reservation drop constraint reservation_identifiantmateriel_fkey;
alter table reservation drop constraint reservation_id_disponibilite_fkey;

-- Vider les tables avec réinitialisation des séquences et suppression en cascade
TRUNCATE TABLE reservation RESTART IDENTITY CASCADE;
TRUNCATE TABLE disponibilite RESTART IDENTITY CASCADE;
TRUNCATE TABLE materiel RESTART IDENTITY CASCADE;
TRUNCATE TABLE utilisateur RESTART IDENTITY CASCADE;

-- Insert 1,000,000 rows into utilisateur
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..1000000 LOOP
        INSERT INTO utilisateur (id_utilisateur, nom, prenom, email)
        VALUES (
            i,
            'nom_' || i,
            'prenom_' || i,
            'user_' || i || '@example.com'
        );
    END LOOP;
END $$;

-- Insert 1,000,000 rows into materiel
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..1000000 LOOP
        INSERT INTO materiel (id_materiel, nom, description, quantite)
        VALUES (
            i,
            'materiel_' || i,
            'description for materiel_' || i,
            (random() * 20)::INT + 1 -- Quantité aléatoire entre 1 et 20
        );
    END LOOP;
END $$;

-- Insert 2,000,000 rows into disponibilite
DO $$
DECLARE
    i INT;
    start_date DATE;
    end_date DATE;
BEGIN
    FOR i IN 1..2000000 LOOP
        start_date := DATE '2025-01-01' + (random() * 365)::INT;
        end_date := start_date + (random() * 30)::INT;

        INSERT INTO disponibilite (id_disponibilite, id_materiel, date_debut, date_fin, retard)
        VALUES (
            i,
            (random() * 999999)::INT + 1, -- id_materiel aléatoire entre 1 et 1,000,000
            start_date,
            end_date,
            (random() < 0.5) -- Boolean aléatoire (TRUE ou FALSE)
        );
    END LOOP;
END $$;

-- Insert 2,000,000 rows into reservation
DO $$
DECLARE
    i INT;
    reservation_date DATE;
    return_date DATE;
    effective_return_date DATE;
BEGIN
    FOR i IN 1..2000000 LOOP
        reservation_date := DATE '2025-01-01' + (random() * 365)::INT;
        return_date := reservation_date + (random() * 15)::INT;
        effective_return_date := reservation_date + (random() * 15)::INT;

        INSERT INTO reservation (id_reservation, date_debut, date_fin, numero_etudiant, identifiant_materiel, id_disponibilite, date_retour_effective)
        VALUES (
            i,
            reservation_date,
            return_date,
            (random() * 999999)::INT + 1,  -- numero_etudiant aléatoire entre 1 et 1,000,000
            (random() * 999999)::INT + 1,  -- identifiant_materiel aléatoire entre 1 et 1,000,000
            (random() * 1999999)::INT + 1, -- id_disponibilite aléatoire entre 1 et 2,000,000
            effective_return_date
        );
    END LOOP;
END $$;
