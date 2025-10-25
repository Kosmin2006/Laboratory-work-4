CREATE TABLE user_account (
    login VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE profile (
    login VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL
);
CREATE TABLE email_confirmation (
    confirmation_code VARCHAR(50) PRIMARY KEY,
    status VARCHAR(20) NOT NULL,
    login VARCHAR(50) NOT NULL
);
CREATE TABLE system (
    name VARCHAR(100) PRIMARY KEY
);
CREATE TABLE content (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    system_name VARCHAR(100)
);
CREATE TABLE material (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    format VARCHAR(20),
    content_id INTEGER NOT NULL
);
ALTER TABLE profile
ADD CONSTRAINT profile_login_fk
FOREIGN KEY (login)
REFERENCES user_account (login)
ON DELETE CASCADE;
ALTER TABLE email_confirmation
ADD CONSTRAINT email_confirm_login_fk
FOREIGN KEY (login)
REFERENCES profile (login)
ON DELETE CASCADE;
ALTER TABLE content
ADD CONSTRAINT content_system_fk
FOREIGN KEY (system_name)
REFERENCES system (name)
ON DELETE SET NULL;
ALTER TABLE material
ADD CONSTRAINT material_content_fk
FOREIGN KEY (content_id)
REFERENCES content (id)
ON DELETE CASCADE;
ALTER TABLE user_account
ADD CONSTRAINT user_email_pattern
CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
ALTER TABLE email_confirmation
ADD CONSTRAINT email_status_pattern
CHECK (status IN ('confirmed', 'pending'));
ALTER TABLE content
ADD CONSTRAINT content_type_check
CHECK (type IN ('text', 'video', 'image'));
ALTER TABLE material
ADD CONSTRAINT material_format_check
CHECK (format IN ('txt', 'mp4', 'jpg'));
