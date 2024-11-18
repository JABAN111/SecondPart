CREATE TABLE Users (
                       user_id UUID PRIMARY KEY,
                       username VARCHAR(255),
                       email VARCHAR(255),
                       password VARCHAR(255),
                       created_at TIMESTAMP,
                       updated_at TIMESTAMP
);

CREATE TABLE Money_Type (
                            money_type_id UUID PRIMARY KEY,
                            name VARCHAR(255)
);

CREATE TABLE Deposit_Accounts (
                                  account_id UUID PRIMARY KEY,
                                  user_id UUID REFERENCES Users(user_id),
                                  money_type_id UUID REFERENCES Money_Type(money_type_id),
                                  balance DECIMAL,
                                  created_at TIMESTAMP,
                                  updated_at TIMESTAMP
);

CREATE TABLE Transaction_Status (
                                    transaction_status_id UUID PRIMARY KEY,
                                    status_name VARCHAR(255)
);

CREATE TABLE Transaction_Type (
                                  transaction_type_id UUID PRIMARY KEY,
                                  name VARCHAR(255)
);

CREATE TABLE Transactions (
                              transaction_id UUID PRIMARY KEY,
                              account_id UUID REFERENCES Deposit_Accounts(account_id),
                              amount DECIMAL,
                              transaction_type_id UUID REFERENCES Transaction_Type(transaction_type_id),
                              transaction_status_id UUID REFERENCES Transaction_Status(transaction_status_id),
                              transaction_date TIMESTAMP
);

CREATE TABLE Magical_Properties (
                                    magical_properties_id UUID PRIMARY KEY,
                                    description TEXT,
                                    danger_level VARCHAR(255)
);

CREATE TABLE Artifact_History (
                                  artifact_history_id UUID PRIMARY KEY,
                                  change_description TEXT,
                                  last_user UUID REFERENCES Users(user_id),
                                  change_date TIMESTAMP
);



CREATE TABLE Artifacts (
                           artifact_id UUID PRIMARY KEY,
                           name VARCHAR(255),
                           magical_properties UUID REFERENCES Magical_Properties(magical_properties_id),
                           current_user_id UUID REFERENCES Users(user_id),
                           history_id UUID REFERENCES Artifact_History(artifact_history_id),
                           created_at TIMESTAMP
);

CREATE TABLE Artifact_Storage (
                                  artifact_storage_id UUID PRIMARY KEY,
                                  vault_id UUID,
                                  artifact_id UUID REFERENCES Artifacts(artifact_id),
                                  storage_date TIMESTAMP,
                                  location VARCHAR(255),
                                  created_at TIMESTAMP
);

CREATE TABLE Keys (
                      key_id UUID PRIMARY KEY,
                      artifact_storage_id UUID REFERENCES Artifact_Storage(artifact_storage_id),
                      user_id UUID REFERENCES Users(user_id),
                      key_token VARCHAR(255),
                      issued_at TIMESTAMP,
                      expires_at TIMESTAMP
);

CREATE TABLE Roles (
                       role_id UUID PRIMARY KEY,
                       role_name VARCHAR(255),
                       description TEXT
);

CREATE TABLE Permissions (
                             permission_id UUID PRIMARY KEY,
                             permission_name VARCHAR(255),
                             description TEXT
);

CREATE TABLE User_Roles (
                            user_role_id UUID PRIMARY KEY,
                            user_id UUID REFERENCES Users(user_id),
                            role_id UUID REFERENCES Roles(role_id)
);

CREATE TABLE Role_Permissions (
                                  role_permission_id UUID PRIMARY KEY,
                                  role_id UUID REFERENCES Roles(role_id),
                                  permission_id UUID REFERENCES Permissions(permission_id)
);


INSERT INTO Users (user_id, username, email, password, created_at, updated_at)
VALUES
    (gen_random_uuid(), 'user1', 'user1@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user2', 'user2@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user3', 'user3@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user4', 'user4@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user5', 'user5@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user6', 'user6@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user7', 'user7@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user8', 'user8@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user9', 'user9@example.com', 'password123', NOW(), NOW()),
    (gen_random_uuid(), 'user10', 'user10@example.com', 'password123', NOW(), NOW());

INSERT INTO Money_Type (money_type_id, name)
VALUES
    (gen_random_uuid(), 'GAL'),
    (gen_random_uuid(), 'EUL'),
    (gen_random_uuid(), 'RUL');

INSERT INTO Deposit_Accounts (account_id, user_id, money_type_id, balance, created_at, updated_at)
VALUES
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1), (SELECT money_type_id FROM Money_Type LIMIT 1), 1000.00, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 1), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 1), 1500.50, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 2), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 2), 2000.00, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 3), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 3), 2500.75, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 4), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 4), 500.00, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 5), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 5), 3000.00, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 6), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 6), 3500.25, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 7), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 7), 4000.00, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 8), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 8), 4500.50, NOW(), NOW()),
    (gen_random_uuid(), (SELECT user_id FROM Users LIMIT 1 OFFSET 9), (SELECT money_type_id FROM Money_Type LIMIT 1 OFFSET 9), 5000.00, NOW(), NOW());

