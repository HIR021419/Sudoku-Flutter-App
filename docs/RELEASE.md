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

## Publier une release

```bash
git tag v1.0.0
git push origin v1.0.0
```

Le workflow `.github/workflows/ci.yml` se déclenche :

1. **Analyze + test** sur la branche main (toujours)
2. **Build APK signé release** car la ref est un tag `v*`
3. **Création d'une GitHub Release** avec l'APK attaché et des release notes auto-générées depuis les commits

L'APK est disponible :
- En artifact (lié au run du workflow, 90 jours)
- En attachement de la GitHub Release (permanent)

Format du nom : `sudoku-v1.0.0.apk`.

## Lien direct vers le Play Store

L'APK généré peut être uploadé sur Google Play Console. Pour une release "professionnelle" via le Play Store :

1. Convertir l'APK en AAB (App Bundle) — Google Play préfère :
   ```bash
   flutter build appbundle --release
   ```
   Modifier le workflow pour produire un `.aab` au lieu d'un `.apk`.

2. Créer un compte développeur Google Play (25 USD une fois)
3. Créer une nouvelle app
4. Upload du `.aab` dans la track "Internal testing" → puis "Production" après QA
