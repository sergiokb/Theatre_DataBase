--Триггер, завершающий период актуальности предыдущего актера при назначении нового
CREATE OR REPLACE FUNCTION change_validity()
RETURNS trigger AS
$$
BEGIN
    UPDATE theatrical_roles SET valid_to = NOW()
    WHERE (valid_to > NOW() AND id = NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER role_belonging BEFORE INSERT
    ON theatrical_roles
    FOR EACH ROW
    EXECUTE PROCEDURE change_validity();



--Триггер, выбрасывающий ошибку при попытке дать проданный билет новому зрителю
CREATE OR REPLACE FUNCTION prevent_buying()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    tic tickets%rowtype;
BEGIN
    FOR tic IN SELECT * FROM tickets WHERE id = NEW.ticket_id
    LOOP
        IF tic.is_sold = TRUE THEN
            RAISE EXCEPTION 'This ticket is already sold!';
        END IF;
    END LOOP;
    RETURN NULL;
END;
$$;

CREATE TRIGGER taking_ticket
BEFORE INSERT ON spectators
FOR EACH ROW
EXECUTE FUNCTION prevent_buying();





-- Примеры:
--------------
-- DELETE FROM theatrical_roles where valid_from = '2022-01-23' OR  valid_from = '2019-11-13';
--
-- INSERT INTO theatrical_roles (id, performance_id, character_id, actor_id, valid_from, valid_to)
-- VALUES (614, 361, 412, 512, '2022-01-23', '9999-01-01'),
--        (663, 387, 421, 513, '2019-11-13', '9999-01-01')
--------------
-- INSERT INTO spectators (id, firstname, middlename, lastname, date_of_birth, ticket_id)
-- VALUES (903, 'Ivan', 'Ivanovich', 'Ivanov', '1976-11-21', 832);
--------------