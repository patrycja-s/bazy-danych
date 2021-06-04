-- utworzenie bazy danych
CREATE DATABASE cw9;

-- utworzenie tabel
CREATE TABLE GeoEon (
	id_eon INT PRIMARY KEY, 
	nazwa_eon VARCHAR(40) NOT NULL
);

CREATE TABLE GeoEra (
	id_era INT PRIMARY KEY, 
	id_eon INT NOT NULL,
	nazwa_era VARCHAR(40) NOT NULL,
	FOREIGN KEY (id_eon) REFERENCES GeoEon(id_eon)
);

CREATE TABLE GeoOkres (
	id_okres INT PRIMARY KEY, 
	id_era INT NOT NULL,
	nazwa_okres VARCHAR(40) NOT NULL,
	FOREIGN KEY (id_era) REFERENCES GeoEra(id_era)
);

CREATE TABLE GeoEpoka (
	id_epoka INT PRIMARY KEY, 
	id_okres INT NOT NULL,
	nazwa_epoka VARCHAR(40) NOT NULL,
	FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres)
);

CREATE TABLE GeoPietro (
	id_pietro INT PRIMARY KEY, 
	id_epoka INT NOT NULL,
	nazwa_pietro VARCHAR(40) NOT NULL,
	FOREIGN KEY (id_Epoka) REFERENCES GeoEpoka(id_epoka)
);

-- wypelnienie tabel 
INSERT INTO GeoEon VALUES
	(0, 'fanerozoik'),
	(1, 'proterozoik'),
	(2, 'archaik'),
	(3, 'hadeik');

INSERT INTO GeoEra VALUES
	(0, 0, 'kenozoik'),
	(1, 0, 'mezozoik'),
	(2, 0, 'paleozoik'),
	(3, 1, 'neoproterozoik'),
	(4, 1, 'mezoproterozoik'),
	(5, 1, 'paleoproterozoik'),
	(6, 2, 'neoarchaik'),
	(7, 2, 'mezoarchaik'),
	(8, 2, 'paleoarchaik'),
	(9, 2, 'eoarchaik');

INSERT INTO GeoOkres VALUES
	(0, 0, 'czwartorzęd'),
	(1, 0, 'neogen'),
	(2, 0, 'paleogen'),
	(3, 1, 'kreda'),
	(4, 1, 'jura'),
	(5, 1, 'trias'),
	(6, 2, 'perm'),
	(7, 2, 'karbon'),
	(8, 2, 'dewon'),
	(9, 2, 'sylur'),
	(10, 2, 'ordowik'),
	(11, 2, 'kambr'),
	(12, 3, 'ediakar'),
	(13, 3, 'kriogen'),
	(14, 3, 'ton'),
	(15, 4, 'sten'),
	(16, 4, 'ektas'),
	(17, 4, 'kalim'),
	(18, 5, 'stater'),
	(19, 5, 'orosir'),
	(20, 5, 'riak'),
	(21, 5, 'sider');

INSERT INTO GeoEpoka VALUES
	(0, 0, 'holocen'),
	(1, 0, 'plejstocen'),
	(2, 1, 'pliocen'),
	(3, 1, 'miocen'),
	(4, 2, 'oligocen'),
	(5, 2, 'eocen'),
	(6, 2, 'paleocen'),
	(7, 3, 'późna kreda'),
	(8, 3, 'wczesna kreda'),
	(9, 4, 'jura późna'),
	(10, 4, 'jura środkowa'),
	(11, 4, 'jura wczesna'),
	(12, 5, 'późny trias'),
	(13, 5, 'środkowy trias'),
	(14, 5, 'wczesny trias'),
	(15, 6, 'loping'),
	(16, 6, 'gwadalup'),
	(17, 6, 'cisural'),
	(18, 7, 'pensylwan'),
	(19, 7, 'missisip'),
	(20, 8, 'późny dewon'),
	(21, 8, 'środkowy dewon'),
	(22, 8, 'wczesny dewon'),
	(23, 9, 'przydol'),
	(24, 9, 'ludlow'),
	(25, 9, 'wenlok'),
	(26, 9, 'landower'),
	(27, 10, 'ordowik późny'),
	(28, 10, 'ordowik środkowy'),
	(29, 10, 'ordowik wczesny'),
	(30, 11, 'furong'),
	(31, 11, 'miaoling'),
	(32, 11, 'oddział 2'),
	(33, 11, 'terenew');

