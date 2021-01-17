--STRING ��LEMLER�




--ASCII - CHAR

--��ine girilen de�erin ASCII t�r�nden de�erini verir.

SELECT ASCII('A')

SELECT ASCII('�')

SELECT ASCII('1')

--Yukar�daki i�lemlerin ters onksiyonudur. 
--Yani bir ASCII de�erinin hangi karaktere kar��l�k geldi�ini ��renebiliri.

SELECT CHAR(49)  --> 1

SELECT CHAR(214) --> �

SELECT ASCII(CHAR(214))  --> 214

SELECT CHAR(ASCII('�'))  --> �




--SUBSTRING

SELECT SUBSTRING('AL� BALTACI', 1, 3) --> 1. karakterden itibaren 3. tane se�.




--CHARINDEX

SELECT CHARINDEX('�','AL� BALTACI',1) --> Hangi karakteri nerede nereden itibaren arayacak.



--CONCAT

--2 veya daha fazla str ifadenin birle�tirilmesi i�in kullan�l�r.

SELECT 'AL�'+'BALTACI'

SELECT CONCAT('AL�', ' BALTACI')

SELECT CONCAT_WS(' ','AL�','BALTACI')  --> Seperator alan fonksiyon. 

--Bir m��terinin kullan�c� ad�, �ifresi, ad� soyad�.

SELECT CONCAT_WS(' ',USERNAME_, PASSWORD_, NAMESURNAME) 
FROM USER_ 




--FORMAT

--Bug�n�n tarihini getirelim...

SELECT FORMAT(GETDATE(), 'd', 'en-us') --> 1/17/2021

SELECT FORMAT(GETDATE(), 'D', 'en-us') --> Sunday, January 17, 2021

SELECT FORMAT(GETDATE(), 'd', 'tr') --> 17.01.2021  -- emin de�ilim ama bu ekilde �al��t�.

SELECT FORMAT(GETDATE(), 'D', 'tr') --> 17 Ocak 2021 Pazar




--LEFT - RIGHT - LEN

SELECT LEFT('AL� BALTACI', 4)  --> Ba�tan 4 karakter.

SELECT RIGHT('AL� BALTACI', 4)  --> Sondan 4 karakter.

SELECT LEN('AL� BALTACI')  --> Uzunluk.

--Ad soyad� ay�ral�m...

SELECT LEFT('AL� BALTACI', CHARINDEX(' ','AL� BALTACI')), RIGHT ('AL� BALTACI', LEN('AL� BALTACI') - CHARINDEX(' ','AL� BALTACI'))

--T�m tablo i�in ayn� i�lemi yapal�m.

SELECT LEFT(NAMESURNAME, CHARINDEX(' ',NAMESURNAME)), RIGHT(NAMESURNAME, LEN(NAMESURNAME) - CHARINDEX(' ',NAMESURNAME))
FROM USER_




--TRIM - LTRIM - RTRIM

SELECT TRIM(' AL� ALTACI ')   --> Ba�tan ve sondan bo�luklar� silmek i�in.

SELECT LTRIM(' AL� BALTACI ') --> Ba�tan

SELECT RTRIM(' AL� BALTACI ') --> Sondan

SELECT RTRIM(LTRIM(' AL� BALTACI '))  --> Bu �ekilde kullan�m da mevcut.




--LOWER - UPPER - REVERSE - REPLICATE

						  --- ��kt� ---

SELECT LOWER('K���K')	  --> k���k

SELECT UPPER('b�y�k')	  --> B�Y�K

SELECT REVERSE('TERSTEN') --> NETSRET

SELECT REPLICATE('0', 10) --> 0000000000

--�imdi REPLICATE i�in daha g�zel bir i�lem yapal�m.

--�ncelikle s�rano ve s�rano2 s�tunlar�na sahip bir tablo olu�tural�m.

--Sonra tablodan s�rano s�tununa numaralar� ekleyeli. Farkl� uzunlukta numaralar olsun.

--Ard�ndan bu numaralar�n uzunluklar�n� standartla�t�rmak i�in hepsine 8 e tamamlayal�m.

SELECT *, REPLICATE('0', 8-LEN(SIRANO))+CONVERT(VARCHAR,SIRANO) FROM TEST

--�imdi UPDATE edelim.

UPDATE TEST SET SIRANO2=REPLICATE('0', 8-LEN(SIRANO))+CONVERT(VARCHAR,SIRANO)

--Tabloya tekrardan bakal�m.

SELECT *, REPLICATE('0', 8-LEN(SIRANO))+CONVERT(VARCHAR,SIRANO) FROM TEST




--REPLACE

--Bir de�eri ba�ka bir de�er ile de�i�tirmek i�in.

SELECT 'A. BALTACI'

SELECT REPLACE('A. BALTACI', 'A.', 'AL�')


/* Uzun bir metin oldu�unu var sayal�m ve bu metin �zerinde de�i�iklikler yapmak istiyoruz.
�al��aca��m�z bu metnin uzun olmas� i�lemler s�ras�nda bize s�k�nt� ��kartacakt�r.
O y�zden bu metni bir de�ere atay�p i�lemlerimize devam edebiliriz.

A�a��da Harvard Business Review T�rkiye'den ald���m bir makalenin ilk paragraf�n� getirdim.

�imdi bu paragraf �zerinde baz� de�i�iklikler yapmak istiyoruz. 
Onun i�in ilk ba�ta metnimizi bir de�i�kene atayal�m.
Sorgular�m�zda bu de�i�keni kulanal�m.
*/

https://hbrturkiye.com/dergi/acemi-ceo-lar-neden-ustun-performans-gosterir

'Teoride
Acemi CEO�lar Neden �st�n Performans G�sterir?
Deneyimli y�neticiler eski taktiklere fazla g�veniyor.

Y�netim kurullar� en iyi CEO aday� aray���na y�ksek hedefler koyarak ba�layabilir. 
Fakat direkt�rler k�t� bir yedeklemenin, itibarlar�n� (ve elbette payda�lar�n�) zedeleme ihtimali oldu�unu bilir. 
Bu y�zden bir�ok durumda bir aday�n olumlu potansiyellerine odaklanmak yerine onlar� olumsuz 
etkileyebilecek risklerine odaklan�p kendilerine �u soruyu sorarlar: En g�venli se�im kim? 
Ba�ar�s�z olma ihtimali en d���k aday kim? Bu sorunun cevab� da genellikle 
en iyi i� pozisyonunda tecr�beye sahip aday olur. Nitekim yeni i�e al�nan CEO�lar�n 
i�inde i�e al�nmadan �nce ayn� pozisyonda �al��anlar�n say�s� 
1997�den bu yana d�rt kat�na ��kt� ve �imdi y�zde 16�l�k bir b�l�m� temsil ediyorlar.'

--DECLARE ile de�i�ken tan�mlan�r ve 
--@ ile de�i�ken oldu�u belirtilir.


DECLARE @HBR AS VARCHAR(MAX) 

SET @HBR='Teoride
Acemi CEO�lar Neden �st�n Performans G�sterir?
Deneyimli y�neticiler eski taktiklere fazla g�veniyor.'

SELECT @HBR