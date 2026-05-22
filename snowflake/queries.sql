-- ============================================================
-- PROJET OLIST — Requêtes Snowflake
-- ============================================================

-- ── SETUP ────────────────────────────────────────────────────
-- Création de la base de données et du schéma
CREATE DATABASE IF NOT EXISTS olist_db;
USE DATABASE olist_db;
CREATE SCHEMA IF NOT EXISTS gold;

-- ── ANALYSE 1 : Commandes par mois ───────────────────────────
-- Nombre de commandes groupées par mois
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) as mois,
    COUNT(*) as nb_commandes
FROM "olist-db".PUBLIC.ORDERS_PAR_MOIS
GROUP BY mois
ORDER BY mois;

-- ── ANALYSE 2 : Taux de livraison par statut ─────────────────
-- Pourcentage de chaque statut sur le total
SELECT 
    order_status,
    COUNT(*) as nb_commandes,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as pourcentage
FROM "olist-db".PUBLIC.ORDERS_PAR_MOIS
GROUP BY order_status
ORDER BY nb_commandes DESC;

-- ── ANALYSE 3 : Délai moyen de livraison ─────────────────────
-- Délai min, moyen et max en jours
SELECT
    ROUND(AVG(DATEDIFF('day', 
        order_purchase_timestamp, 
        order_delivered_customer_date
    )), 1) as delai_moyen_jours,
    MIN(DATEDIFF('day',
        order_purchase_timestamp,
        order_delivered_customer_date
    )) as delai_min_jours,
    MAX(DATEDIFF('day',
        order_purchase_timestamp,
        order_delivered_customer_date
    )) as delai_max_jours
FROM "olist-db".PUBLIC.ORDERS_PAR_MOIS
WHERE order_delivered_customer_date IS NOT NULL;

-- ── TIME TRAVEL ───────────────────────────────────────────────
-- Récupérer les données telles qu'elles étaient il y a 5 minutes
SELECT COUNT(*) as nb_lignes_avant_suppression
FROM "olist-db".PUBLIC.ORDERS_PAR_MOIS
AT(OFFSET => -300);

-- ── VUE : Commandes par mois avec pourcentage ────────────────
CREATE OR REPLACE VIEW "olist-db".PUBLIC.VW_COMMANDES_PAR_MOIS AS
    SELECT 
        DATE_TRUNC('month', order_purchase_timestamp) as mois,
        COUNT(*) as nb_commandes,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as pourcentage
    FROM "olist-db".PUBLIC.ORDERS_PAR_MOIS
    GROUP BY mois;
