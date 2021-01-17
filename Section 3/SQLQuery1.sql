--TEMEL SQL KOMUTLARI

--�ALI�TIRMAK ���N "CTRL + E"



-- 1) SELECT 

--TABLOYU �A�IRMAK ���N
SELECT 
ID,CUSTOMERNAME,CITY,BIRTHDATE,DISTRICT,GENDER
FROM
ETRADE.DBO.CUSTOMER 
--E�ER OBJ. EXP. �ZER�NDEK� ALANDA �ALI�TI�IMIZ VER� TABANI SE��L� �SE 
--SADECE CUSTOMER YAZMAK YETERL� OLACAKTIR.

--�ok fazla kolon olan tablolar� teker teker yazarak getirmek mant�ks�z olacakt�r.
--Tablonun alt�nda yer alan Columns klas�r� s�r�klenip b�rak�l�rsa 
--kolon isimleri otomatik olarak gelecektir.
SELECT
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER
--K��eli parantezleri program otomatik olarak atar. 
--yaz�m yanl��� bo�luk gibi sql e s�k�nt� ��kartabilecek durumlar bu �ekilde �nlenir.

--Sadece istedi�imiz s�tunlar� getirelim (Customer, city)
SELECT 
CUSTOMERNAME, CITY
FROM
ETRADE.DBO.CUSTOMER



-- 2) INSERT 

--Toplaya kay�t ekledi�imiz, kay�t insert etti�imiz komuttur.

--GENEL KULLANIM
--INSERT INTO TABLOADI
--(KOLON,KOLON2,KOLON3,...)
--VALUES
--(DE�ER1,DE�ER2,DE�ER3,...)

--Tabloya yeni bir m��teri ekleyelim
INSERT INTO 
CUSTOMER
([CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER])
VALUES 
('BURCU CANDAN', 'KOCAEL�', 'MERKEZ', '08.05.1994', 'K') 

SELECT 
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER

--Excel den tablomuza veri yap��t�ral�m.
--�ncelikle kolon say�lar�n�n uyup uymad���na bakal�m.
--ID nin uyu�mad���n� g�rd�k. 
--Men� k�sm�ndaki SQL se�ene�ini se�ip oradan ID k�sm�n� sildik.
--sa� click yap�p execute dedik ve ID yi u�urduk.
--Sonra tablodaki * i�aretli alanda sa� clik yap�p paste dedik ve i�lem tamam.
--�imdi tablomuzu ID si ile birlikte �a��ral�m...
SELECT 
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER

--�imdi tablodaki 1000 ki�inin hepsini buraya �ekmek istersek:
--hepsi ayn� �ekilde se�ilip �ekilebilir.
--Ya da SQL komutlar�ndan faydalan�labilir.
--veri fazla oldu�u i�in komutlar en mant�kl� se�enek olabilir...
--A�a��daki form�l excele yap��t�r�l�r.
--INSERT INTO CUSTOMER ([CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]) VALUES ('"&&"','"&&"','"&&"','"&&"','"&&"')
--form�l�n ba��na = i�areti konur ve "" i�ine yaz�l�r.
--&& ifadelerinin aras�na bilgisi al�nmak istenen s�tunun h�cre numaras� girilir.
--Yani form�l� gittik ilk m��terinin yan�na yap��t�rd�k. Sonra m��terinin ismini almak i�in 
--ismin bulundu�u h�cre olan A2'yi se�tik --> '"&A2&"'
--Ayn� i�lemi di�er sutunlar i�in de uygulad�k...
--T�m tabloya uygulad�k...

--�imdi bunlar� kopyalay�p yap��t�raca��z ama �nce mevcut tablomuzu bo�altal�m...
--Kar���kl�klar� �nlemek ad�na...
TRUNCATE TABLE CUSTOMER
--Tablomuzu tekrardan kontrol edelim...
SELECT
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER
--g�r�nd��� gibi bilgiler u�tu.
--�imdi yeni bir query olu�turup kopyalad���m�z form�lleri buraya yap��t�ral�m ve �al��t�ral�m 
--�imdi tablomuzu yeniden �a��ral�m...
SELECT 
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER
--1000 verimiz gelmi� durumda.



--3) UPDATE 

