#encoding: utf-8

#Sending many parameters
if Rack::Utils.respond_to?("key_space_limit=")
  Rack::Utils.key_space_limit = 123456789
end

DESCRIPTION = "Flairspring - Bútor, lámpa, tükör, komfort fotel"
KEYWORDS = "Flairspring keywords - Bútor, lámpa, tükör, komfort fotel"

SEARCH_TERMS = "kör alakú tükrök,modern tükrök,órák,könyvtámasz,festmények,absztrakt faldekor,hintázó komfort fotelek,motoros komfort fotelek,bőrkanapé,vendégágyas kanapék,komódok,dohányzó asztalok,asztali lámpa,állólámpa,csillárok".split(",")

PERSONAL_DISCOUNT = 0.03

MELYSEG = 74
SZELESSEG = 75
MAGASSAG = 76
SULY = 77

#Napban
NEW_PRODUCT_DAYS = 14

#Szállítási idők
#Uttermost - 1
#La-z-boy - 2
SHIPPING = {1 => "3-8 hét", 2 => "3 hónap"}