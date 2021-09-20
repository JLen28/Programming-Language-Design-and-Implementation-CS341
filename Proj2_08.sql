SELECT Nam as Name,ROUND(PreCOVIDAvg) AS PreCOVIDAvg,ROUND(PostCOVIDAvg) AS PostCOVIDAvg, ROUND(PreCOVIDAvg - PostCOVIDAvg) as Decrease, ROUND((PreCOVIDAvg - PostCOVIDAvg) / (PreCOVIDAvg) * 100,2) as PercentDrop
FROM ( SELECT Stations.Name AS Nam, Stations.StationID as ID2, AVG(DailyTotal) as PreCOVIDAvg
	   FROM LineColors
       INNER JOIN StopDetails ON StopDetails.LineID = 2
	   INNER JOIN Stops ON StopDetails.StopID = Stops.StopID
       INNER JOIN Stations ON Stops.StationID = Stations.StationID
       INNER JOIN Riderships ON Stops.StationID = Riderships.StationID
       WHERE Riderships.TheDate < '2020-03-1'
       GROUP BY Stations.StationID
       ) AS q1
 JOIN (SELECT Stations.Name AS Nam2,Stations.StationID AS ID, AVG(DailyTotal) as PostCOVIDAvg
	   FROM LineColors
       INNER JOIN StopDetails ON StopDetails.LineID = 2
	   INNER JOIN Stops ON StopDetails.StopID = Stops.StopID
       INNER JOIN Stations ON Stops.StationID = Stations.StationID
       INNER JOIN Riderships ON Stops.StationID = Riderships.StationID
       WHERE Riderships.TheDate >= '2020-03-1'
       GROUP BY Stations.StationID
	) AS q2
	ON q1.ID2 = q2.ID