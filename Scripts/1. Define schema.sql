CREATE TABLE Errors
(
    ErrorId INT
    , ErrorName NVARCHAR(50)
    , ErrorDescription NVARCHAR(150)
)
GO

CREATE TABLE Plants
(
    PlantId TINYINT PRIMARY KEY CLUSTERED
    , Name NVARCHAR(25)
    , Description NVARCHAR(150)
)
GO
  
CREATE TABLE Machineries
(
    PlantId TINYINT,
    MachineryId INT,
    Name NVARCHAR(25),
    Description NVARCHAR(150),
    CONSTRAINT PkCL PRIMARY KEY CLUSTERED (PlantId, MachineryId)
);
GO

CREATE TABLE ErrorHistory
(
    EventId UNIQUEIDENTIFIER
    , ErrorStart DATETIME2(6)
    , ErrorEnd DATETIME2(6)
    , PlantId TINYINT
    , MachineryId INT
    , ErrorNumber INT
    , Notes NVARCHAR(MAX)
    , Description NVARCHAR(MAX)
    , Solution NVARCHAR(MAX)
);
GO

CREATE TABLE LogPowerConsumption
(
    EventDate DATETIME2(6)
    , PlantId INT
    , MachineryId INT
    , PowerConsumption INT
    , PowerConsumptionAvg INT
);
GO


/*******************************************************************************************
Populating
*******************************************************************************************/

--Creates 10 types of errors
INSERT INTO Errors VALUES (1,'Low Power','The Power Supplier is not working')
INSERT INTO Errors VALUES (2,'Low Pressure','Hydraulic failure')
INSERT INTO Errors VALUES (3,'Low Temperature','Temperature Failure')
INSERT INTO Errors VALUES (4,'Low Torque','Torque is too low, set it properly')
INSERT INTO Errors VALUES (5,'Low Speed','Speed is too low.')
INSERT INTO Errors VALUES (6,'High Power','The Power Supplier is in danger')
INSERT INTO Errors VALUES (7,'High Pressure','Safety is at risk')
INSERT INTO Errors VALUES (8,'High Temperature','Temperature Failure, check it and seti it properly')
INSERT INTO Errors VALUES (9,'High Torque','Torque is too high, set it properly')
INSERT INTO Errors VALUES (10,'High Speed','Safety is at risk')
GO

--Creates 10 plants
INSERT INTO Plants VALUES (1,'Plant 1 Cx 1', 'Description for plant 1')
INSERT INTO Plants VALUES (2,'Plant 2 Cx 2', 'Description for plant 2')
INSERT INTO Plants VALUES (3,'Plant 3 Cx 3', 'Description for plant 3')
INSERT INTO Plants VALUES (4,'Plant 4 Cx 4', 'Description for plant 4')
INSERT INTO Plants VALUES (5,'Plant 5 Cx 5', 'Description for plant 5')
INSERT INTO Plants VALUES (6,'Plant 6 Cx 6', 'Description for plant 6')
INSERT INTO Plants VALUES (7,'Plant 7 Cx 7', 'Description for plant 7')
INSERT INTO Plants VALUES (8,'Plant 8 Cx 8', 'Description for plant 8')
INSERT INTO Plants VALUES (9,'Plant 9 Cx 9', 'Description for plant 9')
INSERT INTO Plants VALUES (10,'Plant 10 Cx 10', 'Description for plant 10')
GO

--Create 100 Machineries for each plant
DECLARE @PlantId TINYINT;
DECLARE @MachineryId INT;
DECLARE @SQL NVARCHAR(MAX);

-- Loop through each PlantId
SET @PlantId = 1;
WHILE @PlantId <= 10
BEGIN
	SET @MachineryId = 1;
	WHILE @MachineryId <= 100
    BEGIN
        -- Construct the dynamic SQL statement
        SET @SQL = 'INSERT INTO Machineries (PlantId, MachineryId, Name, Description) ' +
                   'VALUES (' + CAST(@PlantId AS NVARCHAR(3)) + ', ' + 
                   CAST(@MachineryId AS NVARCHAR(3)) + ', ' +
                   '''Machinery ' + CAST(@PlantId AS NVARCHAR(3)) + '-' + CAST(@MachineryId AS NVARCHAR(3)) + ''', ' +
                   '''Description for Machinery ' + CAST(@PlantId AS NVARCHAR(3)) + '-' + CAST(@MachineryId AS NVARCHAR(3)) + ''')';

        -- Execute the dynamic SQL statement
        EXEC sp_executesql @SQL;

        SET @MachineryId = @MachineryId + 1;
    END
    SET @PlantId = @PlantId + 1;
END
GO


