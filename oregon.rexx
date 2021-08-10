/* REXX */

/* The program that follows is a reconstruction */
/* of the Oregon Trail game written for HP time-shared */
/* BASIC by Don Rawitsch and Bill Heinemann and Paul Dillenberger */
/* in 1971. Its source is an updated version published in the */
/* July-August 1978 issue of Creative Computing. */


say "DO YOU NEED INSTRUCTIONS  (y/n)"
pull C$
if C$ == "y" then call instructions

call shot_input

call initial_purchases

do while 1
	call zero_items
	call set_date
	call begin_turn
	call choices
	call eat
	call riders_attack
	call events
	call mountain
	call check_end
end

return 0

instructions:
say "THIS PROGRAM SIMULATES A TRIP OVER THE OREGON TRAIL FROM"
say "INDEPENDENCE, MISSOURI TO OREGON CITY, OREGON IN 1847."
say "YOUR FAMILY OF FIVE WILL COVER THE 2040 MILE OREGON TRAIL"
say "IN 5-6 MONTHS --- IF YOU MAKE IT ALIVE."
say ""
say "YOU HAD SAVED $900 TO SPEND FOR THE TRIP, AND YOU'VE JUST"
say "   PAID $200 FOR A WAGON."
say "YOU WILL NEED TO SPEND THE REST OF YOUR MONEY ON THE"
say "   FOLLOWING ITEMS:"
say ""
say "     OXEN - YOU CAN SPEND $200-$300 ON YOUR TEAM"
say "            THE MORE YOU SPEND, THE FASTER YOU'LL GO"
say "               BECAUSE YOU'LL HAVE BETTER ANIMALS"
say ""
say "     FOOD - THE MORE YOU HAVE, THE LESS CHANCE THERE"
say "               IS OF GETTING SICK"
say ""
say "     AMMUNITION - 81 BUYS A BELT OF 50 BULLETS"
say "            YOU WILL NEED BULLETS FOR ATTACKS BY ANIMALS"
say "               AND BANDITS, AND FOR HUNTING FOOD"
say ""
say "     CLOTHING - THIS IS ESPECIALLY IMPORTANT FOR THE COLD"
say "               WEATHER YOU WILL ENCOUNTER WHEN CROSSING"
say "               THE MOUNTAINS"
say ""
say "     MISCELLANEOUS SUPPLIES - THIS INCLUDES MEDICINE AND"
say "               OTHER THINGS YOU WILL NEED FOR SICKNESS"
say "               AND EMERGENCY REPAIRS"
say ""
say ""
say "YOU CAN SPEND ALL YOUR MONEY BEFORE YOU START YOUR TRIP -"
say "OR YOU CAN SAVE SOME OF YOUR CASH TO SPEND AT FORTS ALONG"
say "THE WAY WHEN YOU RUN LOW.  HOWEVER, ITEMS COST MORE AT"
say "THE FORTS.  YOU CAN ALSO GO HUNTING ALONG THE WAY TO GET"
say "MORE FOOD."
say "WHENEVER YOU HAVE TO USE YOUR TRUSTY RIFLE ALONG THE WAY,"
say "YOU WILL BE TOLD TO TYPE IN A WORD (ONE THAT SOUNDS LIKE A"
say "GUN SHOT).  THE FASTER YOU TYPE IN THAT WORD AND HIT THE"
say "RETURN KEY, THE BETTER LUCK YOU'LL HAVE WITH YOUR GUN."
say ""
say "AT EACH TURN, ALL ITEMS ARE SHOWN IN DOLLAR AMOUNTS"
say "EXCEPT BULLETS"
say "WHEN ASKED TO ENTER MONEY AMOUNTS, DON'T USE A ""$""."
say ""
say "GOOD LUCK!!!"
say ""
say ""
return 0

shot_input:
say "HOW GOOD A SHOT ARE YOU WITH YOUR RIFLE?"
say "  (1) ACE MARKSMAN,  (2) GOOD SHOT,  (3) FAIR TO MIDDLIN'"
say "         (4) NEED MORE PRACTICE,  (5) SHAKY KNEES"
say "ENTER ONE OF THE ABOVE -- THE BETTER YOU CLAIM YOU ARE, THE"
say "FASTER YOU'LL HAVE TO BE WITH YOUR GUN TO BE SUCCESSFUL."

pull D9
if D9 > 5 then D9 = 0
return 0

