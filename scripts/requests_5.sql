--Добавить зрителя
INSERT INTO spectators (id, firstname, lastname, date_of_birth, ticket_id)
VALUES (999, 'Sergey', 'Kunin-Bogoiavlenskii', '2004-01-30', 848);

--Добавить театр
INSERT INTO theatres (id, name, country, city, address)
VALUES (169, 'Royal Shakespeare Theatre', 'United Kingdom', 'Stratford-upon-Avon', 'Waterside, CV37 6BB');

--Добавить режиссера
INSERT INTO directors (id, firstname, lastname, began_career)
VALUES (711, 'Evgeniy', 'Mironov', '2006-01-01');

-- Актеры, у которых указано отчество
SELECT * FROM actors WHERE middlename is not NULL;

--Средняя цена билетов по зонам на представление с id 361
SELECT zone, AVG(price)
FROM tickets
WHERE performance_id = 361
GROUP BY zone;

-- Режиссеры, начавшие карьеру после распада СССР
SELECT * FROM directors WHERE began_career > '1998-10-16';

--Актеры, игравшие Гамлета
SELECT actors.firstname, actors.lastname
FROM actors
JOIN theatrical_roles ON actors.id = theatrical_roles.actor_id
JOIN performances ON theatrical_roles.performance_id = performances.id
JOIN plays ON performances.play_id = plays.id
WHERE plays.name = 'Hamlet';


-- Продать билет с id 821
UPDATE tickets SET is_sold = true WHERE id = 821;

-- Изменить цену билета с id 395
UPDATE tickets SET price = 2000 WHERE performance_id = 395;

-- Удалить зрителей за 70
DELETE FROM spectators WHERE date_of_birth < '1951-01-01';

-- Удалить непроданные билеты в мезонине
DELETE FROM tickets WHERE is_sold = false AND zone = 'mezzanine';

SELECT * FROM performances


