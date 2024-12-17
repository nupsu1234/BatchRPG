@echo off
title Batch RPG

:startmenu
cls
echo.
echo Welcome to the game!
echo.
echo What do you want to do?
echo.
echo 1. Start new game
echo 2. Credits
echo 3. Quit
echo.
set /p input=C:\
if "%input%" == "1" goto newgame
if "%input%" == "2" goto credits
if "%input%" == "3" exit
goto startmenu

:credits
cls
echo.
echo This game was made by StarterNoob (also known as nupsu1234).
echo.
echo Started the project sometime in March, 2018.
echo.
pause
goto startmenu

:newgame
set shortsword=0
set ringofhealth=0
set ringofmana=0
set spellstun=0
set greaterheal=0
set magicbarrier=0
set magicbarrieractive=0
set level=1
set playerhp=100
set playerhpcap=100
set playerdmg=5
set playermana=100
set playermanacap=100
set gold=100
set exp=0
set fleenum=0
set ring=0
set expcap=100
goto game

:game
set expuntil=%expcap%
set /a expuntil-=%exp%
set input=0
set wolfhp=65
set wolfdmg=3
set bandithp=100
set banditdmg=10
set goblinhp=120
set goblindmg=16
set skeletonhp=150
set skeletondmg=20
set giantlizardhp=200
set giantlizarddmg=35
set trollhp=250
set trolldmg=50
set cavedragonhp=300
set cavedragondmg=65
set obeliskhp=500
set obeliskdmg=0
set azerothhp=1000
set azerothdmg=75
set goldgain=0
set expgain=0
set playerdmgincrease=0
set playerhpcapincrease=0
set playermanacapincrease=0
set lesserheal=1
set stun=0
set enemyspellnum=0
if %exp% geq %expcap% goto levelup
cls
echo.
echo Welcome to the actual game!
echo.
echo What's your next move?
echo.
echo 1. Fight stuff
echo 2. Shop
echo 3. Rest
echo 4. Check my stats
echo 5. Equipment
echo 6. Go back to the start menu
echo.
set /a fightnum=%random% %%8 +1
set /p input=C:\
if "%input%" == "1" goto prefight
if "%input%" == "2" goto shop
if "%input%" == "3" goto rest
if "%input%" == "4" goto mystats
if "%input%" == "5" goto equipment
if "%input%" == "6" goto startmenu
goto game

