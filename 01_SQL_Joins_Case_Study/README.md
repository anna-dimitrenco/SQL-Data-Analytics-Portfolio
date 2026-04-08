# Case Study: SQL Join Logik für Business Analytics

## Warum sind Joins wichtig?

In relationalen Datenbanken liegen Informationen oft in verschiedenen Tabellen. Joins sind das Herzstück der Datenanalyse, weil sie es ermöglichen, diese Informationen sinnvoll zu verknüpfen. Ohne die richtige Join-Logik kann ein Analyst wichtige Daten übersehen oder falsche Geschäftsentscheidungen treffen.

In diesem Projekt zeige ich, wie man 5 typische Business-Anforderungen eines Online-Shops mit SQL löst.

## Praxisbeispiele & Aufgaben (Management-Anforderungen)

### 1. Inner Join: Analyse der aktiven Verkäufe

Anforderung vom Manager: "Ich brauche eine Liste aller Kunden, die bereits erfolgreich bestellt haben."

Ziel: Nur aktive Kunden analysieren und den realen Umsatz berechnen. Daten ohne Übereinstimmung werden ignoriert.

### 2. Left Join: Kundenpotenzial-Analyse

Anforderung vom Manager: "Zeigen Sie mir alle registrierten Kunden und deren Bestellungen, falls vorhanden."

Ziel: Ein vollständiges Bild der Datenbank erhalten. Wir identifizieren Kunden, die zwar registriert sind, aber noch keine Käufe getätigt haben (NULL-Werte).

### 3. Left Anti Join: Churn-Prävention (Marketing-Audit)

Anforderung vom Manager: "Welche Kunden haben sich registriert, aber noch nie etwas bestellt?"

Ziel: Erstellung einer Liste für Marketing-Aktionen. Diese Kunden erhalten spezielle Rabatte, um sie zur ersten Bestellung zu motivieren.

### 4. Right Anti Join: Data Quality Audit

Anforderung vom Manager: "Gibt es Bestellungen im System, die keinem Kunden zugeordnet sind?"

Ziel: Identifikation von Systemfehlern (Bugs). Jede Bestellung ohne Kunden-ID ist ein technisches Problem, das korrigiert werden muss.

### 5. Full Join: Strategischer Datenabgleich (Reconciliation)

Anforderung vom Manager: "Erstellen Sie eine komplette Übersicht über alle Kunden und alle Transaktionen für ein Audit."

Ziel: Vollständige Transparenz. Alle Üбереinstimmungen und Lücken beider Tabellen werden auf einem Dashboard sichtbar.


## Technische Umsetzung

Datenbank: MySQL (Entwicklung der Abfragen)

Skript: Join-Logik.sql

Visualisierung: Power BI Dashboard (In Arbeit ⏳)

Erstellt von: Anna Dimitrenco
