--ALIAS KULLANIMI -- GROUP BY




----------ALIAS KULLANIMI ----------
--Alias bir tabloya kýsaltma isim verilmesi iþlemidir.
--çok fazla tablo üzerinde iþlem yapýlacaksa bu durum 
--kodlarda karýþýklýklar meydana getirebilcektir.
--Daha sade ve anlýþýlýr bir kod yazmak için kullanýlabilir.

--USER_ bilgilerini ve ADDRES den de ADDRESSTEXT bilgilerini getirelim.
--1. müþteri için

SELECT U.*, A.ADDRESSTEXT FROM USER_ U JOIN ADDRES A ON U.ID=A.USERID WHERE U.ID=1


--Þimdi iþleri daha karmaþýk hale getirelim.

--> USER_ tablosunda
--  Kullanýcý adý, ad soyad, email, telnr1, telnr2
--> CITY tablosundan 
--  Ýl
--> TOWN tablosundan 
--  Ýlçe
--> DISTRICT tablosundan 
--  Mahalle
--> ADDRES tablosundan 
--  ADRES

--> Bu tablolardan gelen sütunlarýn isimlerini soruda verildiði gibi 
--Türkçeleþtir.

--> Yani nihai çýktý þu þekilde olacak:

--> KULLANICI ADI, AD SOYAD, EMAIL, TELNR1, TELNR2, ÝL, ÝLÇE, MAHALLE, ADRES

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, U.TELNR1, TELNR2,
C.CITY ÝL, T.TOWN SEHIR, D.DISTRICT MAHALLE, A.ADDRESSTEXT ADRES
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
JOIN TOWN T ON T.ID=A.TOWNID
JOIN DISTRICT D ON D.ID=A.DISTRICTID
WHERE U.ID=1




---------- GROUP BY KULLANIMI ----------

--GROUP BY kullanýrken GROUP BY kýsmýna kolonlara verilen isimleri yazýlmaz.

--Burada þunu yapalým:

--> KULLANICI ADI, AD SOYAD, EMAIL, TELEFON1, TELEFON2, ADRES SAYISI

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  --Bu ve benzeri iþlemler varsa GROUP BY da olacak...
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
WHERE U.ID=1
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2

--Þimdi her müþterinin toplm adres sayýsý gelsin 

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2

--Adres bilgileri büyükten küçüðe sýralansýn

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2
ORDER BY ADRESSAYISI DESC

--Adres sayýsý 1 tane olanlara bakalým.

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2
HAVING COUNT(A.ID)=1


--Hangi þehirde kaç müþterimiz var.

SELECT C.CITY SEHIR, COUNT(U.ID) MUSTERISAYISI
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
GROUP BY C.CITY
ORDER BY 2 DESC


--Müþterinin toplam adres sayýsý ve bu adresler kaç farklý þehirden.

SELECT U.NAMESURNAME ADSOYAD, COUNT(A.ID) ADRESSAYISI, COUNT(DISTINCT C.CITY) FARKLIADRESSAYISI
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
GROUP BY U.NAMESURNAME

--Þimdi bu müþerilerden adres sayýsý ve farklý adres sayýsý farklý olanlarý getirelim.

SELECT U.NAMESURNAME ADSOYAD, COUNT(A.ID) ADRESSAYISI, 
COUNT(DISTINCT C.CITY) FARKLIADRESSAYISI
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
GROUP BY U.NAMESURNAME
HAVING COUNT(A.ID) <> COUNT(DISTINCT C.CITY)