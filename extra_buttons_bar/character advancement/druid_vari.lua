-- Documentation {5176, 2, 0, 1} {Spellid, Ability Essence,  Talent Essence, Required Level}
-- Make sure to adjust Count if you add or subtract any spells
-- talent documentation {5,{16814,16814,16814,16814,16814},0,1,10,2,762} {number of ranks, {spellids}, AE cost, TE cost, required level,
-- 																															column, talentId}
-- talents tab variables refers to talenttab dbc


druid_balance_spells = {{5176, 2, 0, 1}, {8921, 2, 0, 4}, {467, 2, 0, 6}, {339, 2, 0, 8}, {18960, 2, 0, 10},
{16689, 2, 0, 10}, {770, 2, 0, 18}, {2637, 2, 0, 18}, {2912, 2, 0, 20}, {2908, 1, 0, 22}, {29166, 2, 0, 40},
{16914, 2, 0, 40}, {22812, 2, 0, 44}, {33786, 2, 0, 70}}

druid_balance_spells_count = 14
druid_balance_bgs = {"Interface\\TalentFrame\\DruidBalance-TopLeft", "Interface\\TalentFrame\\DruidBalance-TopRight",
"Interface\\TalentFrame\\DruidBalance-BottomLeft", "Interface\\TalentFrame\\DruidBalance-BottomRight"}

druid_balance_talents = {{5,{16814,16815,16816,16817,16818},0,1,10,2,762}, {5,{57810,57811,57812,57813,57814},0,1,10,3,2238}, 
{3,{16845,16846,16847},0,1,15,1,783}, {2,{35363,35364},0,1,15,2,1822}, {2,{16821,16822},0,1,15,4,763}, 
{3,{16836,16839,16840},0,1,20,1,782}, {3,{16880,61345,61346},0,1,20,2,789}, {1,{57865},1,1,20,3,2240}, {2,{16819,16820},0,1,20,4,764}, 
{5,{16909,16910,16911,16912,16913},0,1,25,2,792}, {3,{16850,16923,16924},0,1,25,3,784}, 
{3,{33589,33590,33591},0,1,30,1,1782}, {1,{5570},2,1,30,2,788}, {3,{57849,57850,57851},0,1,30,3,2239}, 
{3,{33597,33599,33956},0,1,35,1,1784}, {3,{16896,16897,16899},0,1,35,2,790}, {2,{33592,33596},0,1,35,3,1783}, 
{1,{24858},2,1,40,2,793}, {3,{48384,48395,48396},0,1,40,3,1912}, {3,{33600,33601,33602},0,1,40,4,1785}, 
{3,{48389,48392,48393},0,1,45,1,1913}, {5,{33603,33604,33605,33606,33607},0,1,45,3,1786}, 
{3,{48516,48521,48525},0,1,50,1,1924}, {1,{50516},2,1,50,2,1923}, {1,{33831},2,1,50,3,1787}, {2,{48488,48514},0,1,50,4,1925}, 
{3,{48506,48510,48511},0,1,55,2,1928}, 
{1,{48505},3,1,60,2,1926}}
druid_balance_talents_tab = 18


druid_feral_spells = {{99, 2, 0, 10}, {6807, 1, 0, 10}, {6795, 1, 0, 10}, {5487, 2, 0, 10}, {5229, 2, 0, 12},
{5211, 2, 0, 14}, {1066, 2, 0, 16}, {779, 2, 0, 16}, {16857, 2, 0, 18}, {1082, 1, 0, 20},
{1079, 2, 0, 20}, {768, 2, 0, 20}, {5215, 2, 0, 20}, {62078, 2, 0, 20}, {5221, 2, 0, 22}, {1822, 1, 0, 24}, {5217, 2, 0, 24},
{1850, 2, 0, 26}, {8998, 2, 0, 28}, {5209, 2, 0, 28}, {783, 2, 0, 30}, {22568, 2, 0, 32},
{6785, 2, 0, 32}, {9005, 2, 0, 36}, {22842, 2, 0, 36}, {20719, 1, 0, 40}, {62600, 2, 0, 40}, {22570, 2, 0, 62}, {33745, 2, 0, 66}, {52610, 2, 0, 75}}

druid_feral_spells_count = 30
druid_feral_bgs = {"Interface\\TalentFrame\\DruidFeralCombat-TopLeft", "Interface\\TalentFrame\\DruidFeralCombat-TopRight",
"Interface\\TalentFrame\\DruidFeralCombat-BottomLeft", "Interface\\TalentFrame\\DruidFeralCombat-BottomRight"}

