--TEMEL SQL KOMUTLARI

--ÇALIÞTIRMAK ÝÇÝN "CTRL + E"



-- 1) SELECT 

--TABLOYU ÇAÐIRMAK ÝÇÝN
SELECT 
ID,CUSTOMERNAME,CITY,BIRTHDATE,DISTRICT,GENDER
FROM
ETRADE.DBO.CUSTOMER 
--EÐER OBJ. EXP. ÜZERÝNDEKÝ ALANDA ÇALIÞTIÐIMIZ VERÝ TABANI SEÇÝLÝ ÝSE 
--SADECE CUSTOMER YAZMAK YETERLÝ OLACAKTIR.

--Çok fazla kolon olan tablolarý teker teker yazarak getirmek mantýksýz olacaktýr.
--Tablonun altýnda yer alan Columns klasörü sürüklenip býrakýlýrsa 
--kolon isimleri otomatik olarak gelecektir.
SELECT
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER
--Köþeli parantezleri program otomatik olarak atar. 
--yazým yanlýþý boþluk gibi sql e sýkýntý çýkartabilecek durumlar bu þekilde önlenir.

--Sadece istediðimiz sütunlarý getirelim (Customer, city)
SELECT 
CUSTOMERNAME, CITY
FROM
ETRADE.DBO.CUSTOMER



-- 2) INSERT 

--Toplaya kayýt eklediðimiz, kayýt insert ettiðimiz komuttur.

--GENEL KULLANIM
--INSERT INTO TABLOADI
--(KOLON,KOLON2,KOLON3,...)
--VALUES
--(DEÐER1,DEÐER2,DEÐER3,...)

--Tabloya yeni bir müþteri ekleyelim
INSERT INTO 
CUSTOMER
([CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER])
VALUES 
('BURCU CANDAN', 'KOCAELÝ', 'MERKEZ', '08.05.1994', 'K') 

SELECT 
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER

--Excel den tablomuza veri yapýþtýralým.
--Öncelikle kolon sayýlarýnýn uyup uymadýðýna bakalým.
--ID nin uyuþmadýðýný gördük. 
--Menü kýsmýndaki SQL seçeneðini seçip oradan ID kýsmýný sildik.
--sað click yapýp execute dedik ve ID yi uçurduk.
--Sonra tablodaki * iþaretli alanda sað clik yapýp paste dedik ve iþlem tamam.
--þimdi tablomuzu ID si ile birlikte çaðýralým...
SELECT 
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER

--Þimdi tablodaki 1000 kiþinin hepsini buraya çekmek istersek:
--hepsi ayný þekilde seçilip çekilebilir.
--Ya da SQL komutlarýndan faydalanýlabilir.
--veri fazla olduðu için komutlar en mantýklý seçenek olabilir...
--Aþaðýdaki formül excele yapýþtýrýlýr.
--INSERT INTO CUSTOMER ([CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]) VALUES ('"&&"','"&&"','"&&"','"&&"','"&&"')
--formülün baþýna = iþareti konur ve "" içine yazýlýr.
--&& ifadelerinin arasýna bilgisi alýnmak istenen sütunun hücre numarasý girilir.
--Yani formülü gittik ilk müþterinin yanýna yapýþtýrdýk. Sonra müþterinin ismini almak için 
--ismin bulunduðu hücre olan A2'yi seçtik --> '"&A2&"'
--Ayný iþlemi diðer sutunlar için de uyguladýk...
--Tüm tabloya uyguladýk...

--Þimdi bunlarý kopyalayýp yapýþtýracaðýz ama önce mevcut tablomuzu boþaltalým...
--Karýþýklýklarý önlemek adýna...
TRUNCATE TABLE CUSTOMER
--Tablomuzu tekrardan kontrol edelim...
SELECT
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER
--göründüðü gibi bilgiler uçtu.
--Þimdi yeni bir query oluþturup kopyaladýðýmýz formülleri buraya yapýþtýralým ve çalýþtýralým 
--þimdi tablomuzu yeniden çaðýralým...
SELECT 
[ID], [CUSTOMERNAME], [CITY], [DISTRICT], [BIRTHDATE], [GENDER]
FROM
ETRADE.DBO.CUSTOMER
--1000 verimiz gelmiþ durumda.



