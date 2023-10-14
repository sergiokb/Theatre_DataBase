-- Общие роли двух актеров по их id
CREATE OR REPLACE FUNCTION common_plays(integer, integer)
	RETURNS TABLE (
	 	name VARCHAR(50),
		play_character VARCHAR(50)
	 )
AS
$$
BEGIN
  RETURN QUERY
    SELECT DISTINCT pc.name, pl.name from theatrical_roles as tr
        JOIN performances as pr on tr.performance_id = pr.id
        JOIN plays as pl on pr.play_id = pl.id
        JOIN play_characters as pc on tr.character_id = pc.id WHERE pc.id in (
    (SELECT tr.character_id from theatrical_roles as tr
        JOIN performances as pr on tr.performance_id = pr.id
        JOIN plays as pl on pr.play_id = pl.id where tr.actor_id = $1)
    INTERSECT
    (SELECT tr.character_id from theatrical_roles as tr
        JOIN performances as pr on tr.performance_id = pr.id
        JOIN plays as pl on pr.play_id = pl.id where tr.actor_id = $2));
END;
$$ LANGUAGE plpgsql;
-- select * from common_plays(534, 576)


--Выручка от представлений в данном театре по его id (до и после вычета НДС)
CREATE OR REPLACE FUNCTION get_revenue_from_performances(integer, integer)
	RETURNS TABLE (performance_id INT, revenue NUMERIC, after_vat_deducted NUMERIC)
AS
$$
BEGIN
  RETURN QUERY
	SELECT p.id, round(SUM(tickets.price), 2) as revenue, round(SUM(tickets.price) * (1 - $2 / 100.0), 2) as after_vat_deducted
	FROM tickets JOIN performances p on tickets.performance_id = p.id
    JOIN theatres t on p.theatre_id = t.id WHERE theatre_id = $1
    GROUP BY p.id ORDER BY revenue;
END;
$$ LANGUAGE plpgsql;

--select * from get_revenue_from_performances(179, 20)