--(DATEDIFF  --> Burada kullan�ld�...)

--UPDATE GENEL KULLANIM:
--UPDATE TABLOADI
--SET COLUMN1=VALUE1,COLUMN2=VALUE2...

--UPDATE fonksiyonunu tablomuzdaki bir ya da birden fazla alan� de�i�tirmek isted�imizde 
--kullan�r�z...

--Etrade - Customer tablomuza yeni bir �zellik eklemek isteyelim.
--Bu yeni �zellik m��terilerimizin ya�lar�n� tutsun.
--Customer tablomuz sa� click yap�p design diyelim ve AGE �zelli�imzi ekleyelim.

--�imdi tablomuzu �a��ral�m...
SELECT * FROM CUSTOMER

--* t�m�n� se�er.
--Tabloda g�r�ld��� �zere AGE de�i�kenimiz eklenmi�. Fakat bo�...
--M��terilerin do�um tarihlerini bug�n�n tarihinden ��kartarak ya� hesaplamas� yapal�m ve 
--sonucu AGE de�i�kenimize yazd�ral�m
UPDATE CUSTOMER
SET AGE=DATEDIFF(YEAR,BIRTHDATE,GETDATE())

--De�i�iklik yapmak istedi�imiz tablo ismini girdik,
--sonra set diyeren de�i�kenimizi se�tik,
--yapmak istedi�imiz i�lemi girdik.

--DATEDIFF aradaki fark� bulmak i�in kullan�l�r.
--Ne istiyoruz? --> YEAR
--Ba�lang�� tarihimiz ne? --> BIRTHDATE
--Biti� tarihimiz ne? --> GETDATE (Bug�n�n tarihi)

--Tablomuza tekrar bakal�m...
SELECT * FROM CUSTOMER
--Ya�lar hesapland�!!!



--4) DELETE - TRUNCATE

--INTO --> Burada kullan�ld�.

--GENEL KULLANIM:
--DELETE FROM TABLOADI

--DELETE bir tabloyu silmek istedi�imiz zaman kulland���m�z fonksiyonumuzdur.

--�imdi biraz �nceki tablomuzu silmek istedi�imizi varsayal�m...
--Fakat daha �al��aca��m�z i�in tablodan tamamen vazge�emk istemiyorum.
--Bunun i�in �ncelikle yedekleme i�lemi yapal�m ve 
--sonras�nda tablomuzu silelim...

SELECT * INTO CUSTOMERYEDEK FROM CUSTOMER

--Bu �ekilde CUSTOMER tablomuzdaki verileri �ekerek,
--CUSTOMERYEDEK ismindeki tabloya aktarmas�n� istedik.
--Tabloyu manuel olarak olu�turmad�k,
--Yazd���m�z kod �nce tabloyu olu�turdu sonra verileri �ekti...
--Table alt�na bak�l�nca yeni tablo g�r�necektir...

--Yeni tablomuza veriler akta�lm�� m� kontrol edelim.
SELECT * FROM CUSTOMERYEDEK
--Ba�ar�l�...

--�imdi olu�turdu�umuz CUSTOMERYEDEK tablosunu silelim...
DELETE FROM CUSTOMERYEDEK
--Bu �ekilde tablomuzun i�indeki verileri silmi� olduk.

--Kontrol edelim..
SELECT * FROM CUSTOMERYEDEK
--Tablo bo� gelidi...

--�imdi sildi�imiz tabloya yeni bir veri girdi�imizde ID 1 den de�il
--1001 den ba�layacakt�r.
--Deneyelim...
--�imdi gidip tabloya manuel olarak bilgileri girelim ve sonuca bakal�m.
--Eklemeler yap�ld� �imdi tablomuzu �a��ral�m.
SELECT * FROM CUSTOMERYEDEK
--G�r�ld��� �zere ID 1001'den ba�lad�.

--Bunun �n�ne ge�mek istendi�i zaman TRUNCATE komutu devreye girer...
TRUNCATE TABLE CUSTOMERYEDEK

--Silinmi� mi kontrol edelim...
SELECT * FROM CUSTOMERYEDEK
--Tablo bo�...

