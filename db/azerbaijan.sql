CREATE DATABASE azerbaijan DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE azerbaijan; 

CREATE TABLE regions(
    region_id INT(4) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    region_name VARCHAR(50) NOT NULL, 
    area FLOAT(10, 2) NOT NULL,
    population INT NOT NULL
);


INSERT INTO regions (region_name, area, population)
VALUES
("Absheron", 5420, 2613300),
("Ganja-Qazakh", 12480, 1191700),
("Shaki-Zaqatala", 8969, 543400),
("Lankaran", 6140, 926500),
("Guba-Khachmaz", 6960, 498400),
("Aran", 23375, 1893036),
("Upper Karabakh", 7253.5, 628200),
("Kalbajar-Lachin", 6400, 231300),
("Mountainous Shirvan", 6060, 287800),
("Nakhchivan", 5550, 414900);


SELECT * FROM regions;

CREATE TABLE administrative_divisions(
    division_id INT(4) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    division_name VARCHAR(40) NOT NULL,
    azerbaijani_name VARCHAR(40) NOT NULL,
    capital VARCHAR(40) ,
    area FLOAT(10, 2) NOT NULL,
    population INT NOT NULL,
    region VARCHAR(40) NOT NULL,
    notes VARCHAR(255)
);

INSERT INTO administrative_divisions (division_name, azerbaijani_name, capital, area, population, region, notes)
VALUES
("Absheron District", "Abşeron", "Xirdalan", "1360", "192900", "Absheron", "Includes an exclave in Baku"),
("Aghjabadi District", "Ağcabədi", "Aghjabadi", "1760", "124000", "Aran", NULL),
("Agdam District", "Ağdam", "Alibeyli", "1150", "180600", "Yukhari-Karabakh",	NULL),
("Agdash District", "Ağdaş", "Agdash", "1050", "100600", "Aran", NULL),
("Agstafa District", "Ağstafa", "Agstafa", "1500", "81400", "Ganja-Qazakh", NULL),
("Agsu District", "Ağsu", "Agsu", "1020", "72100", "Daglig-Shirvan", NULL),
("Shirvan (city)", "Şirvan", NULL, "30", "78700", "Aran", "Named Ali Bayramli (Əli Bayramlı) until April 24, 2008"),
("Astara District", "Astara", "Astara", "620", "98300", "Lankaran", NULL),
("Baku (city)", "Bakı", NULL, "2130", "2092400", "Absheron", "Comprising 12 rayonlar it is the capital and largest city of Azerbaijan"),
("Balakan District", "Balakən", "Balakan", "920", "91100", "Shaki-Zaqatala", NULL),
("Barda District", "Bərdə", "Barda", "960", "143900", "Aran", NULL),
("Beylagan District", "Beyləqan", "Beylagan", "1130", "87900", "Aran", NULL),
("Bilasuvar District", "Biləsuvar", "Bilasuvar", "1400", "90300", "Aran", NULL),
("Jabrayil District", "Cəbrayıl", "Jabrayil", "1050", "72700", "Yukhari-Karabakh", NULL),
("Jalilabad District", "Cəlilabad", "Jalilabad", "1440", "196500", "Lankaran", NULL),
("Dashkasan District", "Daşkəsən", "Daşkəsən", "1050", "33200", "Ganja-Qazakh", NULL),
("Shabran District", "Şabran", "Shabran", "1090", "53000", "Quba-Khachmaz", "Named Davachi (Dəvəçi) until 2010"),
("Fuzuli District",	"Füzuli", "Füzuli", "1390", "118900", "Yukhari-Karabakh", NULL),
("Gadabay District", "Gədəbəy", "Gadabay", "1290", "95000" ,"Ganja-Qazakh", NULL),
("Ganja (city)", "Gəncə", NULL,	"110", "316300", "Ganja-Qazakh", "Azerbaijan's second-largest city"),
("Goranboy District", "Goranboy", "Goranboy", "1760", "96200", "Ganja-Qazakh", NULL),
("Goychay District", 	"Göyçay",	"Goychay",	"740",	"111100",	"Aran", NULL),
("Hajigabul District",	"Hacıqabul",	"Hajiqabul",	"1640",	"67300",	"Aran",	NULL),
("Imishli District",	"İmişli",	"Imishli",	"1820",	"116600",	"Aran",	NULL),
("Ismailli District",	"İsmayıllı",	"Ismailli",	"2060",	"80900",	"Daglig-Shirvan", NULL),
("Kalbajar District",	"Kəlbəcər",	"Kalbajar",	3050,	83200,	"Kalbajar-Lachin", NULL),
("Kurdamir District",	"Kürdəmir",	"Kurdamir",	1630,	105700,	"Aran",	NULL),
("Lachin District",	"Laçın",	"Lachin",	1840,	70900,	"Kalbajar-Lachin", NULL),
("Lankaran District",	"Lənkəran",	"Lankaran",	1540,	209900,	"Lankaran",	NULL),
("Lankaran (city)",	"Lənkəran",	NULL,	70,	83300,	"Lankaran",	NULL),
("Lerik District",	"Lerik",	"Lerik",	1080,	76400,	"Lankaran",	NULL),
("Masally District",	"Masallı",	"Masally",	720,	202500,	"Lankaran", NULL),
("Mingachevir (city)",	"Mingəçevir",	NULL,	130,	97800,	"Aran", NULL),	
("Naftalan (city)",	"Naftalan",	NULL,	30,	9100,	"Ganja-Qazakh", NULL),	
("Neftchala District",	"Neftçala",	"Neftchala",	1450,	81300,	"Aran" , NULL),	
("Oghuz District",	"Oğuz",	"Oghuz",	1220,	40900,	"Shaki-Zaqatala",	NULL),
("Qabala District",	"Qəbələ",	"Qabala",	1550,	95600,	"Shaki-Zaqatala", NULL),	
("Qakh District",	"Qax",	"Qakh",	1490,	53900,	"Shaki-Zaqatala",	NULL),
("Qazakh District",	"Qazax",	"Qazakh",	700,	90800,	"Ganja-Qazakh",	NULL),
("Gobustan District",	"Qobustan",	"Gobustan",	1370,	41100,	"Daglig-Shirvan",	NULL),
("Quba District",	"Quba",	"Quba",	2580,	155600,	"Quba-Khachmaz",	NULL),
("Qubadli District",	"Qubadlı",	"Qubadli",	800,	36700,	"Kalbajar-Lachin",	NULL),
("Qusar District",	"Qusar",	"Qusar",	1540,	89300,	"Quba-Khachmaz",	NULL),
("Saatly District",	"Saatlı",	"Saatly",	1180,	95100,	"Aran",	NULL),
("Sabirabad District",	"Sabirabad",	"Sabirabad",	1470,	155400,	"Aran",	NULL),
("Shaki District",	"Şəki",	"Shaki",	2430,	173500,	"Shaki-Zaqatala",	NULL),
("Shaki (city)",	"Şəki",	NULL,	9,	63700,	"Shaki-Zaqatala",	NULL),
("Salyan District",	"Salyan",	"Salyan",	1790,	124900,	"Aran",	NULL),
("Shamakhi District",	"Şamaxı",	"Shamakhi",	1610,	93700,	"Daglig-Shirvan", NULL),	
("Shamkir District",	"Şəmkir",	"Shamkir",	1660,	196100,	"Ganja-Qazakh",	NULL),
("Samukh District",	"Samux",	"Nebiagali",	1450,	54600,	"Ganja-Qazakh",	NULL),
("Siazan District",	"Siyəzən",	"Siazan",	700,	38400,	"Quba-Khachmaz",	NULL),
("Sumqayit (city)",	"Sumqayıt",	NULL,	80,	314800,	"Absheron",	NULL),
("Shusha District",	"Şuşa",	"Shusha",	290,	29700,	"Yukhari-Karabakh", NULL),
("Shusha (city)",	"Şuşa",	NULL,	5.5,	4100,	"Yukhari-Karabakh",	NULL),
("Tartar District",	"Tərtər",	"Tartar",	960,	98400,	"Yukhari-Karabakh",	NULL),
("Tovuz District",	"Tovuz",	"Tovuz",	1900,	160700,	"Ganja-Qazakh",	NULL),
("Ujar District",	"Ucar",	"Ujar",	850,	79800,	"Aran",	NULL),
("Khachmaz District",	"Xaçmaz",	"Khachmaz",	1050,	162100,	"Quba-Khachmaz",	NULL),
("Khankendi (city)",	"Xankəndi", NULL,		8,	55200,	"Yukhari-Karabakh",	NULL),
("Goygol District",	"Göygöl",	"Goygol",	1030,	58300,	"Ganja-Qazakh",	"Formerly Khanlar"),
("Khizi District",	"Xızı",	"Khizi",	1850,	14700,	"Absheron", NULL),
("Khojaly District", "Xocalı", "Khojali", 940,	26500,	"Yukhari-Karabakh",	NULL),
("Khojavend District",	"Xocavənd",	"Khojavend",	1460,	42100,	"Yukhari-Karabakh",	NULL),
("Yardymli District",	"Yardımlı",	"Yardymli",	670,	59600,	"Lankaran", NULL),
("Yevlakh District",	"Yevlax",	"Yevlakh",	1540,	119600,	"Aran",	NULL),
("Yevlakh (city)",	"Yevlax", NULL,		95,	59036,	"Aran",	NULL),
("Zangilan District",	"Zəngilan",	"Zangilan",	710, 40500,	"Kalbajar-Lachin", NULL),
("Zaqatala District",	"Zaqatala",	"Zaqatala",	1350,	120300,	"Shaki-Zaqatala",	NULL),
("Zardab District",	"Zərdab",	"Zardab",	860,	54000,	"Aran",	NULL);



