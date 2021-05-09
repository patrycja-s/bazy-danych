--7b
--zadanie wykonane w sql server

--zad 2
--trigger modyfikujacy nazwisko 
CREATE TRIGGER upperLastName ON Person.person
AFTER INSERT, UPDATE
AS 
BEGIN
	UPDATE Person.person SET LastName = UPPER(Person.LastName) FROM inserted WHERE person.BusinessEntityID = inserted.BusinessEntityID;
END
GO

--pokazanie dzialania na update, zeby nie dodawac nowych wierszy
UPDATE Person.person 
SET FirstName = 'Ann' 
WHERE BusinessEntityID = 1;

SELECT TOP 50 * FROM Person.person;


--zad3
--trigger wyswietlajacy kominikat jesli zmiana wartosci w polu TaxRate jest wieksza niż o 30%
CREATE TRIGGER txtRateMonitor ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	DECLARE @oldTax FLOAT = (SELECT TaxRate FROM deleted);
	DECLARE @newTax FLOAT = (SELECT TaxRate FROM inserted);
	DECLARE @change FLOAT = @oldTax * 0.3;

	IF (@newTax > (@oldTax + @change)) OR (@newTax < (@oldTax - @change))
		PRINT 'blad - zmieniono wartosc w polu TaxRate o wiecej niz 30%';
END;
GO

--pokazanie dzialania
--wyswietla sie kominunikat
UPDATE Sales.SalesTaxRate 
SET TaxRate = '20'
WHERE SalesTaxRateID = 1;

--nie wyswietla sie komunikat
UPDATE Sales.SalesTaxRate
SET TaxRate = '14.50'
WHERE SalesTaxRateID = 2;

SELECT TOP 50 * FROM Sales.SalesTaxRate


