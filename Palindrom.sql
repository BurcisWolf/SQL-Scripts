USE master;
GO

/*
NOT SURE IF WORD IS A PALINDROME ? USE THIS FUNCTION TO BE SURE!

Works only for worlds and numbers without space characters!!

A palindrome is a sequence—be it a word, phrase, number, or other symbols—that reads the same backward as it does forward. 
The term "palindrome" is derived from the Greek words palin (again) and dromos (way, direction), 
which together convey the idea of "running back again"
*/

CREATE OR ALTER FUNCTION fn_isItPalindrom(@text varchar(20))
RETURNS varchar(41)
AS
BEGIN
	DECLARE @backwards varchar(20)
	DECLARE @erg varchar(41)
	SET @backwards = REVERSE(@text)
	IF( LOWER(@text) = LOWER(@backwards) )
	BEGIN
		SET @erg = @text + ' is a Palindrome.';
	END
	ELSE
	BEGIN
		SET @erg = @text + ' is not a Palindrome!';
	END
	RETURN @erg
END


GO


CREATE OR ALTER FUNCTION fn_isItPalindrom2(@text varchar(20))
RETURNS varchar(41)
AS
BEGIN
	DECLARE @long int = LEN(@text);							
	DECLARE @i int = 1;
	DECLARE @result int = 0;
	DECLARE @erg varchar(41)
	WHILE @i <= LEN(@text)
	BEGIN
		DECLARE @first varchar(1) = SUBSTRING(@text, @i, 1);
		DECLARE @last varchar(1) = SUBSTRING(@text, @long, 1);
		IF ( @first = @last )
		BEGIN
			SET @i = @i + 1;
			SET @long = @long - 1;	
			SET @result = 1;
		END
		ELSE 
		BEGIN
			SET @i = @long + 1;
		END
	END
	IF (@result = 0) SET @erg = @text + ' is not a Palindrome!';
	ELSE SET @erg = @text + ' is a Palindrome.';
	RETURN @erg;
END