--3) UPDATE 

--(DATEDIFF  --> Burada kullanýldý...)

--UPDATE GENEL KULLANIM:
--UPDATE TABLOADI
--SET COLUMN1=VALUE1,COLUMN2=VALUE2...

--UPDATE fonksiyonunu tablomuzdaki bir ya da birden fazla alaný deðiþtirmek istedðimizde 
--kullanýrýz...

--Etrade - Customer tablomuza yeni bir özellik eklemek isteyelim.
--Bu yeni özellik müþterilerimizin yaþlarýný tutsun.
--Customer tablomuz sað click yapýp design diyelim ve AGE özelliðimzi ekleyelim.

--Þimdi tablomuzu çaðýralým...
SELECT * FROM CUSTOMER

--* tümünü seçer.
--Tabloda görüldüðü üzere AGE deðiþkenimiz eklenmiþ. Fakat boþ...
--Müþterilerin doðum tarihlerini bugünün tarihinden çýkartarak yaþ hesaplamasý yapalým ve 
--sonucu AGE deðiþkenimize yazdýralým
UPDATE CUSTOMER
SET AGE=DATEDIFF(YEAR,BIRTHDATE,GETDATE())

--Deðiþiklik yapmak istediðimiz tablo ismini girdik,
--sonra set diyeren deðiþkenimizi seçtik,
--yapmak istediðimiz iþlemi girdik.

--DATEDIFF aradaki farký bulmak için kullanýlýr.
--Ne istiyoruz? --> YEAR
--Baþlangýç tarihimiz ne? --> BIRTHDATE
--Bitiþ tarihimiz ne? --> GETDATE (Bugünün tarihi)

--Tablomuza tekrar bakalým...
SELECT * FROM CUSTOMER
--Yaþlar hesaplandý!!!



--4) DELETE - TRUNCATE

--INTO --> Burada kullanýldý.

--GENEL KULLANIM:
--DELETE FROM TABLOADI

--DELETE bir tabloyu silmek istediðimiz zaman kullandýðýmýz fonksiyonumuzdur.

--Þimdi biraz önceki tablomuzu silmek istediðimizi varsayalým...
--Fakat daha çalýþacaðýmýz için tablodan tamamen vazgeçemk istemiyorum.
--Bunun için öncelikle yedekleme iþlemi yapalým ve 
--sonrasýnda tablomuzu silelim...

SELECT * INTO CUSTOMERYEDEK FROM CUSTOMER

--Bu þekilde CUSTOMER tablomuzdaki verileri çekerek,
--CUSTOMERYEDEK ismindeki tabloya aktarmasýný istedik.
--Tabloyu manuel olarak oluþturmadýk,
--Yazdýðýmýz kod önce tabloyu oluþturdu sonra verileri çekti...
--Table altýna bakýlýnca yeni tablo görünecektir...

--Yeni tablomuza veriler aktaýlmýþ mý kontrol edelim.
SELECT * FROM CUSTOMERYEDEK
--Baþarýlý...

--Þimdi oluþturduðumuz CUSTOMERYEDEK tablosunu silelim...
DELETE FROM CUSTOMERYEDEK
--Bu þekilde tablomuzun içindeki verileri silmiþ olduk.

--Kontrol edelim..
SELECT * FROM CUSTOMERYEDEK
--Tablo boþ gelidi...

--Þimdi sildiðimiz tabloya yeni bir veri girdiðimizde ID 1 den deðil
--1001 den baþlayacaktýr.
--Deneyelim...
--Þimdi gidip tabloya manuel olarak bilgileri girelim ve sonuca bakalým.
--Eklemeler yapýldý þimdi tablomuzu çaðýralým.
SELECT * FROM CUSTOMERYEDEK
--Görüldüðü üzere ID 1001'den baþladý.

--Bunun önüne geçmek istendiði zaman TRUNCATE komutu devreye girer...
TRUNCATE TABLE CUSTOMERYEDEK

--Silinmiþ mi kontrol edelim...
SELECT * FROM CUSTOMERYEDEK
--Tablo boþ...

--Tekrar ekleme yapalým ve tabloyu çaðýrýp 
--ID numarasýnýn kaçtan baþladýðýný kontrol edelim.
--Eklem yapýldý..
--þimdi tabloyu tekrar çaðýralým.
SELECT * FROM CUSTOMERYEDEK
--ID 1'den baþlamýþ...



