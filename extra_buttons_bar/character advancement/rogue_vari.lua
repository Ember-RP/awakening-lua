-- Documentation {5176, 2, 0, 1} {Spellid, Ability Essence,  Talent Essence, Required Level}
-- Make sure to adjust Count if you add or subtract any spells
-- talent documentation {5,{16814,16814,16814,16814,16814},0,1,10,2,762} {number of ranks, {spellids}, AE cost, TE cost, required level,
-- 																															column, talentId}
-- talents tab variables refers to talenttab dbc

rogue_assassination_spells = {{2098, 2, 0, 1}, {5171, 2, 0, 10}, {8647, 2, 0, 14}, {703, 2, 0, 14}, {8676, 2, 0, 18},
{1943, 2, 0, 20}, {2842, 2, 0, 20}, {1833, 2, 0, 26}, {408, 2, 0, 30}, {32645, 2, 0, 62}, {26679, 2, 0, 64}, {51722, 2, 0, 80}}

rogue_assassination_spells_count = 12
rogue_assassination_bgs = {"Interface\\TalentFrame\\RogueAssassination-TopLeft", "Interface\\TalentFrame\\RogueAssassination-TopRight",
"Interface\\TalentFrame\\RogueAssassination-BottomLeft", "Interface\\TalentFrame\\RogueAssassination-BottomRight"}

rogue_assassination_talents = {{3,{14162,14163,14164},0,1,10,1,276}, {2,{14144,14148},0,1,10,2,272}, {5,{14138,14139,14140,14141,14142},0,1,10,3,270}, 
{3,{14156,14160,14161},0,1,15,1,273}, {2,{51632,51633},0,1,15,2,2068}, {3,{13733,13865,13866},0,1,15,4,277}, 
{1,{14983},1,1,20,1,382}, {2,{14168,14169},0,1,20,2,278}, {5,{14128,14132,14135,14136,14137},0,1,20,3,269}, 
{3,{16513,16514,16515},0,1,25,2,682}, {5,{14113,14114,14115,14116,14117},0,1,25,3,268}, 
{3,{31208,31209,312090},0,1,30,1,1721}, {1,{14177},2,1,30,2,280}, {3,{14174,14175,14176},0,1,30,3,279}, {2,{31244,31245},0,1,30,4,1762}, 
{5,{14186,14190,14193,14194,14195},0,1,35,2,283}, {2,{14158,14159},0,1,35,3,274}, 
{2,{51625,51626},0,1,40,1,2065}, {1,{58426},1,1,40,2,281}, {3,{31380,31382,31383},0,1,40,3,1723}, 
{3,{51634,51635,51636},0,1,45,1,2069}, {3,{31234,31235,31236},0,1,45,3,1718}, 
{3,{31226,31227,58410},0,1,50,1,1715}, {1,{1329},2,1,50,2,1719}, {3,{51627,51628,51629},0,1,50,3,2066}, 
{5,{51664,51665,51667,51668,51669},0,1,55,2,2070}, 
{1,{51662},3,1,60,2,2071}}

rogue_assassination_talents_tab = 8


rogue_combat_spells = {{1752, 2, 0, 1}, {53, 2, 0, 4}, {1776, 2, 0, 6}, {5277, 2, 0, 8}, {2983, 2, 0, 10},
{1766, 2, 0, 12}, {1966, 2, 0, 16}, {5938, 2, 0, 70}, {51723, 2, 0, 80}}

rogue_combat_spells_count = 9
rogue_combat_bgs = {"Interface\\TalentFrame\\RogueCombat-TopLeft", "Interface\\TalentFrame\\RogueCombat-TopRight",
"Interface\\TalentFrame\\RogueCombat-BottomLeft", "Interface\\TalentFrame\\RogueCombat-BottomRight"}

