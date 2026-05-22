# ============================================================
# PROJET OLIST — Pipeline Data End-to-End
# Databricks + PySpark
# ============================================================

######## ── COUCHE BRONZE ────────────────────────────────────────────
# Chargement des données brutes depuis le volume Databricks
df = spark.read.csv(
    "/Volumes/workspace/default/ingrid_projet/olist_orders_dataset.csv",
    header=True,
    inferSchema=True
)

# Sauvegarde en format Delta (données brutes)
df.write.format("delta").mode("overwrite").save(
    "/Volumes/workspace/default/ingrid_projet/bronze/orders"
)

# ── COUCHE SILVER ────────────────────────────────────────────
# Nettoyage : suppression des nulls sur la date de livraison
df_silver = df.dropna(subset=["order_delivered_customer_date"])

# Sauvegarde en Silver
df_silver.write.format("delta").mode("overwrite").save(
    "/Volumes/workspace/default/ingrid_projet/silver/orders"
)

# ── COUCHE GOLD ──────────────────────────────────────────────
from pyspark.sql.functions import date_format, count

# Agrégation : nombre de commandes par mois et par statut
df_gold = df_silver \
    .withColumn("mois", date_format("order_purchase_timestamp", "yyyy-MM")) \
    .groupBy("mois", "order_status") \
    .agg(count("order_id").alias("nb_commandes")) \
    .orderBy("mois")

# Sauvegarde en Gold
df_gold.write.format("delta").mode("overwrite").save(
    "/Volumes/workspace/default/ingrid_projet/gold/orders_par_mois"
)

# Export CSV pour Snowflake
df_gold.toPandas().to_csv(
    "/Volumes/workspace/default/ingrid_projet/gold/orders_par_mois.csv",
    index=False
)