--Tekrar ekleme yapal�m ve tabloyu �a��r�p 
--ID numaras�n�n ka�tan ba�lad���n� kontrol edelim.
--Eklem yap�ld�..
--�imdi tabloyu tekrar �a��ral�m.
SELECT * FROM CUSTOMERYEDEK
--ID 1'den ba�lam��...



--5) WHERE

--GENEL KULLANIM:
--SELECT * FROM TABLOADI
--WHERE COLUMN1 = VALUE1

--WHERE �art durumu getirir.
--ya�� 20 den b�y�k olan.
--�stanbul'da ya�ayan.
--Ya�� 30'dan k���k, Manisa'da ya�ayan, cinsiyeti Kad�n olan.......

--WHERE �ARTLARI--
-- =		E�ittir.
-- <>		E�it De�ildir.
-- >		B�y�kt�r.
-- <		K���kt�r.
-- >=		B�y�kt�r ya da e�ittir.
-- <=		K���kt�r ya da e�ittir.
-- BETWEEN  Aras�ndad�r.
-- LIKE		�le ba�lar, ile biter, i�erir.
-- IN		��indedir.

--Tablomuzu �a��ral�m..
SELECT * FROM CUSTOMER


--5.1) E��TT�R "="

--�imdi t�m tablo yerine sadece ismi "Salih FAYDALI" olan m��teriy �a��ral�m.
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME = 'Salih FAYDALI'
--�stedi�imiz ki�i geldi.
--Burada ismin tablodaki ile ayn� formatta olmas�na gerek yoktur yani 
--harfler k���k ya da b�y�k olabilir SQL buna duyars�zd�r.
--(Ba�ta gerekli ayarlamalar yap�ld��� i�in!!!!!)

--ID'si "18" olan m��teriyi �a��ral�m.
SELECT * FROM CUSTOMER
WHERE ID=18
--M��teri geldi.
--Int bir ifade girdi�imiz i�in '' gerek yok.

--CITY'si "Manisa" olanlar� getirsin.
SELECT * FROM CUSTOMER
WHERE CITY='MAN�SA'
--23 Manisa'l� m��terimiz geldi.

--Do�um tarihi "1963-08-06" OLANLAR..
SELECT * FROM CUSTOMER
WHERE BIRTHDATE='1963-08-06'
--1 M��teri geldi.

--UYARI!!!
--Tarih formatlar�nda farkl�l�klar olabilece�i i�in bazen s�k�nt�lar ile kar��la��labilir.
--Bu sorunlardan ka��nmak i�in ye da bir sorun ile kar��la��ld���nda
--tarih �u formatta yaz�labilir
--'19951023' --> Y�layg�n --> y�l ay g�n :)

--Bir de bu �ekilde deneyelim...
SELECT * FROM CUSTOMER
WHERE BIRTHDATE='19630806'
--Ayn� m��terimiz ba�ar�l� bir �ekilde geldi.


--5.2) E��T DE��LD�R "<>"

--�imdi 2 �art isteyelim.
--"Rize"nin "Pazar / Rize" d���ndan olanlar gelsin.
SELECT * FROM CUSTOMER
WHERE CITY='R�ZE' AND DISTRICT<>'PAZAR / R�ZE'
--�sted�imiz m��teriler geldi.


--5.3) B�Y�KT�R ">"

--Ya�� 45'den b�y�k olan Manisal�lar�n --�S�M, -�L�E, YA�I.
SELECT [CUSTOMERNAME],[DISTRICT],[AGE] FROM CUSTOMER
WHERE AGE>45 AND CITY = 'MAN�SA'


--5.4) B�Y�K E��T ">="

--Ya�� 60 ve 60'dan b�y�k olanlar.
SELECT * FROM CUSTOMER
WHERE AGE>=60


--5.5) K���KT�R "<"

--Ya�� 45'den K���K olan Manisal�lar�n --�S�M, -�L�E, YA�I.
SELECT [CUSTOMERNAME],[DISTRICT],[AGE] FROM CUSTOMER
WHERE AGE<45 AND CITY = 'MAN�SA'


--5.6) K���K E��T "<="

--Ya�� 30 ve 30'den k���k olanlar.
SELECT * FROM CUSTOMER
WHERE AGE<=30


--5.7) BETWEEN

