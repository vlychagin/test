create database WheatherReportLV;
go
use WheatherReportLV
go

BEGIN TRANSACTION;

-- Таблица: inhabitatnts
CREATE TABLE Inhabitatnts (
    Id      INT PRIMARY KEY identity(1, 1),
    Name     nvarchar(50)    NOT NULL,
    Language nvarchar(30)    NOT NULL
);

set identity_insert Inhabitatnts on;
INSERT INTO Inhabitatnts (Id, name, language) 
	VALUES 
	(1, 'новосветовцы', 'русский'),
	(2, 'старобешевцы', 'греческий'),
	(3, 'седовцы', 'русский'),
	(4, 'горловчане', 'русский'),
	(5, 'берлинцы', 'немецкий'),
	(6, 'астанчане', 'казахский'),
	(7, 'римляне', 'итальянский'),
	(8, 'веронцы', 'итальянский'),
	(9, 'мюнхенцы', 'немецкий');
set identity_insert Inhabitatnts off;

-- Таблица: precipitations
CREATE TABLE Precipitations (
    Id  INT PRIMARY KEY identity,
    Name nvarchar(30)    NOT NULL
);

set identity_insert Precipitations on;
INSERT INTO Precipitations (Id, Name) 
	VALUES 
	(1, 'сухо'),
	(2, 'дождь'),
	(3, 'снег'),
	(4, 'град');
set identity_insert Precipitations off;

-- Таблица: Regions
CREATE TABLE Regions (
    Id           INT PRIMARY KEY identity,
    Title        nvarchar(50)    NOT NULL,
    Area         INT CHECK (Area > 0) NOT NULL,
    IdInhabitant INT REFERENCES Inhabitatnts (Id) NOT NULL
);

set identity_insert Regions on;
INSERT INTO Regions (Id, Title, Area, IdInhabitant) VALUES 
	(1, 'Новый Свет', 12, 1),
	(2, 'Старобешево', 26, 2),
	(3, 'Седово', 18, 3),
	(4, 'Горловка', 422, 4),
	(5, 'Берлин', 892, 5),
	(6, 'Астана', 802, 6),
	(7, 'Рим', 1287, 7),
	(8, 'Верона', 199, 8),
	(9, 'Мюнхен', 310, 9);
set identity_insert Regions off;

-- Таблица: wheathers
CREATE TABLE Wheathers (
    Id              INT PRIMARY KEY identity,
    IdRegion        INTEGER REFERENCES Regions (Id),
    Date            DATE    NOT NULL,
    Temperature     INTEGER NOT NULL,
    IdPrecipitation INTEGER REFERENCES Precipitations (Id) 
);

set identity_insert Wheathers on;
INSERT INTO wheathers (Id, IdRegion, Date, Temperature, IdPrecipitation) 
VALUES 
	(1, 1, '2017-05-20', 25, 1),
	(2, 1, '2017-05-21', 24, 2),
	(3, 1, '2017-05-22', 29, 2),
	(4, 1, '2017-05-23', 25, 1),
	(5, 1, '2017-05-24', 23, 1),
	(6, 1, '2017-05-28', 23, 1),
	(7, 1, '2017-05-30', 25, 2),
	(8, 2, '2017-02-22', 26, 1),
	(9, 2, '2017-05-25', 25, 2),
	(10, 9, '2017-05-20', 18, 1),
	(11, 9, '2017-05-29', 22, 2),
	(12, 3, '2017-02-15', -2, 1),
	(13, 3, '2017-02-16', -3, 1),
	(14, 3, '2017-02-17', -6, 3),
	(15, 3, '2017-02-18', -6, 3),
	(16, 3, '2017-02-19', -3, 3),
	(17, 3, '2017-02-20', -12, 3),
	(18, 4, '2017-02-15', -3, 3),
	(19, 4, '2017-02-26', 0, 2),
	(20, 5, '2017-02-15', 12, 2),
	(21, 5, '2017-02-16', 11, 2),
	(22, 6, '2017-02-15', -25, 1),
	(23, 6, '2017-02-16', -23, 2),
	(24, 7, '2017-02-15', 15, 1),
	(25, 7, '2017-02-16', 13, 2),
	(26, 8, '2017-02-15', 16, 2),
	(27, 8, '2017-02-16', 15, 1),
	(28, 5, '2017-06-10', 26, 1),
	(29, 5, '2017-06-11', 22, 2),
	(30, 3, '2017-06-10', 27, 1),
	(31, 3, '2017-06-11', 27, 1),
	(32, 4, '2017-06-10', 22, 1),
	(33, 4, '2017-06-11', 23, 1),
	(34, 2, '2017-06-10', 24, 1),
	(35, 2, '2017-06-11', 11, 2);
set identity_insert Wheathers off;

COMMIT TRANSACTION;
