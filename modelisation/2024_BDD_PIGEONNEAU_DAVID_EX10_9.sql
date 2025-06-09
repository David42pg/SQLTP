-- Activer l'extension pg_trgm pour utiliser des index trigrammes 
CREATE EXTENSION IF NOT EXISTS pg_trgm;


-- L'opérateur gin_trgm_ops spécifie que l'index utilise la méthode trigramme
CREATE INDEX idx_utilisateur_nom_gin ON utilisateur USING gin (nom gin_trgm_ops);

-- Exemple de requête avec LIKE utilisant cet index, recherche des utilisateurs dont le nom contient la chaîne 'nom1' n'importe où
EXPLAIN ANALYZE
SELECT * FROM utilisateur
WHERE nom LIKE '%nom1%';

-- Le plan d'exécution montre un 'Index Scan', cela permet d'éviter un scan séquentiel coûteux sur la table entière