-- Ya�� 30 ve 40 aras�nda olanlar�n isim ve ya�lar�.
SELECT CUSTOMERNAME, AGE FROM CUSTOMER
WHERE AGE BETWEEN 30 AND 40


--5.8) LIKE

--LIKE "=" ile ayn� i�levler i�in kullan�labilir.
--Farkl� olarak i�eren anlam�nda da kullan�labilir.
--a i�eren isimler gibi.
--bu % ile sa�lan�r.
--a�a��da �rnekler mevcut.

--�smi "Salih FAYDALI" olan 
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME LIKE 'Salih FAYDALI' 
--Geldi.
--LIKE bu �ekilde "=" ile ayn� i�levi g�r�r.

--Peki ismi "Ali" olanlar� getirelim.
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME LIKE 'Ali%'
--Burada ismi aliye olanlar da geldi, ��nk� aliye ismi ali'yi de i�inde bar�nd�r�r.
--% kelmeden sonra yaz�ld��� i�in ba�tan itibaren ilk 3 harfe bakarak burada "ali" 
--ifadesini arar.

--�imdi de sondan bakarak bir arama yapmas�n� isteyelim.
--�rne�in "sa" ile biten �ehir ismlerini lstelemek isteyelim.
SELECT * FROM CUSTOMER
WHERE CITY LIKE '%SA'

--Peki ba�ta ya da sonda olmas�n� �nemsemeden sadece arad���m�z ifadeyi 
--bar�nd�ran sat�rlar� getirmek istersek.
--�rne�in isminde "ha" ge�en m��terilerin ismlerini listelemek istedi�imzi varsayal�m.
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME LIKE '%HA%'
--�sminde ve soyisminde ha olanlar ba�ar�l� bir �ekilde listelendi.


--5.9) IN

--Isparta'n�n Ulubarlu ve Yalva� il�elerinde ya�ayanlar� listeleyelim.
SELECT * FROM CUSTOMER
WHERE CITY = 'ISPARTA' AND DISTRICT IN ('ULUBORLU', 'YALVA�')

--�imdi tam tersini yapal�m yani Ispartal� olup bu ilelerde ya�amayanlar� listeleyelim.
SELECT * FROM CUSTOMER
WHERE CITY='ISPARTA'
AND DISTRICT NOT IN ('ULUBORLU', 'YALVA�')



--6) AND / OR

--Birden fazla durum, �art vb. girilmesi gerekti�in de kullan�lan operat�rlerdir.
--�nceki b�l�mde zaten kullanm��t�k :)

--AND--

--�ki se�ene�in de do�ru olmas� gerekir.

--A = A AND B = B --> DO�RU

--A = A AND B = C --> YANLI� (KES���M YOK)

--A = D AND B = C --> YANLI�

--OR--

--Se�eneklerden birinin do�ru olmas� yeterlidir.

--A = A OR B = B --> DO�RU

--A = A OR B = C --> DO�RU

--A = D OR B = B --> DO�RU

--A = D OR B = C --> YANLI�

--�imdi ismi "H�seyin" olanlar� VE �ehri "�STANBUL" olanlar� getirelim.
SELECT * FROM CUSTOMER WHERE CITY = '�STANBUL' AND CUSTOMERNAME LIKE ('H�SEY�N%')
--�ki �arta birden uyan tek m��teri varm��.

--�imdi de ismi "H�seyin" olanlar� YA DA �ehri "�STANBUL" olanlar� getirelim.
SELECT * FROM CUSTOMER WHERE CITY = '�STANBUL' OR CUSTOMERNAME LIKE ('H�SEY�N%')
--iki �arttan birini sa�layan t�m m��terilerimiz listelendi.



--7) DISTINCT

--GENEL KULLANIM:
--SELECT DISTINCT COLUMN1, COLUMN2
--FROM TABLOADI

--Tekrar eden verileri tekille�tirir.
--�rne�in �ehirleri g�rmek istersen listede yer alan �ehir isimlerini birer kere yazd�r�r.
--Yani listemizde 10 farkl� �ehirden 100 ki�i varsa, 
--her ki�iye ait olan �ehirler teker teker yaz�lmaz. 
--Sadece 10 farkl� �ehrin ismi yaz�l�r. falan falan 

