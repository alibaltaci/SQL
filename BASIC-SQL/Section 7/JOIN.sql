--JOIN ÝÞLEMLERÝ



--JOIN GENEL

--Tüm kullanýcýlar.

SELECT * FROM USER_

--ID = 1

SELECT * FROM USER_ WHERE ID=1

-- ID 1'in Adres bilgileri.

SELECT * FROM ADDRES WHERE USERID=1

--4 farklý adres geldi.

--1. Kullanýcýnýn USER_ Tablosundan
--Kullanýcý adý, adý soyadý, mail adresi, 
--1 ve 2. telefon numaralarý gelsin.
--ADDRES tablosundan Adresleri gelsin.

--Ýþlemleri ayrý ayrý yapalým. Sonra birleþtirelim.

--1.Adým
SELECT USERNAME_, NAMESURNAME, EMAIL, TELNR1, TELNR2
FROM USER_ WHERE ID=1

--2.Adým
SELECT ADDRESSTEXT FROM ADDRES WHERE USERID=1

--JOIN kullanarak farklý taablolarda bulunan bilgileri birleþtirebiliriz.

SELECT USER_.USERNAME_, USER_.NAMESURNAME, USER_.EMAIL, USER_.TELNR1, USER_.TELNR2,
ADDRES.ADDRESSTEXT
FROM USER_
JOIN ADDRES ON USER_.ID=ADDRES.USERID
WHERE USER_.ID=1

--Bu tür iþlemlerde hangi tablodan neyi çekeceðimizi "." yardýmý ile belirtmiþ oluyoruz.
--Ayný alan baþka tablolarda tekrar ediyorsa karýþýklýk çýkmamasý adýna . ile baðlamak 
--önem arz etmektedir.




--INNER JOIN

--JOIN VE INNER JOIN AYNIDIR.........

--Kesiþim kümesi olan kýsmý bize getirir. 
--Eðer bir tablodaki bilginin diðer tabloda bir karþýðý yoksa o satýr gelmez.

--Ýlk kullanýcýný USER_ VE ADDRES tablosundaki tüm bilgilerini getirelim.

SELECT * FROM USER_ 
JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID=1

--Ayný þekilde sadece USER_ tablosundaki bilgileri getirelim.

SELECT USER_.* FROM USER_
JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID=1

-- 2 Numaralý müþterinin addres tablosundaki bilgilerni silelim.

DELETE FROM ADDRES WHERE USERID=2 

--Þimdi bu müþterimiz için USER_ ve ADDRES bilgilerini getirmeye çalýþalým.

SELECT * FROM USER_ JOIN ADDRES ON USER_.ID=ADDRES.USERID WHERE USER_.ID=2

--Hiçbir þey gelmedi neden? çünkü bir kesiþim kümesi yok.

--Ayný kullanýcýnýn sadece USER_ tablosundaki bilgilere bakalým.

SELECT * FROM USER_ WHERE ID=2

--geldi.




-- LEFT JOIN

--Sol tblodaki tüm deðerleri getirir, eðer sol tablodaki bir deðerin 
--sað tabloda bir karþýlýðý yoksa sað tabloda null deðeri gelir.
--Eðer sað tablodaki bir deðerin sol tabloda bir karþýðý yoksa 
--sað tarafdaki deðer gelmez.




-- RIGHT JOIN

-- LEFT JOIN açýklamasýnýn tam tersi :)




-- FULL JOIN 

-- Birleþim kümesidir.

--Tablolardaki bilgileri diðer tablolarda karþýlýðý olmasa dahi gelirler ve null 
--deðer alýrlar.




--ÖRNEKLER ÝLE DAHA ÝYÝ ANLAMAYA ÇALIÞALIM.

--Yukarýda anlatýrken kullanýlan sað sol meselesi neye göre belirleniyor?
--Hangi tablo saðda hangi tablo solda?

--Buna "=" ile karar veriyoruz.
--Yani SOL TARAF = SAÐ TARAF
--Yani LEFT JOIN = RIGHT JOIN

--Þimdi 10, 11, 12 nolu kullanýcýlarýnýn isimlerini ve addres bilgilerini getirelim.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
INNER JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10, 11, 12)

--Kesiþimler geldi. Hepsinin karþýlýðý varmýþ.

--12 nolu müþterimizi silelim (ADDRES DEN )

DELETE FROM ADDRES WHERE USERID=12

--INNER JOIN ile tekrardan bakalým.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_ 
JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10, 11, 12)

--102 Nolu müþterinin adres bilgisi var ama user bilgileri gittiði için 
--kesiþim kümesine giremedi ve burada gelmedi.

--Þimdi ayný iþlemi LEFT JOIN ile deneyelim.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
LEFT JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10,11,12)

--Tablo ayný neden? çünkü solu esas aldýk ve soldaki tabloda bilgi yok.
--saðýn solda bir karþýlýðý olmayýnca sað gelemedi.

--Tam tersini yaparsak ayný kod ile RIGHT JOIN iþlemi yapalým.

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
RIGHT JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10,11,12)

--NOT:
--Genelde veri bütünlüðünün bozulmamasý için LEFT JOIN kullanýlýr.

--Sýra "FULL JOIN" de

SELECT USER_.NAMESURNAME, ADDRES.* FROM USER_
FULL JOIN ADDRES ON ADDRES.USERID=USER_.ID
WHERE USER_.ID IN (10,11,12)

--Hepsini getirdi.

--NOT:
--RIGHT OUTHER JOIN gibi kullanýmlar da mevcuttur ayný iþlemi ifade eder.
--Farklý programlarda olabilmektedir.
--Burada yazmaya gerek yok.

