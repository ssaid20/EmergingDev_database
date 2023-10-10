-- Users table storing individual user details
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    clerk_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255),
    bio TEXT,
    picture VARCHAR(255) NOT NULL,
);

-- Table to store which questions a user has saved
CREATE TABLE user_saved_questions (
    user_id INTEGER REFERENCES users(id),
    question_id INTEGER REFERENCES questions(id), 
    PRIMARY KEY (user_id, question_id)
);

-- Table storing individual questions posted by users
CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    views INTEGER DEFAULT 0,
    author_id INTEGER REFERENCES users(id) NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Junction table to link questions with their associated tags
CREATE TABLE question_tags (
    question_id INTEGER REFERENCES questions(id),
    tag_id INTEGER REFERENCES tags(id), 
    PRIMARY KEY (question_id, tag_id)
);

-- Junction table to track users who upvoted a particular question
CREATE TABLE question_upvotes (
    question_id INTEGER REFERENCES questions(id),
    user_id INTEGER REFERENCES users(id),
    PRIMARY KEY (question_id, user_id)
);

-- Junction table to track users who downvoted a particular question
CREATE TABLE question_downvotes (
    question_id INTEGER REFERENCES questions(id),
    user_id INTEGER REFERENCES users(id),
    PRIMARY KEY (question_id, user_id)
);

-- Junction table to link questions with their associated answers
CREATE TABLE question_answers (
    question_id INTEGER REFERENCES questions(id),
    answer_id INTEGER REFERENCES answers(id), 
    PRIMARY KEY (question_id, answer_id)
);

-- Table storing interactions made by users (like asking a question, answering, etc.)
CREATE TABLE interactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) NOT NULL, 
    action VARCHAR(255) NOT NULL,
    question_id INTEGER REFERENCES questions(id), 
    answer_id INTEGER REFERENCES answers(id), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Junction table to link interactions with their associated tags
CREATE TABLE interaction_tags (
    interaction_id INTEGER REFERENCES interactions(id),
    tag_id INTEGER REFERENCES tags(id), 
    PRIMARY KEY (interaction_id, tag_id)
);

-- Table storing answers given by users to particular questions
CREATE TABLE answers (
    id SERIAL PRIMARY KEY,
    author_id INTEGER REFERENCES users(id) NOT NULL, 
    question_id INTEGER REFERENCES questions(id) NOT NULL, 
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Junction table to track users who upvoted a particular answer
CREATE TABLE answer_upvotes (
    answer_id INTEGER REFERENCES answers(id),
    user_id INTEGER REFERENCES users(id),
    PRIMARY KEY (answer_id, user_id)
);

-- Junction table to track users who downvoted a particular answer
CREATE TABLE answer_downvotes (
    answer_id INTEGER REFERENCES answers(id),
    user_id INTEGER REFERENCES users(id),
    PRIMARY KEY (answer_id, user_id)
);

//
-- The 'tags' table stores information about various tags that can be associated with questions.
-- Each tag has a unique name and a description.
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,                        
    name VARCHAR(255) UNIQUE NOT NULL,            
    description TEXT NOT NULL,                    
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- The 'tag_questions' table is a junction table that establishes a many-to-many relationship between tags and questions.
-- It indicates which questions are associated with which tags.
CREATE TABLE tag_questions (
    tag_id INTEGER REFERENCES tags(id),           
    question_id INTEGER REFERENCES questions(id), 
    PRIMARY KEY (tag_id, question_id)             
);

-- The 'tag_followers' table is a junction table that establishes a many-to-many relationship between tags and users.
-- It indicates which users are following which tags.
CREATE TABLE tag_followers (
    tag_id INTEGER REFERENCES tags(id),           
    user_id INTEGER REFERENCES users(id),        
    PRIMARY KEY (tag_id, user_id)                 
);


