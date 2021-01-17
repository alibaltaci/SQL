--ÖRNEK SATIÞ DATASI 

--Ýlk olarak geçen derste oluþturduðumuz ETRADE veri tabanýný silelim.
--ETRADE üzerine gidip sað click dedik ve delete dedik.
--Delete dedikten sonra çýkan tabloda 
--"Close existing connections" 
--seçeneðni iþaretlemek önemlidir.

--Databases üzeine gidip "restore database" dedik.
--"Device" seçeneði seçildi.
--Çýkan tabloda "add" dedik.
--"ETRADE.BAK" pathini yapýþtýrdýk.
-- OK OK OK OK dedik :)
--Yani database eklenmiþ oldu.
--611.000 satýr...
--Datanýn alanlarý hakkýnda açýklamalar "Alan Listesi" dosyasýnda mevcuttur.



--AGGREGATE FUNCTIONS (SUM, COUNT, MIN, MAX, AVG)

--GENEL KULLANIM:
--SELECT 
--SUM(PRICE9, COUNT(ID), MIN(PRICE), MAX(PRICE), AVG(PRICE)
--FROM TABLOADI

--Tablomuzu çekelim
SELECT * FROM SALES

--Kocaeli þubesini çekileim.
SELECT * FROM SALES WHERE BRANCH = 'KOCAELÝ SUBESÝ'
--14.292 satýr geldi.

--Kocaeli þubesinin toplam satýþýný getirelim.
--Þube --> BRANCH
--Stýþ --> LINENET
SELECT SUM(LINENET) FROM SALES WHERE BRANCH = 'KOCAELÝ SUBESÝ'
--53151,0199999996 
--GELDÝ.

--Tüm satýþlar 
SELECT SUM(LINENET) FROM SALES 
--2282695,56000024

--Manisa Þuesinin kazancý, toplam satýþ miktarý, minimum satýþ ve maximum satýþ 
SELECT SUM(LINENET), COUNT(*), MIN(LINENET), MAX(LINENET) 
FROM SALES 
WHERE BRANCH = 'MANÝSA SUBESÝ'
-- geldi...

--Yukarýdaki tablonun sütunlarýna bu sefer isim vererek çaðýralým...
SELECT SUM(LINENET) AS TOPLAMSATIS, COUNT(*) AS SATISMIKTARI, MIN(LINENET) AS MINSATIS,
MAX(LINENET) AS MAXSATIS, AVG(LINENET) AS ORTALAMASATISFIYATI FROM SALES 
WHERE BRANCH='MANÝSA SUBESÝ'



--GROUP BY KULLANIMI - 1 

--HAVING --> burada kullanýldý.

--Þubelere göre group by çekip yukarýdaki bilgileri tüm þubeler için tek bir tabloda alalým.

SELECT 
BRANCH,
SUM(LINENET) AS TOPLAM_SATIS, COUNT(*) AS SATIS_SAYISI, MIN(LINENET) AS EN_DUSUK_FIYAT,
MAX(LINENET) AS EN_YUKSEK_FIYAT, AVG(LINENET) AS ORTALAMA_SATIS_FIYATI
FROM SALES GROUP BY BRANCH

--Ýki yere BRANCH yazmamaýzýn sebebi: select isimleri getiriyor, group by da grupluyor.
--select kýsmýna yazmaz isek gruplanýr ama þube isimleri gelmez.

--Þimdi satýþ tutarýna göre þubeleri sýralayalým

SELECT BRANCH, SUM(LINENET) 
FROM SALES 
GROUP BY BRANCH ORDER BY SUM(LINENET)

--Bu þekilde azdan çoða doðru bir sýralama yaptý 
--ama biz çoktan baþlayan bir sýralama istiyoruz.

SELECT BRANCH AS SUBE, SUM(LINENET) AS TOPLAM_SATIS
FROM SALES 
GROUP BY BRANCH ORDER BY SUM(LINENET)DESC

--En çok satýþ yapan ilk 10 þubemzi getirelim.

SELECT TOP 10
BRANCH AS SUBE, SUM(LINENET) AS TOPLAM_SATIS 
FROM SALES 
GROUP BY BRANCH ORDER BY SUM(LINENET) DESC --BURAYA "TOPLAM_SATIS" ya da "2" yazýlabilir.

--Toplam satýþý 50.000 den büyük ve eþit olan þubeler çoktan aza sýralansýn.

SELECT BRANCH AS SUBE, SUM(LINENET) AS TOPLAM_SATIS 
FROM SALES
GROUP BY BRANCH
HAVING SUM(LINENET) >= 50000
ORDER BY 2 DESC

--Burada where kullanamýyoruz.
--Mantýðý, þimdi burada aslýnda yeni bir deðiþken türettik gibi ve 
--where þartý gidip buradan toplam satýþlara bakmýyor, 
--Where gidip normal satýþlardan buna bakýyor her satýr için.
--Yeni deðiþkeni þarta baðlamak için "HAVING" kullanýlýr.



--ORDER BY KULLANIMI - 2 

--Bir maðazanýn gün bazlý þatýþlarýný getirelim.
--Subeye göre sýralansýn ve þubeler kendi içinde en çok satýþ yapýlan güne göre sýralansýn.

SELECT BRANCH SUBE, DATE_ TARIH, SUM(LINENET) TOPLAM_SATIS, COUNT(*) SATIS_MIKTARI 
FROM SALES
GROUP BY BRANCH, DATE_
ORDER BY BRANCH, SATIS_MIKTARI DESC

--güzel oldu.

--NOT: "AS" kullanmadan da isimlendirme yaplabiliyormuþ.



--GROUP BY KULLANIMI - 3 

--Bir günün maðaza bazlý satýþ rakamlarý.

SELECT DATE_ TARIH, BRANCH SUBE, SUM(LINENET) TOPLAM_SATIS, COUNT(*) SATIS_MIKTARI 
FROM SALES 
GROUP BY DATE_, BRANCH
ORDER BY TARIH , TOPLAM_SATIS



--GROUP BY KULLANIMI - 4 

--Ürün kategorilerine göre satýþ rakamlarý

SELECT CATEGORY_NAME1 KATEGORI1, SUM(LINENET) TOPLAM_SATIS
FROM SALES 
WHERE CATEGORY_NAME1 IS NOT NULL --GÖSTERMEMESÝ ÝÇÝN...
GROUP BY CATEGORY_NAME1
ORDER BY 2 DESC

--Ayný iþlem için marklarý da görmek istersek.
SELECT
CATEGORY_NAME1, BRAND, SUM(LINENET)
FROM SALES
WHERE CATEGORY_NAME1 IS NOT NULL
GROUP BY CATEGORY_NAME1, BRAND
ORDER BY 3 DESC

--Ürün markasýna göre satýþlar.
SELECT BRAND, SUM(LINENET)
FROM SALES
WHERE BRAND IS NOT NULL
GROUP BY BRAND
ORDER BY SUM(LINENET) DESC

--Ülkerden en çok ne satýyoruz öðrenelim.

SELECT BRAND, CATEGORY_NAME1, CATEGORY_NAME2, SUM(LINENET)
FROM SALES 
WHERE BRAND IS NOT NULL AND BRAND='ÜLKER'
GROUP BY BRAND, CATEGORY_NAME1, CATEGORY_NAME2
ORDER BY 4 DESC 



-- GROUP BY KULLANIMI - 5 

--Maðazalarýmýzýn müþteri sayýsýný saydýralým...

SELECT BRANCH, COUNT(DISTINCT(CLIENTNAME))
FROM SALES
WHERE BRANCH IS NOT NULL 
GROUP BY BRANCH
ORDER BY COUNT(DISTINCT(CLIENTNAME)) DESC

--1 müþteri farklý maðazalardan alýþveriþ yapmýþ olabilir mi?

--Maðazalarýmýzdaki farklý müþteri sayýlarýný toplayalým.
SELECT COUNT(DISTINCT CLIENTNAME)
FROM SALES
--49205 Bu kadar farklý müþterimiz varmýþ. 
--Demek ki birden fazla maðazadan alýþveriþ yapan müþteriler mevcut.

--Þimdi bir müþterinin gittiði maðaza sayýsýný bulalaým.
SELECT CLIENTNAME, COUNT(DISTINCT BRANCH)
FROM SALES 
WHERE CLIENTNAME IS NOT NULL
GROUP BY CLIENTNAME
ORDER BY 2 DESC

--10 ve 10 dan fazla maðazadan alýþveriþ yapmýþ olam müþterileri listeleyelim.
SELECT 
CLIENTNAME, COUNT(DISTINCT BRANCH)
FROM SALES
WHERE CLIENTNAME IS NOT NULL
GROUP BY CLIENTNAME 
HAVING COUNT(DISTINCT BRANCH) >= 10
ORDER BY 2 DESC 