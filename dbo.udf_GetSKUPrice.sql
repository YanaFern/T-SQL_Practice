CREATE FUNCTION dbo.udf_GetSKUPrice
(
@ID_SKU AS INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @Price DECIMAL(18,2);
	SET @Price = (
		SELECT (B.Value / B.Quantity)
		FROM dbo.Basket as B
		WHERE B.ID_SKU = @ID_SKU
		);
	RETURN @Price;
END;