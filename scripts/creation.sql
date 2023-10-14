DROP TABLE IF EXISTS spectators;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS theatrical_roles;
DROP TABLE IF EXISTS play_characters;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS performances;
DROP TABLE IF EXISTS plays;
DROP TABLE IF EXISTS theatres;
DROP TABLE IF EXISTS directors;

CREATE TABLE directors (
                      id INTEGER PRIMARY KEY,
                      firstname VARCHAR(128) NOT NULL,
                      middlename VARCHAR(128),
                      lastname VARCHAR(128) NOT NULL,
                      began_career DATE
);

CREATE TABLE theatres(
                    id INTEGER PRIMARY KEY,
                    name VARCHAR(128) NOT NULL,
                    country VARCHAR(128),
                    city VARCHAR(128),
                    address VARCHAR(256)
);

CREATE TABLE plays (
                     id INTEGER PRIMARY KEY,
                     name VARCHAR(128) NOT NULL,
                     director_id INTEGER REFERENCES directors(id),
                     premier_date DATE
);

CREATE TABLE performances (
                     id INTEGER PRIMARY KEY,
                     play_id INTEGER REFERENCES plays(id),
                     theatre_id INTEGER REFERENCES theatres(id),
                     date DATE
);

CREATE TABLE actors(
                      id INTEGER PRIMARY KEY,
                      firstname VARCHAR(128) NOT NULL,
                      middlename VARCHAR(128),
                      lastname VARCHAR(128) NOT NULL,
                      date_of_birth DATE
);

CREATE TABLE play_characters(
                        id	INTEGER	PRIMARY KEY,
                        name VARCHAR(128) NOT NULL,
                        play_id INTEGER NOT NULL,
                        rank VARCHAR(32) NOT NULL

);

CREATE TABLE theatrical_roles(
                        id INTEGER NOT NULL,
                        performance_id INTEGER REFERENCES performances(id),
                        character_id INTEGER REFERENCES play_characters(id),
                        actor_id INTEGER NOT NULL,
                        valid_from DATE	NOT NULL,
                        valid_to DATE NOT NULL,
                        CONSTRAINT pk_roles PRIMARY KEY (id, valid_from)
);

CREATE TABLE tickets(
                       id INTEGER PRIMARY KEY,
                       performance_id INTEGER REFERENCES performances(id),
                       price NUMERIC NOT NULL,
                       hall SMALLINT NOT NULL,
                       zone VARCHAR(32),
                       zone_num SMALLINT,
                       row_num SMALLINT NOT NULL,
                       seat SMALLINT NOT NULL,
                       is_sold BOOLEAN NOT NULL
);

CREATE TABLE spectators(
                      id INTEGER PRIMARY KEY,
                      firstname VARCHAR(128) NOT NULL,
                      middlename VARCHAR(128),
                      lastname VARCHAR(128) NOT NULL,
                      date_of_birth DATE NOT NULL,
                      ticket_id INTEGER REFERENCES tickets(id)
);

-- SELECT * FROM spectators;
-- SELECT * FROM tickets;
-- SELECT * FROM theatrical_roles;
-- SELECT * FROM play_characters;
-- SELECT * FROM actors;
-- SELECT * FROM performances;
-- SELECT * FROM plays;
-- SELECT * FROM theatres;
-- SELECT * FROM directors;
