--SUBQUERY 

--Bizden al��veri� yapan m��terilerin listesi


SELECT U.NAMESURNAME, COUNT(B.ID)
FROM USER_ U
JOIN BASKET B ON B.USERID=U.ID
GROUP BY U.NAMESURNAME

--Bu �ekilde al��veri� yapm�� m��terilermiz geldi.

--�imdi t�m m��terilerimii getirelim yanlar�nda al��veri� yap�p yapmad�klar� yazs�n.

SELECT U.NAMESURNAME, COUNT(B.ID)
FROM USER_ U
LEFT JOIN BASKET B ON B.USERID=U.ID
GROUP BY U.NAMESURNAME

--Al�� veri� yapanlar�n yanlar�nd bilgi ile birlikte.


SELECT U.NAMESURNAME, COUNT(B.ID)
FROM USER_ U
LEFT JOIN BASKET B ON B.USERID=U.ID
GROUP BY U.NAMESURNAME 
HAVING COUNT(B.ID)>0


--�imdi bunlar� SUBQUERY ile yapal�m.

SELECT U.NAMESURNAME, 
(SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID)
FROM USER_ U

SELECT U.NAMESURNAME, 
(SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID)
FROM USER_ U
WHERE (SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID)>0


--SUBQUERY �LE M��TER� B�LG�S� GET�RME.

--En son sepete ekleme yapt��� tarih.

SELECT ID, NAMESURNAME,
(SELECT MAX(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) LASTBASKETDATE
FROM USER_ U

--NULL gelenler daha �nce hi� al��veri� yapmama�� olanlar.

--Kullan�c� ka� kere sepete ekleme yapm��t�r. 0 dan b�y�k olanlar.

SELECT ID, NAMESURNAME,
(SELECT MAX(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) LASTBASKETDATE,
(SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID) BASKETCOUNT
FROM USER_ U
WHERE (SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID) > 0
ORDER BY 4 DESC


--Yukar�dakiler dahil ilk tarihi de getirelim.

SELECT ID, NAMESURNAME,
(SELECT MAX(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) LASTBASKETDATE,
(SELECT MIN(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) FIRSTBASKETDATE,
(SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID) BASKETCOUNT
FROM USER_ U
WHERE (SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID) > 0
ORDER BY 5 DESC

--Toplam harcamay� da getirelim.

SELECT ID, NAMESURNAME,
(SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID) BASKETCOUNT,
(SELECT MIN(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) FIRSTBASKETDATE,
(SELECT MAX(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) LASTBASKETDATE,
(SELECT SUM(TOTAL) FROM BASKETDETAIL WHERE BASKETID IN (SELECT ID FROM BASKET WHERE USERID=U.ID)) AS TOTAL
FROM USER_ U
WHERE (SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID)>0
ORDER BY 6 DESC


--Toplam ka� �r�n ald���n� da hesaplayal�m.

SELECT ID, NAMESURNAME,
(SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID) BASKETCOUNT,
(SELECT MIN(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) FIRSTBASKETDATE,
(SELECT MAX(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) LASTBASKETDATE,
(SELECT SUM(TOTAL) FROM BASKETDETAIL WHERE BASKETID IN (SELECT ID FROM BASKET WHERE USERID=U.ID)) AS TOTAL,
(SELECT COUNT(*) FROM BASKETDETAIL WHERE BASKETID IN (SELECT ID FROM BASKET WHERE USERID=U.ID)) ITEMCOUNT
FROM USER_ U
WHERE (SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID)>0
ORDER BY 7 DESC


--Ayn� sorgu i�lemini JOIN ile yapal�m.

SELECT U.ID, U.NAMESURNAME, 
COUNT(B.ID) BASKETCOUNT, MIN(B.CREATEDDATE) FIRSTBASKETDATE,
MAX(B.CREATEDDATE) LASTBASKETDATE, SUM(BD.TOTAL) TOTAL, COUNT(BD.ID) ITEMCOUNT
FROM USER_ U
JOIN BASKET B ON B.USERID=U.ID
JOIN BASKETDETAIL BD ON BD.BASKETID=B.ID
GROUP BY U.ID, U.NAMESURNAME



/*
M��TER�N�N SEPET�NE EKLED��� SON �R�N...

Normal JOIN i�lemleri ile bunun getirilebilmesi m�mk�n de�ildir. 
JOIN i�lemleri ile ancak son ekleme tarihine gidilebilmektedir.

Bu sebepten dolay� SUBQUERY kullan�m� ka��n�lmaz hale gelmektedir.
*/

SELECT ID, NAMESURNAME,
(SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID) BASKETCOUNT,
(SELECT MIN(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) FIRSTBASKETDATE,
(SELECT MAX(CREATEDDATE) FROM BASKET WHERE USERID=U.ID) LASTBASKETDATE,
(SELECT SUM(TOTAL) FROM BASKETDETAIL WHERE BASKETID IN (SELECT ID FROM BASKET WHERE USERID=U.ID)) AS TOTAL,
(SELECT COUNT(*) FROM BASKETDETAIL WHERE BASKETID IN (SELECT ID FROM BASKET WHERE USERID=U.ID)) ITEMCOUNT,
(
	SELECT ITEMNAME FROM ITEM WHERE ID IN 
		(
			SELECT TOP 1 ITEMID FROM BASKETDETAIL WHERE BASKETID IN 
				(
					SELECT ID FROM BASKET WHERE USERID=U.ID
				)ORDER BY DATE_ DESC
		)

) LASTITEMNAME

FROM USER_ U
WHERE (SELECT COUNT(*) FROM BASKET WHERE USERID=U.ID)>0



