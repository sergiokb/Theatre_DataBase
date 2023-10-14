
-- Инициалы зрителей
CREATE OR REPLACE VIEW spectators_initials AS
SELECT spectators.ticket_id, CASE WHEN spectators.middlename IS NOT NULL THEN
                                 substring(spectators.firstname, 1, 1) || '.'
                                 || substring(spectators.middlename, 1, 1) || '.'
                                 || substring(spectators.lastname, 1, 1) || '.'
                           ELSE  substring(spectators.firstname, 1, 1) || '.'
                                 || substring(spectators.lastname, 1, 1) || '.'
                          END as initials
FROM spectators;

-- Только даты премьер
CREATE OR REPLACE VIEW only_premiers AS
SELECT name, premier_date
FROM plays;

-- Только адресы театров
CREATE OR REPLACE VIEW only_addresses AS
SELECT name, address
FROM theatres;

-- Грядущие представления
CREATE OR REPLACE VIEW plays_coming AS
SELECT plays.name, performances.date FROM plays JOIN performances ON plays.id = performances.play_id
WHERE performances.date > NOW();

-- Таблица некупленных билетов
CREATE OR REPLACE VIEW unbought_tickets AS
SELECT tickets.performance_id, tickets.zone, tickets.row_num, tickets.seat, tickets.price
FROM tickets
WHERE tickets.is_sold = false
ORDER BY tickets.performance_id;

-- Самые популярные представления
CREATE OR REPLACE VIEW most_popular_performances AS
SELECT performances.id, plays.name, count(*) FROM tickets
    JOIN performances ON tickets.performance_id = performances.id
    JOIN plays ON performances.play_id = plays.id
GROUP BY performances.id, plays.name
ORDER BY count(*) DESC
LIMIT 10;

-- Афиша
CREATE OR REPLACE VIEW poster AS
SELECT DISTINCT performances.id, performances.date, plays.name as play, d.lastname as director,
       t.name as theatre FROM performances
    JOIN plays ON performances.play_id = plays.id
    JOIN directors d on plays.director_id = d.id
    JOIN theatres t on performances.theatre_id = t.id
ORDER BY performances.date;