--�imdi sadece �ehir isimlerini listelemek isteyelim. 
SELECT CITY FROM CUSTOMER
--T�m m��teriler i�in �ehir isimleri geldi.

--�imdi de tekrar eden i�lemlerden kurtularak bu i�lemi yapal�m.
--Listemizde ka� farkl� �ehirden insan var bunu ��renmek istiyoruz  
--say� bizim i�in �nemsiz...
SELECT DISTINCT CITY FROM CUSTOMER
--81 farkl� �ehir geldi. 
--Demek ki T�rkiye'nin her yerinden m��terimiz varm��.

--�stanbul'un ka�farkl� semtinden m��terimiz var.
SELECT DISTINCT CITY,DISTRICT FROM CUSTOMER WHERE CITY = '�STANBUL'

--Sadece �stanbul'un farkl� semtlerini �a��ral�m. Tabloda �stanbul yer almas�n.
SELECT DISTINCT DISTRICT FROM CUSTOMER WHERE CITY = '�STANBUL'
--TAMAMDIR.



--8) ORDER BY

--GENEL KULLANIM:
--SELECT COLUMN1, COLUMN2...
--FROM TABLOADI
--ORDER BY COLIMN1 ASC(A'dan Z'ye), COLUMN2 DESC(B�y�kten k����e, Z'den A'ya)

--Bir s�ralama komutudur.

--Listemizi M��teri ad�na g�re A'dan Z'ye s�ralayal�m.
SELECT * FROM CUSTOMER
ORDER BY CUSTOMERNAME

--�ehirlerimizi ve o �ehirlerde yer alan m��terilerimizi s�ralayal�m.
SELECT * FROM CUSTOMER 
ORDER BY CITY,CUSTOMERNAME

--�imdi �ehirlerimizi s�ralayal�m fakat o �ehirlerde olan m��terilermizi
--tersten s�ralayal�m.
SELECT * FROM CUSTOMER 
ORDER BY CITY, CUSTOMERNAME DESC
--ASC �n tan�ml� olarak geldi�i i�in yazmaya gerek yok san�r�m...

--E�er s�ralanmak istenen s�tunun numaras� yani ka��nc� s�tun oladu�u biliniyorsa 
--s�tun numaras�n� yazarak da s�ralamak m�mk�n.

--�rne�in AGE s�tunu 7. s�tunumuzdur.
--Buna g�re s�ralama i�lemini yapal�m.
SELECT * FROM CUSTOMER 
ORDER BY 7

--Tam tersi...
SELECT * FROM CUSTOMER 
ORDER BY 7 desc

--�ehirismlerinin tersten s�ralan���na g�re, ya�lar�n k���ten b�y��e s�ralan���.
SELECT * FROM CUSTOMER
ORDER BY 3 DESC, 7
--Gayet ba�ar�l�.



--9) TOP 

--MYSQL --> LIMIT
--ORACLE --> ROWNUM

--GENEL KULLANIM:
--SELECT TOP N COLUMN1, COLUMN2...
--FROM TABLOADI
--ORDER BY COLUMN1 ASC, COLUMN2 DESC

--Listamizdeki ilk 5 m��teriyi �ekelim.
SELECT TOP 5 * FROM CUSTOMER

--�imdi m��teri ad�na g�re s�ralay�p ilk 5 m��teriyi �ekelim.
SELECT TOP 5 * FROM CUSTOMER
ORDER BY CUSTOMERNAME

--�sme g�re s�ralay�p istanbullu olan ilk 5 m��teriyi�ekelim.
SELECT TOP 5 * FROM CUSTOMER
WHERE CITY = '�STANBUL'
ORDER BY CUSTOMERNAME 

--TOP, PERCENT ile birlikte kullan�l�rsa y�zdelik dilim se�ilmesini sa�lar.
--Verinin % 10'u gibi gibi gibi

--�stanbullu olan m��terilerin % 10'u gelsin ve bu m��teriler isimlerine g�re s�ralans�nlar.
SELECT TOP 10 PERCENT * FROM CUSTOMER
WHERE CITY = '�STANBUL'
ORDER BY CUSTOMERNAME

--�sim s�ras�na g�re t�m m��terilerin yar�s�...
SELECT TOP 50 PERCENT * FROM CUSTOMER
ORDER BY CUSTOMERNAME