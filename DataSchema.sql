CREATE TABLE user_accounts (
    user_login VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE user_profiles (
    profile_login VARCHAR(50) PRIMARY KEY,
    profile_password VARCHAR(255) NOT NULL,
    profile_email VARCHAR(100) NOT NULL
);

CREATE TABLE email_confirmations (
    confirmation_code VARCHAR(50) PRIMARY KEY,
    confirmation_status VARCHAR(20) NOT NULL,
    profile_login VARCHAR(50) NOT NULL
);

CREATE TABLE systems (
    system_name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE contents (
    content_id SERIAL PRIMARY KEY,
    content_title VARCHAR(100) NOT NULL,
    content_type VARCHAR(50),
    system_name VARCHAR(100)
);

CREATE TABLE materials (
    material_id SERIAL PRIMARY KEY,
    material_title VARCHAR(100) NOT NULL,
    material_description VARCHAR(500),
    material_format VARCHAR(20),
    content_id INTEGER NOT NULL
);

ALTER TABLE user_profiles
ADD CONSTRAINT fk_profile_user
FOREIGN KEY (profile_login)
REFERENCES user_accounts (user_login)
ON DELETE CASCADE;

ALTER TABLE email_confirmations
ADD CONSTRAINT fk_emailconfirm_profile
FOREIGN KEY (profile_login)
REFERENCES user_profiles (profile_login)
ON DELETE CASCADE;

ALTER TABLE contents
ADD CONSTRAINT fk_content_system
FOREIGN KEY (system_name)
REFERENCES systems (system_name)
ON DELETE SET NULL;

ALTER TABLE materials
ADD CONSTRAINT fk_material_content
FOREIGN KEY (content_id)
REFERENCES contents (content_id)
ON DELETE CASCADE;

ALTER TABLE user_accounts
ADD CONSTRAINT chk_user_email_pattern
CHECK (user_email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

ALTER TABLE email_confirmations
ADD CONSTRAINT chk_email_status
CHECK (confirmation_status IN ('confirmed', 'pending'));

ALTER TABLE contents
ADD CONSTRAINT chk_content_type
CHECK (content_type IN ('text', 'video', 'image'));

ALTER TABLE materials
ADD CONSTRAINT chk_material_format
CHECK (material_format IN ('txt', 'mp4', 'jpg'));
