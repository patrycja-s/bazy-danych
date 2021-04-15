-- utworzenie bazy danych
CREATE DATABASE firma_tmp;

-- dodanie schematu
CREATE SCHEMA ksiegowosc;

-- dodanie tabel
CREATE TABLE ksiegowosc.pracownicy (
	ID_pracownika INT PRIMARY KEY, 
	imie VARCHAR(40) NOT NULL,
	nazwisko VARCHAR(40) NOT NULL,
	adres VARCHAR(80),
	telefon VARCHAR(12)
);
-- dodanie komentarza do tabeli
COMMENT ON TABLE ksiegowosc.pracownicy 
	IS 'Wszyscy pracownicy firmy wraz z adresami i telefonami.';


CREATE TABLE ksiegowosc.godziny (
	ID_godziny INT PRIMARY KEY,
	data DATE,
	liczba_godzin INT,
	ID_pracownika INT NOT NULL,
	FOREIGN KEY (ID_pracownika) REFERENCES ksiegowosc.pracownicy(ID_pracownika)
);
COMMENT ON TABLE ksiegowosc.godziny 
	IS 'Liczba godzin przepracowanych przez osobę w danym miesiacu.';
COMMENT ON COLUMN ksiegowosc.godziny.data
	IS 'Data rozliczenia liczby godzin - ostatni dzień miesiąca.';
	

CREATE TABLE ksiegowosc.pensja (
	ID_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(50),
	kwota MONEY NOT NULL
);
COMMENT ON TABLE ksiegowosc.pensja 
	IS 'Wysokość pensji dla danego stanowiska.';


CREATE TABLE ksiegowosc.premia (
	ID_premii VARCHAR(5) PRIMARY KEY,
	rodzaj VARCHAR(50),
	kwota MONEY NOT NULL
);
COMMENT ON TABLE ksiegowosc.premia 
	IS 'Rodzaje premii przyznawanych do pensji oraz ich kwoty.';
COMMENT ON COLUMN ksiegowosc.premia.rodzaj
	IS 'Kolumna rodzaj opisuje za co przyznawana jest premia.';
COMMENT ON COLUMN ksiegowosc.premia.id_premii
	IS 'Skrót od nazwy rodzaju premii. W przypadku nieuzyskania premii przez pracownika należy wybrać premię o id BRAK';
	

CREATE TABLE ksiegowosc.wynagrodzenie (
	ID_wynagrodzenia INT PRIMARY KEY,
	data DATE NOT NULL, 
	ID_pracownika INT NOT NULL,
	ID_godziny INT, 
	ID_pensji INT,
	ID_premii VARCHAR(5) NOT NULL, -- nie moze byz null poniewaz jest premia 'brak' o wysokosci 0
	FOREIGN KEY (ID_pracownika) REFERENCES ksiegowosc.pracownicy(ID_pracownika),
	FOREIGN KEY (ID_godziny) REFERENCES ksiegowosc.godziny(ID_godziny), 
	FOREIGN KEY (ID_pensji) REFERENCES ksiegowosc.pensja(ID_pensji),
	FOREIGN KEY (ID_premii) REFERENCES ksiegowosc.premia(ID_premii)
);
COMMENT ON TABLE ksiegowosc.wynagrodzenie 
	IS 'Miesięczne wynagrodzenia dla pracowników uwzglęniające pensję, premię oraz ilości przepracowanych godzin w danym miesiącu.';
COMMENT ON COLUMN ksiegowosc.wynagrodzenie.data
	IS 'Data wypłaty wynagrodzenia.';

-- wypelnienie tabel
INSERT INTO ksiegowosc.pracownicy 
VALUES 
	(0, 'Adam', 'Mróz', 'Kraków ul. Wielicka 38/212A', '+48704256806'),
	(1, 'Aniela', 'Jankowska', 'Kraków ul. Focha 3/2', '+48745093495'),
	(2, 'Monika', 'Wróblewska', 'Kraków ul. Rynek 8F', '+48108680277'),
	(3, 'Mateusz', 'Lis', 'Kraków ul. Centralna 2/31', '+48716102496'),
	(4, 'Olga', 'Sawicka', 'Kraków ul. Mogilska 93/5', '+48535436595'),
	(5, 'Helena', 'Urbańska', 'Kraków ul. Szewska 21', '+48110312102'),
	(6, 'Artur ', 'Czerwiński', 'Kraków ul. Lea 3/13', '+48224648271'),
	(7, 'Zuzanna', 'Lis', 'Kraków ul. Królewska 41/3', '+48153834770'),
	(8, 'Mateusz', 'Kamiński', 'Kraków ul. Lea 3B/16', '+48881006747'),
	(9, 'Igor', 'Sikorski', 'Kraków ul. Szewska 4/3A', '+48776490526');