druid_feral_talents = {{5, {16934,16935,16936,16937,16938}, 0, 1, 10, 2,796}, {5, {16858,16859,16860,16861,16862}, 0, 1, 10, 3,795},
{3, {16947,16948,16949}, 0, 1, 15, 1,799}, {2, {16998,16999}, 0, 1, 15, 2,805}, {3, {16929,16930,16931}, 0, 1, 15, 3,794},
{2, {17002,24866}, 0, 1, 20, 1,807}, {1, {61336}, 2, 1, 20, 2,1162}, {3, {16942,16943,16944}, 0, 1, 20, 3,798},
{2,{16966,16968},0,1,25,1,802},{3,{16972,16974,16975},0,1,25, 2,803},{2,{37116,37117},0,1,25,3,801},{2,{48409,48410},0,1,25,4,1914},
{2, {16940,16941}, 0, 1, 30, 1,797}, {1, {49377}, 2, 1, 30, 3,804}, {2, {33872,33873}, 0, 1, 30, 4,1792},
{3, {57878,57880,57881}, 0, 1, 35, 1,2242},{5, {17003,17004,17005,17006,24894},0,1,35,2,808},{3,{33853,33855,33856},0,1,35,3,1794},
{1, {17007}, 2, 1, 40, 2,809}, {2,{34297,34300},0,1,40,3,1798}, {3,{33851,33852,33957},0,1,40,4,1793},
{3,{57873,57876,57877},0,1,45,1,2241},{3,{33859,33866,33867},0,1,45,3,1795},{3,{48483,48484,48485},0,1,45,4,1919},
{3,{48492,48494,48495},0,1,50,1,1921},{1,{33917},2,1,50,2,1796},{3,{48532,48489,48491},0,1,50,3,1920},
{5,{48432,48433,48434,51268,51269},0,1,55,2,1918},{1,{63503},1,1,55,3,2266},
{1, {50334}, 3, 1, 60, 2,1927}}
druid_feral_talents_tab = 16


druid_restoration_spells = {{5185, 2, 0, 1}, {1126, 2, 0, 1}, {774, 2, 0, 4}, {8936, 2, 0, 12}, {50769, 2, 0, 12},
{8946, 2, 0, 14}, {20484, 2, 0, 20}, {2782, 2, 0, 24}, {2893, 2, 0, 26}, {740, 2, 0 ,30},
{33763, 2, 0, 64},{504642, 0, 80}}

druid_restoration_spells_count = 11
druid_restoration_bgs = {"Interface\\TalentFrame\\DruidRestoration-TopLeft", "Interface\\TalentFrame\\DruidRestoration-TopRight",
"Interface\\TalentFrame\\DruidRestoration-BottomLeft", "Interface\\TalentFrame\\DruidRestoration-BottomRight"}

druid_restoration_talents = {{2,{17050,17051},0,1,10,1,821}, {3,{17063,17065,17066},0,1,10,2,823}, {5,{17056,17058,17059,17060,17061},0,1,10,3,822}, 
{5,{17069,17070,17071,17072,17073},0,1,15,1,824}, {3,{17118,17119,17120},0,1,15,2,841}, {1,{16833},1,1,15,3,826}, 
{3,{17106,17107,17108},0,1,20,1,829}, {1,{16864},1,1,20,2,827}, {2,{48411,48412},0,1,20,3,1915}, 
{5,{24968,24969,24970,24971,24972},0,1,25,2,843}, {3,{17111,17112,17113},0,1,25,3,830}, 
{1,{17116},2,1,30,1,831}, {5,{17104,24943,24944,24945,24946},0,1,30,2,828}, {2,{17123,17124},0,1,30,4,842}, 
{2,{33879,33880},0,1,35,1,1788}, {5,{17074,17075,17076,17077,17078},0,1,35,3,825}, 
{3,{34151,34152,34153},0,1,40,1,1797}, {1,{18562},2,1,40,2,844}, {3,{33881,33882,33883},0,1,40,3,1790}, 
{5,{33886,33887,33888,33889,33890},0,1,45,2,1789}, {3,{48496,48499,48500},0,1,45,3,1922}, 
{3,{48539,48544,48545},0,1,50,1,1929}, {1,{65139},2,1,50,2,1791}, {3,{48535,48536,48537},0,1,50,3,1930}, 
{2,{63410,63411},0,1,55,1,2264}, {5,{51179,51180,51181,51182,51183},0,1,55,3,1916}, 
{1,{48438},3,1,60,2,1917}}

druid_restoration_talents_tab = 17
