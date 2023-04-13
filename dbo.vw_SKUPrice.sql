CREATE VIEW dbo.vw_SKUPrice
AS
SELECT S.ID, S.Code, S.Name, 
	dbo.udf_GetSKUPrice(S.ID) AS Price
FROM dbo.SKU as S;