INSERT INTO ksiegowosc.godziny 
VALUES 
	(0, '2021-03-31', 160, 0),
	(1, '2021-03-31', 140, 1),
	(2, '2021-03-31', 170, 2),
	(3, '2021-03-31', 150, 3),
	(4, '2021-03-31', 168, 4),
	(5, '2021-03-31', 180, 5),
	(6, '2021-02-26', 161, 6),
	(7, '2021-02-26', 162, 7),
	(8, '2021-02-26', 130, 8),
	(9, '2021-02-26', 160, 9);

INSERT INTO ksiegowosc.pensja 
VALUES 
	(0, 'Kierownik', 11000),
	(1, 'Web Designer', 7200),
	(2, 'Specjalista ds. Sprzedaży', 5100),
	(3, 'Kierownik projektu', 5800),
	(4, 'Graphic Designer', 6700),
	(5, 'Junior Graphic Designer', 4200),
	(6, 'Copywriter', 4500),
	(7, 'Koordynator Kampanii Marketingowych', 5600),
	(8, 'Specjalista ds. Rekrutacji', 4300),
	(9, 'Księgowa', 3500);

INSERT INTO ksiegowosc.premia 
VALUES 
	('PROM', 'Awans', 1000),
	('OVER', 'Nadgodziny', 200),
	('FREQ', 'Frekwencja', 100),
	('HLDAY', 'Praca w święta', 200),
	('PERF', 'Wydajność pracy', 200),
	('WKND', 'Praca w weekendy', 100),
	('MONTH', 'Comiesięczna premia', 30),
	('MTHW', 'Pracownik miesiąca', 400),
	('SNRT', 'Premia za staż', 300),
	('BRAK', 'Brak premii', 0);

INSERT INTO ksiegowosc.wynagrodzenie
VALUES
	(0, '2021-04-05', 0, 0, 4, 'PERF'),
	(1, '2021-04-05', 1, 1, 5, 'OVER'),
	(2, '2021-04-05', 2, 2, 1, 'FREQ'),
	(3, '2021-04-05', 3, 3, 9, 'BRAK'),
	(4, '2021-04-05', 4, 4, 1, 'WKND'),
	(5, '2021-04-05', 5, 5, 2, 'PERF'),
	(6, '2021-03-06', 6, 6, 4, 'BRAK'),
	(7, '2021-03-06', 7, 7, 3, 'OVER'),
	(8, '2021-03-06', 8, 8, 1, 'SNRT'),
	(9, '2021-03-06', 9, 9, 0, 'OVER');


-- a wyświetl tylko id pracownika oraz jego nazwisko
SELECT ID_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- b wyświetl id pracowników, których płaca jest większa niż 1000
SELECT ID_pracownika, (pe.kwota+pr.kwota) AS płaca
FROM ksiegowosc.wynagrodzenie w
	LEFT JOIN ksiegowosc.pensja pe ON pe.ID_pensji = w.ID_pensji
	LEFT JOIN ksiegowosc.premia pr ON pr.ID_premii = w.ID_premii
WHERE pe.kwota+pr.kwota > '1000';

-- c wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000
SELECT ID_pracownika, (pe.kwota+pr.kwota) AS płaca, w.ID_premii
FROM ksiegowosc.wynagrodzenie w
	LEFT JOIN ksiegowosc.pensja pe ON pe.ID_pensji = w.ID_pensji
	LEFT JOIN ksiegowosc.premia pr ON pr.ID_premii = w.ID_premii
WHERE pe.kwota+pe.kwota > '2000'
AND w.ID_premii LIKE 'BRAK';

-- d wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

-- e wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’
SELECT * FROM ksiegowosc.pracownicy 
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- f wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas pracy to 160 h miesięcznie
SELECT imie, nazwisko, (liczba_godzin-160) AS nadgodziny 
FROM ksiegowosc.pracownicy
	JOIN ksiegowosc.godziny ON ksiegowosc.pracownicy.ID_pracownika = ksiegowosc.godziny.ID_pracownika
WHERE liczba_godzin > 160;

-- g wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN
SELECT imie, nazwisko, kwota AS pensja
FROM ksiegowosc.pracownicy p
	JOIN ksiegowosc.wynagrodzenie w ON w.ID_pracownika = p.ID_pracownika
	JOIN ksiegowosc.pensja pe ON pe.ID_pensji = w.ID_pensji
WHERE kwota >= '5000' AND kwota <= '7000';

-- h wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii
SELECT imie, nazwisko, (liczba_godzin-160) AS nadgodziny, ID_premii
FROM ksiegowosc.pracownicy p
	JOIN ksiegowosc.wynagrodzenie w ON w.ID_pracownika = p.ID_pracownika
	JOIN ksiegowosc.godziny g ON w.ID_godziny = g.ID_godziny
WHERE liczba_godzin > 160
AND ID_premii LIKE 'BRAK';

