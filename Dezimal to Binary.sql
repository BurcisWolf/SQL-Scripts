USE master;
GO

CREATE OR ALTER FUNCTION fn_DezToBin (@input int)
RETURNS varchar(20)
AS
BEGIN
	IF(@input >= 0)
	BEGIN
		DECLARE @erg varchar(20);
		WHILE (@input > 0) 
		BEGIN
			SET @erg = CONCAT(@erg, CAST(@input % 2 AS varchar(1)));
			SET @input = @input / 2;
		END
		SET @erg = REVERSE(@erg)
	END
	ELSE 
	BEGIN
		SET @erg = 'Fehler'
	END
	RETURN @erg
END