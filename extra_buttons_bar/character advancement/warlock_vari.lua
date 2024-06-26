-- Documentation {5176, 2, 0, 1} {Spellid, Ability Essence,  Talent Essence, Required Level}
-- Make sure to adjust Count if you add or subtract any spells
-- talent documentation {5,{16814,16814,16814,16814,16814},0,1,10,2,762} {number of ranks, {spellids}, AE cost, TE cost, required level,
-- 																															column, talentId}
-- talents tab variables refers to talenttab dbc

warlock_affliction_spells = {{702, 2, 0, 4}, {172, 2, 0, 4}, {1454, 2, 0, 6}, {980, 2, 0, 8}, {5782, 2, 0, 8},
{1120, 2, 0, 10}, {689, 2, 0, 14}, {5138, 2, 0, 24}, {1714, 2, 0, 26}, {1490, 2, 0, 32}, {5484, 2, 0, 40},
{6789, 2, 0, 42}, {603, 2, 0, 60}, {27243, 2, 0, 70}}

warlock_affliction_spells_count = 14
warlock_affliction_bgs = {"Interface\\TalentFrame\\Warlockcurses-TopLeft", "Interface\\TalentFrame\\Warlockcurses-TopRight",
"Interface\\TalentFrame\\Warlockcurses-BottomLeft", "Interface\\TalentFrame\\Warlockcurses-BottomRight"}

warlock_affliction_talents = {{2,{18827,18829},0,1,10,1,1284}, {3,{18174,18175,18176},0,1,10,2,1005}, {5,{17810,17811,17812,17813,17814},0,1,10,3,1003}, 
{2,{18179,18180},0,1,15,1,1006}, {2,{18213,18372},0,1,15,2,1101}, {2,{18182,18183},0,1,15,3,1007}, {2,{17804,17805},0,1,15,4,1004}, 
{2,{53754,53759},0,1,20,1,2205}, {3,{17783,17784,17785},0,1,20,2,1001}, {1,{18288},1,1,20,3,1061}, 
{2,{18218,18219},0,1,25,1,1021}, {2,{18094,18095},0,1,25,2,1002}, {3,{32381,32382,32383},0,1,25,4,1764}, 
{5,{32385,32387,32392,32393,32394},0,1,30,1,1763}, {1,{63108},1,1,30,2,1041}, {1,{18223},2,1,30,3,1081}, 
{2,{54037,54038},0,1,35,1,1873}, {5,{18271,18272,18273,18274,18275},0,1,35,2,1042}, 
{3,{47195,47196,47197},0,1,40,1,1878}, {5,{30060,30061,30062,30063,30064},0,1,40,2,1669}, {1,{18220},2,1,40,3,1022}, 
{2,{30054,30057},0,1,45,1,1668}, {3,{32477,32483,32484},0,1,45,3,1667}, 
{3,{47198,47199,47200},0,1,50,1,1875}, {1,{30108},2,1,50,2,1670}, {1,{58435},1,1,50,3,2245}, 
{5,{47201,47202,47203,47204,47205},0,1,55,2,1876}, 
{1,{48181},3,1,60,2,2041}}

warlock_affliction_talents_tab = 20


warlock_demonology_spells = {{687, 2, 0, 1}, {688, 2, 0, 1}, {697, 2, 0, 10}, {6201, 2, 0, 10}, {755, 2, 0, 12},
{5697, 1, 0, 16}, {693, 2, 0, 18}, {698, 2, 0, 20}, {712, 2, 0, 20}, {126, 1, 0, 22},
{5500, 2, 0, 24}, {132, 2, 0, 26}, {710, 2, 0, 28}, {6366, 2, 0, 28}, {1098, 2, 0, 30}, {691, 2, 0, 30},
{6229, 2, 0, 32}, {2362, 2, 0, 36}, {1122, 2, 0, 50},
{18540, 2, 0, 60}, {28176, 2, 0, 62}, {29858, 2, 0, 66}, {29893, 2, 0, 68}, {48018, 2, 0, 80}, {48020, 2, 0, 80}}

warlock_demonology_spells_count = 25
warlock_demonology_bgs = {"Interface\\TalentFrame\\Warlocksummoning-TopLeft", "Interface\\TalentFrame\\Warlocksummoning-TopRight",
"Interface\\TalentFrame\\Warlocksummoning-BottomLeft", "Interface\\TalentFrame\\Warlocksummoning-BottomRight"}

