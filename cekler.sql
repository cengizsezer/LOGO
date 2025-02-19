SELECT LG_181_CLCARD_2.CODE AS KİMDEN, 
C.DOC AS [çek 1 senet 2], 
C.BANKNAME AS BANKA, 
Substring(C.BNBRANCHNO, 6, 12) AS ŞUBE, 
C.NEWSERINO AS [Seri No], 
Substring(CONVERT(varchar(10), C.DUEDATE, 103), 7, 4) + Substring(CONVERT(varchar(10), C.DUEDATE, 103), 4, 2) + Substring(CONVERT(varchar(10), C.DUEDATE, 103), 1, 2) AS vadesi, 
C.AMOUNT AS Tutar, 
CASE CURRSTAT 
	WHEN 1 THEN 'Portföyde' 
	WHEN 2 THEN 'Ciro Edildi' 
	WHEN 3 THEN 'Teminata Verildi' 
	WHEN 4 THEN 'Tahsile Verildi' 
	WHEN 5 THEN 'Protestolu Tahsile Verildi' 
	WHEN 6 THEN 'İade Edildi' 
	WHEN 7 THEN 'Protesto Edildi' 
	WHEN 8 THEN 'Tahsil Edildi' 
	WHEN 9 THEN 'Kendi Çekimiz' 
	WHEN 10 THEN 'Borç Senedimiz' 
	WHEN 11 THEN 'Karşılığı Yok' 
	WHEN 12 THEN 'Tahsil Edilemiyor' 
	ELSE 'Ne Oldugu Belirsiz' 
END 
AS DURUMU, 
C.OWING AS [CİRO EDEN], 
C.DUEDATE AS Vade, 
LG_181_01_CSROLL.ROLLNO, 
(
	SELECT DEFINITION_ FROM   LG_181_CLCARD AS LG_181_CLCARD_1 
	WHERE  ( 
		LOGICALREF IN (SELECT CARDREF FROM LG_181_01_CSTRANS AS LG_181_01_CSTRANS_1 WHERE ( CSREF = C.LOGICALREF ) AND ( TRCODE = 3 )) 
	)
)  AS [CİRO EDİLEN], 
LG_181_01_CSTRANS_2.CARDREF, 
LG_181_BANKACC.CODE 
BANKA 
FROM   LG_181_01_CSCARD AS C 
INNER JOIN dbo.LG_181_CLCARD AS LG_181_CLCARD_2 
INNER JOIN dbo.LG_181_01_CSROLL ON LG_181_CLCARD_2.LOGICALREF = dbo.LG_181_01_CSROLL.CARDREF 
INNER JOIN dbo.LG_181_01_CSTRANS AS LG_181_01_CSTRANS_2 ON dbo.LG_181_01_CSROLL.LOGICALREF = LG_181_01_CSTRANS_2.ROLLREF ON C.LOGICALREF = LG_181_01_CSTRANS_2.CSREF 
INNER JOIN LG_181_BANKACC ON LG_181_BANKACC.LOGICALREF = LG_181_01_CSTRANS_2.CARDREF 
WHERE  ( dbo.LG_181_01_CSROLL.TRCODE IN ( 05, 06, 07, 08 ) ) 
AND CURRSTAT = 4 

UNION ALL 

SELECT 
LG_181_CLCARD_2.CODE AS KİMDEN, 
C.DOC AS [çek 1 senet 2], 
C.BANKNAME AS BANKA, 
Substring(C.BNBRANCHNO, 6, 12) AS ŞUBE, 
C.NEWSERINO AS [Seri No], 
Substring(CONVERT(varchar(10), C.DUEDATE, 103), 7, 4) + Substring(CONVERT(varchar(10), C.DUEDATE, 103), 4, 2) + Substring(CONVERT(varchar(10), C.DUEDATE, 103), 1, 2) AS vadesi, 
C.AMOUNT AS Tutar, 
CASE CURRSTAT 
	WHEN 1 THEN 'Portföyde' 
	WHEN 2 THEN 'Ciro Edildi' 
	WHEN 3 THEN 'Teminata Verildi' 
	WHEN 4 THEN 'Tahsile Verildi' 
	WHEN 5 THEN 'Protestolu Tahsile Verildi' 
	WHEN 6 THEN 'İade Edildi' 
	WHEN 7 THEN 'Protesto Edildi' 
	WHEN 8 THEN 'Tahsil Edildi' 
	WHEN 9 THEN 'Kendi Çekimiz' 
	WHEN 10 THEN 'Borç Senedimiz' 
	WHEN 11 THEN 'Karşılığı Yok' 
	WHEN 12 THEN 'Tahsil Edilemiyor' 
	ELSE 'Ne Oldugu Belirsiz' 
END 
AS DURUMU, 
C.OWING AS [CİRO EDEN], 
C.DUEDATE AS Vade, 
LG_181_01_CSROLL.ROLLNO, 
(
	SELECT DEFINITION_ 
	FROM   LG_181_CLCARD AS LG_181_CLCARD_1 
	WHERE  ( LOGICALREF IN (SELECT CARDREF FROM LG_181_01_CSTRANS AS LG_181_01_CSTRANS_1 WHERE ( CSREF = C.LOGICALREF ) AND ( TRCODE = 3 )) )
)  AS [CİRO EDİLEN], 
'', 
'' 
FROM   LG_181_01_CSCARD AS C 
INNER JOIN dbo.LG_181_CLCARD AS LG_181_CLCARD_2 
INNER JOIN dbo.LG_181_01_CSROLL ON LG_181_CLCARD_2.LOGICALREF = dbo.LG_181_01_CSROLL.CARDREF 
INNER JOIN dbo.LG_181_01_CSTRANS AS LG_181_01_CSTRANS_2 ON dbo.LG_181_01_CSROLL.LOGICALREF = LG_181_01_CSTRANS_2.ROLLREF ON C.LOGICALREF = LG_181_01_CSTRANS_2.CSREF 
where  currstat = 1 
