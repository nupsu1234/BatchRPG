@echo off
setlocal EnableDelayedExpansion

rem ==================== Game Initialization ===================
:init
call :initPlayer
call :initSpells
goto :startmenu

rem ==================== Title Menu ============================
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
choice /c 123 /m "Choose an option:"

if errorlevel 3 goto exit
if errorlevel 2 goto credits
if errorlevel 1 goto newgame

:exit
exit

:credits
cls
echo.
echo This game was made by Nupsu.
echo.
echo Started the project sometime in March 2018. Picked it back up December 2024.
echo.
pause
goto startmenu

:newgame
call :initPlayer
call :initSpells
goto game

rem ==================== Player Initialization ================
:initPlayer
rem Set initial player statistics
set level=1
set playerhp=100
set playerhpcap=100
set playerdmg=5
set playermana=100
set playermanacap=100
set gold=100
set exp=0
set expcap=100
rem Set initial status effects
set magicbarrieractive=0
set stun=0
goto :eof

rem ==================== Spell System Init ===================
:initSpells
rem Define which spells are available at start (1=learned, 0=not learned)
set lesserheal=1
set spellstun=0
set greaterheal=0
set magicbarrier=0
goto :eof

rem ==================== Enemy Configuration =================
:setEnemyStats
rem Configure enemy stats based on enemy type passed as parameter
rem Format for each enemy:
rem - Base stats (HP, DMG)
rem - Rewards (gold range, exp range)
rem - Combat options (can flee?, spell damage, special attack)
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
) else if "%~1"=="bandit" (
    set enemyname=Bandit
    set enemyhp=100
    set enemydmg=10
    set goldmin=4
    set goldmax=8
    set expmin=10
    set expmax=16
    set canflee=true
    set spelldmg=14
    set spellname=Slice
) else if "%~1"=="goblin" (
    set enemyname=Goblin
    set enemyhp=120
    set enemydmg=16
    set goldmin=10
    set goldmax=16
    set expmin=18
    set expmax=24
    set canflee=true
    set spelldmg=24
    set spellname=Stab
) else if "%~1"=="skeleton" (
    set enemyname=Skeleton
    set enemyhp=150
    set enemydmg=20
    set goldmin=26
    set goldmax=32
    set expmin=30
    set expmax=40
    set canflee=true
    set spelldmg=32
    set spellname=Bone Throw
) else if "%~1"=="giantlizard" (
    set enemyname=Giant Lizard
    set enemyhp=200
    set enemydmg=35
    set goldmin=40
    set goldmax=50
    set expmin=64
    set expmax=72
    set canflee=true
    set spelldmg=70
    set spellname=Venomous Bite
) else if "%~1"=="troll" (
    set enemyname=Cave Troll
    set enemyhp=250
    set enemydmg=50
    set goldmin=60
    set goldmax=70
    set expmin=84
    set expmax=92
    set canflee=true
    set spelldmg=100
    set spellname=Bash
) else if "%~1"=="cavedragon" (
    set enemyname=Cave Dragon
    set enemyhp=300
    set enemydmg=65
    set goldmin=80
    set goldmax=100
    set expmin=120
    set expmax=150
    set canflee=true
    set spelldmg=130
    set spellname=Fire Breath
) else if "%~1"=="obelisk" (
    rem Special non-combat enemy
    set enemyname=Obelisk
    set enemyhp=500
    set enemydmg=0
    set goldmin=0
    set goldmax=0
    set expmin=0
    set expmax=0
    set canflee=true
    set spelldmg=0
    set spellname=None
) else if "%~1"=="abaddon" (
    rem Boss enemy
    set enemyname=Abaddon
    set enemyhp=1000
    set enemydmg=75
    set goldmin=500
    set goldmax=800
    set expmin=800
    set expmax=1200
    set canflee=false
    set spelldmg=150
    set spellname=Dark Slash
)
goto :eof

rem ==================== Combat System ======================
:combat
cls
call :showCombatStatus
rem Display combat options to player
choice /c 1234 /m "Choose an option:"
echo.
echo 1) Attack
echo 2) Cast spell
echo 3) Wait
echo 4) Flee
if errorlevel 4 call :tryFlee
if errorlevel 3 call :wait
if errorlevel 2 call :spellMenu
if errorlevel 1 call :attack
rem Check for combat end conditions
if %enemyhp% leq 0 call :victory & goto :eof
if %playerhp% leq 0 call :defeat & goto :eof
goto :combat

rem ==================== Combat UI =========================
:showCombatStatus
rem Display current combat status
echo Fighting %enemyname%
echo Your HP: %playerhp%/%playerhpcap% Mana: %playermana%/%playermanacap%
echo Enemy HP: %enemyhp% DMG: %enemydmg%
rem Show active status effects
if %stun% gtr 0 echo Enemy stunned for %stun% turns
if %magicbarrieractive% gtr 0 echo Magic barrier active for %magicbarrieractive% turns
goto :eof

rem ==================== Spell System =====================
:spellMenu
cls
rem Display available spells and current mana
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

rem ==================== Spell Casting ====================
:castSpell
rem Route to appropriate spell based on selection
set /a _spellNum="%~1" 2>nul
if %errorlevel% neq 0 (
    echo Invalid input - must be a number
    goto :eof
)
if %_spellNum% lss 1 (
    echo Invalid spell selection - must be 1-4
    goto :eof
)
if %_spellNum% gtr 4 (
    echo Invalid spell selection - must be 1-4
    goto :eof
)
if "%~1"=="1" if %playermana% geq 25 (call :healSpell 25 20 lesser) else (echo Not enough mana - needs 25 & goto :eof)
if "%~1"=="2" if %playermana% geq 50 (call :stunSpell) else (echo Not enough mana - needs 50 & goto :eof)
if "%~1"=="3" if %playermana% geq 50 (call :healSpell 50 50 greater) else (echo Not enough mana - needs 50 & goto :eof)
if "%~1"=="4" if %playermana% geq 40 (call :barrierSpell) else (echo Not enough mana - needs 40 & goto :eof)
goto :eof

:healSpell
rem Parameters: %1=mana cost, %2=heal amount, %3=spell type
if %playermana% lss %~1 (echo Not enough mana for %~3 heal. & goto :eof)
if %playerhp% geq %playerhpcap% (echo HP already full. & goto :eof)
set /a "healed=%~2"
if %playerhp% + %healed% gtr %playerhpcap% set /a "healed=%playerhpcap%-%playerhp%"
set /a "playermana-=%~1"
set /a "playerhp+=healed"
echo Healed for %healed% HP.
goto :eof

:stunSpell
if %playermana% lss 50 (echo Not enough mana for stun. & goto :eof)
set /a "playermana-=50"
set /a "stun+=%random% %%3 +2"
goto :eof

:barrierSpell
if %playermana% lss 40 (echo Not enough mana for barrier. & goto :eof)
set /a "playermana-=40"
set /a "magicbarrieractive+=1"
goto :eof