:equipment
cls
if %shortsword% geq 1 echo Shortsword - Increases attack by 3
if %ringofhealth% geq 1 echo Ring of health x%ringofhealth% - Increases maximum health by 10
if %ringofmana% geq 1 echo Ring of mana x%ringofmana% - Increases maximum mana by 10
if %spellstun% geq 1 echo Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo Greater heal - 75 mana - Heal self for 50 HP
if %magicbarrier% geq 1 echo Magic barrier - 40 mana - Negate damage for 1 turn (doesn't take a turn to cast, stacks)
pause
goto game

:levelup
set /a exp-=%expcap%
set /a expcap+=%random% %%14 +7
set /a playerdmgincrease+=%random% %%4 +1
set /a playerhpcapincrease+=%random% %%15 +5
set /a playerhpcap+=%playerhpcapincrease%
set /a playerdmg+=%playerdmgincrease%
set /a playermanacapincrease+=%random% %%15 +5
set /a playermanacap+=%playermanacapincrease%
set /a level+=1
cls
echo You leveled up!
echo.
echo Damage increased by %playerdmgincrease%
echo Maximum health increased by %playerhpcapincrease%
echo Maximum mana increased by %playermanacapincrease%
echo Exp cap increased to %expcap%
echo.
pause
goto game

:shop
set input=0
cls
echo What do you want to buy? Each item can only be bought once, except for rings. You can buy 10 rings in total.
echo.
echo You have %gold% gold.
echo.
echo 1. Shortsword - increases attack by 3 - 15 gold
echo 2. Ring of health - increases health by 10 - 30 gold
echo 3. Ring of mana - increases mana by 10 - 30 gold
echo 4. Spellbook (stun) - Gives you a spell that stuns enemies for 2-4 turns - 100 gold
echo 5. Spellbook (greater heal) - Gives you a spell that heals you for 50 HP - 150 gold
echo 6. Spellbook (magic barrier) - Gives you a spell that negates damage taken for 1 turn - 200 gold
echo.
echo 7. Sell
echo 8. Leave
echo.
set /p input=C:\
if "%input%" == "1" goto shortsword
if "%input%" == "2" goto ringofhealth
if "%input%" == "3" goto ringofmana
if "%input%" == "4" goto spellstun
if "%input%" == "5" goto spellgreaterheal
if "%input%" == "6" goto spellmagicbarrier
if "%input%" == "7" goto sell
if "%input%" == "8" goto game
goto shop

:sell
set input=0
cls
echo What do you want to sell? You only get half of the items original value.
echo.
echo 1. Leave
echo.
if %shortsword% geq 1 echo 2. Shortsword - 8 gold
if %ringofhealth% geq 1 echo 3. Ring of health - 15 gold
if %ringofmana% geq 1 echo 4. Ring of mana - 15 gold
if %spellstun% geq 1 echo 5. Spellbook (stun) - 100 gold
if %greaterheal% geq 1 echo 6. Spellbook (greater heal) - 150 gold
if %magicbarrier% geq 1 ecgo 7. Spellbook (magic barrier) - 200 gold
echo.
set /p input=C:\
if "%input%" == "1" goto shop
if "%input%" == "2" goto sellshortsword
if "%input%" == "3" goto sellringofhealth
if "%input%" == "4" goto sellringofmana
if "%input%" == "5" goto sellstun
if "%input%" == "6" goto sellgreaterheal
if "%input%" == "7" goto sellmagicbarrier
goto sell

:selling
cls
echo Item successfully sold!
echo.
pause
goto sell

:sellshortsword
if %shortsword% lss 1 goto sell
set /a playerdmg-=3
set /a gold+=8
set shortsword=0
goto selling

:sellringofhealth
if %ringofhealth% lss 1 goto sell
set /a playerhpcap-=10
set /a playerhp-=10
set /a gold+=15
set /a ringofhealth-=1
set /a ring-=1
goto selling

:sellringofmana
if %ringofmana% lss 1 goto sell
set /a playermanacap-=10
set /a playermana-=10
set /a gold+=15
set /a ringofmana-=1
set /a ring-=1
goto selling

:sellstun
if %spellstun% lss 1 goto sell
set spellstun=0
set /a gold+=100
goto selling

:sellgreaterheal
if %spellgreaterheal% lss 1 goto sell
set spellstun=0
set /a gold+=150
goto selling

:sellmagicbarrier
if %magicbarrier% lss 1 goto sell
set spellmagicbarrier=0
set /a gold+=200
goto selling

:shortsword
if %shortsword% geq 1 goto alreadyhave
if %gold% lss 15 goto notenoughgold
set /a gold-=15
set shortsword=1
set /a playerdmg+=3
goto purchase

:ringofhealth
if %ring% geq 10 goto toomanyrings
if %gold% lss 30 goto notenoughgold
set /a gold-=30
set /a ringofhealth+=1
set /a ring+=1
set /a playerhpcap+=10
set /a playerhp+=10
goto purchase

:ringofmana
if %ring% geq 10 goto toomanyrings
if %gold% lss 30 goto notenoughgold
set /a gold-=30
set /a ringofmana+=1
set /a ring+=1
set /a playermanacap+=10
set /a playermana+=10
goto purchase

:spellstun
if %spellstun% geq 1 goto alreadyhave
if %gold% lss 100 goto notenoughgold
set /a gold-=100
set spellstun=1
goto purchase

:spellgreaterheal
if %greaterheal% geq 1 goto alreadyhave
if %gold% lss 150 goto notenoughgold
set /a gold-=150
set greaterheal=1
goto purchase

:spellmagicbarrier
if %magicbarrier% geq 1 goto alreadyhave
if %gold% lss 150 goto notenoughgold
set /a gold-=200
set magicbarrier=1
goto purchase

:alreadyhave
cls
echo You already have that item.
echo.
pause
goto shop

:notenoughgold
cls
echo You don't have enough gold to buy that item.
echo.
pause
goto shop

:toomanyrings
cls
echo Dude. I think that's enough rings.
echo.
pause
goto shop

:purchase
cls
echo Item successfully purchased!
echo.
pause
goto shop

:rest
cls
echo You rest at a campfire.
echo.
echo Your HP has been fully restored!
echo Your mana has been fully restored!
echo.
pause
set playerhp=%playerhpcap%
set playermana=%playermanacap%
goto game

:mystats
cls
echo Me
echo -----------
echo Attack: %playerdmg%
echo Health: %playerhp%
echo Mana: %playermana%
echo Gold: %gold%
echo EXP: %exp%
echo Level: %level%
echo -----------
echo EXP until next level: %expuntil%
echo.
pause
goto game

:prefight
cls
echo Roll the dice! This depends on what enemy you will be fighting.
echo.
pause
cls
echo You rolled a %fightnum%! What will it be?
echo.
pause
if "%fightnum%" == "1" goto fight1pre
if "%fightnum%" == "2" goto fight2pre
if "%fightnum%" == "3" goto fight3pre
if "%fightnum%" == "4" goto fight4pre
if "%fightnum%" == "5" goto fight5pre
if "%fightnum%" == "6" goto fight6pre
if "%fightnum%" == "7" goto fight7pre
if "%fightnum%" == "8" goto fight8pre
goto prefight

:fight1pre
set input=0
cls
echo You see a wolf in the distance.
echo.
echo What do you do?
echo.
echo 1. Fight
echo 2. Check enemy stats
echo 3. Sneak away
echo.
set /p input=C:\
if "%input%" == "1" goto fight1
if "%input%" == "2" goto fight1stats
if "%input%" == "3" goto game
goto fight1pre

:fight1stats
cls
echo Wolf
echo ---------------
echo Attack: 5
echo Health: 65
echo Gold drop: 1-5
echo EXP gain: 3-8
echo ---------------
echo.
pause
goto fight1pre

:fight1
if %stun% geq 1 set wolfdmg=0
if %stun% lss 1 set wolfdmg=3
set input=0
cls
echo You are fighting a wolf.
echo.
if "%enemyspellnum%" == "2" echo The wolf used Grievous Bite on you! You lost 6 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %wolfhp%
echo.
echo Enemy attack: %wolfdmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee (25% chance)
echo.
set /p input=C:\
if "%input%" == "1" goto fight1attack
if "%input%" == "2" goto spells1
if "%input%" == "3" goto wait1
if "%input%" == "4" goto flee1
goto fight1

:spells1
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight1
if "%input%" == "2" goto lesserheal1
if "%input%" == "3" goto stun1
if "%input%" == "4" goto greaterheal1
if "%input%" == "5" goto magicbarrier1
goto spells1

:lesserheal1
if %playermana% lss 25 goto notenoughmana1
if %playerhp% geq %playerhpcap% goto fullhp1
set /a playermana-=25
set /a playerhp+=20
goto spells1

:greaterheal1
if %playermana% lss 50 goto notenoughmana1
if %playerhp% geq %playerhpcap% goto fullhp1
set /a playermana-=50
set /aplayerhp+=50
goto spells1

:fullhp1
cls
echo Your health is already at full.
echo.
pause
goto spells1

:stun1
if %spellstun% lss 1 goto spells1
if %playermana% lss 50 goto notenoughmana1
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight1

:magicbarrier1
if %spellmagicbarrier% lss 1 goto spells1
if %playermana% lss 40 goto notenoughmana1
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells1

:notenoughmana1
cls
echo Not enough mana.
echo.
pause
goto spells1

:flee1
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail1
if "%fleenum%" == "2" goto fleesuccess
if "%fleenum%" == "3" goto fleefail1
if "%fleenum%" == "4" goto fleefail1
goto flee1

:fleesuccess
cls
echo You ran away.
echo.
pause
goto game

:fleefail1
cls
echo You fled.. unsuccessfully!
echo.
pause
goto wait1


:wait1
set /a playerhp-=%wolfdmg%
if %playerhp% lss 1 goto defeat
goto fight1

:fight1attack
set enemyspellnum=0
set /a enemyspellnum+= %random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell1
set /a playerhp-=%wolfdmg%
if magicbarrieractive geq 1 goto magicbarrieractive1
set /a wolfhp-=%playerdmg%
if %wolfhp% lss 1 goto victory1
if %playerhp% lss 1 goto defeat
goto fight1

:magicbarrieractive1
if magicbarrieractive geq 1 set /a magicbarrieractive-=1
if %wolfhp% lss 1 goto victory1
goto fight1

:enemyspell1
set /a wolfhp-=%playerdmg%
if magicbarrieractive geq 1 goto magicbarrieractive1
set /a playerhp-=6
if %wolfhp% lss 1 goto victory1
if %playerhp% lss 1 goto defeat
goto fight1

:victory1
set /a goldgain+=%random% %%5 +1
set /a expgain+=%random% %%5 +3
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeat the wolf!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto game

:defeat
set input=0
cls
echo You died. Which sucks, because I haven't implemented a save system yet.
echo.
echo Start new game? (Y/N)
echo.
set /p input=C:\
if "%input%" == "y" goto newgame
if "%input%" == "n" goto startmenu
goto defeat

:fight2pre
set input=0
cls
echo You come across a tent. Inside is a sleeping bandit.
echo.
echo What do you do?
echo.
echo 1. Fight
echo 2. Check enemy stats
echo 3. Sneak away
echo.
set /p input=C:\
if "%input%" == "1" goto fight2
if "%input%" == "2" goto fight2stats
if "%input%" == "3" goto game
goto fight2pre

:fight2
if %stun% geq 1 set banditdmg=0
if %stun% lss 1 set banditdmg=7
set input=0
cls
echo You are fighting a bandit.
echo.
if "%enemyspellnum%" == "2" echo The bandit used Slice! You lost 14 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %bandithp%
echo.
echo Enemy attack: %banditdmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee (25% chance)
echo.
set /p input=C:\
if "%input%" == "1" goto fight2attack
if "%input%" == "2" goto spells2
if "%input%" == "3" goto wait2
if "%input%" == "4" goto flee2
goto fight2

:spells2
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight2
if "%input%" == "2" goto lesserheal2
if "%input%" == "3" goto stun2
if "%input%" == "4" goto greaterheal2
if "%input%" == "5" goto magicbarrier2
goto spells2

:lesserheal2
if %playermana% lss 25 goto notenoughmana2
if %playerhp% geq %playerhpcap% goto fullhp2
set /a playermana-=25
set /a playerhp+=20
goto spells2

:greaterheal2
if %playermana% lss 50 goto notenoughmana2
if %playerhp% geq %playerhpcap% goto fullhp2
set /a playermana-=50
set /aplayerhp+=50
goto spells2

:fullhp2
cls
echo Your health is already at full.
echo.
pause
goto spells2

:stun2
if %spellstun% lss 1 goto spells2
if %playermana% lss 50 goto notenoughmana2
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight2

:magicbarrier2
if %spellmagicbarrier% lss 1 goto spells2
if %playermana% lss 40 goto notenoughmana2
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells2

:notenoughmana2
cls
echo Not enough mana.
echo.
pause
goto spells2

:wait2
set /a playerhp-=%banditdmg%
if %playerhp% lss 1 goto defeat
goto fight2

:fight2stats
cls
echo Bandit
echo -----------------
echo Attack: 10
echo Health: 100
echo Gold drop: 4-8
echo EXP gain: 10-16
echo -----------------
echo.
pause
goto fight2pre

:flee2
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail2
if "%fleenum%" == "2" goto fleesuccess
if "%fleenum%" == "3" goto fleefail2
if "%fleenum%" == "4" goto fleefail2
goto flee2

:fleefail2
cls
echo You fled.. unsuccessfully!
echo.
pause
goto wait2

:fight2attack
set enemyspellnum=0
set /a enemyspellnum+= %random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell2
set /a playerhp-=%banditdmg%
if magicbarrieractive geq 1 goto magicbarrieractive2
set /a wolfhp-=%playerdmg%
if %bandithp% lss 1 goto victory2
if %playerhp% lss 1 goto defeat
goto fight2

:magicbarrieractive2
if magicbarrieractive geq 1 set /a magicbarrieractive-=1
if %bandithp% lss 1 goto victory2
goto fight2

:enemyspell2
set /a bandithp-=%playerdmg%
if magicbarrieractive geq 1 goto magicbarrieractive2
set /a playerhp-=14
if %bandithp% lss 1 goto victory2
if %playerhp% lss 1 goto defeat
goto fight2

:victory2
set /a goldgain+=%random% %%5 +4
set /a expgain+=%random% %%7 +10
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeat the bandit!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto game

:fight3pre
set input=0
cls
echo You spot a goblin village.
echo.
echo What do you do?
echo.
echo 1. Lure a goblin out (fight)
echo 2. Check enemy stats
echo 3. Sneak away
echo.
set /p input=C:\
if "%input%" == "1" goto fight3
if "%input%" == "2" goto fight3stats
if "%input%" == "3" goto game
goto fight3pre

:fight3stats
cls
echo Goblin
echo ------------------
echo Health: 120
echo Attack: 16
echo Gold drop: 10-16
echo EXP gain: 18-24
echo ------------------
echo.
pause
goto fight3pre

:fight3
if %stun% geq 1 set goblindmg=0
if %stun% lss 1 set goblindmg=12
set input=0
cls
echo You are fighting a goblin.
echo.
if "%enemyspellnum%" == "2" echo The goblin used Stab! You lost 24 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %goblinhp%
echo.
echo Enemy attack: %goblindmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee (25% chance)
echo.
set /p input=C:\
if "%input%" == "1" goto fight3attack
if "%input%" == "2" goto spells3
if "%input%" == "3" goto wait3
if "%input%" == "4" goto flee3
goto fight3

:spells3
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight3
if "%input%" == "2" goto lesserheal3
if "%input%" == "3" goto stun3
if "%input%" == "4" goto greaterheal3
if "%input%" == "5" goto magicbarrier3
goto spells3

:lesserheal3
if %playermana% lss 25 goto notenoughmana3
if %playerhp% geq %playerhpcap% goto fullhp3
set /a playermana-=25
set /a playerhp+=20
goto spells3

:greaterheal3
if %playermana% lss 50 goto notenoughmana3
if %playerhp% geq %playerhpcap% goto fullhp3
set /a playermana-=50
set /aplayerhp+=50
goto spells3

:notenoughmana3
cls
echo Not enough mana.
echo.
pause
goto spells3

:fullhp3
cls
echo Your health is already at full.
echo.
pause
goto spells3

:stun3
if %spellstun% lss 1 goto spells3
if %playermana% lss 50 goto notenoughmana3
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight3

:magicbarrier3
if %spellmagicbarrier% lss 1 goto spells3
if %playermana% lss 40 goto notenoughmana3
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells3

:wait3
set /a playerhp-=%goblindmg%
if %playerhp% lss 1 goto defeat
goto fight3

:flee3
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail3
if "%fleenum%" == "2" goto fleesuccess
if "%fleenum%" == "3" goto fleefail3
if "%fleenum%" == "4" goto fleefail3
goto flee3

:fleefail3
cls
echo You fled.. unsuccessfully!
echo.
pause
goto wait3

:fight3attack
set enemyspellnum=0
set /a enemyspellnum+= %random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell3
set /a playerhp-=%goblindmg%
if magicbarrieractive geq 1 goto magicbarrieractive3
set /a wolfhp-=%playerdmg%
if %goblinhp% lss 1 goto victory3
if %playerhp% lss 1 goto defeat
goto fight3

:magicbarrieractive3
if magicbarrieractive geq 1 set /a magicbarrieractive-=1
if %goblinhp% lss 1 goto victory3
goto fight3

:enemyspell3
set /a goblinhp-=%playerdmg%
if magicbarrieractive geq 1 goto magicbarrieractive3
set /a playerhp-=24
if %goblinhp% lss 1 goto victory3
if %playerhp% lss 1 goto defeat
goto fight3

:victory3
set /a goldgain+=%random% %%7 +10
set /a expgain+=%random% %%7 +18
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeat the goblin!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto game

:fight4pre
set input=0
cls
echo After exploring some ruins, you come across an old crypt. Probably full of skeletons?
echo.
echo What do you do?
echo.
echo 1. Enter (fight)
echo 2. Check enemy stats
echo 3. Turn around and leave
echo.
set /p input=C:\
if "%input%" == "1" goto fight4
if "%input%" == "2" goto fight4stats
if "%input%" == "3" goto game
goto fight4pre

:fight4stats
cls
echo Skeleton
echo -----------------
echo Health: 150
echo Attack: 16
echo Gold drop: 26-32
echo EXP gain: 30-40
echo -----------------
echo.
pause
goto fight4pre

:fight4
if %stun% geq 1 set skeletondmg=0
if %stun% lss 1 set skeletondmg=16
set input=0
cls
echo You are fighting a skeleton.
echo.
if "%enemyspellnum%" == "2" echo The skeleton used Bone Throw! You lost 32 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %skeletonhp%
echo.
echo Enemy attack: %skeletondmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee (25% chance)
echo.
set /p input=C:\
if "%input%" == "1" goto fight4attack
if "%input%" == "2" goto spells4
if "%input%" == "3" goto wait4
if "%input%" == "4" goto flee4
goto fight4

:spells4
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight4
if "%input%" == "2" goto lesserheal4
if "%input%" == "3" goto stun4
if "%input%" == "4" goto greaterheal4
if "%input%" == "5" goto magicbarrier4
goto spells4

:lesserheal4
if %playermana% lss 25 goto notenoughmana4
if %playerhp% geq %playerhpcap% goto fullhp4
set /a playermana-=25
set /a playerhp+=20
goto spells4

:greaterheal4
if %playermana% lss 50 goto notenoughmana4
if %playerhp% geq %playerhpcap% goto fullhp4
set /a playermana-=50
set /aplayerhp+=50
goto spells4

:fullhp4
cls
echo Your health is already at full.
echo.
pause
goto spells4

:stun4
if %spellstun% lss 1 goto spells4
if %playermana% lss 50 goto notenoughmana4
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight4

:notenoughmana4
cls
echo Not enough mana.
echo.
pause
goto spells4

:wait4
set /a playerhp-=%skeletondmg%
if %playerhp% lss 1 goto defeat
goto fight4

:flee4
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail4
if "%fleenum%" == "2" goto fleesuccess
if "%fleenum%" == "3" goto fleefail4
if "%fleenum%" == "4" goto fleefail4
goto flee4

:fleefail4
cls
echo You fled.. unsuccessfully!
echo.
pause
goto wait4

:fight4attack
set enemyspellnum=0
set /a enemyspellnum+=%random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell4
set /a playerhp-=%skeletondmg%
set /a skeletonhp-=%playerdmg%
if %playerhp% lss 1 goto defeat
if %skeletonhp% lss 1 goto victory4
goto fight4

:enemyspell4
set /a skeletonhp-=%playerdmg%
set /a playerhp-=32
if %skeletonhp% lss 1 goto victory4
if %playerhp% lss 1 goto defeat
goto fight4

:victory4
set /a goldgain+=%random% %%7 +26
set /a expgain+=%random% %%11 +30
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeat the goblin!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto game

:fight5pre
set input=0
cls
echo While navigating the swamps, you hear a noise behind you. It's a giant lizard!
echo.
echo What do you do?
echo.
echo 1. Fight
echo 2. Check enemy stats
echo 3. Run
echo.
set /p input=C:\
if "%input%" == "1" goto fight5
if "%input%" == "2" goto fight5stats
if "%input%" == "3" goto game
goto fight5pre

:fight5stats
cls
echo Giant lizard
echo -----------------
echo Health: 200
echo Attack: 35
echo Gold drop: 40-50
echo EXP gain: 64-72
echo -----------------
echo.
pause
goto fight5pre

:fight5
if %stun% geq 1 set giantlizarddmg=0
if %stun% lss 1 set giantlizarddmg=35
set input=0
cls
echo You are fighting a giant lizard.
echo.
if "%enemyspellnum%" == "2" echo The giant lizard used Venomous Bite! You lost 70 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %giantlizardhp%
echo.
echo Enemy attack: %giantlizarddmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee (25% chance)
echo.
set /p input=C:\
if "%input%" == "1" goto fight5attack
if "%input%" == "2" goto spells5
if "%input%" == "3" goto wait5
if "%input%" == "4" goto flee5
goto fight5

:spells5
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight5
if "%input%" == "2" goto lesserheal5
if "%input%" == "3" goto stun5
if "%input%" == "4" goto greaterheal5
if "%input%" == "5" goto magicbarrier5
goto spells5

:lesserheal5
if %playermana% lss 25 goto notenoughmana5
if %playerhp% geq %playerhpcap% goto fullhp5
set /a playermana-=25
set /a playerhp+=20
goto spells5

:greaterheal5
if %playermana% lss 50 goto notenoughmana5
if %playerhp% geq %playerhpcap% goto fullhp5
set /a playermana-=50
set /aplayerhp+=50
goto spells5

:fullhp5
cls
echo Your health is already at full.
echo.
pause
goto spells5

:stun5
if %spellstun% lss 1 goto spells5
if %playermana% lss 50 goto notenoughmana5
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight5

:magicbarrier5
if %spellmagicbarrier% lss 1 goto spells5
if %playermana% lss 40 goto notenoughmana5
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells5

:notenoughmana5
cls
echo Not enough mana.
echo.
pause
goto spells5

:wait5
set /a playerhp-=%giantlizarddmg%
if %playerhp% lss 1 goto defeat
goto fight5

:fight5attack
set enemyspellnum=0
set /a enemyspellnum+=%random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell5
set /a playerhp-=%giantlizarddmg%
set /a giantlizardhp-=%playerdmg%
if %playerhp% lss 1 goto defeat
if %giantlizardhp% lss 1 goto victory5
goto fight5

:enemyspell5
set /a giantlizardhp-=%playerdmg%
set /a playerhp-=70
if %giantlizardhp% lss 1 goto victory5
if %playerhp% lss 1 goto defeat
goto fight5

:victory5
set /a goldgain+=%random% %%11 +40
set /a expgain+=%random% %%9 +64
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeated the giant lizard!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto game

:flee5
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail5
if "%fleenum%" == "2" goto fleesuccess
if "%fleenum%" == "3" goto fleefail5
if "%fleenum%" == "4" goto fleefail5
goto flee5

:fleefail5
cls
echo You fled.. unsuccessfully!
echo.
pause
goto wait5

:fight6pre
set input=0
cls
echo After exploring a dark cave, you hear heavy breathing behind you. Cave troll!
echo.
echo What do you do?
echo.
echo 1. Fight
echo 2. Check enemy stats
echo 3. Run
echo.
set /p input=C:\
if "%input%" == "1" goto fight6
if "%input%" == "2" goto fight6stats
if "%input%" == "3" goto game
goto fight6pre

:fight6stats
cls
echo Cave Troll
echo -----------------
echo Health: 250
echo Attack: 50
echo Gold drop: 60-70
echo EXP gain: 84-92
echo -----------------
echo.
pause
goto fight6pre

:fight6
if %stun% geq 1 set trolldmg=0
if %stun% lss 1 set trolldmg=50
set input=0
cls
echo You are fighting a cave troll.
echo.
if "%enemyspellnum%" == "2" echo The cave troll used Bash! You lost 100 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %trollhp%
echo.
echo Enemy attack: %trolldmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee (25% chance)
echo.
set /p input=C:\
if "%input%" == "1" goto fight6attack
if "%input%" == "2" goto spells6
if "%input%" == "3" goto wait6
if "%input%" == "4" goto flee6
goto fight6

:spells6
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight6
if "%input%" == "2" goto lesserheal6
if "%input%" == "3" goto stun6
if "%input%" == "4" goto greaterheal6
if "%input%" == "5" goto magicbarrier6
goto spells6

:lesserheal6
if %playermana% lss 25 goto notenoughmana6
if %playerhp% geq %playerhpcap% goto fullhp6
set /a playermana-=25
set /a playerhp+=20
goto spells6

:greaterheal6
if %playermana% lss 50 goto notenoughmana6
if %playerhp% geq %playerhpcap% goto fullhp6
set /a playermana-=50
set /aplayerhp+=50
goto spells6

:fullhp6
cls
echo Your health is already at full.
echo.
pause
goto spells6

:stun6
if %spellstun% lss 1 goto spells6
if %playermana% lss 50 goto notenoughmana6
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight6

:magicbarrier6
if %spellmagicbarrier% lss 1 goto spells6
if %playermana% lss 40 goto notenoughmana6
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells6

:notenoughmana6
cls
echo Not enough mana.
echo.
pause
goto spells6

:wait6
set /a playerhp-=%trolldmg%
if %playerhp% lss 1 goto defeat
goto fight6

:fight6attack
set enemyspellnum=0
set /a enemyspellnum+=%random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell6
set /a playerhp-=%trolldmg%
set /a trollhp-=%playerdmg%
if %playerhp% lss 1 goto defeat
if %trollhp% lss 1 goto victory6
goto fight6

:enemyspell6
set /a trollhp-=%playerdmg%
set /a playerhp-=100
if %trollhp% lss 1 goto victory6
if %playerhp% lss 1 goto defeat
goto fight6

:victory6
set /a goldgain+=%random% %%11 +60
set /a expgain+=%random% %%9 +84
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeated the cave troll!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto game

:flee6
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail6
if "%fleenum%" == "2" goto fleesuccess
if "%fleenum%" == "3" goto fleefail6
if "%fleenum%" == "4" goto fleefail6
goto flee6

:fleefail6
cls
echo You fled.. unsuccessfully!
echo.
pause
goto wait6

:fight7pre
set input=0
cls
echo After coming across a treasure horde in a cave, you notice that you are doing a staring contest with a cave dragon.
echo.
echo What do you do?
echo.
echo 1. Fight
echo 2. Check enemy stats
echo 3. Run
echo.
set /p input=C:\
if "%input%" == "1" goto fight7
if "%input%" == "2" goto fight7stats
if "%input%" == "3" goto game
goto fight7pre

:fight7stats
cls
echo Cave Dragon
echo -----------------
echo Health: 300
echo Attack: 65
echo Gold drop: 80-100
echo EXP gain: 120-150
echo -----------------
echo.
pause
goto fight7pre

:fight7
if %stun% geq 1 set cavedragondmg=0
if %stun% lss 1 set cavedragondmg=65
set input=0
cls
echo You are fighting a cave dragon.
echo.
if "%enemyspellnum%" == "2" echo The cave dragon used Fire Breathe! You lost 130 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %cavedragonhp%
echo.
echo Enemy attack: %cavedragondmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee (25% chance)
echo.
set /p input=C:\
if "%input%" == "1" goto fight7attack
if "%input%" == "2" goto spells7
if "%input%" == "3" goto wait7
if "%input%" == "4" goto flee7
goto fight7

:spells7
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight7
if "%input%" == "2" goto lesserheal7
if "%input%" == "3" goto stun7
if "%input%" == "4" goto greaterheal7
if "%input%" == "5" goto magicbarrier7
goto spells7

:lesserheal7
if %playermana% lss 25 goto notenoughmana7
if %playerhp% geq %playerhpcap% goto fullhp7
set /a playermana-=25
set /a playerhp+=20
goto spells7

:greaterheal7
if %playermana% lss 50 goto notenoughmana7
if %playerhp% geq %playerhpcap% goto fullhp7
set /a playermana-=50
set /aplayerhp+=50
goto spells7

:fullhp7
cls
echo Your health is already at full.
echo.
pause
goto spells7

:stun7
if %spellstun% lss 1 goto spells7
if %playermana% lss 50 goto notenoughmana7
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight7

:magicbarrier7
if %spellmagicbarrier% lss 1 goto spells7
if %playermana% lss 40 goto notenoughmana7
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells7

:notenoughmana7
cls
echo Not enough mana.
echo.
pause
goto spells7

:wait7
set /a playerhp-=%cavedragondmg%
if %playerhp% lss 1 goto defeat
goto fight7

:fight7attack
set enemyspellnum=0
set /a enemyspellnum+=%random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell7
set /a playerhp-=%cavedragondmg%
set /a cavedragonhp-=%playerdmg%
if %playerhp% lss 1 goto defeat
if %cavedragonhp% lss 1 goto victory7
goto fight7

:enemyspell7
set /a cavedragonhp-=%playerdmg%
set /a playerhp-=130
if %cavedragonhp% lss 1 goto victory7
if %playerhp% lss 1 goto defeat
goto fight7

:victory7
set /a goldgain+=%random% %%21 +80
set /a expgain+=%random% %%31 +120
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeated the cave dragon!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto game

:flee7
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail7
if "%fleenum%" == "2" goto fleesuccess
if "%fleenum%" == "3" goto fleefail7
if "%fleenum%" == "4" goto fleefail7
goto flee6

:fleefail7
cls
echo You fled.. unsuccessfully!
echo.
pause
goto wait7

:fight8pre
set input=0
cls
echo You come across a black obelisk in a dungeon. It is engraved with glowing red runes.
echo.
echo You feel an unknown evil force inside the obelisk.
echo.
echo What do you do?
echo.
echo 1. Attack
echo 2. Check enemy stats
echo 3. Run
echo.
set /p input=C:/
if "%input%" == "1" goto fight8
if "%input%" == "2" goto fight8stats
if "%input%" == "3" goto game
goto fight8pre

:fight8stats
cls
echo Obelisk
echo -----------------
echo Health: 500
echo Attack: 0
echo Gold drop: 0
echo EXP gain: 0
echo -----------------
echo.
pause
goto fight8pre

:fight8
set input=0
cls
echo You are attempting to tip over the obelisk.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %obeliskhp%
echo.
echo Enemy attack: %obeliskdmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrier% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee
echo.
set /p input=C:\
if "%input%" == "1" goto fight8attack
if "%input%" == "2" goto spells8
if "%input%" == "3" goto fight8
if "%input%" == "4" goto flee8
goto fight8

:flee8
cls
echo You decide it probably isn't a good idea and leave.
pause.
goto game

:spells8
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight8
if "%input%" == "2" goto lesserheal8
if "%input%" == "3" goto stun8
if "%input%" == "4" goto greaterheal8
if "%input%" == "5" goto magicbarrier8
goto spells8

:lesserheal8
if %playermana% lss 25 goto notenoughmana8
if %playerhp% geq %playerhpcap% goto fullhp8
set /a playermana-=25
set /a playerhp+=20
goto spells8

:greaterheal8
if %playermana% lss 50 goto notenoughmana8
if %playerhp% geq %playerhpcap% goto fullhp8
set /a playermana-=50
set /aplayerhp+=50
goto spells8

:fullhp8
cls
echo Your health is already at full.
echo.
pause
goto spells8

:stun8
if %spellstun% lss 1 goto spells8
if %playermana% lss 50 goto notenoughmana8
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight8

:magicbarrier8
if %spellmagicbarrier% lss 1 goto spells8
if %playermana% lss 40 goto notenoughmana8
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells8

:notenoughmana8
cls
echo Not enough mana.
echo.
pause
goto spells8

:fight8attack
if %stun% geq 1 set /a stun-=1
set /a playerhp-=%obeliskdmg%
set /a obeliskhp-=%playerdmg%
if %playerhp% lss 1 goto defeat
if %obeliskhp% lss 1 goto abaddon
goto fight8

:abaddon
cls
echo.
echo You managed to tip over the obelisk.
echo.
echo It shatters spectacularily as it hits the ground. You see dark mist exit the obelisk.
echo.
echo You made a mistake. It was inevitable.
echo.
echo The mist takes form in front of you. It's Abaddon, the demon king!
echo.
pause
goto fight9

:fight9
if %stun% geq 1 set azerothdmg=0
if %stun% lss 1 set azerothdmg=75
set input=0
cls
echo You are fighting Abaddon. You feel like this isn't going to end well.
echo.
if "%enemyspellnum%" == "2" echo Abaddon used Obliterate! You lost 150 HP.
echo.
echo Your health: %playerhp%
echo.
echo Your attack: %playerdmg%
echo.
echo.
echo Enemy health: %azerothhp%
echo.
echo Enemy attack: %azerothdmg%
echo.
if %stun% geq 1 echo Enemy is stunned for %stun% turn(s)
if %magicbarrieractive% geq 1 echo Magic barrier is active for %magicbarrieractive% turn(s)
echo.
echo What is your next move?
echo.
echo 1. Attack
echo 2. Spells
echo 3. Wait
echo 4. Flee
echo.
set /p input=C:\
if "%input%" == "1" goto fight9attack
if "%input%" == "2" goto spells9
if "%input%" == "3" goto wait9
if "%input%" == "4" goto flee9
goto fight9

:spells9
set input=0
cls
echo Spells - You have %playermana% mana.
echo.
echo 1. Leave
if %lesserheal% geq 1 echo 2. Lesser heal - 25 mana - Restore 20 HP
if %spellstun% geq 1 echo 3. Stun - 50 mana - Enemies who are stunned will deal no damage
if %greaterheal% geq 1 echo 4. Greater heal - 50 mana - Restore 50 HP
if %magicbarrier% geq 1 echo 5. Magic barrier - 40 mana - Negate all damage for 1 turn, doesn't take a turn to cast
echo.
set /p input=C:\
if "%input%" == "1" goto fight9
if "%input%" == "2" goto lesserheal9
if "%input%" == "3" goto stun9
if "%input%" == "4" goto greaterheal9
if "%input%" == "5" goto magicbarrier9
goto spells9

:lesserheal9
if %playermana% lss 25 goto notenoughmana9
if %playerhp% geq %playerhpcap% goto fullhp9
set /a playermana-=25
set /a playerhp+=20
goto spells9

:greaterheal9
if %playermana% lss 50 goto notenoughmana9
if %playerhp% geq %playerhpcap% goto fullhp9
set /a playermana-=50
set /aplayerhp+=50
goto spells9

:fullhp9
cls
echo Your health is already at full.
echo.
pause
goto spells9

:stun9
if %spellstun% lss 1 goto spells9
if %playermana% lss 50 goto notenoughmana9
set /a playermana-=50
set /a stun+=%random% %%3 +2
goto fight9

:magicbarrier9
if %spellmagicbarrier% lss 1 goto spells9
if %playermana% lss 40 goto notenoughmana9
set /a playermana-=40
set /a magicbarrieractive+=1
goto spells9

:notenoughmana9
cls
echo Not enough mana.
echo.
pause
goto spells9

:wait9
set /a playerhp-=%azerothdmg%
if %playerhp% lss 1 goto defeat
goto fight9

:fight9attack
set enemyspellnum=0
set /a enemyspellnum+=%random% %%4 +1
if %stun% geq 1 set /a stun-=1
if "%enemyspellnum%" == "2" goto enemyspell9
set /a playerhp-=%azerothdmg%
set /a azerothhp-=%playerdmg%
if %playerhp% lss 1 goto defeat
if %azerothhp% lss 1 goto azerothwin
goto fight9

:enemyspell9
set /a azerothhp-=%playerdmg%
set /a playerhp-=150
if %azerothhp% lss 1 goto victory9
if %playerhp% lss 1 goto defeat
goto fight9

:azerothwin
set input=0
cls
echo.
echo With one final strike from your sword, you smite down Abaddon, the demon king.
echo.
echo Is this it? Is this where your adventure ends?
echo.
set /p input=C:/
if "%input%" == "yes" exit
if "%input%" == "no" goto victory9
if "%input%" == "y" exit
if "%input%" == "n" goto victory9
goto azerothwin

:flee9
set fleenum=0
set /a fleenum+=%random% %%4 +1
if "%fleenum%" == "1" goto fleefail9
if "%fleenum%" == "2" goto fleefail9
if "%fleenum%" == "3" goto fleefail9
if "%fleenum%" == "4" goto fleefail9
goto flee6

:fleefail9
cls
echo You cannot run from Abaddon.
echo.
pause
goto fight9

:victory9
set /a goldgain+=%random% %%301 +500
set /a expgain+=%random% %%401 +800
set /a gold+=%goldgain%
set /a exp+=%expgain%
cls
echo You successfully defeated Azeroth!
echo.
echo You gained %goldgain% gold and %expgain% EXP!
echo.
echo Don't forget to rest after a fight.
echo.
pause
goto ending

:ending
set input=0
cls
echo This is where your adventure ends, hero.
echo.
echo Would you like to continue playing? Y/N
echo.
set /p input=C:\
if "%input%" == "y" goto game
if "%input%" == "Y" goto game
if "%input%" == "n" goto startmenu
if "%input%" == "N" goto startmenu
