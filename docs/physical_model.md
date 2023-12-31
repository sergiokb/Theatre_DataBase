   **PERFORMANCES**   

| Название     | Описание                    | Тип данных | Ограничение                 |
|--------------|-----------------------------|------------|-----------------------------|
| `id`         | Идентификатор представления | `INTEGER`  | `PRIMARY KEY`               |
| `play_id`    | Идентификатор постановки    | `INTEGER`  | `FOREIGN KEY (PLAYS.id)`    |
| `theatre_id` | Идентификатор театра        | `INTEGER`  | `FOREIGN KEY (THEATRES.id)` |
| `date`       | Дата представления          | `DATE`     | `NOT NULL`                  |


   **PLAYS**   

| Название       | Описание                  | Тип данных     | Ограничение                  |
|----------------|---------------------------|----------------|------------------------------|
| `id`           | Идентификатор постановки  | `INTEGER`      | `PRIMARY KEY`                |
| `name`         | Название постановки       | `VARCHAR(128)` | `NOT NULL`                   |
| `director_id`  | Идентификатор режиссера   | `INTEGER`      | `FOREIGN KEY (DIRECTORS.id)` |
| `premier_date` | Дата премьеры             | `DATE`         |                              |


   **DIRECTORS**

| Название       | Описание                      | Тип данных     | Ограничение   |
|----------------|-------------------------------|----------------|---------------|
| `id`           | Идентификатор режиссера       | `INTEGER`      | `PRIMARY KEY` |
| `firstname`    | Имя режиссера                 | `VARCHAR(128)` | `NOT NULL`    |
| `middlename`   | Отчество/второе имя режиссера | `VARCHAR(128)` |               |
| `lastname`     | Фамилия режиссера             | `VARCHAR(128)` | `NOT NULL`    |
| `began_career` | Год начала карьеры            | `DATE`         |               |


   **THEATRICAL_ROLES**

| Название         | Описание                    | Тип данных     | Ограничение                     |
|------------------|-----------------------------|----------------|---------------------------------|
| `id`             | Идентификатор роли          | `INTEGER`      | `PRIMARY KEY`                   |
| `performance_id` | Идентификатор представления | `INTEGER`      | `FOREIGN KEY (PERFORMANCES.id)` |
| `character_id`   | Идентификатор персонажа     | `VARCHAR(128)` | `FOREIGN KEY (CHARACTERS.id)`   |
| `actor_id`       | Идентификатор актерa        | `INTEGER`      | `FOREIGN KEY (ACTORS.id)`       |
| `valid_from`     | Начало актуальности         | `DATE`         | `PRIMARY KEY`                   |
| `valid_to`       | Конец актуальности          | `DATE`         | `NOT NULL`                      |


   **ACTORS**

| Название        | Описание             | Тип данных     | Ограничение                |
|-----------------|----------------------|----------------|----------------------------|
| `id`            | Идентификатор актера | `INTEGER`      | `PRIMARY KEY`              |
| `firstname`     | Имя актера           | `VARCHAR(128)` | `NOT NULL`                 |
| `middlename`    | Отчество актера      | `VARCHAR(128)` |                            |
| `lastname`      | Фамилия актера       | `VARCHAR(128)` | `NOT NULL`                 |
| `date_of_birth` | Дата рождения        | `DATE`         |                            |


   **PLAY_CHARACTERS**   

| Название  | Описание                                                             | Тип данных     | Ограничение              |
|-----------|----------------------------------------------------------------------|----------------|--------------------------|
| ` id`     | Идентификатор персонажа                                              | `INTEGER`      | `PRIMARY KEY`            |
| `name`    | Имя персонажа                                                        | `VARCHAR(128)` | `NOT NULL`               |
| `play_id` | Идентификатор постановки                                             | `INTEGER`      | `FOREIGN KEY (PLAYS.id)` |
| `rank`    | Значимость (Главный/второстепенный/<br/>эпизодический/внесюжетный)   | `VARCHAR(32)`  |                          |


   **THEATRES**

| Название  | Описание             | Тип данных     | Ограничение    |
|-----------|----------------------|----------------|----------------|
| `id`      | Идентификатор театра | `INTEGER`      | `PRIMARY KEY`  |
| `name`    | Название театра      | `VARCHAR(128)` | `NOT NULL`     |
| `country` | Страна театра        | `VARCHAR(128)` |                |
| `city`    | Город театра         | `VARCHAR(128)` |                |
| `address` | Адрес театра         | `VARCHAR(256)` |                |


   **SPECTATORS**

| Название        | Описание              | Тип данных     | Ограничение                |
|-----------------|-----------------------|----------------|----------------------------|
| `id`            | Идентификатор зрителя | `INTEGER`      | `PRIMARY KEY`              |
| `firstname`     | Имя зрителя           | `VARCHAR(128)` | `NOT NULL`                 |
| `middlename`    | Отчество зрителя      | `VARCHAR(128)` |                            |
| `lastname`      | Фамилия зрителя       | `VARCHAR(128)` | `NOT NULL`                 |
| `date_of_birth` | Дата рождения зрителя | `DATE`         | `NOT NULL`                 |
| `ticket_id`     | Идентификатор билета  | `INTEGER`      | `FOREIGN KEY (TICKETS.id)` |


   **TICKETS**

| Название         | Описание                                                             | Тип данных    | Ограничение                     |
|------------------|----------------------------------------------------------------------|---------------|---------------------------------|
| `id`             | Идентификатор билета                                                 | `INTEGER`     | `PRIMARY KEY`                   |
| `performance_id` | Идентификатор представления                                          | `INTEGER`     | `FOREIGN KEY (PERFORMANCES.id)` |
| `price`          | Цена билета в рублях                                                 | `NUMERIC `    | `NOT NULL`                      |
| `hall`           | Номер зала                                                           | `SMALLINT`    |                                 |
| `zone`           | Зона в зрительном зале <br/> (Партер/амфитеатр/бельетаж/балкон/ложа) | `VARCHAR(32)` |                                 |
| `zone_num`       | Номер зоны (если балкон/ложа)                                        | `SMALLINT`    |                                 |
| `row_num`        | Номер ряда                                                           | `SMALLINT`    | `NOT NULL`                      |
| `seat`           | Номер места                                                          | `SMALLINT`    | `NOT NULL`                      |
| `is_sold`        | Продан или нет                                                       | `BOOLEAN `    | `NOT NULL`                      |
