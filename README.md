# olist-data-pipeline
End-to-end data pipeline with Databricks, Snowflake and Dataiku
# 🚀 Olist Data Pipeline — End-to-End Data Engineering Project

## 📋 Description
Pipeline de données end-to-end sur le dataset e-commerce brésilien Olist.
Ce projet couvre l'ingestion, la transformation, le stockage et le Machine Learning
en utilisant les outils data les plus demandés en entreprise.

## 🏗️ Architecture
CSV (Kaggle) → Databricks/Spark → Snowflake → Dataiku
Bronze/Silver/Gold   DWH         ML + Dashboard

## 🛠️ Stack Technique

| Outil | Rôle |
|---|---|
| **Databricks + PySpark** | Ingestion et transformation (Bronze/Silver/Gold) |
| **Snowflake** | Data Warehouse, SQL Analytics, Time Travel |
| **Dataiku** | Data Quality, Machine Learning, Dashboard |
| **GitHub** | Versionning du code |

## 📊 Dataset
- **Source** : Brazilian E-Commerce (Olist) — Kaggle
- **Volume** : 99 441 commandes
- **Période** : Septembre 2016 → Octobre 2018

## 🔑 Points clés du projet
- Architecture **Bronze / Silver / Gold** (Medallion Architecture)
- Détection et correction d'un **Data Leak** (R2 : 0.896 → 0.081)
- **Time Travel** Snowflake — restauration de 625 lignes supprimées
- Modèle ML **Random Forest** pour prédire le délai de livraison
- **Data Quality Rules** automatisées dans Dataiku

## 📁 Structure du repo
olist-data-pipeline/
├── databricks/
│   └── pipeline.py      # Pipeline PySpark Bronze/Silver/Gold
├── snowflake/
│   └── queries.sql      # Requêtes SQL analytiques
└── README.md

## 👤 Auteur
Ange Ingrid IRIHO