INSERT INTO Transaction_Status (transaction_status_id, status_name)
VALUES
    (gen_random_uuid(), 'Pending'),
    (gen_random_uuid(), 'Completed'),
    (gen_random_uuid(), 'Failed'),
    (gen_random_uuid(), 'Cancelled');

INSERT INTO Transaction_Type (transaction_type_id, name)
VALUES
    (gen_random_uuid(), 'Transfer'),
    (gen_random_uuid(), 'Adding');

INSERT INTO Artifact_History (artifact_history_id, change_description, last_user, change_date)
VALUES
    (gen_random_uuid(), 'Artifact created', (SELECT user_id FROM Users LIMIT 1), NOW()),
    (gen_random_uuid(), 'Artifact moved to vault', (SELECT user_id FROM Users LIMIT 1 OFFSET 1), NOW()),
    (gen_random_uuid(), 'Artifact damaged', (SELECT user_id FROM Users LIMIT 1 OFFSET 2), NOW()),
    (gen_random_uuid(), 'Artifact repaired', (SELECT user_id FROM Users LIMIT 1 OFFSET 3), NOW()),
    (gen_random_uuid(), 'Artifact returned to user', (SELECT user_id FROM Users LIMIT 1 OFFSET 4), NOW()),
    (gen_random_uuid(), 'Artifact lost', (SELECT user_id FROM Users LIMIT 1 OFFSET 5), NOW()),
    (gen_random_uuid(), 'Artifact recovered', (SELECT user_id FROM Users LIMIT 1 OFFSET 6), NOW()),
    (gen_random_uuid(), 'Artifact upgraded', (SELECT user_id FROM Users LIMIT 1 OFFSET 7), NOW()),
    (gen_random_uuid(), 'Artifact analyzed', (SELECT user_id FROM Users LIMIT 1 OFFSET 8), NOW()),
    (gen_random_uuid(), 'Artifact destroyed', (SELECT user_id FROM Users LIMIT 1 OFFSET 9), NOW());

INSERT INTO Magical_Properties (magical_properties_id, description, danger_level)
VALUES
    (gen_random_uuid(), 'Allows time travel', 'High'),
    (gen_random_uuid(), 'Grants invisibility', 'Medium'),
    (gen_random_uuid(), 'Controls fire', 'High'),
    (gen_random_uuid(), 'Summons lightning', 'High'),
    (gen_random_uuid(), 'Increases strength', 'Low'),
    (gen_random_uuid(), 'Healing powers', 'Low'),
    (gen_random_uuid(), 'Telepathy', 'Medium'),
    (gen_random_uuid(), 'Cloaks the user', 'Low'),
    (gen_random_uuid(), 'Transforms objects', 'High'),
    (gen_random_uuid(), 'Grants immortality', 'Very High');

INSERT INTO Artifact_Storage (artifact_storage_id, vault_id, artifact_id, storage_date, location, created_at)
VALUES
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1), NOW(), 'Vault A', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 1), NOW(), 'Vault B', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 2), NOW(), 'Vault C', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 3), NOW(), 'Vault D', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 4), NOW(), 'Vault E', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 5), NOW(), 'Vault F', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 6), NOW(), 'Vault G', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 7), NOW(), 'Vault H', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 8), NOW(), 'Vault I', NOW()),
    (gen_random_uuid(), gen_random_uuid(), (SELECT artifact_id FROM Artifacts LIMIT 1 OFFSET 9), NOW(), 'Vault J', NOW());


-- 1. Поиск артефактов в хранилище:
CREATE INDEX idx_artifact_in_storage ON Artifact_Storage (artifact_id, vault_id, storage_date);
-- Преимущества: Ускоряет выборку артефактов по ID, местоположению и дате хранения.

--  2. Проверка артефакта на валидность магических свойств:
CREATE INDEX idx_magical_properties ON Magical_Properties (danger_level);
-- Преимущества: Оптимизирует поиск артефактов с определёнными уровнями опасности.

-- 3. Работа с отчетами
CREATE INDEX idx_accounts_user ON Deposit_Accounts (user_id, money_type_id, balance DESC);
-- Преимущества: Ускоряет генерацию отчётов о счетах клиентов с сортировкой по балансу и валюте.

-- Предлагаемые функции
-- 1) Генерация отчета по счетам
-- 2) Операция средств между счетами
-- 3) Функция для проверки валидности ключа пользователя к артефакту в хранилище.