--Adding the history of the errors
DECLARE @ErrorStart DATETIME2(6) = '2025-01-01'
DECLARE @ErrorEnd DATETIME2(6) = '2025-01-01'

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 90, 2, 'Pressure KPI was below the expected value (4) and Temperature KPI was >= 9 for more than 1 minute. sensor_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 77, 2, 'Temperature KPI was below the expected value (6) and Torque KPI was >= 10 for more than 1 minute. pump_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 35, 3, 'Pressure KPI was below the expected value (1) and Torque KPI was >= 4 for more than 1 minute. gear_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 9, 6, 'Speed KPI was below the expected value (7) and Pressure KPI was >= 5 for more than 1 minute. sensor_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 87, 5, 'Pressure KPI was below the expected value (7) and Torque KPI was >= 8 for more than 1 minute. gear_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 91, 2, 'Pressure KPI was below the expected value (10) and Speed KPI was >= 2 for more than 1 minute. gear_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 57, 6, 'Speed KPI was below the expected value (10) and Pressure KPI was >= 3 for more than 1 minute. valve_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 10, 7, 'Speed KPI was below the expected value (6) and Temperature KPI was >= 3 for more than 1 minute. sensor_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 5, 6, 'Torque KPI was below the expected value (10) and Speed KPI was >= 1 for more than 1 minute. sensor_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 53, 1, 'Torque KPI was below the expected value (9) and Pressure KPI was >= 7 for more than 1 minute. valve_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 54, 4, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 4 for more than 1 minute. motor_16 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 8, 10, 'Temperature KPI was below the expected value (2) and PowerConsumption KPI was >= 2 for more than 1 minute. gear_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 92, 5, 'Pressure KPI was below the expected value (4) and Torque KPI was >= 2 for more than 1 minute. gear_75 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 52, 4, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 4 for more than 1 minute. gear_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 65, 1, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 8 for more than 1 minute. gear_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 5, 7, 'Speed KPI was below the expected value (1) and Pressure KPI was >= 2 for more than 1 minute. valve_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 13, 8, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 6 for more than 1 minute. pump_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 44, 6, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 9 for more than 1 minute. pump_16 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 77, 10, 'Torque KPI was below the expected value (5) and PowerConsumption KPI was >= 3 for more than 1 minute. valve_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 71, 8, 'PowerConsumption KPI was below the expected value (1) and Speed KPI was >= 10 for more than 1 minute. pump_62 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 19, 9, 'Speed KPI was below the expected value (4) and Pressure KPI was >= 8 for more than 1 minute. gear_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 43, 1, 'PowerConsumption KPI was below the expected value (10) and Speed KPI was >= 5 for more than 1 minute. valve_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 96, 9, 'Speed KPI was below the expected value (5) and PowerConsumption KPI was >= 6 for more than 1 minute. gear_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 68, 6, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 7 for more than 1 minute. pump_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 47, 7, 'Pressure KPI was below the expected value (8) and Torque KPI was >= 10 for more than 1 minute. valve_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 2, 7, 'Torque KPI was below the expected value (1) and Pressure KPI was >= 6 for more than 1 minute. valve_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 69, 4, 'PowerConsumption KPI was below the expected value (8) and Temperature KPI was >= 10 for more than 1 minute. motor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 98, 9, 'Torque KPI was below the expected value (4) and Speed KPI was >= 1 for more than 1 minute. pump_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 8, 1, 'Temperature KPI was below the expected value (8) and Pressure KPI was >= 5 for more than 1 minute. sensor_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 76, 10, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 3 for more than 1 minute. pump_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 27, 10, 'Torque KPI was below the expected value (6) and Pressure KPI was >= 5 for more than 1 minute. gear_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 74, 5, 'Temperature KPI was below the expected value (9) and Torque KPI was >= 9 for more than 1 minute. sensor_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 10, 1, 'Torque KPI was below the expected value (5) and Speed KPI was >= 6 for more than 1 minute. gear_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 57, 5, 'Speed KPI was below the expected value (1) and Pressure KPI was >= 7 for more than 1 minute. motor_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 8, 3, 'Temperature KPI was below the expected value (4) and Torque KPI was >= 7 for more than 1 minute. sensor_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 18, 5, 'Speed KPI was below the expected value (7) and Torque KPI was >= 6 for more than 1 minute. sensor_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 76, 10, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 8 for more than 1 minute. gear_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 15, 8, 'Temperature KPI was below the expected value (2) and Speed KPI was >= 1 for more than 1 minute. motor_89 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 26, 2, 'Pressure KPI was below the expected value (6) and PowerConsumption KPI was >= 1 for more than 1 minute. sensor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 12, 10, 'PowerConsumption KPI was below the expected value (7) and Speed KPI was >= 4 for more than 1 minute. gear_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 96, 10, 'Speed KPI was below the expected value (3) and Pressure KPI was >= 1 for more than 1 minute. pump_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 62, 2, 'Torque KPI was below the expected value (10) and Temperature KPI was >= 6 for more than 1 minute. motor_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 62, 10, 'Torque KPI was below the expected value (5) and PowerConsumption KPI was >= 1 for more than 1 minute. motor_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 41, 8, 'Pressure KPI was below the expected value (8) and PowerConsumption KPI was >= 7 for more than 1 minute. motor_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 17, 6, 'Speed KPI was below the expected value (5) and Torque KPI was >= 5 for more than 1 minute. valve_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 77, 3, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 6 for more than 1 minute. motor_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 12, 1, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 4 for more than 1 minute. valve_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 19, 7, 'Pressure KPI was below the expected value (4) and Temperature KPI was >= 2 for more than 1 minute. sensor_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 32, 2, 'Pressure KPI was below the expected value (1) and Torque KPI was >= 7 for more than 1 minute. gear_83 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 5, 2, 'Torque KPI was below the expected value (9) and Speed KPI was >= 7 for more than 1 minute. motor_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 80, 9, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 3 for more than 1 minute. motor_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 64, 10, 'Temperature KPI was below the expected value (5) and Speed KPI was >= 4 for more than 1 minute. gear_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 81, 10, 'Speed KPI was below the expected value (6) and Torque KPI was >= 3 for more than 1 minute. sensor_26 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 26, 1, 'Torque KPI was below the expected value (9) and Pressure KPI was >= 7 for more than 1 minute. gear_6 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 84, 3, 'PowerConsumption KPI was below the expected value (2) and Speed KPI was >= 10 for more than 1 minute. sensor_62 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 43, 3, 'PowerConsumption KPI was below the expected value (8) and Torque KPI was >= 7 for more than 1 minute. sensor_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 77, 2, 'Speed KPI was below the expected value (4) and Pressure KPI was >= 7 for more than 1 minute. valve_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 81, 2, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 3 for more than 1 minute. pump_11 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 14, 1, 'Speed KPI was below the expected value (7) and PowerConsumption KPI was >= 8 for more than 1 minute. motor_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 55, 2, 'Temperature KPI was below the expected value (5) and Torque KPI was >= 10 for more than 1 minute. pump_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 52, 6, 'Pressure KPI was below the expected value (9) and Speed KPI was >= 9 for more than 1 minute. sensor_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 38, 1, 'Speed KPI was below the expected value (4) and Torque KPI was >= 8 for more than 1 minute. sensor_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 48, 5, 'Temperature KPI was below the expected value (3) and Torque KPI was >= 5 for more than 1 minute. valve_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 70, 1, 'Temperature KPI was below the expected value (9) and PowerConsumption KPI was >= 8 for more than 1 minute. gear_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 69, 10, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 3 for more than 1 minute. valve_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 57, 9, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 4 for more than 1 minute. gear_77 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 15, 6, 'Temperature KPI was below the expected value (5) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_92 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 91, 6, 'Temperature KPI was below the expected value (3) and Torque KPI was >= 7 for more than 1 minute. sensor_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 1, 8, 'Torque KPI was below the expected value (10) and Speed KPI was >= 7 for more than 1 minute. gear_26 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 84, 1, 'Pressure KPI was below the expected value (5) and Torque KPI was >= 7 for more than 1 minute. sensor_82 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 1, 8, 'Pressure KPI was below the expected value (3) and Temperature KPI was >= 10 for more than 1 minute. valve_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 98, 6, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 5 for more than 1 minute. motor_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 16, 3, 'Torque KPI was below the expected value (3) and Temperature KPI was >= 8 for more than 1 minute. valve_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 38, 8, 'Pressure KPI was below the expected value (8) and Speed KPI was >= 3 for more than 1 minute. pump_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 26, 3, 'Temperature KPI was below the expected value (5) and Speed KPI was >= 10 for more than 1 minute. gear_95 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 91, 9, 'Temperature KPI was below the expected value (6) and PowerConsumption KPI was >= 9 for more than 1 minute. motor_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 2, 5, 'Torque KPI was below the expected value (4) and Temperature KPI was >= 8 for more than 1 minute. motor_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 54, 5, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 7 for more than 1 minute. pump_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 21, 3, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 10 for more than 1 minute. sensor_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 51, 4, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 10 for more than 1 minute. sensor_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 38, 6, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 10 for more than 1 minute. pump_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 21, 8, 'PowerConsumption KPI was below the expected value (10) and Torque KPI was >= 5 for more than 1 minute. motor_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 10, 3, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 2 for more than 1 minute. motor_34 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 33, 4, 'PowerConsumption KPI was below the expected value (4) and Temperature KPI was >= 10 for more than 1 minute. pump_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 72, 6, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 6 for more than 1 minute. sensor_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 82, 1, 'Pressure KPI was below the expected value (4) and Temperature KPI was >= 5 for more than 1 minute. motor_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 57, 8, 'Speed KPI was below the expected value (1) and PowerConsumption KPI was >= 6 for more than 1 minute. valve_36 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 52, 2, 'Temperature KPI was below the expected value (2) and Torque KPI was >= 9 for more than 1 minute. sensor_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 90, 2, 'Temperature KPI was below the expected value (2) and Torque KPI was >= 2 for more than 1 minute. motor_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 95, 10, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 8 for more than 1 minute. gear_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 92, 7, 'Speed KPI was below the expected value (7) and Pressure KPI was >= 4 for more than 1 minute. sensor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 23, 9, 'Torque KPI was below the expected value (8) and Temperature KPI was >= 10 for more than 1 minute. valve_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 12, 8, 'Temperature KPI was below the expected value (1) and Pressure KPI was >= 9 for more than 1 minute. motor_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 39, 1, 'Temperature KPI was below the expected value (2) and PowerConsumption KPI was >= 1 for more than 1 minute. pump_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 32, 10, 'Torque KPI was below the expected value (9) and Speed KPI was >= 3 for more than 1 minute. gear_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 8, 2, 'PowerConsumption KPI was below the expected value (1) and Torque KPI was >= 8 for more than 1 minute. gear_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 19, 7, 'Torque KPI was below the expected value (7) and Speed KPI was >= 7 for more than 1 minute. motor_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 22, 7, 'Pressure KPI was below the expected value (8) and Torque KPI was >= 3 for more than 1 minute. motor_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 73, 4, 'Speed KPI was below the expected value (1) and Torque KPI was >= 9 for more than 1 minute. gear_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 27, 1, 'Temperature KPI was below the expected value (4) and Pressure KPI was >= 1 for more than 1 minute. motor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 26, 8, 'Torque KPI was below the expected value (7) and Speed KPI was >= 4 for more than 1 minute. valve_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 29, 3, 'Speed KPI was below the expected value (8) and Temperature KPI was >= 4 for more than 1 minute. pump_66 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 21, 4, 'PowerConsumption KPI was below the expected value (6) and Temperature KPI was >= 5 for more than 1 minute. sensor_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 46, 9, 'PowerConsumption KPI was below the expected value (2) and Pressure KPI was >= 1 for more than 1 minute. sensor_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 87, 4, 'PowerConsumption KPI was below the expected value (7) and Temperature KPI was >= 1 for more than 1 minute. valve_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 46, 3, 'Temperature KPI was below the expected value (7) and Torque KPI was >= 4 for more than 1 minute. sensor_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 7, 3, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 3 for more than 1 minute. pump_47 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 63, 2, 'Temperature KPI was below the expected value (10) and Torque KPI was >= 6 for more than 1 minute. gear_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 61, 3, 'Speed KPI was below the expected value (4) and PowerConsumption KPI was >= 2 for more than 1 minute. motor_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 71, 9, 'Pressure KPI was below the expected value (2) and Speed KPI was >= 4 for more than 1 minute. sensor_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 1, 2, 'Torque KPI was below the expected value (6) and PowerConsumption KPI was >= 9 for more than 1 minute. gear_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 43, 10, 'Torque KPI was below the expected value (10) and Temperature KPI was >= 3 for more than 1 minute. sensor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 22, 2, 'Temperature KPI was below the expected value (1) and Speed KPI was >= 6 for more than 1 minute. gear_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 99, 3, 'Temperature KPI was below the expected value (4) and Pressure KPI was >= 7 for more than 1 minute. sensor_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 33, 4, 'Pressure KPI was below the expected value (1) and Torque KPI was >= 7 for more than 1 minute. sensor_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 56, 4, 'Torque KPI was below the expected value (7) and Pressure KPI was >= 2 for more than 1 minute. valve_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 27, 3, 'Temperature KPI was below the expected value (6) and Torque KPI was >= 9 for more than 1 minute. sensor_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 2, 10, 'Temperature KPI was below the expected value (5) and PowerConsumption KPI was >= 8 for more than 1 minute. pump_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 91, 1, 'Temperature KPI was below the expected value (10) and PowerConsumption KPI was >= 3 for more than 1 minute. pump_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 73, 10, 'Speed KPI was below the expected value (3) and Pressure KPI was >= 8 for more than 1 minute. gear_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 67, 9, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 3 for more than 1 minute. sensor_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 19, 8, 'Torque KPI was below the expected value (3) and Pressure KPI was >= 3 for more than 1 minute. motor_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 53, 10, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 10 for more than 1 minute. sensor_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 89, 7, 'Temperature KPI was below the expected value (3) and PowerConsumption KPI was >= 9 for more than 1 minute. valve_86 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 89, 5, 'PowerConsumption KPI was below the expected value (9) and Pressure KPI was >= 1 for more than 1 minute. motor_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 10, 2, 'PowerConsumption KPI was below the expected value (3) and Speed KPI was >= 7 for more than 1 minute. gear_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 70, 7, 'Pressure KPI was below the expected value (4) and Torque KPI was >= 3 for more than 1 minute. pump_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 81, 1, 'Torque KPI was below the expected value (3) and PowerConsumption KPI was >= 3 for more than 1 minute. valve_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 33, 9, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 7 for more than 1 minute. motor_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 26, 1, 'PowerConsumption KPI was below the expected value (6) and Speed KPI was >= 4 for more than 1 minute. gear_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 87, 9, 'Temperature KPI was below the expected value (1) and Speed KPI was >= 2 for more than 1 minute. gear_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 25, 10, 'PowerConsumption KPI was below the expected value (1) and Torque KPI was >= 10 for more than 1 minute. motor_2 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 56, 4, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 3 for more than 1 minute. pump_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 97, 8, 'Temperature KPI was below the expected value (8) and Speed KPI was >= 8 for more than 1 minute. valve_52 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 76, 9, 'Speed KPI was below the expected value (9) and Torque KPI was >= 3 for more than 1 minute. gear_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 63, 9, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 2 for more than 1 minute. valve_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 97, 10, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 8 for more than 1 minute. motor_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 24, 7, 'Temperature KPI was below the expected value (7) and Speed KPI was >= 8 for more than 1 minute. sensor_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 84, 3, 'Temperature KPI was below the expected value (7) and Torque KPI was >= 6 for more than 1 minute. pump_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 99, 9, 'PowerConsumption KPI was below the expected value (3) and Pressure KPI was >= 10 for more than 1 minute. pump_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 6, 1, 'Torque KPI was below the expected value (7) and Temperature KPI was >= 2 for more than 1 minute. pump_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 45, 7, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 2 for more than 1 minute. gear_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 27, 10, 'Torque KPI was below the expected value (1) and Speed KPI was >= 1 for more than 1 minute. pump_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 76, 10, 'Torque KPI was below the expected value (8) and Temperature KPI was >= 3 for more than 1 minute. sensor_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 48, 6, 'Temperature KPI was below the expected value (10) and Pressure KPI was >= 6 for more than 1 minute. valve_86 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 66, 3, 'PowerConsumption KPI was below the expected value (4) and Speed KPI was >= 9 for more than 1 minute. valve_47 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 31, 2, 'Temperature KPI was below the expected value (8) and PowerConsumption KPI was >= 1 for more than 1 minute. gear_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 97, 6, 'Pressure KPI was below the expected value (6) and Torque KPI was >= 6 for more than 1 minute. motor_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 21, 5, 'Temperature KPI was below the expected value (1) and Torque KPI was >= 8 for more than 1 minute. sensor_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 66, 6, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 9 for more than 1 minute. sensor_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 42, 1, 'Torque KPI was below the expected value (9) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 30, 2, 'Speed KPI was below the expected value (4) and Temperature KPI was >= 8 for more than 1 minute. sensor_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 39, 1, 'PowerConsumption KPI was below the expected value (1) and Pressure KPI was >= 4 for more than 1 minute. pump_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 19, 9, 'Temperature KPI was below the expected value (1) and Torque KPI was >= 4 for more than 1 minute. sensor_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 14, 10, 'Speed KPI was below the expected value (6) and Temperature KPI was >= 8 for more than 1 minute. sensor_92 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 10, 3, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 2 for more than 1 minute. motor_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 74, 3, 'Torque KPI was below the expected value (5) and Speed KPI was >= 10 for more than 1 minute. motor_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 9, 5, 'Temperature KPI was below the expected value (5) and Pressure KPI was >= 10 for more than 1 minute. pump_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 10, 10, 'Pressure KPI was below the expected value (10) and PowerConsumption KPI was >= 1 for more than 1 minute. motor_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 63, 7, 'Torque KPI was below the expected value (7) and PowerConsumption KPI was >= 5 for more than 1 minute. valve_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 79, 7, 'Torque KPI was below the expected value (5) and PowerConsumption KPI was >= 9 for more than 1 minute. motor_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 60, 6, 'Speed KPI was below the expected value (5) and PowerConsumption KPI was >= 9 for more than 1 minute. valve_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 50, 9, 'Speed KPI was below the expected value (2) and Pressure KPI was >= 6 for more than 1 minute. sensor_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 95, 2, 'Temperature KPI was below the expected value (3) and Speed KPI was >= 2 for more than 1 minute. sensor_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 47, 10, 'Temperature KPI was below the expected value (10) and Torque KPI was >= 9 for more than 1 minute. pump_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 45, 10, 'Temperature KPI was below the expected value (4) and Torque KPI was >= 7 for more than 1 minute. motor_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 58, 3, 'PowerConsumption KPI was below the expected value (9) and Speed KPI was >= 1 for more than 1 minute. valve_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 42, 1, 'Pressure KPI was below the expected value (6) and Temperature KPI was >= 4 for more than 1 minute. pump_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 14, 2, 'PowerConsumption KPI was below the expected value (7) and Pressure KPI was >= 7 for more than 1 minute. sensor_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 69, 7, 'Speed KPI was below the expected value (8) and Pressure KPI was >= 1 for more than 1 minute. valve_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 83, 3, 'Torque KPI was below the expected value (4) and Pressure KPI was >= 7 for more than 1 minute. pump_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 46, 1, 'Torque KPI was below the expected value (9) and Speed KPI was >= 5 for more than 1 minute. sensor_11 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 94, 8, 'PowerConsumption KPI was below the expected value (5) and Temperature KPI was >= 5 for more than 1 minute. pump_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 52, 7, 'Temperature KPI was below the expected value (10) and Speed KPI was >= 1 for more than 1 minute. motor_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 84, 9, 'Temperature KPI was below the expected value (9) and PowerConsumption KPI was >= 2 for more than 1 minute. sensor_28 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 56, 10, 'Speed KPI was below the expected value (3) and Pressure KPI was >= 2 for more than 1 minute. sensor_77 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 11, 4, 'Temperature KPI was below the expected value (2) and Speed KPI was >= 10 for more than 1 minute. sensor_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 90, 2, 'Pressure KPI was below the expected value (8) and PowerConsumption KPI was >= 8 for more than 1 minute. sensor_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 7, 8, 'Torque KPI was below the expected value (7) and Speed KPI was >= 6 for more than 1 minute. motor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 35, 5, 'Speed KPI was below the expected value (7) and Torque KPI was >= 2 for more than 1 minute. valve_2 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 63, 7, 'Temperature KPI was below the expected value (1) and Speed KPI was >= 5 for more than 1 minute. pump_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 56, 7, 'Speed KPI was below the expected value (1) and PowerConsumption KPI was >= 7 for more than 1 minute. valve_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 81, 2, 'PowerConsumption KPI was below the expected value (6) and Temperature KPI was >= 9 for more than 1 minute. valve_16 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 13, 2, 'Pressure KPI was below the expected value (9) and Speed KPI was >= 5 for more than 1 minute. sensor_26 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 54, 1, 'Speed KPI was below the expected value (7) and PowerConsumption KPI was >= 6 for more than 1 minute. gear_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 73, 2, 'Speed KPI was below the expected value (1) and Pressure KPI was >= 1 for more than 1 minute. gear_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 73, 5, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 2 for more than 1 minute. gear_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 76, 6, 'Pressure KPI was below the expected value (7) and Torque KPI was >= 9 for more than 1 minute. gear_92 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 67, 6, 'PowerConsumption KPI was below the expected value (1) and Pressure KPI was >= 2 for more than 1 minute. pump_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 36, 5, 'Temperature KPI was below the expected value (4) and Speed KPI was >= 9 for more than 1 minute. gear_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 87, 3, 'Torque KPI was below the expected value (10) and Pressure KPI was >= 5 for more than 1 minute. motor_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 77, 2, 'Speed KPI was below the expected value (6) and Torque KPI was >= 2 for more than 1 minute. sensor_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 15, 1, 'Temperature KPI was below the expected value (3) and Pressure KPI was >= 9 for more than 1 minute. pump_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 49, 6, 'Torque KPI was below the expected value (9) and Pressure KPI was >= 8 for more than 1 minute. valve_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 66, 4, 'PowerConsumption KPI was below the expected value (2) and Speed KPI was >= 1 for more than 1 minute. pump_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 83, 10, 'Speed KPI was below the expected value (8) and PowerConsumption KPI was >= 7 for more than 1 minute. gear_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 91, 10, 'Temperature KPI was below the expected value (2) and Pressure KPI was >= 7 for more than 1 minute. sensor_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 71, 5, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 8 for more than 1 minute. valve_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 75, 1, 'PowerConsumption KPI was below the expected value (2) and Temperature KPI was >= 10 for more than 1 minute. gear_46 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 66, 8, 'Pressure KPI was below the expected value (3) and Temperature KPI was >= 9 for more than 1 minute. gear_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 89, 5, 'Speed KPI was below the expected value (1) and Temperature KPI was >= 4 for more than 1 minute. valve_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 38, 7, 'Speed KPI was below the expected value (1) and PowerConsumption KPI was >= 7 for more than 1 minute. gear_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 31, 6, 'Torque KPI was below the expected value (3) and Speed KPI was >= 7 for more than 1 minute. pump_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 88, 5, 'Torque KPI was below the expected value (8) and PowerConsumption KPI was >= 4 for more than 1 minute. motor_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 39, 1, 'Torque KPI was below the expected value (7) and Pressure KPI was >= 6 for more than 1 minute. motor_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 4, 9, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 3 for more than 1 minute. motor_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 75, 4, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 5 for more than 1 minute. motor_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 20, 10, 'Torque KPI was below the expected value (5) and PowerConsumption KPI was >= 6 for more than 1 minute. gear_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 75, 2, 'Pressure KPI was below the expected value (5) and Speed KPI was >= 7 for more than 1 minute. gear_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 6, 1, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 1 for more than 1 minute. sensor_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 68, 3, 'Torque KPI was below the expected value (4) and Pressure KPI was >= 2 for more than 1 minute. pump_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 47, 3, 'Speed KPI was below the expected value (2) and Pressure KPI was >= 8 for more than 1 minute. pump_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 76, 2, 'PowerConsumption KPI was below the expected value (9) and Torque KPI was >= 3 for more than 1 minute. valve_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 42, 10, 'Temperature KPI was below the expected value (5) and Pressure KPI was >= 4 for more than 1 minute. valve_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 85, 8, 'Pressure KPI was below the expected value (3) and Temperature KPI was >= 4 for more than 1 minute. valve_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 61, 9, 'Pressure KPI was below the expected value (7) and Torque KPI was >= 9 for more than 1 minute. valve_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 45, 6, 'Torque KPI was below the expected value (5) and Speed KPI was >= 5 for more than 1 minute. valve_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 45, 3, 'Speed KPI was below the expected value (7) and Temperature KPI was >= 6 for more than 1 minute. motor_89 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 84, 2, 'Temperature KPI was below the expected value (4) and Pressure KPI was >= 7 for more than 1 minute. motor_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 6, 7, 'Temperature KPI was below the expected value (5) and Torque KPI was >= 7 for more than 1 minute. pump_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 68, 1, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 6 for more than 1 minute. motor_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 38, 2, 'Temperature KPI was below the expected value (9) and Torque KPI was >= 9 for more than 1 minute. sensor_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 77, 4, 'Speed KPI was below the expected value (3) and Torque KPI was >= 7 for more than 1 minute. motor_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 35, 2, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 10 for more than 1 minute. motor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 5, 4, 'Pressure KPI was below the expected value (4) and Temperature KPI was >= 10 for more than 1 minute. sensor_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 12, 9, 'PowerConsumption KPI was below the expected value (10) and Torque KPI was >= 9 for more than 1 minute. motor_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 83, 6, 'Pressure KPI was below the expected value (9) and Speed KPI was >= 8 for more than 1 minute. pump_46 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 65, 3, 'Pressure KPI was below the expected value (8) and Temperature KPI was >= 6 for more than 1 minute. sensor_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 28, 2, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 1 for more than 1 minute. pump_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 13, 5, 'Pressure KPI was below the expected value (3) and Speed KPI was >= 9 for more than 1 minute. valve_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 16, 1, 'Torque KPI was below the expected value (5) and Speed KPI was >= 8 for more than 1 minute. motor_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 4, 2, 'Temperature KPI was below the expected value (7) and Torque KPI was >= 7 for more than 1 minute. gear_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 89, 5, 'Speed KPI was below the expected value (7) and Pressure KPI was >= 9 for more than 1 minute. sensor_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 8, 8, 'Torque KPI was below the expected value (3) and Speed KPI was >= 7 for more than 1 minute. gear_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 42, 6, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 9 for more than 1 minute. pump_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 33, 7, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 1 for more than 1 minute. pump_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 14, 6, 'Pressure KPI was below the expected value (2) and Temperature KPI was >= 2 for more than 1 minute. motor_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 21, 10, 'Speed KPI was below the expected value (7) and Pressure KPI was >= 7 for more than 1 minute. gear_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 82, 4, 'Temperature KPI was below the expected value (8) and Torque KPI was >= 3 for more than 1 minute. sensor_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 83, 6, 'Torque KPI was below the expected value (2) and Pressure KPI was >= 5 for more than 1 minute. valve_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 19, 3, 'Temperature KPI was below the expected value (8) and Torque KPI was >= 7 for more than 1 minute. valve_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 74, 3, 'Speed KPI was below the expected value (8) and PowerConsumption KPI was >= 9 for more than 1 minute. sensor_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 40, 7, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 3 for more than 1 minute. valve_26 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 40, 10, 'PowerConsumption KPI was below the expected value (8) and Speed KPI was >= 2 for more than 1 minute. motor_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 44, 1, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 10 for more than 1 minute. gear_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 89, 10, 'Torque KPI was below the expected value (6) and Speed KPI was >= 7 for more than 1 minute. sensor_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 82, 6, 'Pressure KPI was below the expected value (10) and Torque KPI was >= 2 for more than 1 minute. valve_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 15, 7, 'Pressure KPI was below the expected value (8) and Speed KPI was >= 10 for more than 1 minute. gear_52 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 84, 3, 'Pressure KPI was below the expected value (5) and PowerConsumption KPI was >= 10 for more than 1 minute. sensor_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 93, 10, 'Torque KPI was below the expected value (4) and Pressure KPI was >= 9 for more than 1 minute. pump_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 32, 5, 'Speed KPI was below the expected value (7) and Torque KPI was >= 10 for more than 1 minute. gear_100 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 40, 2, 'PowerConsumption KPI was below the expected value (1) and Torque KPI was >= 3 for more than 1 minute. pump_95 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 55, 2, 'Torque KPI was below the expected value (3) and PowerConsumption KPI was >= 4 for more than 1 minute. sensor_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 6, 9, 'Pressure KPI was below the expected value (6) and Torque KPI was >= 4 for more than 1 minute. motor_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 97, 8, 'Pressure KPI was below the expected value (4) and Speed KPI was >= 2 for more than 1 minute. gear_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 95, 1, 'Pressure KPI was below the expected value (5) and Torque KPI was >= 10 for more than 1 minute. motor_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 21, 9, 'Torque KPI was below the expected value (4) and Pressure KPI was >= 6 for more than 1 minute. motor_62 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 39, 7, 'Temperature KPI was below the expected value (6) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 64, 9, 'Temperature KPI was below the expected value (1) and Torque KPI was >= 2 for more than 1 minute. gear_86 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 76, 6, 'PowerConsumption KPI was below the expected value (2) and Speed KPI was >= 5 for more than 1 minute. valve_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 58, 10, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 9 for more than 1 minute. gear_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 39, 9, 'Speed KPI was below the expected value (10) and Temperature KPI was >= 3 for more than 1 minute. motor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 47, 6, 'Pressure KPI was below the expected value (4) and Temperature KPI was >= 3 for more than 1 minute. motor_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 16, 2, 'PowerConsumption KPI was below the expected value (1) and Torque KPI was >= 8 for more than 1 minute. valve_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 19, 4, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 4 for more than 1 minute. gear_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 28, 2, 'Torque KPI was below the expected value (6) and Pressure KPI was >= 7 for more than 1 minute. pump_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 65, 4, 'Speed KPI was below the expected value (7) and Torque KPI was >= 2 for more than 1 minute. gear_92 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 80, 10, 'Torque KPI was below the expected value (7) and Temperature KPI was >= 8 for more than 1 minute. sensor_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 99, 5, 'Pressure KPI was below the expected value (7) and Temperature KPI was >= 4 for more than 1 minute. valve_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 98, 1, 'Torque KPI was below the expected value (2) and Pressure KPI was >= 1 for more than 1 minute. gear_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 46, 10, 'Speed KPI was below the expected value (4) and Pressure KPI was >= 2 for more than 1 minute. motor_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 11, 10, 'Pressure KPI was below the expected value (3) and Torque KPI was >= 7 for more than 1 minute. pump_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 85, 2, 'Pressure KPI was below the expected value (8) and Torque KPI was >= 9 for more than 1 minute. sensor_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 90, 1, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 3 for more than 1 minute. pump_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 60, 2, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 4 for more than 1 minute. sensor_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 31, 1, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 2 for more than 1 minute. motor_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 54, 8, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 5 for more than 1 minute. pump_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 17, 10, 'PowerConsumption KPI was below the expected value (1) and Torque KPI was >= 1 for more than 1 minute. motor_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 69, 2, 'PowerConsumption KPI was below the expected value (4) and Speed KPI was >= 5 for more than 1 minute. gear_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 38, 2, 'Pressure KPI was below the expected value (10) and Temperature KPI was >= 7 for more than 1 minute. sensor_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 46, 5, 'Pressure KPI was below the expected value (10) and PowerConsumption KPI was >= 9 for more than 1 minute. valve_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 99, 2, 'Temperature KPI was below the expected value (9) and PowerConsumption KPI was >= 2 for more than 1 minute. gear_62 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 4, 5, 'PowerConsumption KPI was below the expected value (3) and Temperature KPI was >= 4 for more than 1 minute. pump_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 96, 10, 'Torque KPI was below the expected value (5) and Temperature KPI was >= 4 for more than 1 minute. gear_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 78, 8, 'Pressure KPI was below the expected value (6) and Torque KPI was >= 2 for more than 1 minute. valve_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 15, 3, 'Speed KPI was below the expected value (3) and Torque KPI was >= 8 for more than 1 minute. gear_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 71, 5, 'Speed KPI was below the expected value (9) and Temperature KPI was >= 10 for more than 1 minute. motor_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 73, 8, 'Torque KPI was below the expected value (3) and Pressure KPI was >= 7 for more than 1 minute. sensor_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 52, 7, 'Speed KPI was below the expected value (1) and Torque KPI was >= 10 for more than 1 minute. gear_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 72, 6, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 7 for more than 1 minute. pump_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 65, 3, 'Torque KPI was below the expected value (10) and Temperature KPI was >= 5 for more than 1 minute. pump_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 90, 5, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 5 for more than 1 minute. motor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 21, 7, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 7 for more than 1 minute. gear_26 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 18, 7, 'Speed KPI was below the expected value (5) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 27, 8, 'PowerConsumption KPI was below the expected value (2) and Pressure KPI was >= 4 for more than 1 minute. motor_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 48, 5, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 5 for more than 1 minute. motor_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 98, 4, 'PowerConsumption KPI was below the expected value (6) and Temperature KPI was >= 2 for more than 1 minute. gear_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 46, 1, 'Speed KPI was below the expected value (9) and PowerConsumption KPI was >= 6 for more than 1 minute. motor_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 95, 8, 'PowerConsumption KPI was below the expected value (8) and Speed KPI was >= 10 for more than 1 minute. valve_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 60, 2, 'Temperature KPI was below the expected value (9) and Speed KPI was >= 4 for more than 1 minute. pump_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 24, 3, 'Temperature KPI was below the expected value (9) and Speed KPI was >= 8 for more than 1 minute. motor_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 84, 1, 'Torque KPI was below the expected value (10) and Speed KPI was >= 7 for more than 1 minute. motor_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 22, 7, 'PowerConsumption KPI was below the expected value (9) and Torque KPI was >= 4 for more than 1 minute. gear_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 68, 8, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 1 for more than 1 minute. motor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 30, 1, 'Speed KPI was below the expected value (5) and PowerConsumption KPI was >= 1 for more than 1 minute. sensor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 57, 3, 'Pressure KPI was below the expected value (2) and Torque KPI was >= 3 for more than 1 minute. sensor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 98, 3, 'Torque KPI was below the expected value (4) and Pressure KPI was >= 8 for more than 1 minute. pump_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 15, 7, 'Pressure KPI was below the expected value (1) and PowerConsumption KPI was >= 9 for more than 1 minute. gear_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 70, 6, 'PowerConsumption KPI was below the expected value (7) and Torque KPI was >= 6 for more than 1 minute. pump_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 83, 8, 'PowerConsumption KPI was below the expected value (7) and Speed KPI was >= 8 for more than 1 minute. sensor_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 31, 5, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 4 for more than 1 minute. valve_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 94, 10, 'Torque KPI was below the expected value (1) and Pressure KPI was >= 6 for more than 1 minute. motor_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 84, 1, 'Speed KPI was below the expected value (1) and Torque KPI was >= 7 for more than 1 minute. motor_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 21, 7, 'Torque KPI was below the expected value (5) and Temperature KPI was >= 1 for more than 1 minute. gear_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 1, 1, 'Torque KPI was below the expected value (4) and Temperature KPI was >= 1 for more than 1 minute. pump_89 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 15, 2, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 10 for more than 1 minute. pump_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 64, 10, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 7 for more than 1 minute. valve_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 37, 8, 'Temperature KPI was below the expected value (1) and PowerConsumption KPI was >= 7 for more than 1 minute. pump_28 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 62, 1, 'Temperature KPI was below the expected value (3) and Pressure KPI was >= 7 for more than 1 minute. valve_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 47, 5, 'Temperature KPI was below the expected value (3) and Torque KPI was >= 5 for more than 1 minute. valve_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 79, 1, 'Pressure KPI was below the expected value (2) and PowerConsumption KPI was >= 8 for more than 1 minute. motor_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 29, 10, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 30, 1, 'PowerConsumption KPI was below the expected value (8) and Speed KPI was >= 7 for more than 1 minute. pump_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 42, 10, 'Speed KPI was below the expected value (2) and Pressure KPI was >= 5 for more than 1 minute. gear_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 25, 10, 'PowerConsumption KPI was below the expected value (10) and Temperature KPI was >= 1 for more than 1 minute. valve_34 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 68, 5, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 3 for more than 1 minute. sensor_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 2, 7, 'Temperature KPI was below the expected value (2) and Speed KPI was >= 6 for more than 1 minute. sensor_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 45, 4, 'PowerConsumption KPI was below the expected value (5) and Torque KPI was >= 10 for more than 1 minute. motor_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 42, 8, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 7 for more than 1 minute. motor_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 57, 6, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 7 for more than 1 minute. gear_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 15, 6, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 5 for more than 1 minute. sensor_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 9, 2, 'Speed KPI was below the expected value (8) and Temperature KPI was >= 7 for more than 1 minute. motor_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 46, 3, 'Temperature KPI was below the expected value (9) and PowerConsumption KPI was >= 4 for more than 1 minute. gear_83 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 10, 1, 'Pressure KPI was below the expected value (2) and Speed KPI was >= 5 for more than 1 minute. gear_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 99, 6, 'Torque KPI was below the expected value (5) and PowerConsumption KPI was >= 1 for more than 1 minute. pump_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 49, 1, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 4 for more than 1 minute. sensor_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 80, 6, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 8 for more than 1 minute. pump_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 17, 2, 'Temperature KPI was below the expected value (7) and Torque KPI was >= 1 for more than 1 minute. valve_6 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 25, 6, 'Pressure KPI was below the expected value (6) and Torque KPI was >= 7 for more than 1 minute. sensor_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 14, 5, 'PowerConsumption KPI was below the expected value (2) and Temperature KPI was >= 2 for more than 1 minute. gear_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 43, 3, 'Pressure KPI was below the expected value (9) and PowerConsumption KPI was >= 9 for more than 1 minute. gear_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 73, 2, 'Torque KPI was below the expected value (6) and Pressure KPI was >= 1 for more than 1 minute. pump_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 7, 4, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 9 for more than 1 minute. valve_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 90, 1, 'Pressure KPI was below the expected value (10) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 59, 10, 'Pressure KPI was below the expected value (7) and Speed KPI was >= 2 for more than 1 minute. valve_47 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 60, 3, 'Torque KPI was below the expected value (2) and Speed KPI was >= 9 for more than 1 minute. pump_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 26, 7, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 6 for more than 1 minute. sensor_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 87, 1, 'Torque KPI was below the expected value (6) and Speed KPI was >= 5 for more than 1 minute. valve_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 11, 1, 'PowerConsumption KPI was below the expected value (3) and Pressure KPI was >= 8 for more than 1 minute. gear_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 20, 4, 'PowerConsumption KPI was below the expected value (9) and Pressure KPI was >= 9 for more than 1 minute. gear_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 66, 7, 'Torque KPI was below the expected value (4) and Speed KPI was >= 2 for more than 1 minute. sensor_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 19, 9, 'PowerConsumption KPI was below the expected value (8) and Speed KPI was >= 8 for more than 1 minute. motor_77 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 100, 9, 'Speed KPI was below the expected value (10) and Pressure KPI was >= 4 for more than 1 minute. sensor_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 82, 5, 'PowerConsumption KPI was below the expected value (9) and Pressure KPI was >= 5 for more than 1 minute. valve_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 85, 8, 'PowerConsumption KPI was below the expected value (8) and Pressure KPI was >= 8 for more than 1 minute. pump_82 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 33, 2, 'Speed KPI was below the expected value (10) and Torque KPI was >= 1 for more than 1 minute. sensor_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 95, 9, 'Pressure KPI was below the expected value (3) and Torque KPI was >= 7 for more than 1 minute. sensor_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 49, 1, 'PowerConsumption KPI was below the expected value (3) and Speed KPI was >= 7 for more than 1 minute. motor_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 46, 7, 'Speed KPI was below the expected value (9) and Torque KPI was >= 4 for more than 1 minute. gear_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 5, 1, 'Speed KPI was below the expected value (7) and Torque KPI was >= 4 for more than 1 minute. sensor_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 50, 8, 'Speed KPI was below the expected value (2) and Temperature KPI was >= 10 for more than 1 minute. motor_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 60, 7, 'PowerConsumption KPI was below the expected value (2) and Torque KPI was >= 2 for more than 1 minute. gear_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 84, 5, 'Pressure KPI was below the expected value (7) and PowerConsumption KPI was >= 9 for more than 1 minute. valve_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 58, 6, 'Speed KPI was below the expected value (8) and PowerConsumption KPI was >= 5 for more than 1 minute. sensor_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 52, 8, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 8 for more than 1 minute. pump_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 16, 5, 'Pressure KPI was below the expected value (5) and Speed KPI was >= 9 for more than 1 minute. gear_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 8, 9, 'Temperature KPI was below the expected value (7) and Speed KPI was >= 8 for more than 1 minute. pump_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 94, 10, 'Speed KPI was below the expected value (1) and Pressure KPI was >= 3 for more than 1 minute. pump_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 31, 2, 'Torque KPI was below the expected value (9) and Pressure KPI was >= 6 for more than 1 minute. sensor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 33, 8, 'PowerConsumption KPI was below the expected value (6) and Speed KPI was >= 9 for more than 1 minute. motor_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 12, 5, 'Torque KPI was below the expected value (6) and Speed KPI was >= 7 for more than 1 minute. pump_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 48, 9, 'Speed KPI was below the expected value (10) and Torque KPI was >= 2 for more than 1 minute. sensor_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 96, 5, 'Temperature KPI was below the expected value (4) and Pressure KPI was >= 3 for more than 1 minute. sensor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 22, 3, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 3 for more than 1 minute. sensor_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 55, 9, 'Temperature KPI was below the expected value (8) and Torque KPI was >= 7 for more than 1 minute. motor_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 75, 7, 'Temperature KPI was below the expected value (3) and Pressure KPI was >= 5 for more than 1 minute. sensor_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 44, 9, 'Torque KPI was below the expected value (3) and Temperature KPI was >= 9 for more than 1 minute. valve_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 9, 10, 'Speed KPI was below the expected value (1) and Pressure KPI was >= 7 for more than 1 minute. sensor_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 54, 3, 'Temperature KPI was below the expected value (3) and Pressure KPI was >= 5 for more than 1 minute. motor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 30, 8, 'Pressure KPI was below the expected value (2) and Speed KPI was >= 6 for more than 1 minute. sensor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 41, 7, 'Pressure KPI was below the expected value (4) and Torque KPI was >= 4 for more than 1 minute. valve_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 41, 10, 'PowerConsumption KPI was below the expected value (1) and Speed KPI was >= 4 for more than 1 minute. sensor_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 57, 2, 'Pressure KPI was below the expected value (4) and PowerConsumption KPI was >= 6 for more than 1 minute. sensor_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 46, 3, 'Speed KPI was below the expected value (8) and Torque KPI was >= 5 for more than 1 minute. pump_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 59, 4, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 4 for more than 1 minute. valve_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 92, 10, 'Torque KPI was below the expected value (3) and PowerConsumption KPI was >= 5 for more than 1 minute. motor_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 70, 9, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 3 for more than 1 minute. valve_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 11, 5, 'PowerConsumption KPI was below the expected value (8) and Pressure KPI was >= 10 for more than 1 minute. gear_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 48, 8, 'Pressure KPI was below the expected value (5) and Speed KPI was >= 3 for more than 1 minute. sensor_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 70, 8, 'Temperature KPI was below the expected value (5) and Speed KPI was >= 7 for more than 1 minute. gear_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 74, 3, 'Pressure KPI was below the expected value (9) and PowerConsumption KPI was >= 10 for more than 1 minute. valve_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 69, 7, 'Torque KPI was below the expected value (10) and Pressure KPI was >= 8 for more than 1 minute. motor_92 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 54, 3, 'Torque KPI was below the expected value (6) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 3, 5, 'Pressure KPI was below the expected value (9) and PowerConsumption KPI was >= 4 for more than 1 minute. gear_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 10, 10, 'PowerConsumption KPI was below the expected value (4) and Speed KPI was >= 7 for more than 1 minute. pump_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 52, 8, 'Temperature KPI was below the expected value (7) and Pressure KPI was >= 4 for more than 1 minute. valve_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 71, 8, 'Temperature KPI was below the expected value (4) and Speed KPI was >= 4 for more than 1 minute. motor_82 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 80, 3, 'Torque KPI was below the expected value (6) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 11, 2, 'PowerConsumption KPI was below the expected value (5) and Torque KPI was >= 7 for more than 1 minute. valve_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 34, 1, 'Pressure KPI was below the expected value (9) and PowerConsumption KPI was >= 3 for more than 1 minute. gear_89 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 72, 5, 'Torque KPI was below the expected value (4) and Temperature KPI was >= 8 for more than 1 minute. pump_75 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 100, 7, 'Pressure KPI was below the expected value (4) and Speed KPI was >= 8 for more than 1 minute. pump_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 37, 5, 'Speed KPI was below the expected value (2) and PowerConsumption KPI was >= 8 for more than 1 minute. gear_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 22, 1, 'Torque KPI was below the expected value (4) and PowerConsumption KPI was >= 3 for more than 1 minute. valve_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 24, 8, 'Pressure KPI was below the expected value (3) and Speed KPI was >= 9 for more than 1 minute. sensor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 68, 8, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 1 for more than 1 minute. valve_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 50, 8, 'PowerConsumption KPI was below the expected value (8) and Torque KPI was >= 2 for more than 1 minute. pump_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 11, 8, 'Torque KPI was below the expected value (3) and Speed KPI was >= 8 for more than 1 minute. gear_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 23, 8, 'Speed KPI was below the expected value (7) and Torque KPI was >= 5 for more than 1 minute. gear_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 4, 1, 'PowerConsumption KPI was below the expected value (2) and Temperature KPI was >= 5 for more than 1 minute. pump_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 48, 1, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 8 for more than 1 minute. motor_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 36, 5, 'Speed KPI was below the expected value (8) and Temperature KPI was >= 7 for more than 1 minute. pump_46 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 79, 4, 'PowerConsumption KPI was below the expected value (8) and Torque KPI was >= 5 for more than 1 minute. gear_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 82, 6, 'Torque KPI was below the expected value (6) and Temperature KPI was >= 2 for more than 1 minute. sensor_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 6, 8, 'Torque KPI was below the expected value (9) and PowerConsumption KPI was >= 3 for more than 1 minute. gear_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 16, 6, 'Speed KPI was below the expected value (6) and Pressure KPI was >= 6 for more than 1 minute. motor_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 20, 10, 'Temperature KPI was below the expected value (3) and Torque KPI was >= 5 for more than 1 minute. pump_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 27, 2, 'Speed KPI was below the expected value (2) and PowerConsumption KPI was >= 6 for more than 1 minute. sensor_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 37, 7, 'Pressure KPI was below the expected value (5) and PowerConsumption KPI was >= 1 for more than 1 minute. sensor_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 33, 6, 'PowerConsumption KPI was below the expected value (10) and Speed KPI was >= 1 for more than 1 minute. valve_6 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 14, 10, 'Torque KPI was below the expected value (1) and Pressure KPI was >= 5 for more than 1 minute. sensor_62 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 86, 9, 'Temperature KPI was below the expected value (2) and PowerConsumption KPI was >= 5 for more than 1 minute. motor_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 26, 8, 'PowerConsumption KPI was below the expected value (2) and Temperature KPI was >= 8 for more than 1 minute. sensor_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 73, 10, 'Temperature KPI was below the expected value (6) and Torque KPI was >= 7 for more than 1 minute. valve_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 88, 9, 'Speed KPI was below the expected value (6) and PowerConsumption KPI was >= 10 for more than 1 minute. motor_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 34, 9, 'Speed KPI was below the expected value (8) and Pressure KPI was >= 4 for more than 1 minute. motor_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 42, 7, 'Temperature KPI was below the expected value (2) and Torque KPI was >= 4 for more than 1 minute. pump_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 56, 9, 'Temperature KPI was below the expected value (1) and Pressure KPI was >= 8 for more than 1 minute. pump_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 78, 6, 'Temperature KPI was below the expected value (7) and Torque KPI was >= 2 for more than 1 minute. motor_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 89, 8, 'Temperature KPI was below the expected value (10) and Pressure KPI was >= 9 for more than 1 minute. gear_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 79, 8, 'Pressure KPI was below the expected value (7) and Torque KPI was >= 8 for more than 1 minute. pump_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 58, 10, 'Temperature KPI was below the expected value (9) and Speed KPI was >= 10 for more than 1 minute. pump_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 34, 3, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 2 for more than 1 minute. sensor_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 40, 6, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 2 for more than 1 minute. motor_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 16, 8, 'Temperature KPI was below the expected value (5) and Pressure KPI was >= 7 for more than 1 minute. valve_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 63, 10, 'Temperature KPI was below the expected value (3) and Torque KPI was >= 10 for more than 1 minute. sensor_75 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 84, 8, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 6 for more than 1 minute. motor_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 72, 8, 'Pressure KPI was below the expected value (7) and Speed KPI was >= 4 for more than 1 minute. sensor_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 93, 4, 'PowerConsumption KPI was below the expected value (10) and Temperature KPI was >= 7 for more than 1 minute. valve_100 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 28, 8, 'Torque KPI was below the expected value (6) and Speed KPI was >= 5 for more than 1 minute. pump_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 46, 10, 'Temperature KPI was below the expected value (5) and Torque KPI was >= 8 for more than 1 minute. gear_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 84, 3, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 10 for more than 1 minute. pump_66 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 43, 6, 'Speed KPI was below the expected value (6) and PowerConsumption KPI was >= 9 for more than 1 minute. gear_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 76, 4, 'Pressure KPI was below the expected value (2) and Speed KPI was >= 7 for more than 1 minute. pump_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 12, 3, 'Torque KPI was below the expected value (5) and Speed KPI was >= 9 for more than 1 minute. gear_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 87, 3, 'Temperature KPI was below the expected value (2) and Speed KPI was >= 9 for more than 1 minute. gear_92 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 39, 8, 'Speed KPI was below the expected value (6) and PowerConsumption KPI was >= 7 for more than 1 minute. valve_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 42, 7, 'Torque KPI was below the expected value (3) and Pressure KPI was >= 8 for more than 1 minute. pump_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 81, 5, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 1 for more than 1 minute. sensor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 18, 2, 'Torque KPI was below the expected value (1) and Speed KPI was >= 8 for more than 1 minute. sensor_47 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 47, 7, 'Pressure KPI was below the expected value (10) and Speed KPI was >= 3 for more than 1 minute. motor_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 42, 5, 'Pressure KPI was below the expected value (4) and Temperature KPI was >= 3 for more than 1 minute. motor_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 49, 9, 'PowerConsumption KPI was below the expected value (5) and Temperature KPI was >= 9 for more than 1 minute. pump_52 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 83, 6, 'Speed KPI was below the expected value (3) and Pressure KPI was >= 1 for more than 1 minute. motor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 95, 5, 'Torque KPI was below the expected value (3) and PowerConsumption KPI was >= 10 for more than 1 minute. sensor_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 86, 2, 'Speed KPI was below the expected value (2) and Temperature KPI was >= 5 for more than 1 minute. pump_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 85, 10, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 6 for more than 1 minute. gear_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 44, 4, 'Pressure KPI was below the expected value (3) and Temperature KPI was >= 9 for more than 1 minute. valve_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 39, 8, 'Pressure KPI was below the expected value (5) and Temperature KPI was >= 4 for more than 1 minute. sensor_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 87, 5, 'PowerConsumption KPI was below the expected value (8) and Torque KPI was >= 3 for more than 1 minute. gear_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 80, 2, 'Temperature KPI was below the expected value (5) and PowerConsumption KPI was >= 8 for more than 1 minute. sensor_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 57, 4, 'PowerConsumption KPI was below the expected value (8) and Torque KPI was >= 9 for more than 1 minute. motor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 55, 9, 'Speed KPI was below the expected value (6) and Torque KPI was >= 2 for more than 1 minute. motor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 29, 9, 'Torque KPI was below the expected value (4) and Speed KPI was >= 8 for more than 1 minute. gear_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 41, 9, 'Pressure KPI was below the expected value (5) and Speed KPI was >= 10 for more than 1 minute. sensor_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 37, 4, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 8 for more than 1 minute. pump_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 77, 10, 'Temperature KPI was below the expected value (1) and Speed KPI was >= 1 for more than 1 minute. gear_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 90, 5, 'Pressure KPI was below the expected value (10) and Speed KPI was >= 10 for more than 1 minute. valve_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 8, 5, 'PowerConsumption KPI was below the expected value (7) and Pressure KPI was >= 2 for more than 1 minute. sensor_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 16, 5, 'Torque KPI was below the expected value (3) and Pressure KPI was >= 4 for more than 1 minute. pump_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 65, 7, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 5 for more than 1 minute. pump_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 84, 4, 'Temperature KPI was below the expected value (4) and Torque KPI was >= 9 for more than 1 minute. motor_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 44, 10, 'Temperature KPI was below the expected value (10) and PowerConsumption KPI was >= 1 for more than 1 minute. gear_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 78, 6, 'Temperature KPI was below the expected value (6) and Pressure KPI was >= 4 for more than 1 minute. valve_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 18, 2, 'Speed KPI was below the expected value (8) and PowerConsumption KPI was >= 10 for more than 1 minute. valve_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 62, 3, 'Pressure KPI was below the expected value (5) and PowerConsumption KPI was >= 2 for more than 1 minute. gear_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 99, 1, 'Temperature KPI was below the expected value (5) and Speed KPI was >= 4 for more than 1 minute. gear_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 7, 3, 'Speed KPI was below the expected value (4) and PowerConsumption KPI was >= 6 for more than 1 minute. gear_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 15, 8, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 4 for more than 1 minute. valve_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 19, 4, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 1 for more than 1 minute. pump_66 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 84, 4, 'Torque KPI was below the expected value (3) and Temperature KPI was >= 3 for more than 1 minute. pump_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 27, 4, 'Pressure KPI was below the expected value (6) and Temperature KPI was >= 10 for more than 1 minute. valve_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 30, 10, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 2 for more than 1 minute. valve_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 25, 6, 'Temperature KPI was below the expected value (3) and Torque KPI was >= 9 for more than 1 minute. sensor_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 53, 3, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 6 for more than 1 minute. valve_47 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 54, 2, 'Speed KPI was below the expected value (6) and Temperature KPI was >= 10 for more than 1 minute. valve_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 24, 7, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 10 for more than 1 minute. valve_34 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 4, 5, 'Torque KPI was below the expected value (7) and Pressure KPI was >= 6 for more than 1 minute. motor_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 99, 9, 'Temperature KPI was below the expected value (10) and Pressure KPI was >= 5 for more than 1 minute. gear_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 56, 1, 'Speed KPI was below the expected value (5) and Torque KPI was >= 3 for more than 1 minute. motor_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 5, 6, 'Speed KPI was below the expected value (2) and PowerConsumption KPI was >= 1 for more than 1 minute. valve_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 2, 4, 'Pressure KPI was below the expected value (1) and Torque KPI was >= 2 for more than 1 minute. gear_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 34, 4, 'Temperature KPI was below the expected value (9) and Speed KPI was >= 5 for more than 1 minute. valve_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 90, 2, 'PowerConsumption KPI was below the expected value (7) and Pressure KPI was >= 7 for more than 1 minute. gear_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 68, 1, 'Torque KPI was below the expected value (4) and Speed KPI was >= 9 for more than 1 minute. pump_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 82, 2, 'Torque KPI was below the expected value (7) and Temperature KPI was >= 9 for more than 1 minute. valve_52 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 1, 10, 'Temperature KPI was below the expected value (2) and Pressure KPI was >= 10 for more than 1 minute. sensor_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 74, 4, 'Speed KPI was below the expected value (3) and Torque KPI was >= 8 for more than 1 minute. pump_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 37, 10, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 9 for more than 1 minute. motor_86 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 23, 6, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 7 for more than 1 minute. gear_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 68, 6, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 3 for more than 1 minute. motor_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 37, 6, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 5 for more than 1 minute. valve_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 19, 10, 'Pressure KPI was below the expected value (2) and PowerConsumption KPI was >= 1 for more than 1 minute. pump_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 11, 10, 'Pressure KPI was below the expected value (2) and PowerConsumption KPI was >= 6 for more than 1 minute. valve_16 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 16, 4, 'Speed KPI was below the expected value (7) and Temperature KPI was >= 3 for more than 1 minute. motor_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 51, 9, 'Pressure KPI was below the expected value (9) and Speed KPI was >= 8 for more than 1 minute. sensor_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 38, 2, 'Pressure KPI was below the expected value (5) and Temperature KPI was >= 4 for more than 1 minute. sensor_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 34, 4, 'Pressure KPI was below the expected value (9) and Speed KPI was >= 4 for more than 1 minute. valve_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 28, 9, 'Temperature KPI was below the expected value (4) and Torque KPI was >= 2 for more than 1 minute. sensor_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 33, 9, 'Temperature KPI was below the expected value (8) and Speed KPI was >= 3 for more than 1 minute. gear_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 86, 8, 'Pressure KPI was below the expected value (8) and Speed KPI was >= 7 for more than 1 minute. sensor_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 60, 6, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 2 for more than 1 minute. pump_34 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 18, 8, 'Temperature KPI was below the expected value (7) and Pressure KPI was >= 10 for more than 1 minute. valve_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 14, 6, 'Temperature KPI was below the expected value (9) and PowerConsumption KPI was >= 9 for more than 1 minute. pump_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 60, 3, 'Pressure KPI was below the expected value (7) and Speed KPI was >= 9 for more than 1 minute. pump_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 67, 5, 'Pressure KPI was below the expected value (3) and Torque KPI was >= 10 for more than 1 minute. valve_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 70, 10, 'Temperature KPI was below the expected value (4) and Pressure KPI was >= 9 for more than 1 minute. gear_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 35, 3, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 7 for more than 1 minute. pump_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 3, 3, 'Speed KPI was below the expected value (2) and PowerConsumption KPI was >= 2 for more than 1 minute. motor_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 49, 6, 'Torque KPI was below the expected value (4) and Temperature KPI was >= 3 for more than 1 minute. pump_11 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 3, 8, 'Torque KPI was below the expected value (7) and Pressure KPI was >= 6 for more than 1 minute. motor_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 82, 8, 'Temperature KPI was below the expected value (2) and Speed KPI was >= 8 for more than 1 minute. valve_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 14, 2, 'Torque KPI was below the expected value (2) and Pressure KPI was >= 7 for more than 1 minute. gear_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 51, 7, 'Speed KPI was below the expected value (7) and Pressure KPI was >= 1 for more than 1 minute. valve_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 18, 4, 'Speed KPI was below the expected value (6) and Torque KPI was >= 7 for more than 1 minute. motor_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 61, 10, 'Speed KPI was below the expected value (4) and PowerConsumption KPI was >= 7 for more than 1 minute. valve_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 100, 9, 'Speed KPI was below the expected value (10) and Temperature KPI was >= 4 for more than 1 minute. motor_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 15, 5, 'Torque KPI was below the expected value (6) and Temperature KPI was >= 4 for more than 1 minute. valve_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 33, 8, 'PowerConsumption KPI was below the expected value (10) and Pressure KPI was >= 8 for more than 1 minute. pump_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 60, 3, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 1 for more than 1 minute. pump_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 28, 4, 'Speed KPI was below the expected value (5) and PowerConsumption KPI was >= 7 for more than 1 minute. gear_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 29, 6, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 3 for more than 1 minute. pump_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 96, 1, 'Torque KPI was below the expected value (1) and Speed KPI was >= 8 for more than 1 minute. pump_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 26, 5, 'Speed KPI was below the expected value (3) and PowerConsumption KPI was >= 4 for more than 1 minute. motor_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 10, 1, 'Speed KPI was below the expected value (6) and Pressure KPI was >= 9 for more than 1 minute. pump_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 72, 1, 'Pressure KPI was below the expected value (10) and PowerConsumption KPI was >= 4 for more than 1 minute. sensor_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 28, 4, 'Temperature KPI was below the expected value (8) and Pressure KPI was >= 10 for more than 1 minute. valve_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 20, 2, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 8 for more than 1 minute. valve_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 76, 5, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 8 for more than 1 minute. valve_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 33, 1, 'Pressure KPI was below the expected value (6) and Speed KPI was >= 3 for more than 1 minute. sensor_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 36, 7, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 2 for more than 1 minute. valve_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 78, 5, 'Torque KPI was below the expected value (10) and Speed KPI was >= 1 for more than 1 minute. pump_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 13, 6, 'PowerConsumption KPI was below the expected value (10) and Temperature KPI was >= 3 for more than 1 minute. gear_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 62, 10, 'Torque KPI was below the expected value (4) and PowerConsumption KPI was >= 9 for more than 1 minute. pump_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 53, 3, 'Torque KPI was below the expected value (3) and Pressure KPI was >= 3 for more than 1 minute. sensor_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 65, 4, 'Torque KPI was below the expected value (8) and Temperature KPI was >= 7 for more than 1 minute. pump_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 87, 8, 'Torque KPI was below the expected value (5) and Speed KPI was >= 9 for more than 1 minute. valve_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 62, 3, 'Pressure KPI was below the expected value (7) and Torque KPI was >= 2 for more than 1 minute. motor_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 76, 10, 'PowerConsumption KPI was below the expected value (7) and Torque KPI was >= 7 for more than 1 minute. sensor_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 58, 7, 'Pressure KPI was below the expected value (6) and Speed KPI was >= 1 for more than 1 minute. pump_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 61, 8, 'Temperature KPI was below the expected value (3) and Pressure KPI was >= 3 for more than 1 minute. sensor_86 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 98, 6, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 2 for more than 1 minute. pump_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 6, 2, 'PowerConsumption KPI was below the expected value (2) and Temperature KPI was >= 1 for more than 1 minute. gear_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 26, 9, 'Speed KPI was below the expected value (6) and Torque KPI was >= 1 for more than 1 minute. gear_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 47, 8, 'PowerConsumption KPI was below the expected value (1) and Torque KPI was >= 8 for more than 1 minute. valve_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 29, 5, 'Speed KPI was below the expected value (7) and Torque KPI was >= 5 for more than 1 minute. motor_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 98, 5, 'Temperature KPI was below the expected value (9) and Torque KPI was >= 4 for more than 1 minute. motor_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 55, 4, 'PowerConsumption KPI was below the expected value (2) and Torque KPI was >= 4 for more than 1 minute. valve_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 39, 6, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_75 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 25, 10, 'Torque KPI was below the expected value (10) and Temperature KPI was >= 6 for more than 1 minute. pump_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 37, 3, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 4 for more than 1 minute. motor_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 92, 9, 'Speed KPI was below the expected value (1) and Torque KPI was >= 7 for more than 1 minute. pump_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 84, 10, 'Speed KPI was below the expected value (1) and Pressure KPI was >= 8 for more than 1 minute. gear_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 56, 2, 'Speed KPI was below the expected value (5) and Torque KPI was >= 9 for more than 1 minute. sensor_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 31, 1, 'Speed KPI was below the expected value (6) and Torque KPI was >= 1 for more than 1 minute. pump_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 12, 5, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 4 for more than 1 minute. motor_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 82, 7, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 6 for more than 1 minute. sensor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 66, 6, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 1 for more than 1 minute. motor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 54, 10, 'Torque KPI was below the expected value (5) and Pressure KPI was >= 1 for more than 1 minute. motor_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 87, 2, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 8 for more than 1 minute. gear_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 1, 8, 'Torque KPI was below the expected value (10) and Temperature KPI was >= 9 for more than 1 minute. valve_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 1, 7, 'Pressure KPI was below the expected value (6) and Speed KPI was >= 1 for more than 1 minute. motor_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 32, 5, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 7 for more than 1 minute. gear_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 61, 6, 'Temperature KPI was below the expected value (6) and Speed KPI was >= 3 for more than 1 minute. valve_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 92, 1, 'Torque KPI was below the expected value (5) and Speed KPI was >= 10 for more than 1 minute. gear_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 46, 5, 'PowerConsumption KPI was below the expected value (3) and Temperature KPI was >= 10 for more than 1 minute. sensor_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 16, 10, 'Torque KPI was below the expected value (3) and PowerConsumption KPI was >= 3 for more than 1 minute. sensor_83 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 6, 8, 'Temperature KPI was below the expected value (1) and Speed KPI was >= 2 for more than 1 minute. valve_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 100, 3, 'Temperature KPI was below the expected value (5) and Torque KPI was >= 5 for more than 1 minute. gear_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 18, 8, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 10 for more than 1 minute. pump_95 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 1, 7, 'Speed KPI was below the expected value (8) and Torque KPI was >= 10 for more than 1 minute. motor_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 80, 7, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 8 for more than 1 minute. motor_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 63, 7, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 2 for more than 1 minute. sensor_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 53, 3, 'Speed KPI was below the expected value (10) and Pressure KPI was >= 3 for more than 1 minute. sensor_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 52, 1, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 9 for more than 1 minute. gear_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 20, 8, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 3 for more than 1 minute. valve_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 52, 6, 'Torque KPI was below the expected value (9) and Speed KPI was >= 10 for more than 1 minute. pump_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 39, 9, 'Torque KPI was below the expected value (5) and Temperature KPI was >= 2 for more than 1 minute. pump_16 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 61, 6, 'Speed KPI was below the expected value (1) and PowerConsumption KPI was >= 6 for more than 1 minute. valve_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 60, 2, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 1 for more than 1 minute. gear_34 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 8, 3, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 4 for more than 1 minute. gear_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 30, 6, 'Torque KPI was below the expected value (6) and Speed KPI was >= 3 for more than 1 minute. motor_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 46, 2, 'Torque KPI was below the expected value (7) and PowerConsumption KPI was >= 10 for more than 1 minute. pump_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 62, 8, 'Torque KPI was below the expected value (10) and Speed KPI was >= 8 for more than 1 minute. sensor_89 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 85, 9, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 10 for more than 1 minute. pump_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 75, 3, 'Pressure KPI was below the expected value (1) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 99, 8, 'Torque KPI was below the expected value (9) and Speed KPI was >= 8 for more than 1 minute. gear_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 78, 10, 'Speed KPI was below the expected value (1) and Temperature KPI was >= 8 for more than 1 minute. motor_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 24, 3, 'Torque KPI was below the expected value (9) and Pressure KPI was >= 5 for more than 1 minute. pump_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 89, 2, 'Pressure KPI was below the expected value (10) and Speed KPI was >= 1 for more than 1 minute. motor_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 12, 1, 'Temperature KPI was below the expected value (3) and Speed KPI was >= 5 for more than 1 minute. gear_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 71, 10, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 5 for more than 1 minute. pump_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 20, 4, 'Speed KPI was below the expected value (3) and PowerConsumption KPI was >= 9 for more than 1 minute. motor_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 37, 1, 'Temperature KPI was below the expected value (6) and Speed KPI was >= 1 for more than 1 minute. pump_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 90, 3, 'Speed KPI was below the expected value (2) and Temperature KPI was >= 6 for more than 1 minute. motor_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 39, 3, 'Temperature KPI was below the expected value (9) and PowerConsumption KPI was >= 1 for more than 1 minute. valve_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 32, 4, 'Speed KPI was below the expected value (2) and Temperature KPI was >= 8 for more than 1 minute. sensor_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 67, 4, 'Speed KPI was below the expected value (4) and Pressure KPI was >= 8 for more than 1 minute. pump_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 16, 7, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 9 for more than 1 minute. motor_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 16, 9, 'Speed KPI was below the expected value (2) and Temperature KPI was >= 6 for more than 1 minute. valve_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 63, 10, 'Pressure KPI was below the expected value (6) and Temperature KPI was >= 7 for more than 1 minute. valve_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 52, 6, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 1 for more than 1 minute. sensor_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 5, 8, 'Temperature KPI was below the expected value (2) and PowerConsumption KPI was >= 5 for more than 1 minute. sensor_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 20, 3, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 10 for more than 1 minute. gear_82 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 25, 7, 'Pressure KPI was below the expected value (3) and Torque KPI was >= 1 for more than 1 minute. motor_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 10, 9, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 9 for more than 1 minute. motor_74 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 25, 5, 'PowerConsumption KPI was below the expected value (3) and Pressure KPI was >= 2 for more than 1 minute. sensor_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 92, 3, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 2 for more than 1 minute. sensor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 43, 6, 'Pressure KPI was below the expected value (7) and Torque KPI was >= 8 for more than 1 minute. gear_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 38, 2, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 8 for more than 1 minute. gear_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 11, 7, 'Pressure KPI was below the expected value (6) and Speed KPI was >= 5 for more than 1 minute. motor_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 6, 10, 'Pressure KPI was below the expected value (4) and Speed KPI was >= 9 for more than 1 minute. valve_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 67, 6, 'PowerConsumption KPI was below the expected value (1) and Speed KPI was >= 3 for more than 1 minute. valve_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 11, 8, 'Speed KPI was below the expected value (1) and Torque KPI was >= 3 for more than 1 minute. sensor_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 54, 9, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 6 for more than 1 minute. motor_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 49, 10, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 8 for more than 1 minute. motor_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 5, 2, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 8 for more than 1 minute. valve_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 73, 3, 'Temperature KPI was below the expected value (5) and Torque KPI was >= 2 for more than 1 minute. sensor_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 47, 10, 'Speed KPI was below the expected value (4) and Pressure KPI was >= 9 for more than 1 minute. pump_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 80, 2, 'Temperature KPI was below the expected value (8) and Torque KPI was >= 6 for more than 1 minute. valve_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 42, 6, 'Torque KPI was below the expected value (5) and Temperature KPI was >= 1 for more than 1 minute. motor_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 12, 2, 'Torque KPI was below the expected value (5) and Pressure KPI was >= 3 for more than 1 minute. valve_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 62, 1, 'PowerConsumption KPI was below the expected value (10) and Torque KPI was >= 5 for more than 1 minute. sensor_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 96, 1, 'Torque KPI was below the expected value (2) and Speed KPI was >= 2 for more than 1 minute. gear_67 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 15, 10, 'Speed KPI was below the expected value (6) and Pressure KPI was >= 6 for more than 1 minute. valve_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 14, 3, 'Speed KPI was below the expected value (7) and Temperature KPI was >= 10 for more than 1 minute. gear_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 79, 3, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 6 for more than 1 minute. gear_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 26, 2, 'Pressure KPI was below the expected value (5) and Temperature KPI was >= 7 for more than 1 minute. valve_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 7, 4, 'Pressure KPI was below the expected value (1) and PowerConsumption KPI was >= 8 for more than 1 minute. motor_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 2, 9, 'Torque KPI was below the expected value (4) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 53, 7, 'PowerConsumption KPI was below the expected value (5) and Temperature KPI was >= 9 for more than 1 minute. pump_82 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 94, 3, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 6 for more than 1 minute. pump_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 83, 6, 'Torque KPI was below the expected value (9) and PowerConsumption KPI was >= 9 for more than 1 minute. pump_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 63, 10, 'Torque KPI was below the expected value (3) and Temperature KPI was >= 4 for more than 1 minute. gear_75 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 14, 7, 'Torque KPI was below the expected value (5) and Temperature KPI was >= 2 for more than 1 minute. valve_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 92, 5, 'Speed KPI was below the expected value (2) and Pressure KPI was >= 9 for more than 1 minute. gear_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 32, 6, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 4 for more than 1 minute. valve_36 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 85, 6, 'PowerConsumption KPI was below the expected value (10) and Torque KPI was >= 7 for more than 1 minute. gear_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 7, 7, 'Pressure KPI was below the expected value (9) and Temperature KPI was >= 2 for more than 1 minute. motor_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 19, 5, 'Pressure KPI was below the expected value (2) and Speed KPI was >= 3 for more than 1 minute. pump_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 8, 10, 'PowerConsumption KPI was below the expected value (5) and Pressure KPI was >= 6 for more than 1 minute. sensor_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 70, 8, 'Temperature KPI was below the expected value (4) and Speed KPI was >= 3 for more than 1 minute. sensor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 53, 3, 'PowerConsumption KPI was below the expected value (3) and Pressure KPI was >= 4 for more than 1 minute. sensor_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 27, 4, 'Torque KPI was below the expected value (10) and Temperature KPI was >= 2 for more than 1 minute. sensor_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 67, 7, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 7 for more than 1 minute. pump_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 100, 7, 'Speed KPI was below the expected value (2) and Temperature KPI was >= 6 for more than 1 minute. gear_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 78, 10, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 1 for more than 1 minute. gear_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 48, 3, 'Pressure KPI was below the expected value (3) and Speed KPI was >= 3 for more than 1 minute. motor_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 94, 7, 'Pressure KPI was below the expected value (6) and Speed KPI was >= 3 for more than 1 minute. pump_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 69, 9, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 9 for more than 1 minute. sensor_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 57, 6, 'PowerConsumption KPI was below the expected value (7) and Speed KPI was >= 10 for more than 1 minute. pump_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 29, 7, 'Torque KPI was below the expected value (5) and PowerConsumption KPI was >= 5 for more than 1 minute. sensor_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 95, 1, 'Speed KPI was below the expected value (9) and PowerConsumption KPI was >= 8 for more than 1 minute. motor_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 24, 6, 'Pressure KPI was below the expected value (9) and Speed KPI was >= 2 for more than 1 minute. valve_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 55, 10, 'Torque KPI was below the expected value (9) and Pressure KPI was >= 8 for more than 1 minute. pump_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 90, 4, 'Speed KPI was below the expected value (8) and Temperature KPI was >= 4 for more than 1 minute. valve_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 5, 3, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 4 for more than 1 minute. motor_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 34, 9, 'PowerConsumption KPI was below the expected value (6) and Temperature KPI was >= 6 for more than 1 minute. pump_34 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 7, 4, 'Torque KPI was below the expected value (8) and Speed KPI was >= 3 for more than 1 minute. sensor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 74, 6, 'PowerConsumption KPI was below the expected value (6) and Temperature KPI was >= 8 for more than 1 minute. gear_11 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 76, 4, 'PowerConsumption KPI was below the expected value (3) and Temperature KPI was >= 2 for more than 1 minute. sensor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 7, 8, 'Pressure KPI was below the expected value (5) and Speed KPI was >= 2 for more than 1 minute. sensor_100 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 34, 1, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 2 for more than 1 minute. motor_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 49, 2, 'Torque KPI was below the expected value (6) and Speed KPI was >= 9 for more than 1 minute. gear_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 8, 4, 'PowerConsumption KPI was below the expected value (10) and Temperature KPI was >= 7 for more than 1 minute. gear_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 38, 3, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 2 for more than 1 minute. motor_28 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 62, 6, 'Torque KPI was below the expected value (6) and Temperature KPI was >= 4 for more than 1 minute. motor_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 70, 9, 'PowerConsumption KPI was below the expected value (7) and Torque KPI was >= 10 for more than 1 minute. valve_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 36, 4, 'Pressure KPI was below the expected value (10) and Torque KPI was >= 3 for more than 1 minute. motor_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 45, 6, 'Torque KPI was below the expected value (10) and PowerConsumption KPI was >= 5 for more than 1 minute. gear_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 56, 7, 'Speed KPI was below the expected value (2) and Temperature KPI was >= 9 for more than 1 minute. motor_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 50, 4, 'Torque KPI was below the expected value (4) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 89, 4, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 10 for more than 1 minute. gear_89 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 32, 3, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 6 for more than 1 minute. gear_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 94, 10, 'Temperature KPI was below the expected value (3) and Speed KPI was >= 9 for more than 1 minute. sensor_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 47, 7, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 2 for more than 1 minute. gear_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 53, 7, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 9 for more than 1 minute. pump_6 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 99, 9, 'Torque KPI was below the expected value (1) and Speed KPI was >= 4 for more than 1 minute. valve_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 5, 4, 'Pressure KPI was below the expected value (5) and Torque KPI was >= 6 for more than 1 minute. motor_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 32, 4, 'Temperature KPI was below the expected value (9) and Speed KPI was >= 2 for more than 1 minute. valve_23 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 81, 9, 'Pressure KPI was below the expected value (2) and Temperature KPI was >= 3 for more than 1 minute. motor_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 74, 5, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 4 for more than 1 minute. pump_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 69, 1, 'PowerConsumption KPI was below the expected value (2) and Temperature KPI was >= 4 for more than 1 minute. valve_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 66, 4, 'Pressure KPI was below the expected value (10) and Speed KPI was >= 3 for more than 1 minute. valve_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 48, 9, 'Temperature KPI was below the expected value (7) and Speed KPI was >= 2 for more than 1 minute. pump_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 64, 7, 'Temperature KPI was below the expected value (8) and Speed KPI was >= 5 for more than 1 minute. sensor_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 70, 4, 'Speed KPI was below the expected value (5) and Torque KPI was >= 3 for more than 1 minute. motor_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 86, 3, 'PowerConsumption KPI was below the expected value (2) and Speed KPI was >= 7 for more than 1 minute. sensor_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 95, 1, 'PowerConsumption KPI was below the expected value (7) and Pressure KPI was >= 4 for more than 1 minute. valve_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 48, 6, 'PowerConsumption KPI was below the expected value (4) and Temperature KPI was >= 9 for more than 1 minute. motor_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 96, 8, 'Pressure KPI was below the expected value (2) and PowerConsumption KPI was >= 10 for more than 1 minute. pump_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 87, 4, 'Torque KPI was below the expected value (7) and Pressure KPI was >= 3 for more than 1 minute. gear_46 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 67, 9, 'Temperature KPI was below the expected value (9) and PowerConsumption KPI was >= 2 for more than 1 minute. gear_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 88, 9, 'Torque KPI was below the expected value (2) and Speed KPI was >= 2 for more than 1 minute. sensor_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 24, 1, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 4 for more than 1 minute. sensor_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 56, 9, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 9 for more than 1 minute. pump_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 22, 8, 'Temperature KPI was below the expected value (4) and Pressure KPI was >= 2 for more than 1 minute. sensor_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 66, 9, 'PowerConsumption KPI was below the expected value (6) and Temperature KPI was >= 5 for more than 1 minute. gear_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 21, 7, 'Pressure KPI was below the expected value (9) and Temperature KPI was >= 7 for more than 1 minute. pump_66 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 66, 1, 'PowerConsumption KPI was below the expected value (7) and Pressure KPI was >= 8 for more than 1 minute. valve_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 57, 7, 'Torque KPI was below the expected value (10) and Temperature KPI was >= 9 for more than 1 minute. sensor_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 55, 8, 'Temperature KPI was below the expected value (6) and Pressure KPI was >= 9 for more than 1 minute. motor_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 10, 9, 'PowerConsumption KPI was below the expected value (4) and Temperature KPI was >= 7 for more than 1 minute. pump_11 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 21, 7, 'Pressure KPI was below the expected value (2) and Torque KPI was >= 2 for more than 1 minute. gear_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 22, 5, 'Temperature KPI was below the expected value (2) and Torque KPI was >= 6 for more than 1 minute. pump_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 33, 6, 'Torque KPI was below the expected value (6) and Speed KPI was >= 9 for more than 1 minute. motor_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 32, 7, 'Speed KPI was below the expected value (2) and Pressure KPI was >= 6 for more than 1 minute. sensor_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 21, 8, 'Speed KPI was below the expected value (9) and Torque KPI was >= 6 for more than 1 minute. pump_16 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 37, 5, 'PowerConsumption KPI was below the expected value (6) and Speed KPI was >= 7 for more than 1 minute. motor_66 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 24, 5, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 10 for more than 1 minute. valve_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 59, 8, 'Speed KPI was below the expected value (1) and Torque KPI was >= 3 for more than 1 minute. motor_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 10, 5, 'Speed KPI was below the expected value (5) and PowerConsumption KPI was >= 1 for more than 1 minute. motor_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 54, 5, 'Speed KPI was below the expected value (4) and PowerConsumption KPI was >= 1 for more than 1 minute. gear_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 6, 9, 'PowerConsumption KPI was below the expected value (5) and Pressure KPI was >= 8 for more than 1 minute. sensor_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 47, 7, 'Pressure KPI was below the expected value (6) and Speed KPI was >= 7 for more than 1 minute. gear_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 14, 7, 'Pressure KPI was below the expected value (8) and PowerConsumption KPI was >= 7 for more than 1 minute. pump_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 45, 4, 'Torque KPI was below the expected value (9) and Temperature KPI was >= 3 for more than 1 minute. sensor_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 84, 8, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 6 for more than 1 minute. pump_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 79, 8, 'PowerConsumption KPI was below the expected value (8) and Temperature KPI was >= 7 for more than 1 minute. sensor_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 16, 8, 'Speed KPI was below the expected value (1) and Torque KPI was >= 2 for more than 1 minute. motor_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 11, 1, 'Speed KPI was below the expected value (4) and Temperature KPI was >= 3 for more than 1 minute. sensor_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 2, 3, 'PowerConsumption KPI was below the expected value (4) and Pressure KPI was >= 10 for more than 1 minute. pump_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 22, 4, 'PowerConsumption KPI was below the expected value (2) and Pressure KPI was >= 8 for more than 1 minute. motor_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 43, 6, 'Temperature KPI was below the expected value (3) and PowerConsumption KPI was >= 3 for more than 1 minute. motor_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 16, 6, 'Temperature KPI was below the expected value (1) and PowerConsumption KPI was >= 6 for more than 1 minute. pump_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 72, 8, 'PowerConsumption KPI was below the expected value (3) and Speed KPI was >= 5 for more than 1 minute. sensor_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 90, 7, 'PowerConsumption KPI was below the expected value (5) and Temperature KPI was >= 6 for more than 1 minute. pump_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 2, 10, 'Pressure KPI was below the expected value (3) and Torque KPI was >= 10 for more than 1 minute. valve_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 70, 10, 'Speed KPI was below the expected value (10) and Temperature KPI was >= 9 for more than 1 minute. valve_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 55, 5, 'Speed KPI was below the expected value (1) and Temperature KPI was >= 4 for more than 1 minute. motor_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 19, 4, 'Torque KPI was below the expected value (9) and Speed KPI was >= 4 for more than 1 minute. motor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 10, 10, 'Torque KPI was below the expected value (4) and Speed KPI was >= 2 for more than 1 minute. motor_68 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 35, 10, 'Speed KPI was below the expected value (9) and PowerConsumption KPI was >= 3 for more than 1 minute. motor_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 27, 10, 'Temperature KPI was below the expected value (3) and Torque KPI was >= 6 for more than 1 minute. valve_47 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 31, 4, 'Temperature KPI was below the expected value (8) and Pressure KPI was >= 4 for more than 1 minute. sensor_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 100, 8, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 6 for more than 1 minute. gear_83 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 45, 2, 'Pressure KPI was below the expected value (5) and Temperature KPI was >= 9 for more than 1 minute. pump_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 59, 2, 'Temperature KPI was below the expected value (8) and Pressure KPI was >= 9 for more than 1 minute. gear_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 9, 3, 'Pressure KPI was below the expected value (7) and Temperature KPI was >= 7 for more than 1 minute. valve_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 22, 4, 'PowerConsumption KPI was below the expected value (10) and Torque KPI was >= 6 for more than 1 minute. pump_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 6, 4, 'Pressure KPI was below the expected value (7) and Temperature KPI was >= 8 for more than 1 minute. pump_83 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 29, 10, 'Speed KPI was below the expected value (8) and Pressure KPI was >= 2 for more than 1 minute. sensor_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 62, 6, 'Torque KPI was below the expected value (7) and Temperature KPI was >= 3 for more than 1 minute. motor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 90, 7, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 7 for more than 1 minute. pump_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 3, 10, 'Pressure KPI was below the expected value (6) and PowerConsumption KPI was >= 3 for more than 1 minute. pump_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 98, 7, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 4 for more than 1 minute. sensor_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 25, 8, 'Temperature KPI was below the expected value (3) and Pressure KPI was >= 3 for more than 1 minute. pump_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 99, 10, 'PowerConsumption KPI was below the expected value (10) and Speed KPI was >= 2 for more than 1 minute. motor_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 48, 3, 'PowerConsumption KPI was below the expected value (10) and Speed KPI was >= 3 for more than 1 minute. motor_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 4, 10, 'Speed KPI was below the expected value (9) and Torque KPI was >= 8 for more than 1 minute. motor_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 29, 4, 'Torque KPI was below the expected value (5) and Pressure KPI was >= 9 for more than 1 minute. motor_73 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 1, 4, 'Temperature KPI was below the expected value (1) and Pressure KPI was >= 6 for more than 1 minute. sensor_6 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 16, 1, 'Speed KPI was below the expected value (10) and Temperature KPI was >= 5 for more than 1 minute. sensor_83 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 61, 10, 'Speed KPI was below the expected value (8) and PowerConsumption KPI was >= 1 for more than 1 minute. valve_28 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 91, 2, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 7 for more than 1 minute. valve_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 35, 2, 'Speed KPI was below the expected value (3) and Torque KPI was >= 2 for more than 1 minute. motor_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 47, 7, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 5 for more than 1 minute. gear_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 30, 10, 'Pressure KPI was below the expected value (9) and Speed KPI was >= 8 for more than 1 minute. motor_46 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 34, 8, 'PowerConsumption KPI was below the expected value (7) and Speed KPI was >= 9 for more than 1 minute. motor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 78, 6, 'Temperature KPI was below the expected value (5) and Torque KPI was >= 9 for more than 1 minute. valve_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 39, 7, 'PowerConsumption KPI was below the expected value (1) and Torque KPI was >= 1 for more than 1 minute. gear_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 82, 4, 'Pressure KPI was below the expected value (6) and Torque KPI was >= 9 for more than 1 minute. gear_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 79, 4, 'Pressure KPI was below the expected value (2) and Temperature KPI was >= 3 for more than 1 minute. pump_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 57, 6, 'Pressure KPI was below the expected value (2) and Torque KPI was >= 7 for more than 1 minute. pump_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 83, 6, 'PowerConsumption KPI was below the expected value (10) and Temperature KPI was >= 9 for more than 1 minute. gear_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 4, 4, 'PowerConsumption KPI was below the expected value (8) and Speed KPI was >= 9 for more than 1 minute. gear_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 94, 7, 'Speed KPI was below the expected value (6) and Temperature KPI was >= 4 for more than 1 minute. pump_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 22, 1, 'Torque KPI was below the expected value (5) and Speed KPI was >= 6 for more than 1 minute. valve_35 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 31, 5, 'Pressure KPI was below the expected value (8) and Temperature KPI was >= 9 for more than 1 minute. motor_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 17, 10, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 6 for more than 1 minute. gear_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 78, 7, 'Temperature KPI was below the expected value (3) and Speed KPI was >= 2 for more than 1 minute. valve_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 86, 8, 'PowerConsumption KPI was below the expected value (3) and Pressure KPI was >= 10 for more than 1 minute. motor_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 10, 2, 'Temperature KPI was below the expected value (8) and Speed KPI was >= 10 for more than 1 minute. pump_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 50, 3, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 3 for more than 1 minute. sensor_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 11, 8, 'PowerConsumption KPI was below the expected value (1) and Pressure KPI was >= 3 for more than 1 minute. motor_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 13, 3, 'PowerConsumption KPI was below the expected value (3) and Speed KPI was >= 9 for more than 1 minute. motor_28 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 35, 2, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 4 for more than 1 minute. gear_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 88, 2, 'Pressure KPI was below the expected value (10) and PowerConsumption KPI was >= 8 for more than 1 minute. pump_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 68, 3, 'Speed KPI was below the expected value (7) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 73, 7, 'Temperature KPI was below the expected value (10) and PowerConsumption KPI was >= 3 for more than 1 minute. pump_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 24, 1, 'Temperature KPI was below the expected value (3) and Pressure KPI was >= 8 for more than 1 minute. sensor_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 25, 9, 'Pressure KPI was below the expected value (6) and Speed KPI was >= 1 for more than 1 minute. sensor_30 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 86, 4, 'Torque KPI was below the expected value (4) and Speed KPI was >= 4 for more than 1 minute. motor_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 5, 10, 'Speed KPI was below the expected value (1) and Torque KPI was >= 10 for more than 1 minute. valve_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 45, 5, 'Pressure KPI was below the expected value (4) and PowerConsumption KPI was >= 8 for more than 1 minute. sensor_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 77, 9, 'Temperature KPI was below the expected value (1) and Pressure KPI was >= 9 for more than 1 minute. gear_87 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 71, 3, 'PowerConsumption KPI was below the expected value (5) and Temperature KPI was >= 5 for more than 1 minute. valve_94 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 31, 6, 'PowerConsumption KPI was below the expected value (3) and Temperature KPI was >= 2 for more than 1 minute. pump_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 18, 1, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_86 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 23, 9, 'Speed KPI was below the expected value (10) and Pressure KPI was >= 8 for more than 1 minute. valve_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 39, 10, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 3 for more than 1 minute. sensor_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 100, 4, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 2 for more than 1 minute. motor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 40, 7, 'Temperature KPI was below the expected value (7) and Pressure KPI was >= 3 for more than 1 minute. gear_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 14, 4, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 6 for more than 1 minute. motor_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 94, 4, 'Temperature KPI was below the expected value (7) and Pressure KPI was >= 6 for more than 1 minute. gear_41 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 33, 9, 'Pressure KPI was below the expected value (2) and PowerConsumption KPI was >= 7 for more than 1 minute. gear_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 67, 8, 'Speed KPI was below the expected value (9) and Temperature KPI was >= 3 for more than 1 minute. pump_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 50, 6, 'Pressure KPI was below the expected value (3) and Torque KPI was >= 6 for more than 1 minute. valve_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 90, 2, 'PowerConsumption KPI was below the expected value (3) and Speed KPI was >= 10 for more than 1 minute. pump_8 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 17, 7, 'Pressure KPI was below the expected value (7) and Torque KPI was >= 4 for more than 1 minute. sensor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 56, 7, 'Torque KPI was below the expected value (2) and Temperature KPI was >= 5 for more than 1 minute. gear_27 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 4, 1, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 4 for more than 1 minute. gear_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 80, 5, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 4 for more than 1 minute. valve_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 64, 2, 'Speed KPI was below the expected value (8) and PowerConsumption KPI was >= 4 for more than 1 minute. valve_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 69, 9, 'Torque KPI was below the expected value (5) and PowerConsumption KPI was >= 2 for more than 1 minute. gear_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 26, 2, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 7 for more than 1 minute. motor_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 11, 1, 'Speed KPI was below the expected value (8) and Torque KPI was >= 7 for more than 1 minute. motor_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 88, 9, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 6 for more than 1 minute. gear_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 71, 8, 'Speed KPI was below the expected value (7) and Temperature KPI was >= 7 for more than 1 minute. pump_76 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 51, 7, 'Torque KPI was below the expected value (2) and Temperature KPI was >= 7 for more than 1 minute. pump_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 47, 10, 'Pressure KPI was below the expected value (7) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_46 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 76, 7, 'Pressure KPI was below the expected value (6) and PowerConsumption KPI was >= 6 for more than 1 minute. valve_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 57, 4, 'Pressure KPI was below the expected value (8) and Temperature KPI was >= 3 for more than 1 minute. motor_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 38, 3, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 1 for more than 1 minute. pump_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 80, 2, 'Speed KPI was below the expected value (7) and PowerConsumption KPI was >= 1 for more than 1 minute. valve_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 18, 3, 'Pressure KPI was below the expected value (10) and PowerConsumption KPI was >= 2 for more than 1 minute. sensor_85 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 74, 10, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 1 for more than 1 minute. gear_38 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 17, 9, 'Pressure KPI was below the expected value (4) and PowerConsumption KPI was >= 10 for more than 1 minute. motor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 61, 5, 'Temperature KPI was below the expected value (2) and Pressure KPI was >= 2 for more than 1 minute. motor_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 19, 4, 'Speed KPI was below the expected value (3) and PowerConsumption KPI was >= 10 for more than 1 minute. pump_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 6, 7, 'Torque KPI was below the expected value (9) and PowerConsumption KPI was >= 1 for more than 1 minute. motor_96 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 76, 3, 'Pressure KPI was below the expected value (8) and Torque KPI was >= 9 for more than 1 minute. pump_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 68, 7, 'Torque KPI was below the expected value (8) and Speed KPI was >= 3 for more than 1 minute. motor_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 54, 8, 'PowerConsumption KPI was below the expected value (8) and Pressure KPI was >= 2 for more than 1 minute. motor_89 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 76, 10, 'PowerConsumption KPI was below the expected value (2) and Torque KPI was >= 8 for more than 1 minute. pump_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 88, 1, 'Speed KPI was below the expected value (2) and PowerConsumption KPI was >= 2 for more than 1 minute. sensor_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 51, 4, 'Speed KPI was below the expected value (6) and Torque KPI was >= 10 for more than 1 minute. valve_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 58, 7, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 9 for more than 1 minute. motor_86 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 60, 3, 'Pressure KPI was below the expected value (7) and Speed KPI was >= 4 for more than 1 minute. motor_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 63, 6, 'Torque KPI was below the expected value (10) and PowerConsumption KPI was >= 10 for more than 1 minute. motor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 36, 6, 'Temperature KPI was below the expected value (1) and Speed KPI was >= 4 for more than 1 minute. pump_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 86, 1, 'Speed KPI was below the expected value (6) and PowerConsumption KPI was >= 4 for more than 1 minute. valve_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 1, 9, 'Speed KPI was below the expected value (5) and Torque KPI was >= 5 for more than 1 minute. sensor_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 87, 5, 'Speed KPI was below the expected value (6) and PowerConsumption KPI was >= 6 for more than 1 minute. sensor_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 27, 4, 'Temperature KPI was below the expected value (4) and Speed KPI was >= 9 for more than 1 minute. sensor_80 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 91, 9, 'Torque KPI was below the expected value (2) and Speed KPI was >= 6 for more than 1 minute. valve_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 10, 9, 'Temperature KPI was below the expected value (8) and Speed KPI was >= 2 for more than 1 minute. gear_6 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 52, 4, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 7 for more than 1 minute. gear_90 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 84, 9, 'Torque KPI was below the expected value (8) and Speed KPI was >= 4 for more than 1 minute. valve_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 88, 4, 'Torque KPI was below the expected value (6) and PowerConsumption KPI was >= 2 for more than 1 minute. valve_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 33, 5, 'Torque KPI was below the expected value (2) and Temperature KPI was >= 5 for more than 1 minute. gear_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 54, 7, 'PowerConsumption KPI was below the expected value (5) and Torque KPI was >= 7 for more than 1 minute. motor_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 49, 1, 'Temperature KPI was below the expected value (8) and Pressure KPI was >= 7 for more than 1 minute. valve_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 88, 6, 'Torque KPI was below the expected value (7) and Speed KPI was >= 10 for more than 1 minute. valve_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 6, 5, 'Speed KPI was below the expected value (5) and Pressure KPI was >= 7 for more than 1 minute. gear_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 37, 8, 'Pressure KPI was below the expected value (3) and Torque KPI was >= 10 for more than 1 minute. motor_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 22, 7, 'Speed KPI was below the expected value (1) and PowerConsumption KPI was >= 3 for more than 1 minute. pump_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 80, 10, 'Torque KPI was below the expected value (1) and Temperature KPI was >= 5 for more than 1 minute. motor_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 12, 3, 'Speed KPI was below the expected value (5) and PowerConsumption KPI was >= 7 for more than 1 minute. pump_91 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 15, 9, 'Temperature KPI was below the expected value (2) and Pressure KPI was >= 4 for more than 1 minute. valve_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 100, 6, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 9 for more than 1 minute. valve_84 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 67, 5, 'Temperature KPI was below the expected value (1) and PowerConsumption KPI was >= 2 for more than 1 minute. valve_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 68, 2, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_66 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 43, 3, 'Torque KPI was below the expected value (4) and Speed KPI was >= 1 for more than 1 minute. sensor_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 5, 8, 'Temperature KPI was below the expected value (7) and Pressure KPI was >= 2 for more than 1 minute. motor_92 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 12, 9, 'PowerConsumption KPI was below the expected value (8) and Temperature KPI was >= 1 for more than 1 minute. motor_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 63, 2, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 5 for more than 1 minute. gear_43 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 86, 8, 'Temperature KPI was below the expected value (1) and Pressure KPI was >= 1 for more than 1 minute. gear_1 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 21, 3, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 9 for more than 1 minute. pump_32 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 99, 5, 'PowerConsumption KPI was below the expected value (8) and Speed KPI was >= 8 for more than 1 minute. motor_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 71, 8, 'PowerConsumption KPI was below the expected value (2) and Torque KPI was >= 4 for more than 1 minute. pump_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 10, 3, 'Torque KPI was below the expected value (1) and Temperature KPI was >= 7 for more than 1 minute. valve_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 32, 4, 'Pressure KPI was below the expected value (5) and Speed KPI was >= 1 for more than 1 minute. gear_69 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 35, 10, 'Pressure KPI was below the expected value (10) and Torque KPI was >= 6 for more than 1 minute. pump_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 41, 8, 'PowerConsumption KPI was below the expected value (6) and Torque KPI was >= 3 for more than 1 minute. pump_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 58, 4, 'Temperature KPI was below the expected value (1) and Torque KPI was >= 9 for more than 1 minute. valve_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 5, 4, 'PowerConsumption KPI was below the expected value (9) and Speed KPI was >= 5 for more than 1 minute. gear_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 68, 2, 'Speed KPI was below the expected value (9) and Torque KPI was >= 1 for more than 1 minute. gear_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 34, 6, 'Speed KPI was below the expected value (7) and Temperature KPI was >= 5 for more than 1 minute. pump_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 43, 5, 'Pressure KPI was below the expected value (7) and Speed KPI was >= 7 for more than 1 minute. motor_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 82, 6, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 9 for more than 1 minute. gear_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 95, 3, 'Torque KPI was below the expected value (7) and Speed KPI was >= 9 for more than 1 minute. sensor_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 39, 3, 'PowerConsumption KPI was below the expected value (2) and Temperature KPI was >= 7 for more than 1 minute. motor_71 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 16, 8, 'Torque KPI was below the expected value (1) and Pressure KPI was >= 2 for more than 1 minute. motor_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 15, 2, 'Speed KPI was below the expected value (6) and Pressure KPI was >= 3 for more than 1 minute. sensor_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 77, 3, 'Temperature KPI was below the expected value (7) and PowerConsumption KPI was >= 2 for more than 1 minute. sensor_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 18, 7, 'PowerConsumption KPI was below the expected value (2) and Pressure KPI was >= 1 for more than 1 minute. sensor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 27, 2, 'Speed KPI was below the expected value (3) and Pressure KPI was >= 5 for more than 1 minute. pump_62 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 40, 7, 'Temperature KPI was below the expected value (3) and Speed KPI was >= 4 for more than 1 minute. valve_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 31, 7, 'Temperature KPI was below the expected value (5) and Pressure KPI was >= 1 for more than 1 minute. sensor_36 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 8, 7, 'Torque KPI was below the expected value (5) and Pressure KPI was >= 9 for more than 1 minute. gear_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 96, 5, 'Speed KPI was below the expected value (3) and Torque KPI was >= 4 for more than 1 minute. pump_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 55, 5, 'Temperature KPI was below the expected value (3) and PowerConsumption KPI was >= 2 for more than 1 minute. motor_88 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 90, 4, 'Pressure KPI was below the expected value (3) and Speed KPI was >= 9 for more than 1 minute. motor_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 14, 4, 'Speed KPI was below the expected value (4) and PowerConsumption KPI was >= 5 for more than 1 minute. valve_60 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 52, 3, 'Torque KPI was below the expected value (8) and Speed KPI was >= 2 for more than 1 minute. gear_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 52, 10, 'Temperature KPI was below the expected value (6) and PowerConsumption KPI was >= 5 for more than 1 minute. valve_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 24, 3, 'PowerConsumption KPI was below the expected value (1) and Pressure KPI was >= 7 for more than 1 minute. motor_28 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 16, 6, 'PowerConsumption KPI was below the expected value (9) and Speed KPI was >= 5 for more than 1 minute. gear_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 73, 8, 'Speed KPI was below the expected value (10) and PowerConsumption KPI was >= 7 for more than 1 minute. gear_52 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 56, 1, 'PowerConsumption KPI was below the expected value (10) and Speed KPI was >= 8 for more than 1 minute. valve_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 25, 9, 'Torque KPI was below the expected value (6) and Speed KPI was >= 6 for more than 1 minute. pump_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 33, 8, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 8 for more than 1 minute. gear_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 26, 9, 'Speed KPI was below the expected value (9) and Torque KPI was >= 4 for more than 1 minute. sensor_56 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 18, 6, 'Torque KPI was below the expected value (3) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 66, 4, 'Temperature KPI was below the expected value (4) and PowerConsumption KPI was >= 5 for more than 1 minute. gear_70 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 27, 10, 'PowerConsumption KPI was below the expected value (9) and Pressure KPI was >= 5 for more than 1 minute. pump_9 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 81, 10, 'Pressure KPI was below the expected value (7) and PowerConsumption KPI was >= 3 for more than 1 minute. motor_81 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 40, 4, 'Pressure KPI was below the expected value (3) and PowerConsumption KPI was >= 8 for more than 1 minute. valve_36 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 64, 3, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 9 for more than 1 minute. gear_66 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 60, 1, 'Pressure KPI was below the expected value (5) and PowerConsumption KPI was >= 6 for more than 1 minute. sensor_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 24, 8, 'Torque KPI was below the expected value (2) and Pressure KPI was >= 10 for more than 1 minute. sensor_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 91, 5, 'Temperature KPI was below the expected value (3) and Speed KPI was >= 9 for more than 1 minute. gear_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 79, 10, 'Speed KPI was below the expected value (6) and Temperature KPI was >= 6 for more than 1 minute. valve_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 86, 9, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 8 for more than 1 minute. pump_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 4, 9, 'Torque KPI was below the expected value (6) and PowerConsumption KPI was >= 7 for more than 1 minute. sensor_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 15, 4, 'Torque KPI was below the expected value (8) and Speed KPI was >= 9 for more than 1 minute. motor_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 82, 8, 'PowerConsumption KPI was below the expected value (6) and Temperature KPI was >= 10 for more than 1 minute. pump_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 86, 9, 'Speed KPI was below the expected value (4) and PowerConsumption KPI was >= 6 for more than 1 minute. motor_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 94, 8, 'Speed KPI was below the expected value (8) and Temperature KPI was >= 4 for more than 1 minute. sensor_14 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 55, 6, 'Speed KPI was below the expected value (5) and Temperature KPI was >= 4 for more than 1 minute. pump_57 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 21, 8, 'Pressure KPI was below the expected value (4) and Temperature KPI was >= 7 for more than 1 minute. gear_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 9, 9, 'Speed KPI was below the expected value (4) and Torque KPI was >= 5 for more than 1 minute. pump_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 5, 5, 'Torque KPI was below the expected value (4) and Pressure KPI was >= 1 for more than 1 minute. pump_19 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 65, 4, 'Temperature KPI was below the expected value (9) and Pressure KPI was >= 1 for more than 1 minute. valve_5 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 43, 3, 'PowerConsumption KPI was below the expected value (8) and Speed KPI was >= 8 for more than 1 minute. motor_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 52, 3, 'Speed KPI was below the expected value (7) and Pressure KPI was >= 10 for more than 1 minute. valve_83 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 9, 6, 'Temperature KPI was below the expected value (8) and Pressure KPI was >= 10 for more than 1 minute. pump_45 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 22, 4, 'Torque KPI was below the expected value (3) and Speed KPI was >= 6 for more than 1 minute. sensor_49 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 67, 10, 'Torque KPI was below the expected value (1) and PowerConsumption KPI was >= 10 for more than 1 minute. gear_62 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 63, 8, 'Torque KPI was below the expected value (2) and Temperature KPI was >= 9 for more than 1 minute. pump_11 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 16, 7, 'Speed KPI was below the expected value (7) and Torque KPI was >= 5 for more than 1 minute. valve_28 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 43, 8, 'Pressure KPI was below the expected value (8) and Speed KPI was >= 6 for more than 1 minute. valve_36 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 67, 4, 'Speed KPI was below the expected value (2) and Torque KPI was >= 9 for more than 1 minute. valve_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 62, 6, 'Temperature KPI was below the expected value (1) and Speed KPI was >= 1 for more than 1 minute. gear_15 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 5, 6, 'Temperature KPI was below the expected value (10) and Pressure KPI was >= 8 for more than 1 minute. valve_33 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 14, 9, 'Speed KPI was below the expected value (10) and Torque KPI was >= 8 for more than 1 minute. motor_48 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 15, 4, 'Temperature KPI was below the expected value (3) and Speed KPI was >= 4 for more than 1 minute. valve_13 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 100, 2, 'Pressure KPI was below the expected value (10) and PowerConsumption KPI was >= 2 for more than 1 minute. motor_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 31, 5, 'Temperature KPI was below the expected value (5) and PowerConsumption KPI was >= 8 for more than 1 minute. motor_2 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 43, 3, 'Torque KPI was below the expected value (4) and Pressure KPI was >= 1 for more than 1 minute. sensor_61 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 92, 3, 'Pressure KPI was below the expected value (1) and Speed KPI was >= 2 for more than 1 minute. sensor_82 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 65, 7, 'Pressure KPI was below the expected value (2) and Temperature KPI was >= 4 for more than 1 minute. gear_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 38, 2, 'Pressure KPI was below the expected value (2) and Temperature KPI was >= 10 for more than 1 minute. sensor_11 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 12, 2, 'Torque KPI was below the expected value (2) and PowerConsumption KPI was >= 2 for more than 1 minute. motor_97 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 77, 1, 'PowerConsumption KPI was below the expected value (1) and Pressure KPI was >= 9 for more than 1 minute. motor_78 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 49, 2, 'PowerConsumption KPI was below the expected value (10) and Pressure KPI was >= 6 for more than 1 minute. sensor_39 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 52, 1, 'Speed KPI was below the expected value (7) and Torque KPI was >= 5 for more than 1 minute. pump_26 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 79, 6, 'Speed KPI was below the expected value (6) and PowerConsumption KPI was >= 2 for more than 1 minute. motor_93 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 63, 3, 'Torque KPI was below the expected value (4) and Speed KPI was >= 1 for more than 1 minute. pump_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 39, 5, 'PowerConsumption KPI was below the expected value (7) and Temperature KPI was >= 9 for more than 1 minute. motor_17 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 47, 10, 'PowerConsumption KPI was below the expected value (6) and Pressure KPI was >= 5 for more than 1 minute. valve_65 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 51, 3, 'Torque KPI was below the expected value (5) and Pressure KPI was >= 8 for more than 1 minute. motor_37 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 75, 7, 'Speed KPI was below the expected value (7) and Torque KPI was >= 9 for more than 1 minute. sensor_53 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 51, 1, 'Pressure KPI was below the expected value (1) and Temperature KPI was >= 1 for more than 1 minute. gear_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 97, 10, 'PowerConsumption KPI was below the expected value (8) and Torque KPI was >= 10 for more than 1 minute. motor_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 65, 2, 'Speed KPI was below the expected value (6) and Temperature KPI was >= 2 for more than 1 minute. motor_64 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 97, 5, 'Torque KPI was below the expected value (4) and PowerConsumption KPI was >= 5 for more than 1 minute. pump_79 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 34, 9, 'Pressure KPI was below the expected value (5) and Speed KPI was >= 4 for more than 1 minute. sensor_22 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 98, 2, 'Pressure KPI was below the expected value (9) and Torque KPI was >= 3 for more than 1 minute. valve_40 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 76, 10, 'Pressure KPI was below the expected value (7) and Temperature KPI was >= 7 for more than 1 minute. motor_31 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 6, 10, 'Speed KPI was below the expected value (8) and Temperature KPI was >= 7 for more than 1 minute. sensor_16 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 53, 8, 'Pressure KPI was below the expected value (7) and Speed KPI was >= 9 for more than 1 minute. motor_7 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 97, 6, 'Pressure KPI was below the expected value (2) and PowerConsumption KPI was >= 1 for more than 1 minute. valve_54 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 1, 30, 3, 'Speed KPI was below the expected value (1) and Temperature KPI was >= 5 for more than 1 minute. pump_100 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 1, 8, 'Torque KPI was below the expected value (10) and Pressure KPI was >= 1 for more than 1 minute. sensor_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 24, 6, 'Speed KPI was below the expected value (4) and PowerConsumption KPI was >= 6 for more than 1 minute. pump_26 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 35, 10, 'Speed KPI was below the expected value (9) and PowerConsumption KPI was >= 2 for more than 1 minute. valve_24 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 56, 5, 'Torque KPI was below the expected value (8) and Pressure KPI was >= 6 for more than 1 minute. motor_59 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 99, 1, 'PowerConsumption KPI was below the expected value (9) and Torque KPI was >= 3 for more than 1 minute. pump_72 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 71, 5, 'Torque KPI was below the expected value (1) and Temperature KPI was >= 7 for more than 1 minute. pump_25 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 5, 9, 'Torque KPI was below the expected value (2) and Pressure KPI was >= 10 for more than 1 minute. pump_4 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 78, 10, 'Pressure KPI was below the expected value (6) and PowerConsumption KPI was >= 2 for more than 1 minute. sensor_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 96, 4, 'Speed KPI was below the expected value (8) and Pressure KPI was >= 8 for more than 1 minute. motor_34 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 89, 2, 'Torque KPI was below the expected value (6) and Speed KPI was >= 1 for more than 1 minute. motor_3 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 2, 5, 'Temperature KPI was below the expected value (4) and Torque KPI was >= 3 for more than 1 minute. gear_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 73, 4, 'Temperature KPI was below the expected value (2) and Speed KPI was >= 1 for more than 1 minute. motor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 76, 6, 'Torque KPI was below the expected value (6) and Speed KPI was >= 5 for more than 1 minute. motor_44 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 45, 3, 'Temperature KPI was below the expected value (5) and Pressure KPI was >= 4 for more than 1 minute. motor_82 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 77, 7, 'Pressure KPI was below the expected value (8) and PowerConsumption KPI was >= 8 for more than 1 minute. gear_63 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 100, 1, 'PowerConsumption KPI was below the expected value (3) and Torque KPI was >= 1 for more than 1 minute. pump_100 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 33, 10, 'Speed KPI was below the expected value (9) and Pressure KPI was >= 1 for more than 1 minute. sensor_99 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 54, 7, 'PowerConsumption KPI was below the expected value (5) and Speed KPI was >= 1 for more than 1 minute. motor_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 5, 94, 10, 'Speed KPI was below the expected value (8) and Temperature KPI was >= 7 for more than 1 minute. motor_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 39, 7, 'Torque KPI was below the expected value (3) and Pressure KPI was >= 8 for more than 1 minute. motor_29 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 68, 10, 'Speed KPI was below the expected value (6) and Torque KPI was >= 10 for more than 1 minute. pump_18 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 44, 8, 'PowerConsumption KPI was below the expected value (4) and Temperature KPI was >= 9 for more than 1 minute. sensor_51 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 4, 1, 'PowerConsumption KPI was below the expected value (4) and Torque KPI was >= 9 for more than 1 minute. motor_10 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 68, 2, 'Torque KPI was below the expected value (7) and Temperature KPI was >= 1 for more than 1 minute. pump_20 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 36, 7, 'Torque KPI was below the expected value (3) and Temperature KPI was >= 7 for more than 1 minute. motor_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 7, 72, 10, 'PowerConsumption KPI was below the expected value (4) and Pressure KPI was >= 8 for more than 1 minute. valve_55 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 4, 9, 'PowerConsumption KPI was below the expected value (9) and Temperature KPI was >= 1 for more than 1 minute. valve_21 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 2, 62, 6, 'Temperature KPI was below the expected value (6) and Pressure KPI was >= 3 for more than 1 minute. sensor_58 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 97, 6, 'Torque KPI was below the expected value (7) and Pressure KPI was >= 10 for more than 1 minute. gear_12 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 10, 49, 5, 'PowerConsumption KPI was below the expected value (3) and Pressure KPI was >= 2 for more than 1 minute. pump_98 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 3, 89, 4, 'Pressure KPI was below the expected value (10) and Speed KPI was >= 4 for more than 1 minute. pump_95 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 8, 81, 2, 'Torque KPI was below the expected value (2) and Speed KPI was >= 7 for more than 1 minute. sensor_6 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 4, 4, 2, 'Torque KPI was below the expected value (10) and PowerConsumption KPI was >= 7 for more than 1 minute. pump_42 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 6, 25, 1, 'Speed KPI was below the expected value (3) and Temperature KPI was >= 2 for more than 1 minute. sensor_50 was changed and KPIs returned to expected values.', '', '');

INSERT INTO ErrorHistory (EventId, ErrorStart, ErrorEnd, PlantId, MachineryId, ErrorNumber, Notes, Description, Solution)
VALUES (NEWID(), @ErrorStart, @ErrorEnd, 9, 42, 2, 'Torque KPI was below the expected value (2) and Pressure KPI was >= 6 for more than 1 minute. gear_53 was changed and KPIs returned to expected values.', '', '');

--This update the time frame
UPDATE ErrorHistory
SET ErrorStart = DATEADD(second, ABS(CHECKSUM(NEWID())) % DATEDIFF(second, '2025-01-01', GETDATE()), '2025-01-01');

UPDATE ErrorHistory
SET ErrorEnd = DATEADD(second, ABS(CHECKSUM(NEWID())) % DATEDIFF(second, ErrorStart, GETDATE()), ErrorStart);

