--Действующие лица, сгрупированные по значимости
SELECT COUNT(*), rank
FROM play_characters
GROUP BY rank
HAVING COUNT(*) > 1;

--Режиссеры по убыванию начала карьеры
SELECT firstname, lastname, began_career
FROM directors
ORDER BY began_career DESC;

--Представления, секционированные по месяцу даты
SELECT performances.id, plays.name, date,
COUNT(*) OVER (PARTITION BY extract(month from date)) AS same_month
FROM performances JOIN plays ON performances.play_id = plays.id
order by extract(month from date);

--Пьесы, проранжированные по дате премьеры
SELECT RANK() OVER (ORDER BY premier_date DESC) AS rank, name, premier_date
FROM plays;

--Список всех актеров и максимальной цены билета на спектакли, в которых они участвовали:
SELECT DISTINCT actors.firstname, actors.lastname, MAX(tickets.price) OVER (PARTITION BY actors.id) as max_ticket_price
FROM actors
JOIN theatrical_roles ON actors.id = theatrical_roles.actor_id
JOIN performances ON theatrical_roles.performance_id = performances.id
JOIN tickets ON performances.id = tickets.performance_id;


--Продолжительности обладания ролями и продолжительности предшественников в месяцах
WITH norm as
(select pc.name as character_name, actors.lastname as actor,
CASE WHEN tr.valid_to < NOW() THEN tr.valid_to
ELSE NOW() END as valid_to, tr.valid_from as valid_from,
 tr.character_id as character_id
FROM theatrical_roles as tr
join actors on actors.id = tr.actor_id
join play_characters as pc on pc.id = tr.character_id)
SELECT character_name, actor,
extract (DAY from ((valid_to - valid_from) / 30)) as playing_length,
LAG(extract (DAY from ((valid_to - valid_from) / 30)))
OVER (PARTITION BY character_id ORDER BY valid_to) AS prev_length
FROM norm order by actor