initial_purchases:
X1=-1
K8=0
S4=0
F1=0
F2=0
M=0
M9=0
D3=0
say ""
say ""
ox_purchase:
say "HOW MUCH DO YOU WANT TO SPEND ON YOUR OXEN TEAM"
pull A
if A < 200 then
do
	say "NOT ENOUGH"
	signal ox_purchase
end
else if A > 300 then
do
	say "TOO MUCH"
	signal ox_purchase
end
food_purchase:
say "HOW MUCH DO YOU WANT TO SPEND ON FOOD"
pull F
if F < 0 then
do
	say "IMPOSSIBLE"
	signal food_purchase
end
ammo_purchase:
say "HOW MUCH DO YOU WANT TO SPEND ON AMMUNITION"
pull B
if B < 0 then
do
	say "IMPOSSIBLE"
	signal ammo_purchase
end
clothing_purchase:
say "HOW MUCH DO YOU WANT TO SPEND ON CLOTHING"
pull C
if C < 0 then
do
	say "IMPOSSIBLE"
	signal clothing_purchase
end
misc_purchase:
say "HOW MUCH DO YOU WANT TO SPEND ON MISCELLANEOUS SUPPLIES"
pull M1
if M1 < 0 then
do
	say "IMPOSSIBLE"
	signal misc_purchase
end
T = 700 - A - F - B - C - M1
if T < 0 then
do
	say "YOU OVERSPENT--YOU ONLY HAD $700 TO SPEND.  BUY AGAIN"
	signal ox_purchase
end
B = 50 * B
say "AFTER ALL YOUR PURCHASES, YOU NOW HAVE "T" DOLLARS LEFT"
say ""
return 0


set_date:
say ""
say "MONDAY "
date.0 = "MARCH 29 "
date.1 = "APRIL 12 "
date.2 = "APRIL 26 "
date.3 = "MAY 10 "
date.4 = "MAY 24 "
date.5 = "JUNE 7 "
date.6 = "JUNE 21 "
date.7 = "JULY 5 "
date.8 = "JULY 19 "
date.9 = "AUGUST 2 "
date.10 = "AUGUST 16 "
date.11 = "AUGUST 31 "
date.12 = "SEPTEMBER 13 "
date.13 = "SEPTEMBER 27 "
date.14 = "OCTOBER 11 "
date.15 = "OCTOBER 25 "
date.16 = "NOVEMBER 8" 
date.17 = "NOVEMBER 22 "
date.18 = "DECEMBER 6 "
date.19 = "DECEMBER 20"
say date.D3
say "1847"
D3=D3+1
if D3 == 20 then
do
	say "YOU HAVE BEEN ON THE TRAIL TOO LONG  ------"
	say "YOUR FAMILY DIES IN THE FIRST BLIZZARD OF WINTER"
	call death
end
return 0


check_end:
if M >= 2040 then call final_turn
return 0


zero_items:
if F <= 0 then F = 0
if B <= 0 then B = 0
if C <= 0 then C = 0
if M1 <= 0 then M1 = 0
return 0

begin_turn:
if F <= 13 then
do
	say "YOU'D BETTER DO SOME HUNTING OR BUY FOOD AND SOON!!!!"
end
M2 = M1
if K8==1 | S4==1 then call doctor
say ""
K8 = 0
S4 = 0
if M9 == 1 then 
do 
	say "TOTAL MILEAGE IS 950"
	M9 = 0
end
else say "TOTAL MILEAGE IS "M
say ""
say "BULLETS,FOOD,CLOTHING,MISC. SUPP.,CASH"
say B","F","C","M1","T
M = TRUNC(M+200+(A-220)/5+RANDOM(0,10))
L1 = 0
C1 = 0
return 0

events:
D1=0
R1=RANDOM(1,16)
if R1 == 1 then
do
	say "WAGON BREAKS DOWN--LOSE TIME AND SUPPLIES FIXING IT"
	M=M-15-RANDOM(0,5)
	M1=M1-8
end
else if R1 == 2 then
do
	say "OX INJURES LEG---SLOWS YOU DOWN REST OF TRIP"
	M=M-25
	A=A-20
end
else if R1 == 3 then
do
	say "BAD LUCK---YOUR DAUGHTER BROKE HER ARM"
	say "YOU HAD TO STOP AND USE SUPPLIES TO MAKE A SLING"
	M=M-5-RANDOM(0,4)
	M1=M1-2-RANDOM(0,3)