-- i uszereguj pracowników według pensji
SELECT p.ID_pracownika, imie, nazwisko, kwota AS pensja
FROM ksiegowosc.pracownicy p 
	INNER JOIN ksiegowosc.wynagrodzenie w ON w.ID_pracownika = p.ID_pracownika
	LEFT JOIN ksiegowosc.pensja pe ON w.ID_pensji = pe.ID_pensji --left join jakby jakis pracownik mial w pensji null
ORDER BY pensja;

-- j uszereguj pracowników według pensji i premii malejąco
SELECT p.ID_pracownika, imie, nazwisko, pe.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
	INNER JOIN ksiegowosc.wynagrodzenie w ON w.ID_pracownika = p.ID_pracownika
	LEFT JOIN ksiegowosc.pensja pe ON w.ID_pensji = pe.ID_pensji --left join jakby jakis pracownik mial w pensji null
	JOIN ksiegowosc.premia pr ON w.ID_premii = pr.ID_premii
ORDER BY pensja DESC, premia DESC;

-- k zlicz i pogrupuj pracowników według pola ‘stanowisko’
SELECT stanowisko, COUNT(ID_pracownika) AS ilosc_pracownikow
FROM ksiegowosc.pensja pe
	LEFT JOIN ksiegowosc.wynagrodzenie w ON pe.ID_pensji = w.ID_pensji
GROUP BY stanowisko 
ORDER BY ilosc_pracownikow DESC;

-- l policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne)
SELECT ROUND(AVG((pe.kwota+pr.kwota)::numeric), 2) AS srednia, 
MIN(pe.kwota+pr.kwota) AS minimalna, 
MAX(pe.kwota+pr.kwota) AS maksymalna
FROM ksiegowosc.wynagrodzenie w
	INNER JOIN ksiegowosc.pensja pe ON w.ID_pensji = pe.ID_pensji
	LEFT JOIN ksiegowosc.premia pr ON w.ID_premii = pr.ID_premii
WHERE pe.stanowisko LIKE 'Web Designer';

-- m policz sumę wszystkich wynagrodzeń
SELECT SUM(pe.kwota + pr.kwota) AS suma
FROM ksiegowosc.wynagrodzenie w
	INNER JOIN ksiegowosc.pensja pe ON w.ID_pensji = pe.ID_pensji
	LEFT JOIN ksiegowosc.premia pr ON w.ID_premii = pr.ID_premii

-- n policz sumę wynagrodzeń w ramach danego stanowiska
SELECT stanowisko, SUM(pe.kwota + pr.kwota) AS suma
FROM ksiegowosc.wynagrodzenie w
	INNER JOIN ksiegowosc.pensja pe ON w.ID_pensji = pe.ID_pensji
	LEFT OUTER JOIN ksiegowosc.premia pr ON w.ID_premii = pr.ID_premii
GROUP BY stanowisko

-- o wyznacz liczbę premii przyznanych dla pracowników danego stanowiska
SELECT stanowisko, COUNT(pr.kwota) AS liczba_premii
FROM ksiegowosc.pensja pe
	JOIN ksiegowosc.wynagrodzenie w ON w.ID_pensji = pe.ID_pensji --inner join zeby wykluczyc stanowiska na ktorych nie ma pracownikow
	JOIN ksiegowosc.premia pr ON pr.ID_premii = w.ID_premii
WHERE pr.kwota > '0' --ze wzgledu na bremie 'BRAK' ktora ma kwote 0, bez tego premia ta bylaby uwzgledniona w liczbie premii
GROUP BY stanowisko 
ORDER BY liczba_premii DESC
	
-- p usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł
-- dodaje on delete cascade do kluczy obcych w tabelach
-- dzieki temu moge usunac osoby z tabeli pracownicy wraz z usunieciem ich z tabel godziny i wynagrodzenie
ALTER TABLE ksiegowosc.godziny
DROP CONSTRAINT godziny_id_pracownika_fkey,
ADD CONSTRAINT godziny_id_pracownika_fkey
   FOREIGN KEY (id_pracownika)
   REFERENCES ksiegowosc.pracownicy(id_pracownika)
   ON DELETE CASCADE;

ALTER TABLE ksiegowosc.wynagrodzenie
DROP CONSTRAINT wynagrodzenie_id_pracownika_fkey,
ADD CONSTRAINT wynagrodzenie_id_pracownika_fkey
   FOREIGN KEY (id_pracownika)
   REFERENCES ksiegowosc.pracownicy(id_pracownika)
   ON DELETE CASCADE;

-- usuwam pracownikow
DELETE FROM ksiegowosc.pracownicy
USING ksiegowosc.wynagrodzenie, ksiegowosc.pensja
WHERE ksiegowosc.wynagrodzenie.ID_pracownika = ksiegowosc.pracownicy.ID_pracownika
AND ksiegowosc.pensja.ID_pensji = ksiegowosc.wynagrodzenie.ID_pensji
AND pensja.kwota < '5000'


