@echo off
setlocal EnableDelayedExpansion

:init
call :initPlayer
call :initSpells
goto :startmenu

:initPlayer
set level=1
set playerhp=100
set playerhpcap=100
set playerdmg=5
set playermana=100
set playermanacap=100
set gold=100
set exp=0
set expcap=100
set magicbarrieractive=0
set stun=0
goto :eof

:initSpells
set lesserheal=1
set spellstun=0
set greaterheal=0
set magicbarrier=0
goto :eof

:setEnemyStats
if "%~1"=="wolf" (
    set enemyname=Wolf
    set enemyhp=65
    set enemydmg=3
    set goldmin=1
    set goldmax=5
    set expmin=3
    set expmax=8
    set canflee=true
    set spelldmg=6
    set spellname=Grievous Bite
)
if "%~1"=="dragon" (
    set enemyname=Cave Dragon
    set enemyhp=300
    set enemydmg=65
    set goldmin=80
    set goldmax=100
    set expmin=120
    set expmax=150
    set canflee=false
    set spelldmg=130
    set spellname=Dragon Breath
)
goto :eof

:combat
cls
call :showCombatStatus
choice /c 1234 /m "1.Attack 2.Spells 3.Wait 4.Flee"
if errorlevel 4 call :tryFlee
if errorlevel 3 call :wait
if errorlevel 2 call :spellMenu
if errorlevel 1 call :attack
if %enemyhp% leq 0 call :victory & goto :eof
if %playerhp% leq 0 call :defeat & goto :eof
goto :combat

:showCombatStatus
echo Fighting %enemyname%
echo Your HP: %playerhp%/%playerhpcap% Mana: %playermana%/%playermanacap%
echo Enemy HP: %enemyhp% DMG: %enemydmg%
if %stun% gtr 0 echo Enemy stunned for %stun% turns
if %magicbarrieractive% gtr 0 echo Magic barrier active for %magicbarrieractive% turns
goto :eof

:spellMenu
cls
echo Available spells (%playermana% mana):
if %lesserheal% geq 1 echo 1. Lesser Heal (25 mana)
if %spellstun% geq 1 echo 2. Stun (50 mana)
if %greaterheal% geq 1 echo 3. Greater Heal (50 mana)
if %magicbarrier% geq 1 echo 4. Magic Barrier (40 mana)
echo 5. Back
choice /c 12345 /m "Choose spell:"
if errorlevel 5 goto :eof
call :castSpell %errorlevel%
goto :eof

:castSpell
if "%~1"=="1" call :healSpell 25 20 lesser
if "%~1"=="2" call :stunSpell 
if "%~1"=="3" call :healSpell 50 50 greater
if "%~1"=="4" call :barrierSpell
goto :eof

:healSpell
if %playermana% lss %~1 echo Not enough mana. & goto :eof
if %playerhp% geq %playerhpcap% echo HP already full. & goto :eof
set /a playermana-=%~1
set /a playerhp+=%~2
if %playerhp% gtr %playerhpcap% set playerhp=%playerhpcap%
goto :eof