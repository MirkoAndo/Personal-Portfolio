# Portfolio statico (HTML + CSS + JS vanilla)

Struttura modulare e minimale per un portfolio professionale a lungo termine. Nessun framework; solo HTML5 semantico, CSS moderno (Flexbox/Grid, variabili), JavaScript vanilla per interazioni di base.

## Struttura cartelle
- `index.html` – pagina principale con tutte le sezioni predisposte (placeholder, nessun contenuto inventato).
- `css/main.css` – tema, layout mobile-first, componenti riusabili, focus/accessibilità.
- `js/main.js` – toggle menu mobile e hook per futuri filtri/ordinamenti.
- `assets/` – spazio per loghi, immagini ottimizzate (da aggiungere).

## Scelte architetturali
- **Sezioni indipendenti**: Home/Identità, Percorso, Certificazioni, Esperienze, Progetti, Competenze, Archivio, Contatti.
- **Estensibilità**: data-attributes (`data-year`, `data-type`, `data-stack`, `data-order`) per filtrare/ordinare senza cambiare layout.
- **UI/UX**: minimalismo, un solo colore di accento, tipografia leggibile, spaziatura ampia, animazioni minime.
- **Accessibilità**: skip-link, focus visibile, contrasto alto, nav toggle con `aria-expanded`.
- **Performance**: nessuna dipendenza esterna tranne Google Fonts; CSS/JS separati; mobile-first.

## Come eseguire (statico)
Apri `index.html` in un browser moderno. Su Windows PowerShell:
```powershell
Start-Process index.html
```

## Server Flask (per esposizione in rete)
Prerequisiti: Python 3 e pip.

1) Installa le dipendenze
```powershell
cd "c:\Users\Administrator\Desktop\Personal-Portfolio"
py -3 -m pip install --upgrade pip
py -3 -m pip install -r requirements.txt
```

2) Avvia il server (porta predefinita 80, richiede PowerShell/cmd amministratore per bind sulla 80)
```powershell
start-server.bat
```
	- Porta alternativa (es. 8080): `start-server.bat 8080`

3) Ferma il server
```powershell
stop-server.bat
```

4) Riavvia il server
```powershell
restart-server.bat
```

Note server:
- Salva il PID in `server.pid` per uno stop pulito.
- Serve tutto il contenuto della radice (HTML/CSS/JS/assets) con cache semplice e header di sicurezza base.
- Se usi la porta 80 su Windows, esegui il terminale come Amministratore oppure scegli una porta >1024 (es. 8080) e aggiorna il port forwarding di conseguenza.
- Il warning "This is a development server" è normale per Flask built-in; per esposizione pubblica usa un reverse proxy (nginx/Caddy) o un tunnel (Cloudflare Tunnel) per HTTPS e hardening.

## Come aggiornare i contenuti
- Sostituisci i placeholder tra parentesi quadre `[...]` con dati reali.
- Mantieni la semantica (heading gerarchici, liste per elenchi, paragrafi brevi e tecnici).
- Per nuovi elementi, duplica i blocchi esistenti (es. nuove card progetto) preservando le classi e i data-attributes.

## Estensioni future suggerite
- Filtri client-side per anno/stack/tipologia (usando i data-attributes già presenti).
- Pagina "Archivio" separata se la cronologia cresce molto.
- Ottimizzazione immagini con formati moderni (WebP/AVIF) e lazy-loading.
- Report Lighthouse periodico per monitorare performance/A11y/SEO.

## Pubblicazione con DuckDNS + port forwarding (guida rapida)
1. **DuckDNS**: crea un dominio su duckdns.org, ottieni il token e configura l'update client sul PC/server che esegue Flask (script PowerShell o Scheduled Task che chiama l'URL di update DuckDNS). Verifica che l'IP pubblico venga aggiornato.
2. **Port forwarding (router)**: crea una regola con porta esterna `16470` → IP interno del server (es. `192.168.1.101` come nello screenshot) porta interna `80` TCP. Mantieni l'inoltro attivo.
3. **Firewall Windows**: consenti il traffico in ingresso sulla porta interna (80) o sulla porta che scegli (es. 8080) per l'app Python.
4. **Test**: dall'esterno (rete cellulare) apri `http://<tuo-subdomain>.duckdns.org:16470/`. Se usi una porta alternativa, aggiorna la regola router e usa quella porta nell'URL.
5. **Sicurezza**: questo setup è HTTP. Per HTTPS usa un reverse proxy (es. nginx/Caddy) o un tunnel (Cloudflare Tunnel/ZeroTier) per gestire TLS e rate limiting.

