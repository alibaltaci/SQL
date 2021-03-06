--- �RNEK 2 ---

--EN �OK SATI� YAPILAN M��ER�LER.

SELECT U.NAMESURNAME ADSOYAD, COUNT(BD.ID) ALISVERISSAYISI, 
SUM(BD.AMOUNT) URUNSAYISI, SUM(TOTAL) TOPLAMTUTAR
FROM USER_ U
JOIN BASKET B ON B.USERID=U.ID
JOIN BASKETDETAIL BD ON BD.BASKETID=B.ID
JOIN ORDER_ O ON O.BASKETID=B.ID
JOIN ADDRES A ON A.ID=O.ADDRESSID
JOIN CITY C ON C.ID=A.CITYID
JOIN TOWN T ON T.ID=A.TOWNID
JOIN DISTRICT D ON D.ID=A.DISTRICTID
JOIN INVOICE INV ON INV.ORDERID=O.ID
GROUP BY  U.NAMESURNAME 
ORDER BY SUM(TOTAL) DESC


--�at�� say�m�z� 1000 e ��kartal�m.
--Sat�� olu�turma tablosu ile...

--1000 Sat��a ��kar�ld�.

--Yani durumda en �ok sat� yapan 10 m��teri.

SELECT TOP 10 U.NAMESURNAME ADSOYAD, COUNT(BD.ID) ALISVERISSAYISI, 
SUM(BD.AMOUNT) URUNSAYISI, SUM(TOTAL) TOPLAMTUTAR
FROM USER_ U
JOIN BASKET B ON B.USERID=U.ID
JOIN BASKETDETAIL BD ON BD.BASKETID=B.ID
JOIN ORDER_ O ON O.BASKETID=B.ID
JOIN ADDRES A ON A.ID=O.ADDRESSID
JOIN CITY C ON C.ID=A.CITYID
JOIN TOWN T ON T.ID=A.TOWNID
JOIN DISTRICT D ON D.ID=A.DISTRICTID
JOIN INVOICE INV ON INV.ORDERID=O.ID
GROUP BY  U.NAMESURNAME 
ORDER BY SUM(TOTAL) DESC





--- �RNEK 3 ---

--EN �OK SATI� YAPILAN �R�N KATEGOR�LER�.

SELECT I.CATEGORY1, SUM(OD.TOTALPRICE) TOPLAMTUTAR
FROM ITEM I
JOIN ORDERDETAIL OD ON OD.ITEMID=I.ID
JOIN ORDER_ O ON O.ID=OD.ORDERID
GROUP BY I.CATEGORY1
ORDER BY 2 DESC

--CATEGORY1 de bulunan "elektronik-gida-disi" n�n CATEGORY2 de bulunan alt 
--�r�nlerine bir bakal�m ve bunlar� s�ralayal�m.

SELECT I.CATEGORY1, I.CATEGORY2, SUM(OD.TOTALPRICE) TOTAL
FROM ITEM I
JOIN ORDERDETAIL OD ON OD.ITEMID=I.ID
JOIN ORDER_ O ON O.ID=OD.ORDERID
WHERE I.CATEGORY1 = 'elektronik-gida-disi'
GROUP BY I.CATEGORY1, I.CATEGORY2
ORDER BY 3 DESC 




--- �RNEK 3 ---

--OCAK 2018 (2021) DE B�ZDEN ALI�VER�� YAPAN KADIN VE ERKEK M��TER�LER

SELECT U.GENDER, SUM(BD.TOTAL) TOTAL
FROM USER_ U
JOIN BASKET B ON B.USERID=U.ID
JOIN BASKETDETAIL BD ON BD.BASKETID=B.ID
WHERE B.CREATEDDATE BETWEEN '20210101' AND '20210131'
GROUP BY U.GENDER