end
else if R1 == 4 then
do
	say "OX WANDERS OFF---SPEND TIME LOOKING FOR IT"
	M=M-17
end
else if R1 == 5 then
do
	say "YOUR SON GETS LOST---SPEND HALF THE DAY LOOKING FOR HIM"
	M=M-10
end
else if R1 == 6 then
do
	say "UNSAFE WATER--LOSE TIME LOOKING FOR CLEAN SPRING"
	M=M-RANDOM(0,10)-2
end
else if R1 == 7 then
do
	if M>950 then
	do
		say "COLD WEATHER---BRRRRRRR!---YOU ";
		if C<=22+RANDOM(0,4) then
		do
			say "DON'T ";
			C1=1
		end
		say "HAVE ENOUGH CLOTHING TO KEEP YOU WARM"
		if C1=1 then call illness
	end
	else 
	do
		say "HEAVY RAINS---TIME AND SUPPLIES LOST"
		F=F-10
		B=B-500
		M1=M1-15
		M=M-RANDOM(0,10)-5
	end
end
else if R1 == 8 then
do
	say "BANDITS ATTACK"
	call shooting
	B=B-20*B1
	if B < 0 then 
	do
		say "YOU RAN OUT OF BULLETS---THEY GET LOTS OF CASH"
		T=T/3
		B1=9
	end
	if B1 > 1 then
	do
		say "YOU GOT SHOT IN THE LEG AND THEY TOOK ONE OF YOUR OXEN"
		K8=1
		say "BETTER HAVE A DOC LOOK AT YOUR WOUND"
		M1=M1-5
		A=A-20		
	end
	else
	do
		say "QUICKEST DRAW OUTSIDE OF DODGE CITY!!!"
		say "YOU GOT 'EM!"
	end
end
else if R1 == 9 then
do
	say "THERE WAS A FIRE IN YOUR WAGON--FOOD AND SUPPLIES DAMAGE!"
	F=F-40
	B=B-400
	M1=M1-RANDOM(0,8)-3
	M=M-15
end
else if R1 == 10 then
do
	say "LOSE YOUR WAY IN HEAVY FOG---TIME IS LOST"
	M=M-10-RANDOM(0,5)
end
else if R1 == 11 then
do
	say "YOU KILLED A POISONOUS SNAKE AFTER IT BIT YOU"
	B=B-10
	M1=M1-5
	if M1 < 0 then
	do
		say "YOU DIE OF SNAKEBITE SINCE YOU HAVE NO MEDICINE"
		call death
	end
end
else if R1 == 12 then
do
	say "WAGON GETS SWAMPED FORDING RIVER--LOSE FOOD AND CLOTHES"
	F=F-30
	C=C-20
	M=M-20-RANDOM(0,20)
end
else if R1 == 13 then
do
	say "WILD ANIMALS ATTACK"
	call shooting
	if B <= 39 then
	do
		say "YOU WERE TOO LOW ON BULLETS--"
		say "THE WOLVES OVERPOWERED YOU"
		K8=1
		call death
	end
	else
	do
		if B1 <= 2 then "NICE SHOOTIN' PARDNER---THEY DIDN'T GET MUCH"
		else
		do
			say "SLOW ON THE DRAW---THEY GOT AT YOUR FOOD AND CLOTHES"
			B=B-20*B1
			C=C-B1*4
			F=F-B1*8
		end

	end

end
else if R1 == 14 then
do
	say "HAIL STORM---SUPPLIES DAMAGED"
	M=M-5-RANDOM(0,10)
	B=B-200
	M1=M1-4-RANDOM(0,3)
end
else if R1 == 15 then
do
	if E == 1 then call illness
	else if E == 2 then if RANDOM(1,4) > 1 then call illness
	else if E == 3 then if RANDOM(1,4) > 2 then call illness

end
else if R1 == 16 then
do
	say "HELPFUL INDIANS SHOW YOU WERE TO FIND MORE FOOD"
	F=F+14
end
return 0


mountain:
if M > 950 then
do
	if RANDOM(0,10) > 9-((M/100-15)**2+72)/((M/100-15)**2+12) then call south_pass
	else call rugged_mountain
end
return 0


rugged_mountain:
say "RUGGED MOUNTAINS"
if RANDOM(0,10) > 1 then
do
	if RANDOM(0,100) > 11 then
	do
		say "THE GOING GETS SLOW"
		M=M-45-RANDOM(0,5)
		
	end
	else
	do
		say "WAGON DAMAGED!---LOSE TIME AND SUPPLIES"
		M1=M1-5
		B=B-200
		M=M-20-RANDOM(0,30)
	end
