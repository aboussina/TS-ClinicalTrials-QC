%*=========================================================;
%* Title:  STANAG1059.sas                                  ;
%*                                                         ;
%* Author:  Aaron Boussina                                 ;
%*                                                         ;
%* Purpose:  Allow for conversion of STANAG 1059 country   ;
%*           names to standard 3 letter codes.             ;
%*           Source: https://evs.nci.nih.gov/ftp1/         ;
%*                                                         ;
%* Revisions:                                              ;
%* AB 22OCT2020:  N/A, Initial Release                     ;
%*=========================================================;

proc format;

value $stanag
	"Afghanistan"	=	"AFG"
	"Albania"	=	"ALB"
	"Algeria"	=	"DZA"
	"American Samoa"	=	"ASM"
	"Andorra"	=	"AND"
	"Angola"	=	"AGO"
	"Anguilla"	=	"AIA"
	"Antarctica"	=	"ATA"
	"Antigua and Barbuda"	=	"ATG"
	"Argentina"	=	"ARG"
	"Armenia"	=	"ARM"
	"Aruba"	=	"ABW"
	"Australia"	=	"AUS"
	"Austria"	=	"AUT"
	"Azerbaijan"	=	"AZE"
	"Bahamas"	=	"BHS"
	"Bahrain"	=	"BHR"
	"US Minor Outlying Islands"	=	"UMI"
	"Bangladesh"	=	"BGD"
	"Barbados"	=	"BRB"
	"French Southern Territories"	=	"ATF"
	"Belarus"	=	"BLR"
	"Belgium"	=	"BEL"
	"Belize"	=	"BLZ"
	"Benin"	=	"BEN"
	"Bermuda"	=	"BMU"
	"Bhutan"	=	"BTN"
	"Bolivia"	=	"BOL"
	"Netherlands Antilles"	=	"ANT"
	"Bosnia and Herzegovina"	=	"BIH"
	"Botswana"	=	"BWA"
	"Bouvet Island"	=	"BVT"
	"Brazil"	=	"BRA"
	"British Indian Ocean Territory"	=	"IOT"
	"Brunei Darussalam"	=	"BRN"
	"Bulgaria"	=	"BGR"
	"Burkina Faso"	=	"BFA"
	"Myanmar"	=	"MMR"
	"Burundi"	=	"BDI"
	"Cape Verde"	=	"CPV"
	"Cambodia"	=	"KHM"
	"Cameroon"	=	"CMR"
	"Canada"	=	"CAN"
	"Cayman Islands"	=	"CYM"
	"Central African Republic"	=	"CAF"
	"Chad"	=	"TCD"
	"Chile"	=	"CHL"
	"China"	=	"CHN"
	"Christmas Island"	=	"CXR"
	"France"	=	"FRA"
	"Cocos (Keeling) Islands"	=	"CCK"
	"Colombia"	=	"COL"
	"Comoros"	=	"COM"
	"Congo"	=	"COG"
	"Congo, The Democratic Republic of the"	=	"COD"
	"Cook Islands"	=	"COK"
	"Costa Rica"	=	"CRI"
	"Cote D’Ivoire (Ivory Coast)"	=	"CIV"
	"Croatia (Hrvatska)"	=	"HRV"
	"Cuba"	=	"CUB"
	"Cyprus"	=	"CYP"
	"Czech Republic"	=	"CZE"
	"Denmark"	=	"DNK"
	"Djibouti"	=	"DJI"
	"Dominica"	=	"DMA"
	"Dominican Republic"	=	"DOM"
	"Ecuador"	=	"ECU"
	"Egypt"	=	"EGY"
	"El Salvador"	=	"SLV"
	"Equatorial Guinea"	=	"GNQ"
	"Eritrea"	=	"ERI"
	"Estonia"	=	"EST"
	"Ethiopia"	=	"ETH"
	"Falkland Islands (Malvinas)"	=	"FLK"
	"Faroe Islands"	=	"FRO"
	"Fiji"	=	"FJI"
	"Finland"	=	"FIN"
	"French Guiana"	=	"GUF"
	"French Polynesia"	=	"PYF"
	"Gabon"	=	"GAB"
	"Gambia"	=	"GMB"
	"Palestinian Territory, Occupied"	=	"PSE"
	"Georgia"	=	"GEO"
	"Germany"	=	"DEU"
	"Ghana"	=	"GHA"
	"Gibraltar"	=	"GIB"
	"Greece"	=	"GRC"
	"Greenland"	=	"GRL"
	"Grenada"	=	"GRD"
	"Guadeloupe"	=	"GLP"
	"Guam"	=	"GUM"
	"Guatemala"	=	"GTM"
	"United Kingdom"	=	"GBR"
	"Guinea"	=	"GIN"
	"Guinea-Bissau"	=	"GNB"
	"Guyana"	=	"GUY"
	"Haiti"	=	"HTI"
	"Heard Island and McDonald Islands"	=	"HMD"
	"Honduras"	=	"HND"
	"Hong Kong"	=	"HKG"
	"Hungary"	=	"HUN"
	"Iceland"	=	"ISL"
	"India"	=	"IND"
	"Indonesia"	=	"IDN"
	"Iran, Islamic Republic of"	=	"IRN"
	"Iraq"	=	"IRQ"
	"Ireland"	=	"IRL"
	"Israel"	=	"ISR"
	"Italy"	=	"ITA"
	"Jamaica"	=	"JAM"
	"Svalbard and Jan Mayen Islands"	=	"SJM"
	"Japan"	=	"JPN"
	"Jordan"	=	"JOR"
	"Kazakhstan"	=	"KAZ"
	"Kenya"	=	"KEN"
	"Kiribati"	=	"KIR"
	"Korea, Democratic People’s Republic of"	=	"PRK"
	"Korea, Republic of"	=	"KOR"
	"Kuwait"	=	"KWT"
	"Kyrgyzstan"	=	"KGZ"
	"Lao People’s Democratic Republic"	=	"LAO"
	"Latvia"	=	"LVA"
	"Lebanon"	=	"LBN"
	"Lesotho"	=	"LSO"
	"Liberia"	=	"LBR"
	"Libyan Arab Jamahiriya"	=	"LBY"
	"Liechtenstein"	=	"LIE"
	"Lithuania"	=	"LTU"
	"Luxembourg"	=	"LUX"
	"Macao"	=	"MAC"
	"The Former Yugoslav Republic of Macedonia"	=	"FYR"
	"Madagascar"	=	"MDG"
	"Malawi"	=	"MWI"
	"Malaysia"	=	"MYS"
	"Maldives"	=	"MDV"
	"Mali"	=	"MLI"
	"Malta"	=	"MLT"
	"Marshall Islands"	=	"MHL"
	"Martinique"	=	"MTQ"
	"Mauritania"	=	"MRT"
	"Mauritius"	=	"MUS"
	"Mayotte"	=	"MYT"
	"Mexico"	=	"MEX"
	"Micronesia, Federated States of"	=	"FSM"
	"Moldova, Republic of"	=	"MDA"
	"Monaco"	=	"MCO"
	"Mongolia"	=	"MNG"
	"Montenegro"	=	"MNE"
	"Montserrat"	=	"MSR"
	"Morocco"	=	"MAR"
	"Mozambique"	=	"MOZ"
	"Namibia"	=	"NAM"
	"Nauru"	=	"NRU"
	"Nepal"	=	"NPL"
	"Netherlands"	=	"NLD"
	"New Caledonia"	=	"NCL"
	"New Zealand"	=	"NZL"
	"Nicaragua"	=	"NIC"
	"Niger"	=	"NER"
	"Nigeria"	=	"NGA"
	"Niue"	=	"NIU"
	"Norfolk Island"	=	"NFK"
	"Northern Mariana Islands"	=	"MNP"
	"Norway"	=	"NOR"
	"Oman"	=	"OMN"
	"Pakistan"	=	"PAK"
	"Palau"	=	"PLW"
	"Panama"	=	"PAN"
	"Papua New Guinea"	=	"PNG"
	"Taiwan, Province of China"	=	"TWN"
	"Viet Nam"	=	"VNM"
	"Paraguay"	=	"PRY"
	"Peru"	=	"PER"
	"Philippines"	=	"PHL"
	"Pitcairn"	=	"PCN"
	"Poland"	=	"POL"
	"Portugal"	=	"PRT"
	"Puerto Rico"	=	"PRI"
	"Qatar"	=	"QAT"
	"Reunion"	=	"REU"
	"Romania"	=	"ROU"
	"Russian Federation"	=	"RUS"
	"Rwanda"	=	"RWA"
	"Saint Helena"	=	"SHN"
	"Saint Kitts and Nevis"	=	"KNA"
	"Saint Lucia"	=	"LCA"
	"Saint Pierre and Miquelon"	=	"SPM"
	"Saint Vincent and the Grenadines"	=	"VCT"
	"Samoa"	=	"WSM"
	"San Marino"	=	"SMR"
	"Sao Tome and Principe"	=	"STP"
	"Saudi Arabia"	=	"SAU"
	"Senegal"	=	"SEN"
	"Serbia"	=	"SRB"
	"Seychelles"	=	"SYC"
	"Sierra Leone"	=	"SLE"
	"Singapore"	=	"SGP"
	"Slovakia"	=	"SVK"
	"Slovenia"	=	"SVN"
	"Solomon Islands"	=	"SLB"
	"Somalia"	=	"SOM"
	"South Africa"	=	"ZAF"
	"South Georgia and South Sandwich Islands"	=	"SGS"
	"Spain"	=	"ESP"
	"Sri Lanka"	=	"LKA"
	"Sudan"	=	"SDN"
	"Suriname"	=	"SUR"
	"Swaziland"	=	"SWZ"
	"Sweden"	=	"SWE"
	"Switzerland"	=	"CHE"
	"Syrian Arab Republic"	=	"SYR"
	"Tajikistan"	=	"TJK"
	"Tanzania, United Republic of"	=	"TZA"
	"Thailand"	=	"THA"
	"Timor-Leste"	=	"TLS"
	"Togo"	=	"TGO"
	"Tokelau"	=	"TKL"
	"Tonga"	=	"TON"
	"Trinidad and Tobago"	=	"TTO"
	"Tunisia"	=	"TUN"
	"Turkey"	=	"TUR"
	"Turkmenistan"	=	"TKM"
	"Turks and Caicos Islands"	=	"TCA"
	"Tuvalu"	=	"TUV"
	"Uganda"	=	"UGA"
	"Ukraine"	=	"UKR"
	"United Arab Emirates"	=	"ARE"
	"United States"	=	"USA"
	"Uruguay"	=	"URY"
	"Uzbekistan"	=	"UZB"
	"Vanuatu"	=	"VUT"
	"Holy See (Vatican City State)"	=	"VAT"
	"Venezuela"	=	"VEN"
	"Virgin Islands (British)"	=	"VGB"
	"Virgin Islands (U.S.)"	=	"VIR"
	"Wallis and Futuna Islands"	=	"WLF"
	"Western Sahara"	=	"ESH"
	"Yemen"	=	"YEM"
	"Zambia"	=	"ZMB"
	"Zimbabwe"	=	"ZWE"
	;
run;
