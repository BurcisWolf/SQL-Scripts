USE master;
GO

-- Generate RANDOM Number (0-9),  Upper character (A-Z), Lower character (a-z) and special character
CREATE OR ALTER VIEW vw_randomgen
AS
	SELECT
		CAST(RAND()*10 AS int) AS number,
		CHAR(CAST(RAND() * 26 + 97 AS int)) AS [upper],
		CHAR(CAST(RAND() * 26 + 65 AS int)) AS [lower],
		CHAR(CAST(RAND() * 15 + 33 AS int)) AS spezial,
		CAST((RAND()*(10-14)+4) AS int) AS random 
GO
SELECT * FROM vw_randomgen

-- PASSWORD GENERATOR


DECLARE @i int = 0;
DECLARE @cycles int = 15;
-- to count how often do we have something
DECLARE @number int;
DECLARE @small int;
DECLARE @big int;
DECLARE @speci int;
DECLARE @num int;
-- Output
DECLARE @password varchar(15);
WHILE(@i < @cycles)
BEGIN
	DECLARE @position int = (SELECT random FROM vw_randomgen)
	IF ( @position = 0 )
	BEGIN
		SET @num = (SELECT number FROM vw_randomgen);
		SET @password = CONCAT(@password, CAST(@num AS varchar(1)));
		SET @number = @number + 1;
	END
	ELSE IF ( @position = 1 )
	BEGIN
		SET @password = CONCAT(@password, (SELECT upper FROM vw_randomgen));
		SET @big = @big + 1;
	END
	ELSE IF ( @position = 2 )
	BEGIN
		SET @password = CONCAT(@password, (SELECT lower FROM vw_randomgen));
		SET @small = @small + 1;
	END
	ELSE 
	BEGIN
		SET @password = CONCAT(@password, (SELECT spezial FROM vw_randomgen));
		SET @speci = @speci + 1;
	END
	SET @i = @i + 1;
END

print @password
