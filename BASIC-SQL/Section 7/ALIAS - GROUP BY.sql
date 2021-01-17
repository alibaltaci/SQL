--ALIAS KULLANIMI -- GROUP BY




----------ALIAS KULLANIMI ----------
--Alias bir tabloya k�saltma isim verilmesi i�lemidir.
--�ok fazla tablo �zerinde i�lem yap�lacaksa bu durum 
--kodlarda kar���kl�klar meydana getirebilcektir.
--Daha sade ve anl���l�r bir kod yazmak i�in kullan�labilir.

--USER_ bilgilerini ve ADDRES den de ADDRESSTEXT bilgilerini getirelim.
--1. m��teri i�in

SELECT U.*, A.ADDRESSTEXT FROM USER_ U JOIN ADDRES A ON U.ID=A.USERID WHERE U.ID=1


--�imdi i�leri daha karma��k hale getirelim.

--> USER_ tablosunda
--  Kullan�c� ad�, ad soyad, email, telnr1, telnr2
--> CITY tablosundan 
--  �l
--> TOWN tablosundan 
--  �l�e
--> DISTRICT tablosundan 
--  Mahalle
--> ADDRES tablosundan 
--  ADRES

--> Bu tablolardan gelen s�tunlar�n isimlerini soruda verildi�i gibi 
--T�rk�ele�tir.

--> Yani nihai ��kt� �u �ekilde olacak:

--> KULLANICI ADI, AD SOYAD, EMAIL, TELNR1, TELNR2, �L, �L�E, MAHALLE, ADRES

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, U.TELNR1, TELNR2,
C.CITY �L, T.TOWN SEHIR, D.DISTRICT MAHALLE, A.ADDRESSTEXT ADRES
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
JOIN TOWN T ON T.ID=A.TOWNID
JOIN DISTRICT D ON D.ID=A.DISTRICTID
WHERE U.ID=1




---------- GROUP BY KULLANIMI ----------

--GROUP BY kullan�rken GROUP BY k�sm�na kolonlara verilen isimleri yaz�lmaz.

--Burada �unu yapal�m:

--> KULLANICI ADI, AD SOYAD, EMAIL, TELEFON1, TELEFON2, ADRES SAYISI

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  --Bu ve benzeri i�lemler varsa GROUP BY da olacak...
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
WHERE U.ID=1
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2

--�imdi her m��terinin toplm adres say�s� gelsin 

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2

--Adres bilgileri b�y�kten k����e s�ralans�n

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2
ORDER BY ADRESSAYISI DESC

--Adres say�s� 1 tane olanlara bakal�m.

SELECT U.USERNAME_ KULLANICIADI, U.NAMESURNAME ADSOYAD, U.EMAIL, 
U.TELNR1 TELEFON1, U.TELNR2 TELEFON2, 
COUNT(A.ID) ADRESSAYISI  
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
GROUP BY U.USERNAME_, U.NAMESURNAME, U.EMAIL, U.TELNR1, U.TELNR2
HAVING COUNT(A.ID)=1


--Hangi �ehirde ka� m��terimiz var.

SELECT C.CITY SEHIR, COUNT(U.ID) MUSTERISAYISI
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
GROUP BY C.CITY
ORDER BY 2 DESC


--M��terinin toplam adres say�s� ve bu adresler ka� farkl� �ehirden.

SELECT U.NAMESURNAME ADSOYAD, COUNT(A.ID) ADRESSAYISI, COUNT(DISTINCT C.CITY) FARKLIADRESSAYISI
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
GROUP BY U.NAMESURNAME

--�imdi bu m��erilerden adres say�s� ve farkl� adres say�s� farkl� olanlar� getirelim.

SELECT U.NAMESURNAME ADSOYAD, COUNT(A.ID) ADRESSAYISI, 
COUNT(DISTINCT C.CITY) FARKLIADRESSAYISI
FROM USER_ U
JOIN ADDRES A ON U.ID=A.USERID
JOIN CITY C ON C.ID=A.CITYID
GROUP BY U.NAMESURNAME
HAVING COUNT(A.ID) <> COUNT(DISTINCT C.CITY)