end
else
do
	say "YOU GOT LOST---LOSE VALUABLE TIME TRYING TO FIND TRAIL!"
	M=M-60
end
return 0

south_pass:
if F1==1 then call blue_mountain
else if F1==0 then 
do
	F1=1
	if RANDOM(0,10) < 8 then call blizzard
	else say "YOU MADE IT SAFELY THROUGH SOUTH PASS--NO SNOW"
end
return 0

blue_mountain:
if M >= 1700 & F2 == 0 then
do
	F2 = 1
	if RANDOM(0,10) < 7 then 
	do 
		call blizzard
	end

end
return 0


blizzard:
say "BLIZZARD IN MOUNTAIN PASS--TIME AND SUPPLIES LOST"
L1=1
F=F-25
M1=M1-10
B=B-300
M=M-30-RANDOM(0,40)
if C < 18+RANDOM(0,2) then call illness
return 0

illness:
if RANDOM(0,100)<10+35*(E-1) then
do
	say "MILD ILLNESS---MEDICINE USED"
	M=M-5
	M1=M1-2
end
else if RANDOM(0,100)<100-(40/4**(E-1)) then
do
	say "BAD ILLNESS---MEDICINE USED"
	M=M-5
	M1=M1-5
end
else
do
	say "SERIOUS ILLNESS---"
	say "YOU MUST STOP FOR MEDICAL ATTENTION"
	M1=M1-10
	S4=1
end

if M1<0 then
do
	say "YOU RAN OUT OF MEDICAL SUPPLIES"
	say "YOU DIED OF "
	say "PNEUMONIA"
end	
return 0


riders_attack:
if (RANDOM(0,10) <= ((M/100-4)**2+72)/((M/100-4)**2+12)-1) then
do
	say "RIDERS AHEAD.  THEY ";
	S5=0
	if RANDOM(0,10) < 8 then
	do
		say "DONT"
		S5 = 1
	end
	say "LOOK HOSTILE"
    call choose_tactics
    if RANDOM(0,10) <= 2 then S5=1-S5
    if S5 == 0 then
    do
    	if T1 == 1 then
    	do
    		M=M+20
			M1=M1-15
			B=B-150
			A=A-40
    	end
    	else if T1 == 2 then
    	do
    		call shooting
			B=B-B1*40-80
			call rider_shooting_outcome
    	end
    	else if T1 == 3 then
    	do
			if RANDOM(0,10) > 8 then say "THEY DID NOT ATTACK"
			else
			do
				B=B-150
				M1=M1-15
			end
    	end
    	else if T1 == 4 then
    	do
			call shooting
			B=B-B1*30-80
			M=M-25
			call rider_shooting_outcome    		
    	end
    	say "RIDERS WERE HOSTILE--CHECK FOR LOSSES"	
    end
    else if S5 == 1 then 
    do
    	if T1 == 1 then
    	do
    		M=M+15
			A=A-10
		end
    	else if T1 == 2 then
    	do
			M=M-5
			B=B-100
    	end
    	else if T1 == 4 then M=M-20
		say "RIDERS WERE FRIENDLY, BUT CHECK FOR POSSIBLE LOSSES"
    end
end
return 0


rider_shooting_outcome:
if B1 == 0 then "NICE SHOOTING---YOU DROVE THEM OFF"
else if B1 > 4 then 
do
	say "LOUSY SHOT---YOU GOT KNIFED"
	K8=1
	say "YOU HAVE TO SEE OL' DOC BLANCHARD"
end
else
do
	say "KINDA SLOW WITH YOUR COLT .45"
end
if B < 0 then
do
	say "YOU RAN OUT OF BULLETS AND GOT MASSACRED BY THE RIDERS"
end
return 0

shooting:
S$.0 = 4
S$.1 ="BANG"
S$.2 ="BLAM"
S$.3 ="POW"
S$.4 ="WHAM"
S6=TRUNC(RANDOM(1,4))
say "TYPE "S$.S6
B3 = TIME('S') 
pull C$
B1 = TIME('S')
B1=(B1-B3) - D9
say ""
if B1 < 0 then B1=0
if C$ /== S$.S6 then B1=9
return 0



