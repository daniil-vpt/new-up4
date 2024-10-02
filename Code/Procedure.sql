--Создание процедуры для изменения пароля пользователя
CREATE PROCEDURE change_password
@user_id INT,
@new_password VARCHAR(255)
AS
BEGIN
UPDATE users
SET password = @new_password
WHERE user_id = @user_id;
END;
GO

--Создание процедуры для удаления пользователя
CREATE PROCEDURE delete_user
@user_id INT
AS
BEGIN
DELETE FROM users
WHERE user_id = @user_id;
END;
GO

--Создание процедуры для добавления нового адресата
CREATE PROCEDURE add_recipient
@email_address VARCHAR(255)
AS
BEGIN
INSERT INTO recipients (email_address)
VALUES (@email_address);
END;
GO

--Применение процедуры change_password
EXEC change_password @user_id = 1, @new_password = 'new_password';

--Применение процедуры delete_user
EXEC delete_user @user_id = 3;

--Применение процедуры add_recipient
EXEC add_recipient @email_address = 'new_recipient@example.com';