INSERT INTO GeoPietro VALUES
	(0, 0, 'megalaj'),
	(1, 0, 'northgrip'),
	(2, 0, 'grenland'),
	(3, 1, 'późny'),
	(4, 1, 'chiban'),
	(5, 1, 'kalabr'),
	(6, 1, 'gelas'),
	(7, 2, 'piacent'),
	(8, 2, 'zankl'),
	(9, 3, 'messyn'),
	(10, 3, 'torton'),
	(11, 3, 'serrawal'),
	(12, 3, 'lang'),
	(13, 3, 'burdygał'),
	(14, 3, 'akwitan'),
	(15, 4, 'szat'),
	(16, 4, 'rupel'),
	(17, 5, 'priabon'),
	(18, 5, 'barton'),
	(19, 5, 'lutet'),
	(20, 5, 'iprez'),
	(21, 6, 'tanet'),
	(22, 6, 'zeland'),
	(23, 6, 'dan'),
	(24, 7, 'mastrycht'),
	(25, 7, 'kampan'),
	(26, 7, 'santon'),
	(27, 7, 'koniak'),
	(28, 7, 'turon'),
	(29, 7, 'cenoman'),
	(30, 8, 'alb'),
	(31, 8, 'apt'),
	(32, 8, 'barrem'),
	(33, 8, 'hoteryw'),
	(34, 8, 'walanżyn'),
	(35, 8, 'berrias'),
	(36, 9, 'tyton'),
	(37, 9, 'kimeryd'),
	(38, 9, 'oksford'),
	(39, 10, 'kelowej'),
	(40, 10, 'baton'),
	(41, 10, 'bajos'),
	(42, 10, 'aalen'),
	(43, 11, 'toark'),
	(44, 11, 'pliensbach'),
	(45, 11, 'synemur'),
	(46, 11, 'hettang'),
	(47, 12, 'retyk'),
	(48, 12, 'noryk'),
	(49, 12, 'karnik'),
	(50, 13, 'ladyn'),
	(51, 13, 'anizyk'),
	(52, 14, 'olenek'),
	(53, 14, 'ind'),
	(54, 15, 'czangsing'),
	(55, 15, 'wucziaping'),
	(56, 16, 'kapitan'),
	(57, 16, 'word'),
	(58, 16, 'road'),
	(59, 17, 'kungur'),
	(60, 17, 'artinsk'),
	(61, 17, 'sakmar'),
	(62, 17, 'assel'),
	(63, 18, 'gżel'),
	(64, 18, 'kasimow'),
	(65, 18, 'moskow'),
	(66, 18, 'baszkir'),
	(67, 19, 'serpuchow'),
	(68, 19, 'wizen'),
	(69, 19, 'turnej'),
	(70, 20, 'famen'),
	(71, 20, 'fran'),
	(72, 21, 'żywet'),
	(73, 21, 'eifel'),
	(74, 22, 'ems'),
	(75, 22, 'prag'),
	(76, 22, 'lochkow'),
	(77, 24, 'ludford'),
	(78, 24, 'gorst'),
	(79, 25, 'homer'),
	(80, 25, 'szejnwud'),
	(81, 26, 'telicz'),
	(82, 26, 'aeron'),
	(83, 26, 'ruddan'),
	(84, 27, 'hirnant'),
	(85, 27, 'kat'),
	(86, 27, 'sandb'),
	(87, 28, 'darriwil'),
	(88, 28, 'daping'),
	(89, 29, 'flo'),
	(90, 29, 'tremadok'),
	(91, 30, 'piętro 10'),
	(92, 30, 'dziangszan'),
	(93, 30, 'paib'),
	(94, 31, 'gużang'),
	(95, 31, 'drum'),
	(96, 31, 'wuliuan'),
	(97, 32, 'piętro 4'),
	(98, 32, 'piętro 3'),
	(99, 33, 'piętro 2'),
	(100, 33, 'fortun');

-- tabela zdenormalizowana
CREATE TABLE GeoTabela 
AS (SELECT * FROM GeoPietro 
	NATURAL JOIN GeoEpoka 
	NATURAL JOIN GeoOkres 
	NATURAL JOIN GeoEra 
	NATURAL JOIN GeoEon
   );

-- utworzenie tabeli milion z liczbami od 1 do 999 999
CREATE TABLE Dziesiec (cyfra int, bit int);
INSERT INTO Dziesiec VALUES 
(0, 1), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1);

CREATE TABLE Milion(liczba int, cyfra int, bit int);
INSERT INTO Milion 
SELECT a1.cyfra + 10*a2.cyfra + 100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra AS liczba, 
a1.cyfra AS cyfra, 
a1.bit AS bit 
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6;

-- zapytania
-- 1 ZL
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)
SELECT COUNT(*) FROM Milion 
	INNER JOIN GeoTabela ON (mod(Milion.liczba, 68) = (GeoTabela.id_pietro));

-- 2 ZL
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)
SELECT COUNT(*) FROM Milion 
	INNER JOIN GeoPietro ON (mod(Milion.liczba, 68) = GeoPietro.id_pietro) 
	NATURAL JOIN GeoEpoka 
	NATURAL JOIN GeoOkres 
	NATURAL JOIN GeoEra 
	NATURAL JOIN GeoEon;

-- 3 ZG
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)
SELECT COUNT(*) FROM Milion 
WHERE mod(Milion.liczba, 68) = 
	(SELECT id_pietro FROM GeoTabela 
	 WHERE mod(Milion.liczba, 68) = (id_pietro)
	);

-- 4 ZG
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68) IN 
(SELECT GeoPietro.id_pietro FROM GeoPietro 
 	NATURAL JOIN GeoEpoka 
 	NATURAL JOIN GeoOkres 
 	NATURAL JOIN GeoEra 
 	NATURAL JOIN GeoEon);
	 
-- zalozenie indeksow 
CREATE INDEX liczba_idx ON Milion (liczba);
CREATE INDEX tabela_idx ON GeoTabela(id_eon,id_era,id_okres,id_epoka,id_pietro);
CREATE INDEX eon_idx ON GeoEon (id_eon);
CREATE INDEX era_idx ON GeoEra (id_era);
CREATE INDEX okres_idx ON GeoOkres (id_okres);
CREATE INDEX epoka_idx ON GeoEpoka (id_epoka);
CREATE INDEX pietro_idx ON GeoPietro (id_pietro);