choose_tactics:
say "TACTICS"
say "(1) RUN  (2) ATTACK  (3) CONTINUE  (4) CIRCLE WAGONS"
pull T1
if DATATYPE(T1) == "CHAR" then signal choose_tactics
if ((T1 < 1) | (T1 > 4)) then signal choose_tactics
return 0



choices:
if X1 == 1 then
do

	say "DO YOU WANT TO (1) STOP AT THE NEXT FORT, (2) HUNT, "
	say "OR (3) CONTINUE"
	pull X
	if X == 1 then call fort
	else if X == 2 then 
	do
		if B > 39 then call hunt
		else 
		do 
			say "TOUGH---YOU NEED MORE BULLETS TO GO HUNTING"
			signal choices
		end
	end
end 
else 
do
	say "DO YOU WANT TO (1) HUNT, OR (2) CONTINUE"
	pull X
	if X == 1 then 
	do
		if B > 39 then call hunt
		else 
		do 
			say "TOUGH---YOU NEED MORE BULLETS TO GO HUNTING"
			signal choices
		end
	end
end
X1=X1*(-1)
return 0


fort:
say "ENTER WHAT YOU WISH TO SPEND ON THE FOLLOWING"
say "FOOD";
check = check_buy()
if check then F=TRUNC(F+2/3*P)
say "AMMUNITION"
check = check_buy()
if check then B=TRUNC(B+2/3*P*50)
say "CLOTHING"
check = check_buy()
if check then C=TRUNC(C+2/3*P)
say "MISCELLANEOUS SUPPLIES"
check = check_buy()
if check then M1=TRUNC(M1+2/3*P)
M=M-45
return 0

check_buy:
pull P
if (DATATYPE(P) == "CHAR") | (P < 0) then signal check_buy
if (T-P < 0) then
do
	say "YOU DON'T HAVE THAT MUCH--KEEP YOUR SPENDING DOWN"
	say "YOU MISS YOUR CHANCE TO SPEND ON THAT ITEM"
	return 0
end
else 
do
	T=T-P
	return 1
end


hunt:
M=M-45
call shooting
if B1 <= 1 then
do
	say "RIGHT BETWEEN THE EYES---YOU GOT A BIG ONE!!!!"
	say "FULL BELLIES TONIGHT!"
	F=F+52+RANDOM(0,6)
	B=B-10-RANDOM(0,4)
end
else
do
	if RANDOM(0,100)<13*B1 then 
	do
		say "YOU MISSED---AND YOUR DINNER GOT AWAY....."
	end
	else 
	do
		say "NICE SHOT--RIGHT ON TARGET--GOOD EATIN' TONIGHT!!"
		F=F+48-2*B1
		B=B-10-3*B1
	end
end
return 0

eat:
if F < 13 then 
do
	say "YOU RAN OUT OF FOOD AND STARVED TO DEATH"
	call death
end
else
do
	say "DO YOU WANT TO EAT (1) POORLY  (2) MODERATELY"
	say "OR (3) WELL";
	pull E
	if DATATYPE(E) == "CHAR" then signal eat
	if (E >= 1) & (E <= 3) & (F-8-5*E >= 0) then
	do
		F=F-8-5*E
	end
	else 
	do
		say "YOU CAN'T EAT THAT WELL"
		signal eat
	end

end

return 0

doctor:
T=T-20
say "DOCTOR'S BILL IS $20"

if T < 0 then
do
	say "YOU CAN'T AFFORD A DOCTOR"
	if K8 then say "YOU DIED OF PNEUMONIA"
	else say "YOU DIED OF INJURIES"
	call death
end
return 0

death:
say "DUE TO YOUR UNFORTUNATE SITUATION, THERE ARE A FEW"
say "FORMALITIES WE MUST GO THROUGH"
say ""
say "WOULD YOU LIKE A MINISTER?"
pull C$
say "WOULD YOU LIKE A FANCY FUNERAL?"
pull C$
say "WOULD YOU LIKE US TO INFORM YOUR NEXT OF KIN?"
pull C$
if C$=="y" then
do
	say "THAT WILL BE $4.50 FOR THE TELEGRAPH CHARGE."
	say ""
    say "WE THANK YOU FOR THIS INFORMATION AND WE ARE SORRY YOU"
    say "DIDN'T MAKE IT TO THE GREAT TERRITORY OF OREGON"
    say "BETTER LUCK NEXT TIME"
end
else say "BUT YOUR AUNT SADIE IN ST. LOUIS IS REALLY WORRIED ABOUT YOU"

