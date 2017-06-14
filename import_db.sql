DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS questions_follows;

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (follower_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  reply_id INTEGER,

  FOREIGN KEY (subject_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
  FOREIGN KEY (reply_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  liker_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (liker_id) REFERENCES user(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ("Howard", "Feger"),
  ("Ali", "Haq"),
  ("Tycho", "Price");

INSERT INTO
  questions (title, body, author_id)
VALUES
  ("Life", "what is the meaning of life?", (SELECT id FROM users WHERE fname = "Ali" AND lname = "Haq")),
  ("Not Life", "what is not the meaning of life?", (SELECT id FROM users WHERE fname = "Howard" AND lname = "Feger")),
  ("IERBfibeibn", "What is the meaning of OIREFOBEROJB?", (SELECT id FROM users WHERE fname = "Howard" AND lname = "Feger"));

INSERT INTO
  questions_follows (follower_id, question_id)
VALUES
  (2, 1);

INSERT INTO
  replies (subject_id, user_id, body)
VALUES
  (2, 2, "Nothing.");

INSERT INTO
  replies (subject_id, user_id, body, reply_id)
VALUES
  (2, 1, "Wow.", 1);

INSERT INTO
  replies (subject_id, user_id, body, reply_id)
VALUES
  (2, 3, "Profound answer.", 1);

INSERT INTO
  replies (subject_id, user_id, body, reply_id)
VALUES
  (2, 1, "Incredible.", 2);

INSERT INTO
  question_likes (question_id, liker_id)
VALUES
  (1, 3);

-- SELECT *
-- FROM users
-- JOIN questions_follows on users.id = questions_follows.follower_id
-- JOIN questions on questions.id = questions_follows.question_id ;