### Nota su log con caratteri binari / 400
Se vedi nel log richieste 400 con caratteri binari (es. ClientHello TLS) da IP del router/ISP (`192.168.1.254`), significa che traffico HTTPS sta colpendo la porta HTTP (80). Non è un bug dell'app. Opzioni:
- Ignorare il rumore (richieste vengono già respinte 400).
- Esporre solo via HTTPS dietro reverse proxy o tunnel.
- Chiudere l'accesso diretto alla 80 e usare una porta alternativa interna con forwarding esterno specifico.

## Accessibilità e performance (check veloce)
- Focus visibile, skip-link, contrasto alto già presenti nel CSS; `prefers-reduced-motion` azzera transizioni per chi lo richiede.
- `color-scheme: dark` indica al browser il tema scuro per controlli nativi.
- Evita testi lunghi in maiuscolo; mantieni la gerarchia di heading (h1/h2/h3) già impostata.
- Mantieni un solo colore di accento; verifica sempre il contrasto se cambi palette.
- Immagini: usa formati moderni (WebP/AVIF) e dimensioni ottimizzate; aggiungi `loading="lazy"` se inserisci img.
- Preferisci porte non privilegiate (es. 8080) se non lanci il server come Admin.

## Test manuali base (da eseguire ad ogni release)
- **Layout responsive**: mobile (≤375px), tablet (~768px), desktop (≥1280px); controlla navigazione e griglie.
- **Tab order**: prova `Tab`/`Shift+Tab` dalla skip-link al footer; verifica focus visibile su link e pulsanti.
- **Menu mobile**: a ≤720px apri/chiudi il toggle e controlla che `aria-expanded` cambi.
- **Console**: nessun errore in DevTools all'apertura della Home.
- **Lighthouse (opzionale)**: esegui un audit Performance/SEO/A11y; target >90. Se cali, riduci peso immagini e verifica contrasto.

### Automazione DuckDNS (mirkoportfolio.duckdns.org)
File già inclusi:
- `duckdns-update.ps1` — esegue l'update chiamando DuckDNS e logga in `logs/duckdns.log`.
- `update-duckdns.bat` — wrapper per avviare lo script PowerShell.

Esecuzione manuale:
```powershell
cd "c:\Users\Administrator\Desktop\Personal-Portfolio"
update-duckdns.bat
```

Schedulazione (consigliata, ogni 5 minuti o 10 minuti):
1. Apri "Utilità di pianificazione" → Crea attività di base.
2. Trigger: "Ogni 5 minuti" (impostazione avanzata su un trigger giornaliero).
3. Azione: Avvia programma → `update-duckdns.bat` (cartella del progetto).
4. Opzioni: Esegui indipendentemente dalla connessione rete; abilita ripeti se fallisce.
5. Log: controlla `logs/duckdns.log` per esito ("OK" o "KO").

## Certificazioni (PDF)
- Metti i PDF in `assets/certifications/` e collega i file nelle card della sezione Certificazioni in `index.html`.
- Puoi linkare anche i badge pubblici: https://www.credly.com/users/mirko-ando/badges.
- Certificazioni NetAcad (date da transcript 23 Dec 2025):
	- Introduction to Greenhouse Gas Accounting for IT — 23 Apr 2025
	- Networking Basics — 23 Apr 2025
	- Network Defense — 12 Dec 2024
	- Introduction to Modern AI — 12 Dec 2024
	- Data Analytics Essentials — 07 Dec 2024
	- Using Computer and Mobile Devices — 24 Nov 2024
	- Digital Awareness — 24 Nov 2024
	- Endpoint Security — 20 Nov 2024
	- English for IT 1 & 2 — 20 Nov 2024
	- Network Support and Security — 21 Oct 2024
	- Exploring Networking with Cisco Packet Tracer — 21 Oct 2024
	- Ethical Hacker — 21 Oct 2024
	- Exploring Internet of Things with Cisco Packet Tracer — 21 Oct 2024
	- Introduction to IoT and Digital Transformation — 21 Oct 2024
	- Python Essentials 2 — 15 Oct 2024
	- Getting Started with Cisco Packet Tracer — 24 Sep 2024
	- Computer Hardware Basics — 24 Sep 2024
	- Python Essentials 1 — 22 Sep 2024
	- Introduction to Data Science — 21 Sep 2024
	- Introduction to Cybersecurity — 21 Sep 2024
	- In corso: Cyber Threat Management (iscritto 02 Dec 2025), CCNA: Introduzione alle reti (12 Sep 2024 – 12 Jul 2025)

## Manutenzione
- Mantenere un solo colore di accento per coerenza.
- Verificare contrasto dopo ogni modifica cromatica.
- Aggiornare la timeline (`data-order="desc"`) e gli elenchi mantenendo ordinamento coerente.
