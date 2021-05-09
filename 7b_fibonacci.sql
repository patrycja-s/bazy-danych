--7a

CREATE OR REPLACE FUNCTION fibo(n INT) 
RETURNS void 
LANGUAGE 'plpgsql'
AS $$
DECLARE 
	f1 INT := 0;
	f2 INT := 1;
	fib INT := 0;
	i INT := 1;
BEGIN
	RAISE NOTICE 'wypisana ilość pierwszych wyrazow ciagu fibonacciego: %', n;
	IF n = 1 THEN
		RAISE NOTICE '%', 1;
	ELSEIF n = 2 THEN
		RAISE NOTICE '%', 1;
		RAISE NOTICE '%', 1;
	ELSE
		WHILE i <= n LOOP
			RAISE NOTICE '%', f2;
			fib := f1 + f2;
			f1 := f2;
			f2 := fib;
			i := i + 1;
		END LOOP;
	END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE fibonacci(n INT)
LANGUAGE 'plpgsql'
AS $$
BEGIN
	PERFORM fibo(n);
END;
$$;

CALL fibonacci(10);

