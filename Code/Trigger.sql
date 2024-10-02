--Пример работы триггера track_user_changes:
CREATE TRIGGER track_user_changes
ON users
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Логика для отслеживания изменений при вставке новых записей
        INSERT INTO user_changes_log (user_id, action, action_date)
        SELECT user_id, 'INSERT', GETDATE()
        FROM inserted;
    END

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Логика для отслеживания изменений при удалении записей
        INSERT INTO user_changes_log (user_id, action, action_date)
        SELECT user_id, 'DELETE', GETDATE()
        FROM deleted;
    END

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Логика для отслеживания изменений при обновлении записей
        INSERT INTO user_changes_log (user_id, action, action_date)
        SELECT user_id, 'UPDATE', GETDATE()
        FROM inserted;
    END
END;
GO
