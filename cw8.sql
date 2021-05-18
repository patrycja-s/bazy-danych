-- cw8
-- sql server, baza danych AdventureWorks2019

-- 1. blok anonimowy:
--    > znajdujacy srednia stawke wynagrodzenia pracownikow
--    > wyswietlajacy szczegoly pracownikow, ktorych stawka jest nizsza niz srednia

BEGIN
	SELECT AVG(Rate) AS AverageRate
	FROM HumanResources.EmployeePayHistory;

	SELECT e.*, p.Rate FROM HumanResources.Employee e
	JOIN HumanResources.EmployeePayHistory p on p.BusinessEntityID = e.BusinessEntityID
	WHERE Rate < (SELECT AVG(Rate) FROM HumanResources.EmployeePayHistory);
END;
GO


-- 2. funkcja zwracajaca date wysylki okreslonego zamowienia

CREATE FUNCTION OrderShipDate(@ID INT)
RETURNS DATE
BEGIN
	RETURN (
		SELECT ShipDate FROM Sales.SalesOrderHeader
		WHERE SalesOrderID = @ID 
	)
END;
GO

SELECT dbo.OrderShipDate(43660);
GO


-- 3. procedura skladowana, ktora jakos parametr przyjmuje nazwe produktu, 
--    a jako rezultat wyswietla jego identyfikator, numer i dostepnosc

CREATE PROCEDURE productInfo @name NVARCHAR(50)
AS
BEGIN
	SELECT ProductID, ProductNumber, SafetyStockLevel FROM Production.Product
	WHERE Product.Name = name;
END;
GO

EXEC productInfo Blade
GO


-- 4. funkcja zwracajaca numer karty kredytowej dla konkretnego zamowienia

CREATE FUNCTION creditCardNo (@orderID INT)
RETURNS VARCHAR(50)
BEGIN
	RETURN (
	SELECT CardNumber FROM Sales.CreditCard c
	INNER JOIN Sales.SalesOrderHeader o ON o.CreditCardID = c.CreditCardID 
	WHERE o.SalesOrderID = @orderID
	)
END;
GO

SELECT dbo.creditCardNo(43660)
GO


-- 5. procedura skladowana, ktora jako parametry wejsciowe przyjmuje dwie liczby, num1 i num2, a zwraca wynik ich dzielenia. 
--    ponadto wartosc num1 powinna zawsze byc wieksza niż wartosc num2. jezeli wartosc num1 jest mniejsza niż num2, wyswietla 
--    sie komunikat o bledzie "Niewlasciwie zdefiniowales dane wejsciowe"

CREATE PROCEDURE divide @num1 FLOAT, @num2 FLOAT
AS
BEGIN
	IF @num1 < @num2
		RAISERROR ('Niewlasciwie zdefiniowales dane wejsciowe',16,1);
	ELSE
		SELECT @num1/@num2 AS Quotient;
END;
GO

EXEC divide @num1 = 40, @num2 = 5;
EXEC divide @num1 = 38.8, @num2 = 25.33;
EXEC divide @num1 = 10, @num2 = 25; -- wyswietla sie komunikat o bledzie
GO

-- dodanie obslugi wyjatkow 
CREATE PROCEDURE divide2 @num1 FLOAT, @num2 FLOAT
AS
BEGIN
	IF @num1 < @num2
		RAISERROR ('Niewlasciwie zdefiniowales dane wejsciowe',16,1);
	ELSE
		SELECT COALESCE(@num1/NULLIF(@num2, 0), 0) AS Quotient;
END;
GO

EXEC divide2 @num1 = 10, @num2 = 0;
EXEC divide @num1 = 10, @num2 = 0;
GO

-- dodanie obslugi wyjatkow 2
CREATE PROCEDURE divide3 @num1 FLOAT, @num2 FLOAT
AS
BEGIN
	IF @num1 < @num2
		RAISERROR ('Niewlasciwie zdefiniowales dane wejsciowe',16,1);
	BEGIN TRY
		SELECT @num1/@num2 AS Quotient;
	END TRY
	BEGIN CATCH 
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END;
GO

EXEC divide3 @num1 = 10, @num2 = 0;
GO


-- 6. procedura, ktora jako parametr przyjmuje NationalIDNumber danej osoby, a zwraca
--    stanowisko oraz liczbe dni urlopowych i chorobowych

CREATE PROC VacationAndSickDays @ID NVARCHAR(15)
AS
BEGIN
	SELECT JobTitle, VacationHours/24 AS VacationDays, SickLeaveHours/24 AS SickLeaveDays 
	FROM HumanResources.Employee
	WHERE NationalIDNumber = @ID;
END;
GO

EXEC VacationAndSickDays 295847284;
GO 


-- 7. napisz procedure badaca  kalkulatorem walutowym. Wykorzystaj dwie tabele: Sales.Currency 
--    oraz Sales.CurrencyRate. Parametrami wejsciowymi maja byc: kwota, waluty oraz data 
--    (CurrencyRateDate). Przyjmij, iz zawsze jedna ze stron jest dolar amerykański (USD).
--    Zaimplementuj kalkulacje obustronna, tj:
--    1400 USD → PLN lub PLN → USD

CREATE PROC CurrencyCalc @amount MONEY, @fromCurrency NCHAR(20), @toCurrency NCHAR(20), @date DATE
AS
BEGIN
	IF @fromCurrency = 'USD' OR @fromCurrency = 'US Dollar'
	BEGIN
		SELECT @amount*AverageRate 
		FROM Sales.CurrencyRate 
		JOIN Sales.Currency ON Sales.CurrencyRate.ToCurrencyCode = Sales.Currency.CurrencyCode
		WHERE (ToCurrencyCode = @toCurrency OR Name = @toCurrency)
		AND CurrencyRateDate = @date
	END
	ELSE IF @toCurrency = 'USD' OR @toCurrency = 'US Dollar'
	BEGIN
		SELECT @amount/AverageRate 
		FROM Sales.CurrencyRate
		JOIN Sales.Currency ON Sales.CurrencyRate.ToCurrencyCode = Sales.Currency.CurrencyCode
		WHERE (ToCurrencyCode = @fromCurrency OR Name = @fromCurrency)
		AND CurrencyRateDate = @date
	END
	ELSE 
		RAISERROR ('Niewlasciwie zdefiniowales dane wejsciowe',16,1)
END;
GO

EXEC CurrencyCalc @amount = 100, @fromCurrency = USD, @toCurrency = AUD, @date = '2011-05-31'
EXEC CurrencyCalc @amount = 100, @fromCurrency = AUD, @toCurrency = USD, @date = '2011-05-31'

EXEC CurrencyCalc @amount = 100, @fromCurrency = 'US Dollar', @toCurrency = 'Australian Dollar', @date = '2011-05-31'
EXEC CurrencyCalc @amount = 100, @fromCurrency = AUD, @toCurrency = 'US Dollar', @date = '2011-05-31'

EXEC CurrencyCalc @amount = 100, @fromCurrency = BDT, @toCurrency = AUD, @date = '2011-05-31' -- wyswietla sie error

