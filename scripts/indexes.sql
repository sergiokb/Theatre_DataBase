-- Поиск актеров, режиссеров по имени и фамилии

CREATE INDEX "directors.firstname_lastname"
    ON directors
    USING btree
    (firstname, lastname);

CREATE INDEX "actors.firstname_lastname"
    ON actors
    USING btree
    (firstname, lastname);

-- Поиск билетов в определенной зоне

CREATE INDEX "tickets.zone"
    ON tickets
    USING btree
    (zone);

-- Поиск театра по названию

CREATE INDEX "theatres.name"
    ON theatres
    USING btree
    (name);



