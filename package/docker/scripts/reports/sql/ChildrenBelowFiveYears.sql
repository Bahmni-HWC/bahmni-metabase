SELECT
    COALESCE(loc.name, 'Visit not started') AS `Location Name`,
    COUNT(*) AS `Patient Count`,
    cast(CONVERT_TZ(pt.date_created,'+00:00','+5:30') AS DATE) AS `Registration Date`
FROM patient pt
JOIN person p ON p.person_id = pt.patient_id
LEFT JOIN visit v ON v.patient_id = pt.patient_id
LEFT JOIN location loc ON v.location_id = loc.location_id
WHERE pt.voided IS FALSE
AND floor(DATEDIFF(NOW(), p.birthdate) / 365) <= 5
GROUP BY `Location Name`;