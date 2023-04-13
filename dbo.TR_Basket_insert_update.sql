CREATE TRIGGER dbo.TR_Basket_insert_update
	ON dbo.Basket FOR INSERT
AS
SET NOCOUNT ON;
UPDATE dbo.Basket
SET dbo.Basket.DiscountValue = dbo.Basket.Value * 0.05
WHERE dbo.Basket.ID IN (
	SELECT I.ID
	FROM inserted as I
	WHERE I.ID_SKU IN (
		SELECT I.ID_SKU
		FROM inserted as I
		GROUP BY I.ID_SKU
		HAVING COUNT(*) >= 2
		)
	);
UPDATE dbo.Basket
SET dbo.Basket.DiscountValue = 0.00
WHERE dbo.Basket.ID IN (
	SELECT I.ID
	FROM inserted as I
	WHERE I.ID_SKU NOT IN (
		SELECT I.ID_SKU
		FROM inserted as I
		GROUP BY I.ID_SKU
		HAVING COUNT(*) >= 2
		)
	);