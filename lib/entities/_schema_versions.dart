/// Versions de schéma de persistance par entité.
///
/// Une entité bump sa version dès qu'elle change son JSON layout de façon
/// non rétro-compatible. Les migrations dédiées (entities/migrations/) sont
/// responsables d'amener un blob ancienne version → version courante.
///
/// **Important** : `schemaVersion` n'est plus un champ d'entité — il est
/// injecté par le repository au moment du `save()` et lu par la migration
/// au moment du `load()`.
library;

const int kGameSessionSchemaVersion = 2;
const int kSettingsSchemaVersion = 3;
const int kStatsSchemaVersion = 1;
