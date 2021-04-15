-- utworzenie bazy danych
CREATE DATABASE firma;

-- dodanie schematu
CREATE SCHEMA rozliczenia;

-- dodanie tabel
CREATE TABLE rozliczenia.pracownicy (
	ID_pracownika INT PRIMARY KEY, 
	imie VARCHAR(40) NOT NULL,
	nazwisko VARCHAR(40) NOT NULL,
	adres VARCHAR(80),
	telefon VARCHAR(12)
);

CREATE TABLE rozliczenia.godziny (
	ID_godziny INT PRIMARY KEY,
	data DATE,
	liczba_godzin INT,
	ID_pracownika INT NOT NULL
);

CREATE TABLE rozliczenia.pensje (
	ID_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(50),
	kwota MONEY NOT NULL,
	ID_premii INT
);

CREATE TABLE rozliczenia.premie (
	ID_premii INT PRIMARY KEY,
	rodzaj VARCHAR(50),
	kwota MONEY NOT NULL
);

-- dodanie kluczy obcych
ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (ID_pracownika) 
REFERENCES rozliczenia.pracownicy(ID_pracownika) 
	
ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (ID_premii) 
REFERENCES rozliczenia.premie(ID_premii)

-- wypelnienie tabel
INSERT INTO rozliczenia.pracownicy 
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
	
INSERT INTO rozliczenia.godziny 
VALUES 
	(0, '2021-01-11', 8, 0),
	(1, '2021-01-11', 8, 1),
	(2, '2021-01-15', 9, 2),
	(3, '2021-01-19', 6, 3),
	(4, '2021-01-19', 7, 4),
	(5, '2021-01-19', 8, 5),
	(6, '2021-01-27', 8, 6),
	(7, '2021-01-27', 4, 7),
	(8, '2021-01-27', 9, 8),
	(9, '2021-01-27', 8, 9);

INSERT INTO rozliczenia.premie 
VALUES 
	(0, 'Awans', 1000.00),
	(1, 'Nadgodziny', 200),
	(2, 'Frekwencja', 100.00),
	(3, 'Praca w święta', 200.00),
	(4, 'Wydajność pracy', 200.00),
	(5, 'Praca w weekendy', 100.00),
	(6, 'Comiesięczna premia', 30.00),
	(7, 'Pracownik miesiąca', 400.00),
	(8, 'Pracownik roku', 1400.00),
	(9, 'Premia za staż', 300.00);
	
INSERT INTO rozliczenia.pensje 
VALUES 
	(0, 'Kierownik', 11000.00, NULL),
	(1, 'Web Designer', 7200.00, 3),
	(2, 'Specjalista ds. Sprzedaży', 5100.00, 7),
	(3, 'Kierownik projektu', 5800.00, 4),
	(4, 'Graphic Designer', 6700.00, 9),
	(5, 'Junior Graphic Designer', 4200.00, 2),
	(6, 'Copywriter', 4500.00, 1),
	(7, 'Koordynator Kampanii Marketingowych', 5600.00, 8),
	(8, 'Specjalista ds. Rekrutacji', 4300.00, 2),
	(9, 'Księgowa', 3500.00, NULL);
	
-- wyswietlenie nazwisk i adresow pracownikow
SELECT nazwisko, adres FROM rozliczenia.pracownicy 

-- konwersja daty na dzien tygodnia i miesiac
SELECT data,
DATE_PART('dow', data) AS dzien_tygodnia, 
DATE_PART('month', data) AS miesiac 
FROM rozliczenia.godziny;

-- zmiana kwota na kwota_brutto, dodanie i obliczenie kwota_netto
ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
ALTER TABLE rozliczenia.pensje ADD kwota_netto MONEY;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto * 0.81;


