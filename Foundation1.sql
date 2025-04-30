
SELECT 
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.DischargeDate
    ,DATEDIFF (DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay
    ,DATEADD (DAY, -14, ps.AdmittedDate) AS ReminderDate
    -- could also be DATEADD (WEEK, -2, ps.AdmittedDate) AS ReminderDate
    ,ps.Hospital
    ,ps.Ward
    ,ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ('PRUH','Oxleas')
AND ps.Ward LIKE '%Surgery'
-- AND ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'
ORDER BY ps.AdmittedDate DESC, ps.PatientId DESC


SELECT 
    ps.Hospital
    ,ps.Ward
    ,COUNT(*) as CountOfPatients 
    ,SUM(ps.Tariff) AS TotalTariff 
    ,AVG(ps.Tariff) AS AverageTariff
    ,MAX(ps.Tariff) AS HighestTariff
    ,MIN(ps.Tariff) AS LowestTariff   
FROM PatientStay ps
GROUP BY ps.Hospital, ps.Ward
--ORDER BY ps.Hospital, ps.Ward
ORDER BY CountOfPatients DESC


SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    ,dh.HospitalType
    ,dh.HospitalSize
FROM
    PatientStay ps LEFT JOIN DimHospitalBad dh ON ps.Hospital = dh.Hospital
-- Using a LEFT JOIN tells SQL to return all the rows in the first/left table, regardless of if they have a matching value in the second/right table
WHERE dh.Hospital IS NULL
-- can use IS NULL to check whether there are any missing fields on the second/right table (handy to check that a lookup covers everything in your original table)

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    ,dh.HospitalType
    ,dh.HospitalSize
FROM
    PatientStay ps INNER JOIN DimHospital dh ON ps.Hospital = dh.Hospital
