--�RNEK SATI� DATASI 

--�lk olarak ge�en derste olu�turdu�umuz ETRADE veri taban�n� silelim.
--ETRADE �zerine gidip sa� click dedik ve delete dedik.
--Delete dedikten sonra ��kan tabloda 
--"Close existing connections" 
--se�ene�ni i�aretlemek �nemlidir.

--Databases �zeine gidip "restore database" dedik.
--"Device" se�ene�i se�ildi.
--��kan tabloda "add" dedik.
--"ETRADE.BAK" pathini yap��t�rd�k.
-- OK OK OK OK dedik :)
--Yani database eklenmi� oldu.
--611.000 sat�r...
--Datan�n alanlar� hakk�nda a��klamalar "Alan Listesi" dosyas�nda mevcuttur.



--AGGREGATE FUNCTIONS (SUM, COUNT, MIN, MAX, AVG)

--GENEL KULLANIM:
--SELECT 
--SUM(PRICE9, COUNT(ID), MIN(PRICE), MAX(PRICE), AVG(PRICE)
--FROM TABLOADI

--Tablomuzu �ekelim
SELECT * FROM SALES

--Kocaeli �ubesini �ekileim.
SELECT * FROM SALES WHERE BRANCH = 'KOCAEL� SUBES�'
--14.292 sat�r geldi.

--Kocaeli �ubesinin toplam sat���n� getirelim.
--�ube --> BRANCH
--St�� --> LINENET
SELECT SUM(LINENET) FROM SALES WHERE BRANCH = 'KOCAEL� SUBES�'
--53151,0199999996 
--GELD�.

--T�m sat��lar 
SELECT SUM(LINENET) FROM SALES 
--2282695,56000024

--Manisa �uesinin kazanc�, toplam sat�� miktar�, minimum sat�� ve maximum sat�� 
SELECT SUM(LINENET), COUNT(*), MIN(LINENET), MAX(LINENET) 
FROM SALES 
WHERE BRANCH = 'MAN�SA SUBES�'
-- geldi...

--Yukar�daki tablonun s�tunlar�na bu sefer isim vererek �a��ral�m...
SELECT SUM(LINENET) AS TOPLAMSATIS, COUNT(*) AS SATISMIKTARI, MIN(LINENET) AS MINSATIS,
MAX(LINENET) AS MAXSATIS, AVG(LINENET) AS ORTALAMASATISFIYATI FROM SALES 
WHERE BRANCH='MAN�SA SUBES�'



--GROUP BY KULLANIMI - 1 

--HAVING --> burada kullan�ld�.

--�ubelere g�re group by �ekip yukar�daki bilgileri t�m �ubeler i�in tek bir tabloda alal�m.

SELECT 
BRANCH,
SUM(LINENET) AS TOPLAM_SATIS, COUNT(*) AS SATIS_SAYISI, MIN(LINENET) AS EN_DUSUK_FIYAT,
MAX(LINENET) AS EN_YUKSEK_FIYAT, AVG(LINENET) AS ORTALAMA_SATIS_FIYATI
FROM SALES GROUP BY BRANCH

--�ki yere BRANCH yazmama�z�n sebebi: select isimleri getiriyor, group by da grupluyor.
--select k�sm�na yazmaz isek gruplan�r ama �ube isimleri gelmez.

--�imdi sat�� tutar�na g�re �ubeleri s�ralayal�m

SELECT BRANCH, SUM(LINENET) 
FROM SALES 
GROUP BY BRANCH ORDER BY SUM(LINENET)

--Bu �ekilde azdan �o�a do�ru bir s�ralama yapt� 
--ama biz �oktan ba�layan bir s�ralama istiyoruz.

SELECT BRANCH AS SUBE, SUM(LINENET) AS TOPLAM_SATIS
FROM SALES 
GROUP BY BRANCH ORDER BY SUM(LINENET)DESC

--En �ok sat�� yapan ilk 10 �ubemzi getirelim.

SELECT TOP 10
BRANCH AS SUBE, SUM(LINENET) AS TOPLAM_SATIS 
FROM SALES 
GROUP BY BRANCH ORDER BY SUM(LINENET) DESC --BURAYA "TOPLAM_SATIS" ya da "2" yaz�labilir.

--Toplam sat��� 50.000 den b�y�k ve e�it olan �ubeler �oktan aza s�ralans�n.

SELECT BRANCH AS SUBE, SUM(LINENET) AS TOPLAM_SATIS 
FROM SALES
GROUP BY BRANCH
HAVING SUM(LINENET) >= 50000
ORDER BY 2 DESC

--Burada where kullanam�yoruz.
--Mant���, �imdi burada asl�nda yeni bir de�i�ken t�rettik gibi ve 
--where �art� gidip buradan toplam sat��lara bakm�yor, 
--Where gidip normal sat��lardan buna bak�yor her sat�r i�in.
--Yeni de�i�keni �arta ba�lamak i�in "HAVING" kullan�l�r.



--ORDER BY KULLANIMI - 2 

--Bir ma�azan�n g�n bazl� �at��lar�n� getirelim.
--Subeye g�re s�ralans�n ve �ubeler kendi i�inde en �ok sat�� yap�lan g�ne g�re s�ralans�n.

SELECT BRANCH SUBE, DATE_ TARIH, SUM(LINENET) TOPLAM_SATIS, COUNT(*) SATIS_MIKTARI 
FROM SALES
GROUP BY BRANCH, DATE_
ORDER BY BRANCH, SATIS_MIKTARI DESC

--g�zel oldu.

--NOT: "AS" kullanmadan da isimlendirme yaplabiliyormu�.



--GROUP BY KULLANIMI - 3 

--Bir g�n�n ma�aza bazl� sat�� rakamlar�.

SELECT DATE_ TARIH, BRANCH SUBE, SUM(LINENET) TOPLAM_SATIS, COUNT(*) SATIS_MIKTARI 
FROM SALES 
GROUP BY DATE_, BRANCH
ORDER BY TARIH , TOPLAM_SATIS



--GROUP BY KULLANIMI - 4 

--�r�n kategorilerine g�re sat�� rakamlar�

SELECT CATEGORY_NAME1 KATEGORI1, SUM(LINENET) TOPLAM_SATIS
FROM SALES 
WHERE CATEGORY_NAME1 IS NOT NULL --G�STERMEMES� ���N...
GROUP BY CATEGORY_NAME1
ORDER BY 2 DESC

--Ayn� i�lem i�in marklar� da g�rmek istersek.
SELECT
CATEGORY_NAME1, BRAND, SUM(LINENET)
FROM SALES
WHERE CATEGORY_NAME1 IS NOT NULL
GROUP BY CATEGORY_NAME1, BRAND
ORDER BY 3 DESC

--�r�n markas�na g�re sat��lar.
SELECT BRAND, SUM(LINENET)
FROM SALES
WHERE BRAND IS NOT NULL
GROUP BY BRAND
ORDER BY SUM(LINENET) DESC

--�lkerden en �ok ne sat�yoruz ��renelim.

SELECT BRAND, CATEGORY_NAME1, CATEGORY_NAME2, SUM(LINENET)
FROM SALES 
WHERE BRAND IS NOT NULL AND BRAND='�LKER'
GROUP BY BRAND, CATEGORY_NAME1, CATEGORY_NAME2
ORDER BY 4 DESC 



-- GROUP BY KULLANIMI - 5 

--Ma�azalar�m�z�n m��teri say�s�n� sayd�ral�m...

SELECT BRANCH, COUNT(DISTINCT(CLIENTNAME))
FROM SALES
WHERE BRANCH IS NOT NULL 
GROUP BY BRANCH
ORDER BY COUNT(DISTINCT(CLIENTNAME)) DESC

--1 m��teri farkl� ma�azalardan al��veri� yapm�� olabilir mi?

--Ma�azalar�m�zdaki farkl� m��teri say�lar�n� toplayal�m.
SELECT COUNT(DISTINCT CLIENTNAME)
FROM SALES
--49205 Bu kadar farkl� m��terimiz varm��. 
--Demek ki birden fazla ma�azadan al��veri� yapan m��teriler mevcut.

--�imdi bir m��terinin gitti�i ma�aza say�s�n� bulala�m.
SELECT CLIENTNAME, COUNT(DISTINCT BRANCH)
FROM SALES 
WHERE CLIENTNAME IS NOT NULL
GROUP BY CLIENTNAME
ORDER BY 2 DESC

--10 ve 10 dan fazla ma�azadan al��veri� yapm�� olam m��terileri listeleyelim.
SELECT 
CLIENTNAME, COUNT(DISTINCT BRANCH)
FROM SALES
WHERE CLIENTNAME IS NOT NULL
GROUP BY CLIENTNAME 
HAVING COUNT(DISTINCT BRANCH) >= 10
ORDER BY 2 DESC 