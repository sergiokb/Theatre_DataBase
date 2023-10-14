SELECT actors.firstname, actors.lastname
FROM actors
JOIN theatrical_roles ON actors.id = theatrical_roles.actor_id
JOIN performances ON theatrical_roles.performance_id = performances.id
JOIN plays ON performances.play_id = plays.id
WHERE plays.name = 'Hamlet';