Create nonclustered index TeamName_Index
on Teams(TeamName)

Create nonclustered index AwayTeamID_Index
on  Matches(AwayTeamID)

Create nonclustered index HomeTeamID_Index
on Matches (HomeTeamID)

Create nonclustered index name_Index
on Players ([name])

Create nonclustered index TransferFee_Index
on PlayerTransfers (TransferFee)
-----------------------------------------------------

Create partition function f1 (INT)
AS range left for values (50, 100, 150, 210)   --50 and less will start the first partition
Create partition SCHEME s1
AS partition f1
ALL TO ([PRIMARY])


SELECT * INTO PlayerStats_Temp FROM PlayerStats;


drop table PlayerStats;

create TABLE PlayerStats(
    StatID INT,
    PlayerID INT,
    MatchID INT,
    Goals INT,
    Assists INT,
    YellowCards INT,
    RedCards INT,
    MinutesPlayed INT,
    primary (StatID, MatchID)
)
ON s1(MatchID);



/*
INSERT INTO PlayerStats
SELECT * FROM PlayerStats_Temp;


DROP TABLE PlayerStats_Temp;

SELECT * 
FROM PlayerStats
WHERE MatchID BETWEEN 51 AND 100;*/


/*IF EXISTS (SELECT * FROM sys.partition_functions WHERE name = )
BEGIN
    DROP PARTITION FUNCTION YourPartitionFunctionName;


	IF EXISTS (SELECT * FROM sys.schemas WHERE name = )
BEGIN
    
    DROP SCHEMA YourSchemaName*/