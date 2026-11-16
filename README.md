# Orbit Code

Orbit Code ist eine Desktop-App für die Arbeit mit Coding-Agenten wie Claude Code und Codex:
Mission Control mit allen Chats auf einen Blick, Projekte und Rechner in der Seitenleiste,
Unteraufgaben im Baum, ein Agenten-Büro und ein Graph der Agenten-Notizen.
Sie baut auf [T3 Code](https://github.com/pingdotgg/t3code) (MIT) auf.

Dieses Repo enthält nur die Downloads. Die App ist eine **Beta** und **nicht von Apple signiert**.

## Installieren (Mac mit Apple-Chip)

Website: **https://joelsommerer.github.io/orbit-code-releases/**

Am einfachsten im Terminal einfügen. Das lädt die neueste Version, legt sie in **Programme** und startet sie:

```bash
curl -fsSL https://joelsommerer.github.io/orbit-code-releases/install.sh | sh
```

Von Hand: Unter [Releases](../../releases/latest) `Orbit-<version>-arm64.zip` laden, entpacken und
`Orbit (Beta).app` in **Programme** ziehen. Vor dem ersten Öffnen einmal im Terminal freigeben.
Ohne diesen Schritt meldet macOS, die App sei **beschädigt**. Sie ist es nicht: Die App ist noch
nicht von Apple signiert, und macOS blockiert solche Downloads aus dem Browser.

```bash
xattr -dr com.apple.quarantine "/Applications/Orbit (Beta).app"
```

## Von T3 Code umsteigen

Ist T3 Code auf dem Mac, fragt Orbit beim ersten Start, ob es Projekte, Chats, Provider,
Einstellungen und verbundene Rechner übernehmen soll. T3 Code bleibt dabei unverändert.
Später geht das im Menü **Orbit → Take Over from T3 Code…**.

## Aktualisieren

Den Installer-Befehl erneut ausführen; er beendet Orbit, ersetzt die App und startet sie neu.
Deine Daten in `~/.orbit` bleiben erhalten.