--5) WHERE

--GENEL KULLANIM:
--SELECT * FROM TABLOADI
--WHERE COLUMN1 = VALUE1

--WHERE þart durumu getirir.
--yaþý 20 den büyük olan.
--Ýstanbul'da yaþayan.
--Yaþý 30'dan küçük, Manisa'da yaþayan, cinsiyeti Kadýn olan.......

--WHERE ÞARTLARI--
-- =		Eþittir.
-- <>		Eþit Deðildir.
-- >		Büyüktür.
-- <		Küçüktür.
-- >=		Büyüktür ya da eþittir.
-- <=		Küçüktür ya da eþittir.
-- BETWEEN  Arasýndadýr.
-- LIKE		Ýle baþlar, ile biter, içerir.
-- IN		Ýçindedir.

--Tablomuzu çaðýralým..
SELECT * FROM CUSTOMER


--5.1) EÞÝTTÝR "="

--Þimdi tüm tablo yerine sadece ismi "Salih FAYDALI" olan müþteriy çaðýralým.
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME = 'Salih FAYDALI'
--Ýstediðimiz kiþi geldi.
--Burada ismin tablodaki ile ayný formatta olmasýna gerek yoktur yani 
--harfler küçük ya da büyük olabilir SQL buna duyarsýzdýr.
--(Baþta gerekli ayarlamalar yapýldýðý için!!!!!)

--ID'si "18" olan müþteriyi çaðýralým.
SELECT * FROM CUSTOMER
WHERE ID=18
--Müþteri geldi.
--Int bir ifade girdiðimiz için '' gerek yok.

--CITY'si "Manisa" olanlarý getirsin.
SELECT * FROM CUSTOMER
WHERE CITY='MANÝSA'
--23 Manisa'lý müþterimiz geldi.

--Doðum tarihi "1963-08-06" OLANLAR..
SELECT * FROM CUSTOMER
WHERE BIRTHDATE='1963-08-06'
--1 Müþteri geldi.

--UYARI!!!
--Tarih formatlarýnda farklýlýklar olabileceði için bazen sýkýntýlar ile karþýlaþýlabilir.
--Bu sorunlardan kaçýnmak için ye da bir sorun ile karþýlaþýldýðýnda
--tarih þu formatta yazýlabilir
--'19951023' --> Yýlaygün --> yýl ay gün :)

--Bir de bu þekilde deneyelim...
SELECT * FROM CUSTOMER
WHERE BIRTHDATE='19630806'
--Ayný müþterimiz baþarýlý bir þekilde geldi.


--5.2) EÞÝT DEÐÝLDÝR "<>"

--Þimdi 2 þart isteyelim.
--"Rize"nin "Pazar / Rize" dýþýndan olanlar gelsin.
SELECT * FROM CUSTOMER
WHERE CITY='RÝZE' AND DISTRICT<>'PAZAR / RÝZE'
--Ýstedðimiz müþteriler geldi.


--5.3) BÜYÜKTÜR ">"

--Yaþý 45'den büyük olan Manisalýlarýn --ÝSÝM, -ÝLÇE, YAÞI.
SELECT [CUSTOMERNAME],[DISTRICT],[AGE] FROM CUSTOMER
WHERE AGE>45 AND CITY = 'MANÝSA'


--5.4) BÜYÜK EÞÝT ">="

--Yaþý 60 ve 60'dan büyük olanlar.
SELECT * FROM CUSTOMER
WHERE AGE>=60


--5.5) KÜÇÜKTÜR "<"

--Yaþý 45'den KÜÇÜK olan Manisalýlarýn --ÝSÝM, -ÝLÇE, YAÞI.
SELECT [CUSTOMERNAME],[DISTRICT],[AGE] FROM CUSTOMER
WHERE AGE<45 AND CITY = 'MANÝSA'


--5.6) KÜÇÜK EÞÝT "<="

--Yaþý 30 ve 30'den küçük olanlar.
SELECT * FROM CUSTOMER
WHERE AGE<=30


--5.7) BETWEEN

