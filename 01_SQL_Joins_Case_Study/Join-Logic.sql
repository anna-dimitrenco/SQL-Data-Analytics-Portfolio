USE 281125_dam_AnnaD;

/* PROJECT: SQL Join Logic for Business Analytics
AUTHOR: Anna Dimitrenco
TARGET MARKET: Germany
DATABASE: Online_Shop
*/

CREATE DATABASE IF NOT EXISTS Online_Shop;
USE Online_Shop;

-- Kundentabelle
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE
);

-- Bestelltabelle
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT, 
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

-- Mit Daten füllen
TRUNCATE TABLE customers;
INSERT INTO customers VALUES
(1, 'Hans Müller', 'Berlin', '2023-01-10'),
(2, 'Anna Schmidt', 'Hamburg', '2023-02-15'),
(3, 'Lukas Weber', 'München', '2023-03-20'),
(4, 'Petra Kurz', 'Frankfurt', '2023-04-05'), -- Ein Kunde ohne Aufträge
(5, 'Markus Kraft', 'Stuttgart', '2023-05-12'); -- Ein Kunde ohne Aufträge

TRUNCATE TABLE orders;
INSERT INTO orders VALUES
(101, 1, '2023-10-01', 150.00),
(102, 1, '2023-10-10', 45.50),
(103, 2, '2023-10-15', 89.99),
(104, 3, '2023-11-05', 210.00),
(999, 99, '2023-11-10', 500.00); -- Fehler: Client mit der ID 99 existiert nicht


-- 1. AUFGABE: INNER JOIN
-- Manager: "Ich brauche eine Liste aller aktiven Kunden und deren Bestellungen."
-- Ziel: Analyse der tatsächlichen Umsätze pro Kunde.

SELECT 
    c.customer_id, 
    c.customer_name, 
    o.order_id, 
    o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

/* ERGEBNIS (RESULT):
| customer_id | customer_name | order_id | total_amount |
|-------------|---------------|----------|--------------|
| 1           | Hans Müller   | 101      | 150.00       |
| 1           | Hans Müller   | 102      | 45.50        |
| 2           | Anna Schmidt  | 103      | 89.99        |
| 3           | Lukas Weber   | 104      | 210.00       |
*/


-- 2. AUFGABE: LEFT JOIN - Kundenübersicht & Potenzialanalyse
-- Manager: "Zeigen Sie mir alle registrierten Kunden, auch wenn sie noch nicht bestellt haben."
-- Ziel: Identifikation von Potenzialen (Churn-Vermeidung).

SELECT 
    c.customer_name, 
    c.city, 
    o.order_id, 
    o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

/* ERGEBNIS (RESULT):
| customer_name | city      | order_id | total_amount |
|---------------|-----------|----------|--------------|
| Hans Müller   | Berlin    | 101      | 150.00       |
| Hans Müller   | Berlin    | 102      | 45.50        |
| Anna Schmidt  | Hamburg   | 103      | 89.99        |
| Lukas Weber   | München   | 104      | 210.00       |
| Petra Kurz    | Frankfurt | NULL     | NULL         | <-- NULL zeigt Inaktivität
| Markus Kraft  | Stuttgart | NULL     | NULL         |
*/


-- 3. AUFGABE: LEFT ANTI JOIN (Audit Task)
-- Manager: "Welche Kunden haben sich registriert, aber noch nie etwas gekauft?"
-- Ziel: Erstellung einer Marketing-Liste für Re-Engagement.

SELECT 
    c.customer_name, 
    c.registration_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

/* ERGEBNIS (RESULT):
| customer_name | registration_date |
|---------------|-------------------|
| Petra Kurz    | 2023-04-05        |
| Markus Kraft  | 2023-05-12        |
*/


-- 4.AUFGABE: RIGHT JOIN (Selten verwendet, aber wichtig für die Logik)
-- Manager: "Wir brauchen eine Liste aller Bestellungen inklusive der Kundendaten."
-- Ziel: Übersicht über alle Transaktionen im System.

SELECT 
    o.order_id, 
    o.total_amount, 
    c.customer_name
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

/* ERGEBNIS (RESULT):
| order_id | total_amount | customer_name |
|----------|--------------|---------------|
| 101      | 150.00       | Hans Müller   |
| 102      | 45.50        | Hans Müller   |
| 103      | 89.99        | Anna Schmidt  |
| 104      | 210.00       | Lukas Weber   |
| 999      | 500.00       | NULL          | <-- Fehlerhafter Datensatz ohne Kunde
*/


-- 5. AUFGABE: RIGHT ANTI JOIN (Integrity Check)
-- Manager: "Gibt es Bestellungen, die keinem Kunden zugeordnet sind? (Fehlersuche)"
-- Ziel: Bereinigung der Datenbank von "verwaisten" Datensätzen.


SELECT 
    o.order_id, 
    o.order_date, 
    o.customer_id AS orphaned_id
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

/* ERGEBNIS (RESULT):
| order_id | order_date | orphaned_id |
|----------|------------|-------------|
| 999      | 2023-11-10 | 99          | <-- Dieser Kunde existiert nicht in Table A
*/


-- 6. AUFGABE: FULL ANTI JOIN (Exklusive Datensätze)
-- Manager: "Zeigen Sie mir nur die Datensätze, die KEINE Entsprechung haben."
-- Ziel: Finden von Lücken in beiden Systemen gleichzeitig.


SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
UNION
SELECT c.customer_name, o.order_id
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

/* ERGEBNIS (RESULT):
| customer_name | order_id |
|---------------|----------|
| Petra Kurz    | NULL     |
| Markus Kraft  | NULL     |
| NULL          | 999      |
*/