rogue_combat_talents = {{3,{13741,13793,13792},0,1,10,1,203},{2,{13732,13863},0,1,10,2,201},{5,{13715,13848,13849,13851,13852},0,1,10,3,221},
{2,{14165,14166},0,1,15,1,1827}, {3,{13713,13853,13854},0,1,15,2,187}, {5,{13705,13832,13843,13844,13845},0,1,15,4,181}, 
{2,{13742,13872},0,1,20,1,204}, {1,{14251},2,1,20,2,301}, {5,{13706,13804,13805,13806,13807},0,1,20,3,182}, 
{2,{13754,13867},0,1,25,1,206}, {2,{13743,13875},0,1,25,2,222}, {3,{13712,13788,13789},0,1,25,3,186}, {5,{18427,18428,18429,61330,61331},0,1,25,4,1122}, 
{5,{13709,13800,13801,13802,13803},0,1,30,1,184}, {1,{13877},2,1,30,2,223}, {5,{13960,13961,13962,13963,13964},0,1,30,3,242}, 
{2,{30919,30920},0,1,35,2,1703}, {2,{31124,31126},0,1,35,3,1706}, 
{3,{31122,31123,61329},0,1,40,1,1705}, {1,{13750},2,1,40,2,205}, {2,{31130,31131},0,1,40,3,1707}, 
{2,{5952,51679},0,1,45,1,2072}, {5,{35541,35550,35551,35552,35553},0,1,45,3,1825}, 
{2,{51672,51674},0,1,50,1,2073}, {1,{32601},1,1,50,2,1709}, {2,{51682,58413},0,1,50,3,2074}, 
{5,{51685,51686,51687,51688,51689},0,1,55,2,2075}, 
{1,{51690},3,1,60,2,2076}}

rogue_combat_talents_tab = 7



rogue_subtlety_spells = {{1784, 2, 0, 1}, {921, 2, 0, 4}, {6770, 2, 0, 10}, {1725, 2, 0, 10}, {1804, 2, 0, 10}, {2836, 1, 0, 24},
{1856, 2, 0, 35}, {1842, 1, 0, 30}, {2094, 2, 0, 34}, {1860, 1, 0, 40}, {31224, 2, 0, 66}, {57934, 2, 0, 80}}

rogue_subtlety_spells_count = 12
rogue_subtlety_bgs = {"Interface\\TalentFrame\\RogueSubtlety-TopLeft", "Interface\\TalentFrame\\RogueSubtlety-TopRight",
"Interface\\TalentFrame\\RogueSubtlety-BottomLeft", "Interface\\TalentFrame\\RogueSubtlety-BottomRight"}

rogue_subtlety_talents = {{5,{14179,58422,58423,58424,58425},0,1,10,1,2244}, {5,{13958,13970,13971,813972,813973},0,1,10,2,241}, {2,{14057,14072},0,1,10,3,261}, 
{2,{30892,30893},0,1,15,1,1700}, {2,{14076,14094},0,1,15,2,262}, {3,{13975,14062,14063},0,1,15,3,244}, 
{2,{13981,14066},0,1,20,1,247}, {1,{14278},2,1,20,2,303}, {3,{14171,14172,14173},0,1,20,3,1123}, 
{3,{13983,14070,14071},0,1,25,1,246}, {3,{13976,13979,13980},0,1,25,2,245}, {2,{14079,14080},0,1,25,3,263}, 
{2,{30894,30895},0,1,30,1,1701}, {1,{14185},2,1,30,2,284}, {2,{14082,14083},0,1,30,3,265}, {1,{16511},2,1,30,4,681}, 
{3,{31221,31222,31223},0,1,35,1,1713}, {5,{30902,30903,30904,30905,30906},0,1,35,3,1702}, 
{3,{31211,31212,31213},0,1,40,1,1711}, {1,{14183},2,1,40,2,381}, {3,{31228,31229,31230},0,1,40,3,1722}, 
{5,{31216,31217,31218,31219,31220},0,1,45,2,1712}, {2,{51692,51696},0,1,45,3,2077}, 
{3,{51698,51700,51701},0,1,50,1,2078}, {1,{36554},2,1,50,2,1714}, {2,{58414,58415},0,1,50,3,2079}, 
{5,{51708,51709,51710,51711,51712},0,1,55,2,2080}, 
{1,{51713},3,1,60,2,2081}}

rogue_subtlety_talents_tab = 9