-- Yaþý 30 ve 40 arasýnda olanlarýn isim ve yaþlarý.
SELECT CUSTOMERNAME, AGE FROM CUSTOMER
WHERE AGE BETWEEN 30 AND 40


--5.8) LIKE

--LIKE "=" ile ayný iþlevler için kullanýlabilir.
--Farklý olarak içeren anlamýnda da kullanýlabilir.
--a içeren isimler gibi.
--bu % ile saðlanýr.
--aþaðýda örnekler mevcut.

--Ýsmi "Salih FAYDALI" olan 
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME LIKE 'Salih FAYDALI' 
--Geldi.
--LIKE bu þekilde "=" ile ayný iþlevi görür.

--Peki ismi "Ali" olanlarý getirelim.
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME LIKE 'Ali%'
--Burada ismi aliye olanlar da geldi, çünkü aliye ismi ali'yi de içinde barýndýrýr.
--% kelmeden sonra yazýldýðý için baþtan itibaren ilk 3 harfe bakarak burada "ali" 
--ifadesini arar.

--Þimdi de sondan bakarak bir arama yapmasýný isteyelim.
--Örneðin "sa" ile biten þehir ismlerini lstelemek isteyelim.
SELECT * FROM CUSTOMER
WHERE CITY LIKE '%SA'

--Peki baþta ya da sonda olmasýný önemsemeden sadece aradýðýmýz ifadeyi 
--barýndýran satýrlarý getirmek istersek.
--Örneðin isminde "ha" geçen müþterilerin ismlerini listelemek istediðimzi varsayalým.
SELECT * FROM CUSTOMER
WHERE CUSTOMERNAME LIKE '%HA%'
--Ýsminde ve soyisminde ha olanlar baþarýlý bir þekilde listelendi.


--5.9) IN

--Isparta'nýn Ulubarlu ve Yalvaç ilçelerinde yaþayanlarý listeleyelim.
SELECT * FROM CUSTOMER
WHERE CITY = 'ISPARTA' AND DISTRICT IN ('ULUBORLU', 'YALVAÇ')

--Þimdi tam tersini yapalým yani Ispartalý olup bu ilelerde yaþamayanlarý listeleyelim.
SELECT * FROM CUSTOMER
WHERE CITY='ISPARTA'
AND DISTRICT NOT IN ('ULUBORLU', 'YALVAÇ')



--6) AND / OR

--Birden fazla durum, þart vb. girilmesi gerektiðin de kullanýlan operatörlerdir.
--Önceki bölümde zaten kullanmýþtýk :)

--AND--

--Ýki seçeneðin de doðru olmasý gerekir.

--A = A AND B = B --> DOÐRU

--A = A AND B = C --> YANLIÞ (KESÝÞÝM YOK)

--A = D AND B = C --> YANLIÞ

--OR--

--Seçeneklerden birinin doðru olmasý yeterlidir.

--A = A OR B = B --> DOÐRU

--A = A OR B = C --> DOÐRU

--A = D OR B = B --> DOÐRU

--A = D OR B = C --> YANLIÞ

--Þimdi ismi "Hüseyin" olanlarý VE þehri "ÝSTANBUL" olanlarý getirelim.
SELECT * FROM CUSTOMER WHERE CITY = 'ÝSTANBUL' AND CUSTOMERNAME LIKE ('HÜSEYÝN%')
--Ýki þarta birden uyan tek müþteri varmýþ.

--Þimdi de ismi "Hüseyin" olanlarý YA DA þehri "ÝSTANBUL" olanlarý getirelim.
SELECT * FROM CUSTOMER WHERE CITY = 'ÝSTANBUL' OR CUSTOMERNAME LIKE ('HÜSEYÝN%')
--iki þarttan birini saðlayan tüm müþterilerimiz listelendi.



--7) DISTINCT

--GENEL KULLANIM:
--SELECT DISTINCT COLUMN1, COLUMN2
--FROM TABLOADI

--Tekrar eden verileri tekilleþtirir.
--Örneðin þehirleri görmek istersen listede yer alan þehir isimlerini birer kere yazdýrýr.
--Yani listemizde 10 farklý þehirden 100 kiþi varsa, 
--her kiþiye ait olan þehirler teker teker yazýlmaz. 
--Sadece 10 farklý þehrin ismi yazýlýr. falan falan 

