-- База данных туристического агентства (SQLite)
-- Структура соответствует физической ER-диаграмме из 6 таблиц.
PRAGMA foreign_keys = ON;

CREATE TABLE Client (
    client_id INTEGER PRIMARY KEY AUTOINCREMENT,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    phone TEXT,
    email TEXT
);

CREATE TABLE TourOperator (
    operator_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_name TEXT NOT NULL,
    phone TEXT,
    email TEXT
);

CREATE TABLE Tour (
    tour_id INTEGER PRIMARY KEY AUTOINCREMENT,
    operator_id INTEGER NOT NULL,
    tour_name TEXT NOT NULL,
    country TEXT NOT NULL,
    city TEXT NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    price NUMERIC NOT NULL CHECK (price >= 0),
    FOREIGN KEY (operator_id) REFERENCES TourOperator(operator_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CHECK (date(end_date) >= date(start_date))
);

CREATE TABLE Employee (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    position TEXT,
    phone TEXT
);

CREATE TABLE Booking (
    booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    tour_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    order_date TEXT NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tour_id) REFERENCES Tour(tour_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Payment (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER NOT NULL,
    payment_date TEXT NOT NULL,
    amount NUMERIC NOT NULL CHECK (amount >= 0),
    payment_method TEXT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Примеры данных для проверки работы БД.
INSERT INTO Client (last_name, first_name, phone, email) VALUES
('Иванов', 'Иван', '+7-900-111-22-33', 'ivanov@example.com'),
('Петрова', 'Анна', '+7-900-222-33-44', 'petrova@example.com'),
('Сидоров', 'Максим', '+7-900-333-44-55', 'sidorov@example.com');

INSERT INTO TourOperator (company_name, phone, email) VALUES
('Мир путешествий', '+7-495-111-11-11', 'info@mirtravel.example'),
('Глобус-Тур', '+7-495-222-22-22', 'sales@globus.example');

INSERT INTO Tour (operator_id, tour_name, country, city, start_date, end_date, price) VALUES
(1, 'Отдых на море', 'Турция', 'Анталья', '2027-06-10', '2027-06-20', 125000.00),
(1, 'Экскурсионная поездка', 'Италия', 'Рим', '2027-05-05', '2027-05-12', 98000.00),
(2, 'Зимние каникулы', 'Россия', 'Сочи', '2027-01-10', '2027-01-17', 65000.00);

INSERT INTO Employee (last_name, first_name, position, phone) VALUES
('Смирнова', 'Елена', 'Менеджер', '+7-900-444-55-66'),
('Кузнецов', 'Дмитрий', 'Менеджер', '+7-900-555-66-77');

INSERT INTO Booking (client_id, tour_id, employee_id, order_date, status) VALUES
(1, 1, 1, '2026-11-01', 'Подтверждён'),
(2, 2, 1, '2026-11-02', 'Ожидает оплаты'),
(3, 3, 2, '2026-11-03', 'Подтверждён');

INSERT INTO Payment (booking_id, payment_date, amount, payment_method) VALUES
(1, '2026-11-01', 125000.00, 'Банковская карта'),
(2, '2026-11-02', 30000.00, 'Банковская карта'),
(3, '2026-11-03', 65000.00, 'Банковский перевод');

-- Контрольные запросы:
-- SELECT * FROM Client;
-- SELECT * FROM TourOperator;
-- SELECT * FROM Tour;
-- SELECT * FROM Employee;
-- SELECT * FROM Booking;
-- SELECT * FROM Payment;
-- PRAGMA foreign_key_check;
