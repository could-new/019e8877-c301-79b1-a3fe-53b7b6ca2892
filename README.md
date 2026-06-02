# 🔌 WP HUNTER - WordPress Target Finder

WP Hunter è un'applicazione desktop moderna con un design accattivante a tema "hacking", sviluppata appositamente per Windows (e compatibile cross-platform). Consente di ricercare, generare dork e monitorare target WordPress in un'interfaccia ispirata ai terminali e ai tool di sicurezza.

## 🚀 Caratteristiche Principali

- **Design Hacking Estremo**: Tema scuro (dark mode), font monospace (IBM Plex Mono) ed elementi visivi tipici dei terminali hacker, con accenti verdi fluo, rossi e ciano.
- **Generatore di Dork**: Sezione per generare e copiare rapidamente dork di ricerca specifici per vulnerabilità o configurazioni esposte di WordPress.
- **Terminale Interattivo (Simulato)**: Un log di sistema che mostra in tempo reale le azioni effettuate (scansioni, caricamenti, errori).
- **Tabella dei Target**: Interfaccia di gestione per i target individuati, con stato di vulnerabilità e percorsi sensibili esposti (login, xmlrpc, api, ecc.).

## 💻 Stack Tecnologico

- **Flutter**: Framework UI nativo.
- **Google Fonts**: Utilizzo di IBM Plex Mono per garantire un'estetica da riga di comando.
- **Dart**: Linguaggio di programmazione.

## 🛠️ Come eseguire il progetto

1. Assicurati di avere Flutter installato e configurato per il desktop (Windows).
2. Clona questo repository.
3. Installa le dipendenze eseguendo:
   ```bash
   flutter pub get
   ```
4. Avvia l'applicazione:
   ```bash
   flutter run -d windows
   ```

---

## 🤖 Informazioni su CouldAI

Questa applicazione è stata generata tramite [CouldAI](https://could.ai), un costruttore di app basato sull'Intelligenza Artificiale che trasforma i prompt in applicazioni native pronte per la produzione per iOS, Android, Web e Desktop. Grazie ad agenti IA autonomi, CouldAI progetta, costruisce, testa, distribuisce e itera software di alta qualità.