say "WE THANK YOU FOR THIS INFORMATION AND WE ARE SORRY YOU"
say "DIDN'T MAKE IT TO THE GREAT TERRITORY OF OREGON"
say "BETTER LUCK NEXT TIME"
say ""
say ""
say "SINCERELY"
say ""
say "THE OREGON CITY CHAMBER OF COMMERCE"
exit

final_turn:
F9=(2040-M2)/(M-M2)
F=TRUNC(F+(1-F9)*(8+5*E))
call zero_items
say ""
say "YOU FINALLY ARRIVED AT OREGON CITY"
say "AFTER 2040 LONG MILES---HOORAY!!!!!"
say "A REAL PIONEER!"
say ""
F9=TRUNC(F9*14)
D3=D3*14+F9
F9=F9+1
if F9 > 7 then F9=F9-1
day.1 = "MONDAY"
day.2 = "TUESDAY"
day.3 = "WEDNESDAY"
day.4 = "THURSDAY "
day.5 = "FRIDAY "
day.6 = "SATURDAY "
day.7 = "SUNDAY "
say day.F9

if D3 <= 124 then
do
	D3=D3-93
	say "JULY "D3" 1847"
end
else if D3 <= 155 then
do
	D3=D3-124
	say "AUGUST "D3" 1847"
end
else if D3 <= 185 then
do
	D3=D3-155
	say "SEPTEMBER "D3" 1847"
end
else if D3 <= 216 then
do
	D3=D3-185
	say "OCTOBER "D3" 1847"
end
else if D3 <= 246 then
do
	D3=D3-216
	say "NOVEMBER "D3" 1847"
end
else
do
	D3=D3-246
	say "DECEMBER "D3" 1847"
end

say ""
say "BULLETS,FOOD,CLOTHING,MISC. SUPP.,CASH"
say B","F","C","M1","T
say ""

say "PRESIDENT JAMES K. POLK SENDS YOU HIS"
say "HEARTIEST CONGRATULATIONS"
say ""
say "AND WISHES YOU A PROSPEROUS LIFE AHEAD"
say "AT YOUR NEW HOME"

/* ***IDENTIFICATION OF VARIABLES IN THE PROGRAM*** */ 
/* A = AMOUNT SPENT ON ANIMALS */
/* B = AMOUNT SPENT ON AMMUNITION */
/* B1 = ACTUAL RESPONSE TIME FOR INPUTTING "BANG" */
/* B3 = CLOCK TIME AT START OF INPUTTING "BANG" */
/* C = AMOUNT SPENT ON CLOTHING */
/* C1 = FLAG FOR INSUFFICIENT CLOTHING IN COLD WEATHER */
/* C$ = YES/NO RESPONSE TO QUESTIONS */
/* D1 = COUNTER IN GENERATING EVENTS */
/* D3 = TURN NUMBER FOR SETTING DATE */
/* D4 = CURRENT DATE */ 
/* D9 = CHOICE OF SHOOTING EXPERTISE LEVEL */
/* E = CHOICE OF EATING */ 
/* F = AMOUNT SPENT ON FOOD */
/* F1 = FLAG FOR CLEARING SOUTH PASS */
/* F2 = FLAG FOR CLEARING BLUE MOUNTAINS */ 
/* 6F9 = FRACTION OF 2 WEEKS TRAVELED ON FINAL TURN */ 
/* K8 = FLAG FOR INJURY */
/* L1 = FLAG FOR BLIZZARD */
/* M = TOTAL MILEAGE WHOLE TRIP */
/* M1 = AMOUNT SPENT ON MISCELLANEOUS SUPPLIES */
/* M2 = TOTAL MILEAGE UP THROUGH PREVIOUS TURN */
/* M9 = FLAG FOR CLEARING SOUTH PASS IN SETTING MILEAGE */
/* P = AMOUNT SPENT ON ITEMS AT FORT */
/* R1 = RANDOM NUMBER IN CHOOSING EVENTS */
/* S4 = FLAG FOR ILLNESS */
/* S5 = ""HOSTILITY OF RIDERS"" FACTOR */
/* S6 = SHOOTING WORD SELECTOR */
/* S$ = VARIATIONS OF SHOOTING WORD */
/* T = CASH LEFT OVER AFTER INITIAL PURCHASES */
/* T1 = CHOICE OF TACTICS WHEN ATTACKED */
/* X = CHOICE OF ACTION FOR EACH TURN */
/* X1 = FLAG FOR FORT OPTION */