CREATE TABLE categories (
   id SERIAL NOT NULL,
   name VARCHAR(50),
   PRIMARY KEY(id)
);

CREATE TABLE regions (
   id SERIAL NOT NULL,
   name VARCHAR(25),
   PRIMARY KEY(id)
);

CREATE TABLE users (
   id            SERIAL NOT NULL,
   firstname     VARCHAR(20),
   lastname      VARCHAR(20),
   nickname      VARCHAR(20) NOT NULL UNIQUE,
   password      VARCHAR(20) NOT NULL,
   email         VARCHAR(50) NOT NULL,
   rating        INTEGER,
   balance       FLOAT,
   creation_date TIMESTAMP,
   region        INTEGER NOT NULL,
   PRIMARY KEY(id)
);

CREATE INDEX auth ON users(nickname,password);
CREATE INDEX region_id ON users(region);


CREATE TABLE items (
   id            SERIAL NOT NULL,
   name          VARCHAR(100),
   description   TEXT,
   initial_price FLOAT NOT NULL,
   quantity      INTEGER NOT NULL,
   reserve_price FLOAT DEFAULT 0,
   buy_now       FLOAT DEFAULT 0,
   nb_of_bids    INTEGER DEFAULT 0,
   max_bid       FLOAT DEFAULT 0,
   start_date    TIMESTAMP,
   end_date      TIMESTAMP,
   seller        INTEGER NOT NULL,
   category      INTEGER NOT NULL,
   PRIMARY KEY(id)
);

CREATE INDEX seller_id_items ON items(seller);
CREATE INDEX category_id_items ON items(category);

CREATE TABLE old_items (
   id            INTEGER NOT NULL UNIQUE,
   name          VARCHAR(100),
   description   TEXT,
   initial_price FLOAT NOT NULL,
   quantity      INTEGER NOT NULL,
   reserve_price FLOAT DEFAULT 0,
   buy_now       FLOAT DEFAULT 0,
   nb_of_bids    INTEGER DEFAULT 0,
   max_bid       FLOAT DEFAULT 0,
   start_date    TIMESTAMP,
   end_date      TIMESTAMP,
   seller        INTEGER NOT NULL,
   category      INTEGER NOT NULL,
   PRIMARY KEY(id)
);

CREATE INDEX seller_id ON old_items(seller);
CREATE INDEX category_id ON old_items(category);

CREATE TABLE bids (
   id      SERIAL NOT NULL,
   user_id INTEGER NOT NULL,
   item_id INTEGER NOT NULL,
   qty     INTEGER NOT NULL,
   bid     FLOAT NOT NULL,
   max_bid FLOAT NOT NULL,
   date    TIMESTAMP,
   PRIMARY KEY(id)
);

CREATE INDEX item_bids ON bids(item_id);
CREATE INDEX user_idx ON bids(user_id);

CREATE TABLE comments (
   id           SERIAL NOT NULL,
   from_user_id INTEGER NOT NULL,
   to_user_id   INTEGER NOT NULL,
   item_id      INTEGER NOT NULL,
   rating       INTEGER,
   date         TIMESTAMP,
   comment      TEXT,
   PRIMARY KEY(id)
);

CREATE INDEX from_user ON comments(from_user_id);
CREATE INDEX to_user ON comments(to_user_id);
CREATE INDEX item_comments ON comments(item_id);

CREATE TABLE buy_now (
   id       SERIAL NOT NULL,
   buyer_id INTEGER NOT NULL,
   item_id  INTEGER NOT NULL,
   qty      INTEGER NOT NULL,
   date     TIMESTAMP,
   PRIMARY KEY(id)
);

CREATE INDEX buyer ON buy_now (buyer_id);
CREATE INDEX item_buy_now ON buy_now (item_id);

CREATE TABLE ids (
   id        INTEGER NOT NULL UNIQUE,
   category  INTEGER NOT NULL,
   region    INTEGER NOT NULL,
   users     INTEGER NOT NULL,
   item      INTEGER NOT NULL,
   comment   INTEGER NOT NULL,
   bid       INTEGER NOT NULL,
   buyNow    INTEGER NOT NULL,
   PRIMARY KEY(id)
);