warlock_demonology_talents = {{2,{18692,18693},0,1,10,1,1221}, {3,{18694,18695,18696},0,1,10,2,1222}, {3,{18697,18698,18699},0,1,10,3,1223}, {2,{47230,47231},0,1,10,4,1883}, 
{2,{18703,18704},0,1,15,1,1224}, {3,{18705,18706,18707},0,1,15,2,1225}, {3,{18731,18743,18744},0,1,15,3,1242}, 
{3,{18754,18755,18756},0,1,20,1,1243}, {1,{19028},2,1,20,2,1282}, {1,{18708},2,1,20,3,1226}, {3,{30143,30144,30145},0,1,20,4,1671}, 
{5,{18769,18770,18771,18772,18773},0,1,25,2,1262}, {2,{18709,18710},0,1,25,3,1227}, 
{1,{30326},1,1,30,1,1281}, {2,{18767,18768},0,1,30,3,1261}, 
{5,{23785,23822,23823,23824,23825},0,1,35,2,1244}, {3,{47245,47246,47247},0,1,35,3,1283}, 
{3,{30319,30320,30321},0,1,40,1,1680}, {1,{47193},2,1,40,2,1880}, {3,{35691,35692,35693},0,1,40,3,1263}, 
{5,{30242,30245,30246,30247,30248},0,1,45,2,1673}, {2,{63156,63158},0,1,45,3,2261}, 
{3,{54347,54348,54349},0,1,50,1,1882}, {1,{30146},2,1,50,2,1672}, {3,{63117,63121,63123},0,1,50,3,1884}, 
{5,{47236,47237,47238,47239,47240},0,1,55,2,1885}, 
{1,{59672},3,1,60,2,1886}}

warlock_demonology_talents_tab = 21



warlock_destruction_spells = {{686, 2, 0, 1}, {348, 2, 0, 6}, {5676, 2, 0, 18}, {5740, 2, 0, 20}, {1949, 2, 0, 30},
{6353, 2, 0, 48}, {29722, 2, 0, 64}, {47897, 2, 0, 75}}

warlock_destruction_spells_count = 8
warlock_destruction_bgs = {"Interface\\TalentFrame\\WarlockDestruction-TopLeft", "Interface\\TalentFrame\\WarlockDestruction-TopRight",
"Interface\\TalentFrame\\WarlockDestruction-BottomLeft", "Interface\\TalentFrame\\WarlockDestruction-BottomRight"}

warlock_destruction_talents = {{5,{17793,17796,17801,17802,17803},0,1,10,2,944}, {5,{17788,17789,17790,17791,17792},0,1,10,3,943}, 
{2,{18119,18120},0,1,15,1,982}, {3,{63349,63350,63351},0,1,15,2,1887}, {3,{17778,17779,17780},0,1,15,3,941}, 
{2,{18126,18127},0,1,20,1,983}, {1,{17877},2,1,20,2,963}, {5,{17959,59738,59739,59740,59741},0,1,20,3,967}, 
{2,{18135,18136},0,1,25,1,985}, {2,{17917,17918},0,1,25,2,964}, {3,{17927,17929,17930},0,1,25,4,965}, 
{3,{34935,34938,34939},0,1,30,1,1817}, {3,{17815,17833,17834},0,1,30,2,961}, {1,{18130},1,1,30,3,981}, 
{3,{30299,30301,30302},0,1,35,1,1679}, {5,{17954,17955,17956,17957,17958},0,1,35,3,966}, 
{1,{17962},2,1,40,2,968}, {3,{30293,30295,30296},0,1,40,3,1678}, {3,{18096,18073,63245},0,1,40,4,986}, 
{5,{30288,30289,30290,30291,30292},0,1,45,2,1677}, {2,{54117,54118},0,1,45,3,1889}, 
{3,{47258,47259,47260},0,1,50,1,1888}, {1,{30283},2,1,50,2,1676}, {3,{47220,47221,47223},0,1,50,3,2045}, 
{5,{47266,47267,47268,47269,47270},0,1,55,2,1890}, 
{1,{50796},3,1,60,2,1891}}

warlock_destruction_talents_tab = 19


