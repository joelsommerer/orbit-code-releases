# Orbit Code

Orbit Code ist eine Desktop-App für die Arbeit mit Coding-Agenten wie Claude Code und Codex:
Mission Control mit allen Chats auf einen Blick, Projekte und Rechner in der Seitenleiste,
Unteraufgaben im Baum, ein Agenten-Büro und ein Graph der Agenten-Notizen.
Sie baut auf [T3 Code](https://github.com/pingdotgg/t3code) (MIT) auf.

Dieses Repo enthält nur die Downloads. Die App ist eine **Beta** und **nicht von Apple signiert**.

## Installieren (Mac mit Apple-Chip)

1. Unter [Releases](../../releases/latest) die Datei `Orbit-0.1.9-arm64.zip` herunterladen.
2. Entpacken und `Orbit (Beta).app` in den Ordner **Programme** ziehen.
3. Weil die App nicht signiert ist, blockiert macOS sie zuerst. Einmal im Terminal ausführen:

   ```bash
   xattr -dr com.apple.quarantine "/Applications/Orbit (Beta).app"
   ```

4. Orbit starten.

## Von T3 Code umsteigen

Ist T3 Code auf dem Mac, fragt Orbit beim ersten Start, ob es Projekte, Chats, Provider,
Einstellungen und verbundene Rechner übernehmen soll. T3 Code bleibt dabei unverändert.
Später geht das im Menü **Orbit → Take Over from T3 Code…**.

## Aktualisieren

Es gibt noch keine automatischen Updates. Orbit beenden (Cmd+Q), die neue Version wie oben
installieren und den `xattr`-Befehl erneut ausführen. Deine Daten in `~/.orbit` bleiben erhalten.
