--JOIN ��LEMLER�



--JOIN GENEL

--T�m kullan�c�lar.

SELECT * FROM USER_

--ID = 1

SELECT * FROM USER_ WHERE ID=1

-- ID 1'in Adres bilgileri.

SELECT * FROM ADDRES WHERE USERID=1

--4 farkl� adres geldi.

--1. Kullan�c�n�n USER_ Tablosundan
--Kullan�c� ad�, ad� soyad�, mail adresi, 
--1 ve 2. telefon numaralar� gelsin.
--ADDRES tablosundan Adresleri gelsin.

--��lemleri ayr� ayr� yapal�m. Sonra birle�tirelim.

--1.Ad�m
SELECT USERNAME_, NAMESURNAME, EMAIL, TELNR1, TELNR2
FROM USER_ WHERE ID=1

--2.Ad�m
SELECT ADDRESSTEXT FROM ADDRES WHERE USERID=1

--JOIN kullanarak farkl� taablolarda bulunan bilgileri birle�tirebiliriz.

SELECT USER_.USERNAME_, USER_.NAMESURNAME, USER_.EMAIL, USER_.TELNR1, USER_.TELNR2,
ADDRES.ADDRESSTEXT
FROM USER_
JOIN ADDRES ON USER_.ID=ADDRES.USERID
WHERE USER_.ID=1

--Bu t�r i�lemlerde hangi tablodan neyi �ekece�imizi "." yard�m� ile belirtmi� oluyoruz.
--Ayn� alan ba�ka tablolarda tekrar ediyorsa kar���kl�k ��kmamas� ad�na . ile ba�lamak 
--�nem arz etmektedir.




--INNER JOIN

--JOIN VE INNER JOIN AYNIDIR.........

--Kesi�im k�mesi olan k�sm� bize getirir. 
--E�er bir tablodaki bilginin di�er tabloda bir kar���� yoksa o sat�r gelmez.

--�lk kullan�c�n� USER_ VE ADDRES tablosundaki t�m bilgilerini getirelim.

SELECT * FROM USER_ 
JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID=1

--Ayn� �ekilde sadece USER_ tablosundaki bilgileri getirelim.

SELECT USER_.* FROM USER_
JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID=1

-- 2 Numaral� m��terinin addres tablosundaki bilgilerni silelim.

DELETE FROM ADDRES WHERE USERID=2 

--�imdi bu m��terimiz i�in USER_ ve ADDRES bilgilerini getirmeye �al��al�m.

SELECT * FROM USER_ JOIN ADDRES ON USER_.ID=ADDRES.USERID WHERE USER_.ID=2

--Hi�bir �ey gelmedi neden? ��nk� bir kesi�im k�mesi yok.

--Ayn� kullan�c�n�n sadece USER_ tablosundaki bilgilere bakal�m.

SELECT * FROM USER_ WHERE ID=2

--geldi.




-- LEFT JOIN

--Sol tblodaki t�m de�erleri getirir, e�er sol tablodaki bir de�erin 
--sa� tabloda bir kar��l��� yoksa sa� tabloda null de�eri gelir.
--E�er sa� tablodaki bir de�erin sol tabloda bir kar���� yoksa 
--sa� tarafdaki de�er gelmez.




-- RIGHT JOIN

-- LEFT JOIN a��klamas�n�n tam tersi :)




-- FULL JOIN 

-- Birle�im k�mesidir.

--Tablolardaki bilgileri di�er tablolarda kar��l��� olmasa dahi gelirler ve null 
--de�er al�rlar.




--�RNEKLER �LE DAHA �Y� ANLAMAYA �ALI�ALIM.

--Yukar�da anlat�rken kullan�lan sa� sol meselesi neye g�re belirleniyor?
--Hangi tablo sa�da hangi tablo solda?

--Buna "=" ile karar veriyoruz.
--Yani SOL TARAF = SA� TARAF
--Yani LEFT JOIN = RIGHT JOIN

--�imdi 10, 11, 12 nolu kullan�c�lar�n�n isimlerini ve addres bilgilerini getirelim.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
INNER JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10, 11, 12)

--Kesi�imler geldi. Hepsinin kar��l��� varm��.

--12 nolu m��terimizi silelim (ADDRES DEN )

DELETE FROM ADDRES WHERE USERID=12

--INNER JOIN ile tekrardan bakal�m.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_ 
JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10, 11, 12)

--102 Nolu m��terinin adres bilgisi var ama user bilgileri gitti�i i�in 
--kesi�im k�mesine giremedi ve burada gelmedi.

--�imdi ayn� i�lemi LEFT JOIN ile deneyelim.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
LEFT JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10,11,12)

--Tablo ayn� neden? ��nk� solu esas ald�k ve soldaki tabloda bilgi yok.
--sa��n solda bir kar��l��� olmay�nca sa� gelemedi.

--Tam tersini yaparsak ayn� kod ile RIGHT JOIN i�lemi yapal�m.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
RIGHT JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10,11,12)

--NOT:
--Genelde veri b�t�nl���n�n bozulmamas� i�in LEFT JOIN kullan�l�r.

--S�ra "FULL JOIN" de

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
FULL JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10,11,12)

--Hepsini getirdi.

--NOT:
--RIGHT OUTHER JOIN gibi kullan�mlar da mevcuttur ayn� i�lemi ifade eder.
--Farkl� programlarda olabilmektedir.
--Burada yazmaya gerek yok.

