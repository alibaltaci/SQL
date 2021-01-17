--STRING ÝÞLEMLERÝ




--ASCII - CHAR

--Ýçine girilen deðerin ASCII türünden deðerini verir.

SELECT ASCII('A')

SELECT ASCII('Þ')

SELECT ASCII('1')

--Yukarýdaki iþlemlerin ters onksiyonudur. 
--Yani bir ASCII deðerinin hangi karaktere karþýlýk geldiðini öðrenebiliri.

SELECT CHAR(49)  --> 1

SELECT CHAR(214) --> Ö

SELECT ASCII(CHAR(214))  --> 214

SELECT CHAR(ASCII('Ö'))  --> Ö




--SUBSTRING

SELECT SUBSTRING('ALÝ BALTACI', 1, 3) --> 1. karakterden itibaren 3. tane seç.




--CHARINDEX

SELECT CHARINDEX('Ý','ALÝ BALTACI',1) --> Hangi karakteri nerede nereden itibaren arayacak.



--CONCAT

--2 veya daha fazla str ifadenin birleþtirilmesi için kullanýlýr.

SELECT 'ALÝ'+'BALTACI'

SELECT CONCAT('ALÝ', ' BALTACI')

SELECT CONCAT_WS(' ','ALÝ','BALTACI')  --> Seperator alan fonksiyon. 

--Bir müþterinin kullanýcý adý, þifresi, adý soyadý.

SELECT CONCAT_WS(' ',USERNAME_, PASSWORD_, NAMESURNAME) 
FROM USER_ 




--FORMAT

--Bugünün tarihini getirelim...

SELECT FORMAT(GETDATE(), 'd', 'en-us') --> 1/17/2021

SELECT FORMAT(GETDATE(), 'D', 'en-us') --> Sunday, January 17, 2021

SELECT FORMAT(GETDATE(), 'd', 'tr') --> 17.01.2021  -- emin deðilim ama bu ekilde çalýþtý.

SELECT FORMAT(GETDATE(), 'D', 'tr') --> 17 Ocak 2021 Pazar




--LEFT - RIGHT - LEN

SELECT LEFT('ALÝ BALTACI', 4)  --> Baþtan 4 karakter.

SELECT RIGHT('ALÝ BALTACI', 4)  --> Sondan 4 karakter.

SELECT LEN('ALÝ BALTACI')  --> Uzunluk.

--Ad soyadý ayýralým...

SELECT LEFT('ALÝ BALTACI', CHARINDEX(' ','ALÝ BALTACI')), RIGHT ('ALÝ BALTACI', LEN('ALÝ BALTACI') - CHARINDEX(' ','ALÝ BALTACI'))

--Tüm tablo için ayný iþlemi yapalým.

SELECT LEFT(NAMESURNAME, CHARINDEX(' ',NAMESURNAME)), RIGHT(NAMESURNAME, LEN(NAMESURNAME) - CHARINDEX(' ',NAMESURNAME))
FROM USER_




--TRIM - LTRIM - RTRIM

SELECT TRIM(' ALÝ ALTACI ')   --> Baþtan ve sondan boþluklarý silmek için.

SELECT LTRIM(' ALÝ BALTACI ') --> Baþtan

SELECT RTRIM(' ALÝ BALTACI ') --> Sondan

SELECT RTRIM(LTRIM(' ALÝ BALTACI '))  --> Bu þekilde kullaným da mevcut.




--LOWER - UPPER - REVERSE - REPLICATE

						  --- Çýktý ---

SELECT LOWER('KÜÇÜK')	  --> küçük

SELECT UPPER('büyük')	  --> BÜYÜK

SELECT REVERSE('TERSTEN') --> NETSRET

SELECT REPLICATE('0', 10) --> 0000000000

--Þimdi REPLICATE için daha güzel bir iþlem yapalým.

--Öncelikle sýrano ve sýrano2 sütunlarýna sahip bir tablo oluþturalým.

--Sonra tablodan sýrano sütununa numaralarý ekleyeli. Farklý uzunlukta numaralar olsun.

--Ardýndan bu numaralarýn uzunluklarýný standartlaþtýrmak için hepsine 8 e tamamlayalým.

SELECT *, REPLICATE('0', 8-LEN(SIRANO))+CONVERT(VARCHAR,SIRANO) FROM TEST

--Þimdi UPDATE edelim.

UPDATE TEST SET SIRANO2=REPLICATE('0', 8-LEN(SIRANO))+CONVERT(VARCHAR,SIRANO)

--Tabloya tekrardan bakalým.

SELECT *, REPLICATE('0', 8-LEN(SIRANO))+CONVERT(VARCHAR,SIRANO) FROM TEST




--REPLACE

--Bir deðeri baþka bir deðer ile deðiþtirmek için.

SELECT 'A. BALTACI'

SELECT REPLACE('A. BALTACI', 'A.', 'ALÝ')


/* Uzun bir metin olduðunu var sayalým ve bu metin üzerinde deðiþiklikler yapmak istiyoruz.
Çalýþacaðýmýz bu metnin uzun olmasý iþlemler sýrasýnda bize sýkýntý çýkartacaktýr.
O yüzden bu metni bir deðere atayýp iþlemlerimize devam edebiliriz.

Aþaðýda Harvard Business Review Türkiye'den aldýðým bir makalenin ilk paragrafýný getirdim.

Þimdi bu paragraf üzerinde bazý deðiþiklikler yapmak istiyoruz. 
Onun için ilk baþta metnimizi bir deðiþkene atayalým.
Sorgularýmýzda bu deðiþkeni kulanalým.
*/

https://hbrturkiye.com/dergi/acemi-ceo-lar-neden-ustun-performans-gosterir

'Teoride
Acemi CEO’lar Neden Üstün Performans Gösterir?
Deneyimli yöneticiler eski taktiklere fazla güveniyor.

Yönetim kurullarý en iyi CEO adayý arayýþýna yüksek hedefler koyarak baþlayabilir. 
Fakat direktörler kötü bir yedeklemenin, itibarlarýný (ve elbette paydaþlarýný) zedeleme ihtimali olduðunu bilir. 
Bu yüzden birçok durumda bir adayýn olumlu potansiyellerine odaklanmak yerine onlarý olumsuz 
etkileyebilecek risklerine odaklanýp kendilerine þu soruyu sorarlar: En güvenli seçim kim? 
Baþarýsýz olma ihtimali en düþük aday kim? Bu sorunun cevabý da genellikle 
en iyi iþ pozisyonunda tecrübeye sahip aday olur. Nitekim yeni iþe alýnan CEO’larýn 
içinde iþe alýnmadan önce ayný pozisyonda çalýþanlarýn sayýsý 
1997’den bu yana dört katýna çýktý ve þimdi yüzde 16’lýk bir bölümü temsil ediyorlar.'

--DECLARE ile deðiþken tanýmlanýr ve 
--@ ile deðiþken olduðu belirtilir.


DECLARE @HBR AS VARCHAR(MAX) 

SET @HBR='Teoride
Acemi CEO’lar Neden Üstün Performans Gösterir?
Deneyimli yöneticiler eski taktiklere fazla güveniyor.'

SELECT @HBR