--Þimdi sadece þehir isimlerini listelemek isteyelim. 
SELECT CITY FROM CUSTOMER
--Tüm müþteriler için þehir isimleri geldi.

--Þimdi de tekrar eden iþlemlerden kurtularak bu iþlemi yapalým.
--Listemizde kaç farklý þehirden insan var bunu öðrenmek istiyoruz  
--sayý bizim için önemsiz...
SELECT DISTINCT CITY FROM CUSTOMER
--81 farklý þehir geldi. 
--Demek ki Türkiye'nin her yerinden müþterimiz varmýþ.

--Ýstanbul'un kaçfarklý semtinden müþterimiz var.
SELECT DISTINCT CITY,DISTRICT FROM CUSTOMER WHERE CITY = 'ÝSTANBUL'

--Sadece Ýstanbul'un farklý semtlerini çaðýralým. Tabloda Ýstanbul yer almasýn.
SELECT DISTINCT DISTRICT FROM CUSTOMER WHERE CITY = 'ÝSTANBUL'
--TAMAMDIR.



--8) ORDER BY

--GENEL KULLANIM:
--SELECT COLUMN1, COLUMN2...
--FROM TABLOADI
--ORDER BY COLIMN1 ASC(A'dan Z'ye), COLUMN2 DESC(Büyükten küçüðe, Z'den A'ya)

--Bir sýralama komutudur.

--Listemizi Müþteri adýna göre A'dan Z'ye sýralayalým.
SELECT * FROM CUSTOMER
ORDER BY CUSTOMERNAME

--Þehirlerimizi ve o þehirlerde yer alan müþterilerimizi sýralayalým.
SELECT * FROM CUSTOMER 
ORDER BY CITY,CUSTOMERNAME

--Þimdi þehirlerimizi sýralayalým fakat o þehirlerde olan müþterilermizi
--tersten sýralayalým.
SELECT * FROM CUSTOMER 
ORDER BY CITY, CUSTOMERNAME DESC
--ASC ön tanýmlý olarak geldiði için yazmaya gerek yok sanýrým...

--Eðer sýralanmak istenen sütunun numarasý yani kaçýncý sütun oladuðu biliniyorsa 
--sütun numarasýný yazarak da sýralamak mümkün.

--Örneðin AGE sütunu 7. sütunumuzdur.
--Buna göre sýralama iþlemini yapalým.
SELECT * FROM CUSTOMER 
ORDER BY 7

--Tam tersi...
SELECT * FROM CUSTOMER 
ORDER BY 7 desc

--Þehirismlerinin tersten sýralanýþýna göre, yaþlarýn küçüten büyüðe sýralanýþý.
SELECT * FROM CUSTOMER
ORDER BY 3 DESC, 7
--Gayet baþarýlý.



--9) TOP 

--MYSQL --> LIMIT
--ORACLE --> ROWNUM

--GENEL KULLANIM:
--SELECT TOP N COLUMN1, COLUMN2...
--FROM TABLOADI
--ORDER BY COLUMN1 ASC, COLUMN2 DESC

--Listamizdeki ilk 5 müþteriyi çekelim.
SELECT TOP 5 * FROM CUSTOMER

--Þimdi müþteri adýna göre sýralayýp ilk 5 müþteriyi çekelim.
SELECT TOP 5 * FROM CUSTOMER
ORDER BY CUSTOMERNAME

--Ýsme göre sýralayýp istanbullu olan ilk 5 müþteriyiçekelim.
SELECT TOP 5 * FROM CUSTOMER
WHERE CITY = 'ÝSTANBUL'
ORDER BY CUSTOMERNAME 

--TOP, PERCENT ile birlikte kullanýlýrsa yüzdelik dilim seçilmesini saðlar.
--Verinin % 10'u gibi gibi gibi

--Ýstanbullu olan müþterilerin % 10'u gelsin ve bu müþteriler isimlerine göre sýralansýnlar.
SELECT TOP 10 PERCENT * FROM CUSTOMER
WHERE CITY = 'ÝSTANBUL'
ORDER BY CUSTOMERNAME

--Ýsim sýrasýna göre tüm müþterilerin yarýsý...
SELECT TOP 50 PERCENT * FROM CUSTOMER
ORDER BY CUSTOMERNAME