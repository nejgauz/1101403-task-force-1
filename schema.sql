CREATE DATABASE taskforce
    DEFAULT CHARACTER SET utf8
    DEFAULT COLLATE utf8_general_ci;
USE taskforce;
CREATE TABLE tasks (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    client_id       INT UNSIGHNED NOT NULL,
    executive_id    INT UNSIGHNED NOT NULL,
    cat_id          INT UNSIGHNED NOT NULL,
    city_id         INT UNSIGHNED NOT NULL,
    status          ENUM('new', 'completed', 'cancelled', 'failed', 'in progress') NOT NULL,
    title           VARCHAR(128) NOT NULL,
    description     VARCHAR(255) NOT NULL,
    budget          INT UNSIGHNED DEFAULT NULL,
    dt_create       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dt_end          TIMESTAMP,
    longitude       DECIMAL(9,6),
    latitude        DECIMAL(9,6),
    view_count      INT,
    PRIMARY KEY (id),
    FOREIGN KEY (client_id) REFERENCES users(id),
    FOREIGN KEY (executive_id) REFERENCES users(id),
    FOREIGN KEY (cat_id) REFERENCES categories(id),
    FOREIGN KEY (city_id) REFERENCES cities(id),
);
CREATE TABLE users (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    city_id         INT UNSIGHNED NOT NULL,
    role            ENUM('client', 'executive') NOT NULL,
    message_alert   TINYINT(1) UNSIGHNED NOT NULL,
    action_alert    TINYINT(1) UNSIGHNED NOT NULL,
    review_alert    TINYINT(1) UNSIGHNED NOT NULL,
    show_contacts   TINYINT(1) UNSIGHNED NOT NULL,
    show_profile    TINYINT(1) UNSIGHNED NOT NULL,
    name            VARCHAR(50) NOT NULL,
    avatar_path     VARCHAR(128),
    dt_reg          TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dt_birth        DATE,
    dt_last_visit   TIMESTAMP NOT NULL,
    email           VARCHAR(64) UNIQUE NOT NULL,
    phone           VARCHAR(32),
    skype           VARCHAR(64),
    oth_contact     VARCHAR(64),
    password        CHAR(128) NOT NULL,
    longitude       DECIMAL(9,6),
    latitude        DECIMAL(9,6),
    bio             VARCHAR(65535),
    PRIMARY KEY (id),
    FOREIGN KEY (city_id) REFERENCES cities(id)
);
CREATE TABLE reviews (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    client_id       INT UNSIGHNED NOT NULL,
    executive_id    INT UNSIGHNED NOT NULL,
    task_id         INT UNSIGHNED NOT NULL,
    comment         VARCHAR(65535),
    rate            ENUM('1', '2', '3', '4', '5') NOT NULL,
    dt_create       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (client_id) REFERENCES users(id),
    FOREIGN KEY (executive_id) REFERENCES users(id),
    FOREIGN KEY (task_id) REFERENCES tasks(id)
);
CREATE TABLE users_specialisations (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    user_id         INT UNSIGHNED NOT NULL,
    cat_id          INT UNSIGHNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (cat_id) REFERENCES categories(id)
);
CREATE TABLE cities (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    title           VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE categories (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    title           VARCHAR(64) NOT NULL,
    symb_code       VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE alerts (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    user_id         INT UNSIGHNED NOT NULL,
    reply_id        INT UNSIGHNED NOT NULL,
    task_id         INT UNSIGHNED NOT NULL,
    message_id      INT UNSIGHNED NOT NULL,
    note_type       ENUM('answer', 'message', 'refuse', 'start', 'finish') NOT NULL,
    is_new          TINYINT(1) UNSIGHNED NOT NULL,
    dt_create       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (reply_id) REFERENCES task_replies(id),
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (message_id) REFERENCES messages(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE task_replies (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    executive_id    INT UNSIGHNED NOT NULL,
    task_id         INT UNSIGHNED NOT NULL,
    comment         VARCHAR(65535),
    price           INT UNSIGHNED NOT NULL,
    dt_create       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (executive_id) REFERENCES users(id),
    FOREIGN KEY (task_id) REFERENCES tasks(id)
);
CREATE TABLE attachments (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    user_id         INT UNSIGHNED NOT NULL,
    task_id         INT UNSIGHNED NOT NULL,
    attach_type     ENUM('task', 'user') NOT NULL,
    image_path      VARCHAR(128) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (task_id) REFERENCES tasks(id)
);
CREATE TABLE clients_favorites_executors (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    client_id       INT UNSIGHNED NOT NULL,
    executive_id    INT UNSIGHNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (client_id) REFERENCES users(id),
    FOREIGN KEY (executive_id) REFERENCES users(id)
);
CREATE TABLE messages (
    id              INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    author_id       INT UNSIGHNED NOT NULL,
    addressee_id    INT UNSIGHNED NOT NULL,
    task_id         INT UNSIGHNED NOT NULL,
    dt_create       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    text            VARCHAR(65535) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (addressee_id) REFERENCES users(id),
    FOREIGN KEY (task_id) REFERENCES tasks(id)
);
CREATE TABLE stop_words (
    id         INT UNSIGHNED NOT NULL AUTO_INCREMENT,
    value      VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE FULLTEXT INDEX person ON users(name);
CREATE FULLTEXT INDEX task_search ON tasks(title);