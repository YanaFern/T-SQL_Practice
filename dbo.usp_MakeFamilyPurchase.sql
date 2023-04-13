CREATE PROC dbo.usp_MakeFamilyPurchase
@FamilySurName AS VARCHAR(255)
AS
SET NOCOUNT ON;
IF @FamilySurName IN (
	SELECT dbo.Family.SurName
	FROM dbo.Family
	)
		BEGIN
			UPDATE dbo.Family
			SET dbo.Family.BudgetValue -= (
				SELECT SUM(B.Value)
				FROM dbo.Basket AS B
				JOIN dbo.Family AS F
				ON B.ID_Family = F.ID
				WHERE F.SurName = @FamilySurName
				)
			WHERE dbo.Family.SurName = @FamilySurName;
		END;
ELSE
	BEGIN
		PRINT N'Ошибка: Такой семьи нет';
	END;