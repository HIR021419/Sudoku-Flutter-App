# Publier une release

## Setup initial (à faire une fois)

### 1. Générer un keystore release

Sur ta machine locale :

```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -alias upload \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

Tu seras prompté pour des informations (nom, organisation, etc.) et un mot de passe.

**Conserve ce fichier en lieu sûr** — le perdre signifie ne plus pouvoir mettre à jour l'app sur le Play Store.

### 2. Configurer les secrets GitHub

Encoder le keystore en base64 :

```bash
base64 -w 0 upload-keystore.jks > keystore.base64.txt
```

Sur GitHub : **Settings → Secrets and variables → Actions → New repository secret**. Ajouter :

| Secret | Valeur |
|---|---|
| `KEYSTORE_BASE64` | contenu de `keystore.base64.txt` |
| `KEYSTORE_PASSWORD` | mot de passe du store |
| `KEY_PASSWORD` | mot de passe de la clé (souvent identique au store) |
| `KEY_ALIAS` | alias, ex: `upload` |

### 3. Setup local (optionnel, pour builder en release depuis ton poste)

```bash
cp android/key.properties.example android/key.properties
# Édite android/key.properties avec tes vrais mots de passe + chemin vers le keystore
```

`android/key.properties` est gitignored. Le keystore aussi (via `*.jks` dans `.gitignore`).

## Flow de release

| Trigger | Job | Artifact | GitHub Release ? |
|---|---|---|---|
| Push tag `v*` | `build-signed-aab` | `sudoku-<tag>.aab` | ✅ AAB attaché |
| `workflow_dispatch` (build_aab=true) | `build-signed-aab` | `sudoku-<suffix>.aab` | ❌ |
| `workflow_dispatch` (build_apk=true) | `build-signed-apk` | `sudoku-<suffix>.apk` | ❌ |

L'APK n'est plus produit automatiquement — il sert au **sideload** (tests
internes hors Play Store, distribution directe). Le AAB est le format
**obligatoire** pour Play Store et seul livrable de release sur tag.

### Publier une release (Play Store)

```bash
git tag v1.0.0
git push origin v1.0.0
```

Déclenche :

1. **Analyze + test**
2. **Build AAB signé** (`flutter build appbundle --release`)
3. **GitHub Release** avec l'AAB attaché + release notes auto-générées
4. *(à venir)* Upload automatique vers Play Console — track "internal"

L'AAB est disponible :
- En artifact du run (90 jours)
- En attachement de la GitHub Release (permanent)

### Récupérer manuellement un AAB ou un APK

Onglet **Actions → CI → "Run workflow"** :

- **`build_aab=true`** : produit un AAB téléchargeable (utile pour la
  toute première publication Play Store avant d'avoir mis en place le
  versioning par tag).
- **`build_apk=true`** (défaut) : produit un APK signé pour sideload.
- **`version_suffix`** : suffixe du nom de fichier (défaut `manual` →
  `sudoku-manual.aab` / `sudoku-manual.apk`).

L'artifact est téléchargeable depuis la page du run (encart "Artifacts").

## Publication Play Store — première version (test interne)

Étapes pour la **première** publication :

1. Onglet **Actions → CI → Run workflow** → cocher **`build_aab`** → Run.
2. Une fois le run terminé, télécharger l'artifact `sudoku-manual-aab`
   depuis la page du run.
3. Sur [Play Console](https://play.google.com/console) :
   - Créer un compte développeur (25 USD une fois).
   - Créer une nouvelle app, renseigner les fiches obligatoires
     (description, captures d'écran, classification du contenu, etc.).
   - Aller dans **Tests → Tests internes → Créer une nouvelle version**.
   - Upload du `.aab` → ajouter les notes → enregistrer → publier.
4. Inviter les testeurs (par email ou lien Play). Une fois acceptés, ils
   reçoivent la version sur leur compte Play standard.

Une fois cette étape faite, les releases suivantes passent par tag (`git
tag vX.Y.Z && git push origin vX.Y.Z`) et l'AAB est généré automatiquement.

## Évolution prévue : publication automatique sur le track interne

Après la première publication manuelle, ajouter à `ci.yml` un job
d'upload via [`r0adkll/upload-google-play-action`](https://github.com/r0adkll/upload-google-play-action) :

1. Créer un service account Google Cloud avec le rôle "Release Manager"
   sur Play Console.
2. Stocker la clé JSON du service account dans le secret
   `PLAY_SERVICE_ACCOUNT_JSON`.
3. Ajouter un step après `build-signed-aab` qui upload l'AAB sur le
   track `internal`.

Conditions : ne pas activer ce step tant que la première version n'a
pas été publiée manuellement (Play Console refuse l'upload via API si
l'app n'a pas encore de release publiée à la main).
