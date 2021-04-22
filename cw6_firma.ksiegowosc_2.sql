---- a. zmodyfikuj nr telefonu w tab. pracownicy, dodając do niego kierunkowy dla Polski w nawiasie (+48)
ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon TYPE VARCHAR(14);
UPDATE ksiegowosc.pracownicy SET telefon = '(+48)' || SUBSTRING(telefon, 1, 9);

-- u mnie +48 juz bylo zawarte w numerze telefonu wiec dodaje tylko nawiasy
ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon TYPE VARCHAR(14);

UPDATE ksiegowosc.pracownicy 
SET telefon = '(' || SUBSTRING(telefon, 1, 3) || ')' || SUBSTRING(telefon, 4, 9);


---- b. zmodyfikuj telefon w tab. pracownicy, aby numer oddzielony był myślnikami '555-222-333'
ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon TYPE VARCHAR(16);

UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 8) || '-' || SUBSTRING(telefon, 9, 3) || '-' || SUBSTRING(telefon, 12, 3);


---- c. wyświetl dane pracownika, którego nazwisko jest najdłuższe, używając dużych liter
SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon 
FROM ksiegowosc.pracownicy
ORDER BY LENGTH(nazwisko) DESC
LIMIT 1;

-- w przypadku, gdyby najdluzsza dlugosc ma kilka nazwisk 
SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon 
FROM ksiegowosc.pracownicy
WHERE LENGTH(nazwisko) = (SELECT MAX(LENGTH(nazwisko)) FROM ksiegowosc.pracownicy);


---- d. wyświetl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5
--jesli wszystkie dane zakodowane
SELECT MD5(p.id_pracownika::varchar(10)) AS id, MD5(p.imie) AS imie, MD5(p.nazwisko) AS nazwisko, 
MD5(p.adres) AS adres, MD5(p.telefon) AS telefon, MD5(pe.kwota::varchar(15)) AS pensja 
FROM ksiegowosc.pracownicy p
	JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
	JOIN ksiegowosc.pensja pe ON w.id_pensji = pe.id_pensji;

--jesli tylko pensja zakodowana
SELECT p.*, MD5(pe.kwota::varchar) AS pensja 
FROM ksiegowosc.pracownicy p
	JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
	JOIN ksiegowosc.pensja pe ON w.id_pensji = pe.id_pensji;


---- e. wyświetl pracowników, ich pensje oraz premie. wykorzystaj złączenie lewostronne
SELECT p.*, pe.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
	LEFT JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
	LEFT JOIN ksiegowosc.pensja pe ON w.id_pensji = pe.id_pensji
	LEFT JOIN ksiegowosc.premia pr ON w.ID_premii = pr.ID_premii;


---- f. wygeneruj raport (zapytanie), które zwróci w wyniku treść wg poniższego szablonu: 
-- "Pracownik Jan Nowak, w dniu 7.08.2017 otrzymał pensję całkowitą na kwotę 7540 zł, 
-- gdzie wynagrodzenie zasadnicze wynosiło: 5000 zł, premia: 2000 zł, nadgodziny: 40 h." 

--konwersja daty z formatu yyyy-mm-dd na dd.mm.yyyy
--konwersja kwoty, aby wyswietlala sie bez $ (typ money) oraz bez przecinków
--case when uniemozliwia wpisywanie ujemnych liczb jako nadgodzin
--konwersja daty z formatu yyyy-mm-dd na dd.mm.yyyy
--konwersja kwoty, aby wyswietlala sie bez $ (typ money) oraz bez przecinków
--case when uniemozliwia wpisywanie ujemnych liczb jako nadgodzin
SELECT CONCAT('Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu ', 
			  SUBSTRING(w.data::varchar(10),9,2), '.', SUBSTRING(w.data::varchar(10),6,2), '.', SUBSTRING(w.data::varchar(10),1,4), 
			  ' otrzymał pensję całkowitą na kwotę ', REPLACE(SUBSTRING((pe.kwota+pr.kwota)::varchar, 2), ',', ''), 
			  ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', REPLACE(SUBSTRING(pe.kwota::varchar, 2), ',', ''),
			  ' zł, premia: ', REPLACE(SUBSTRING(pr.kwota::varchar, 2), ',', ''), 
			  ' zł, nadgodziny: ', CASE WHEN (g.liczba_godzin-160) > 0 THEN g.liczba_godzin-160 ELSE 0 END, 
			  ' h.') AS raport
FROM ksiegowosc.pracownicy p
	JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
	JOIN ksiegowosc.pensja pe ON w.id_pensji = pe.id_pensji
	JOIN ksiegowosc.premia pr ON w.ID_premii = pr.ID_premii
	JOIN ksiegowosc.godziny g ON w.ID_godziny = g.ID_godziny;