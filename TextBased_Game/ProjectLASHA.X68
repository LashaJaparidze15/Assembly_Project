*-----------------------------------------------------------
* Title      : Surviving the Jungle
* Written by : Lasha Japaridze
* Student ID: C00303432
* Date: February 28th
* Description: Surviving the Jungle is a text 
* based game where player starts with full health and energy
* with the objective to obtain influence(power) in the jungle
* and become the ruler of the jungle
* through various choices player can make friends with animals, which
* increases power, or fight them and get injured. also they can find 
* various good and harmful food, sleep to regenerate energy, fight 
* rival packs
*-----------------------------------------------------------
    ORG $1000
*-----------------------------------------------------------
* VALIDATION VALUES TO BE USED
*-----------------------------------------------------------
EXIT        EQU 0           ; USED TO EXIT ASSEMBLY PROGRAM
INIT_HEALTH EQU 100         ; INITIAL HEALTH (DEFAULT)
INIT_ENERGY EQU 100         ; INITIAL ENERGY (DEFAULT)
INIT_POWER  EQU 0           ; INITIAL POWER (START AT 0)

*-----------------------------------------------------------
* GAME VARIABLES
*-----------------------------------------------------------
HEALTH      DS.W    1       ; PLAYER'S HEALTH
ENERGY      DS.W    1       ; PLAYER'S ENERGY
POWER       DS.W    1       ; PLAYER'S POWER

*-----------------------------------------------------------
* START OF GAME
*-----------------------------------------------------------
START:
    BSR     INIT_GAME       ; INITIALIZE GAME VARIABLES
    BSR     WELCOME         ; DISPLAY WELCOME MESSAGE
    BSR     MAIN_LOOP       ; ENTER MAIN GAME LOOP
    BRA     END             ; END GAME

*-----------------------------------------------------------
* INITIALIZE GAME VARIABLES
*-----------------------------------------------------------
INIT_GAME:
    MOVE.W  #INIT_HEALTH,HEALTH  ; SET INITIAL HEALTH
    MOVE.W  #INIT_ENERGY,ENERGY  ; SET INITIAL ENERGY
    MOVE.W  #INIT_POWER,POWER    ; SET INITIAL POWER (START AT 0)
    RTS

*-----------------------------------------------------------
* WELCOME MESSAGE
*-----------------------------------------------------------
WELCOME:
    BSR     ENDL            ; PRINT NEWLINE
    LEA     WELCOME_MSG,A1  ; LOAD WELCOME MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE
    RTS

*-----------------------------------------------------------
* MAIN GAME LOOP
*-----------------------------------------------------------
MAIN_LOOP:
    BSR     DISPLAY_STATS   ; DISPLAY PLAYER STATS
    BSR     DISPLAY_OPTIONS ; DISPLAY GAME OPTIONS
    BSR     GET_INPUT       ; GET PLAYER INPUT
    BSR     PROCESS_INPUT   ; PROCESS PLAYER INPUT
    BSR     UPDATE_STATS    ; UPDATE PLAYER STATS
    BSR     CHECK_GAME_OVER ; CHECK IF GAME IS OVER
    BNE     MAIN_LOOP       ; CONTINUE LOOP IF GAME NOT OVER
    RTS

*-----------------------------------------------------------
* DISPLAY PLAYER STATS
*-----------------------------------------------------------
DISPLAY_STATS:
    BSR     ENDL            ; PRINT NEWLINE
    LEA     HEALTH_MSG,A1   ; LOAD HEALTH MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.W  HEALTH,D1       ; LOAD HEALTH VALUE
    MOVE.B  #3,D0           ; PRINT VALUE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

    LEA     ENERGY_MSG,A1   ; LOAD ENERGY MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.W  ENERGY,D1       ; LOAD ENERGY VALUE
    MOVE.B  #3,D0           ; PRINT VALUE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

    LEA     POWER_MSG,A1    ; LOAD POWER MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.W  POWER,D1        ; LOAD POWER VALUE
    MOVE.B  #3,D0           ; PRINT VALUE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE
    RTS

*-----------------------------------------------------------
* DISPLAY GAME OPTIONS
*-----------------------------------------------------------
DISPLAY_OPTIONS:
    BSR     ENDL            ; PRINT NEWLINE
    LEA     OPTIONS_MSG,A1  ; LOAD OPTIONS MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

    ; CHECK IF PLAYER HAS A PACK (POWER > 0)
    CMP.W   #0,POWER        ; CHECK IF POWER > 0
    BLE     NO_PACK         ; IF NOT, SKIP NEW OPTION

    ; DISPLAY NEW OPTION
    LEA     FIGHT_PACK_OPTION,A1 ; LOAD FIGHT PACK OPTION MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

NO_PACK:
    RTS

*-----------------------------------------------------------
* GET PLAYER INPUT
*-----------------------------------------------------------
GET_INPUT:
    LEA     INPUT_MSG,A1    ; LOAD INPUT MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.B  #4,D0           ; READ INPUT (TRAP #15)
    TRAP    #15
    RTS

*-----------------------------------------------------------
* PROCESS PLAYER INPUT
*-----------------------------------------------------------
PROCESS_INPUT:
    CMP.B   #1,D1           ; CHECK IF INPUT IS 1 (EXPLORE)
    BEQ     EXPLORE         ; BRANCH TO EXPLORE
    CMP.B   #2,D1           ; CHECK IF INPUT IS 2 (SLEEP)
    BEQ     SLEEP           ; BRANCH TO SLEEP
    CMP.B   #3,D1           ; CHECK IF INPUT IS 3 (FIND FOOD)
    BEQ     FIND_FOOD       ; BRANCH TO FIND_FOOD
    CMP.B   #4,D1           ; CHECK IF INPUT IS 4 (FIGHT RIVALING PACKS)
    BEQ     FIGHT_PACKS     ; BRANCH TO FIGHT_PACKS
    BRA     INVALID_INPUT   ; BRANCH TO INVALID_INPUT

EXPLORE:
    BSR     EXPLORE_JUNGLE  ; CALL EXPLORE JUNGLE SUBROUTINE
    RTS

SLEEP:
    BSR     SLEEP_SUB       ; CALL SLEEP SUBROUTINE
    RTS

FIND_FOOD:
    BSR     FIND_FOOD_SUB   ; CALL FIND FOOD SUBROUTINE
    RTS

INVALID_INPUT:
    LEA     INVALID_MSG,A1  ; LOAD INVALID INPUT MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    RTS

*-----------------------------------------------------------
* EXPLORE JUNGLE
*-----------------------------------------------------------
EXPLORE_JUNGLE:
    LEA     EXPLORE_MSG,A1  ; LOAD EXPLORE MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

    ; PROMPT PLAYER TO ENTER A NUMBER BETWEEN 1 AND 100
    LEA     ENTER_NUMBER_MSG,A1 ; LOAD ENTER NUMBER MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.B  #4,D0           ; READ INPUT (TRAP #15)
    TRAP    #15

    ; CHECK IF NUMBER IS BETWEEN 1 AND 100
    CMP.B   #1,D1           ; CHECK IF INPUT >= 1
    BLT     INVALID_NUMBER  ; IF NOT, BRANCH TO INVALID_NUMBER
    CMP.B   #100,D1         ; CHECK IF INPUT <= 100
    BGT     INVALID_NUMBER  ; IF NOT, BRANCH TO INVALID_NUMBER

    ; CHECK IF NUMBER IS EVEN OR ODD
    AND.B   #1,D1           ; CHECK LSB (IF 0, EVEN; IF 1, ODD)
    BEQ     EVEN_NUMBER     ; BRANCH TO EVEN_NUMBER IF EVEN
    BRA     ODD_NUMBER      ; BRANCH TO ODD_NUMBER IF ODD

EVEN_NUMBER:
    LEA     EVEN_MSG,A1     ; LOAD EVEN NUMBER MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    ADD.W   #10,POWER       ; INCREASE POWER BY 10
    SUB.W   #10,ENERGY      ; DECREASE ENERGY BY 10 (DEFAULT FOR EXPLORATION)
    RTS

ODD_NUMBER:
    LEA     ODD_MSG,A1      ; LOAD ODD NUMBER MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    SUB.W   #20,HEALTH      ; DECREASE HEALTH BY 20
    SUB.W   #15,ENERGY      ; DECREASE ENERGY BY 15 (FIGHT WITH ANIMALS)
    RTS

INVALID_NUMBER:
    LEA     INVALID_NUMBER_MSG,A1 ; LOAD INVALID NUMBER MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    RTS

*-----------------------------------------------------------
* SLEEP
*-----------------------------------------------------------
SLEEP_SUB:
    LEA     SLEEP_MSG,A1    ; LOAD SLEEP MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

    ; REGENERATE ENERGY
    ADD.W   #40,ENERGY      ; INCREASE ENERGY BY 40
    RTS

*-----------------------------------------------------------
* FIND FOOD
*-----------------------------------------------------------
FIND_FOOD_SUB:
    LEA     FIND_FOOD_MSG,A1 ; LOAD FIND FOOD MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

    ; PROMPT PLAYER TO ENTER A NUMBER BETWEEN 1 AND 100
    LEA     ENTER_NUMBER_MSG,A1 ; LOAD ENTER NUMBER MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.B  #4,D0           ; READ INPUT (TRAP #15)
    TRAP    #15

    ; CHECK IF NUMBER IS BETWEEN 1 AND 100
    CMP.B   #1,D1           ; CHECK IF INPUT >= 1
    BLT     INVALID_NUMBER  ; IF NOT, BRANCH TO INVALID_NUMBER
    CMP.B   #100,D1         ; CHECK IF INPUT <= 100
    BGT     INVALID_NUMBER  ; IF NOT, BRANCH TO INVALID_NUMBER

    ; CHECK IF NUMBER IS EVEN OR ODD
    AND.B   #1,D1           ; CHECK LSB (IF 0, EVEN; IF 1, ODD)
    BEQ     GOOD_FOOD       ; BRANCH TO GOOD_FOOD IF EVEN
    BRA     POISONOUS_FOOD  ; BRANCH TO POISONOUS_FOOD IF ODD

GOOD_FOOD:
    LEA     GOOD_FOOD_MSG,A1 ; LOAD GOOD FOOD MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    ADD.W   #20,HEALTH      ; INCREASE HEALTH BY 20
    ADD.W   #30,ENERGY      ; INCREASE ENERGY BY 30
    SUB.W   #5,ENERGY       ; DECREASE ENERGY BY 5 (ENERGY LOST FOR FINDING GOOD FOOD)
    RTS

POISONOUS_FOOD:
    LEA     POISONOUS_FOOD_MSG,A1 ; LOAD POISONOUS FOOD MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    SUB.W   #20,HEALTH      ; DECREASE HEALTH BY 20
    SUB.W   #30,ENERGY      ; DECREASE ENERGY BY 30
    SUB.W   #10,ENERGY      ; DECREASE ENERGY BY 10 (DEFAULT FOR SEARCHING)
    RTS

*-----------------------------------------------------------
* FIGHT RIVALING PACKS
*-----------------------------------------------------------
FIGHT_PACKS:
    LEA     FIGHT_PACK_MSG,A1 ; LOAD FIGHT PACK MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    BSR     ENDL            ; PRINT NEWLINE

    ; PROMPT PLAYER TO ENTER A NUMBER BETWEEN 1 AND 100
    LEA     ENTER_NUMBER_MSG,A1 ; LOAD ENTER NUMBER MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.B  #4,D0           ; READ INPUT (TRAP #15)
    TRAP    #15

    ; CHECK IF NUMBER IS BETWEEN 1 AND 100
    CMP.B   #1,D1           ; CHECK IF INPUT >= 1
    BLT     INVALID_NUMBER  ; IF NOT, BRANCH TO INVALID_NUMBER
    CMP.B   #100,D1         ; CHECK IF INPUT <= 100
    BGT     INVALID_NUMBER  ; IF NOT, BRANCH TO INVALID_NUMBER

    ; CHECK IF NUMBER IS EVEN OR ODD
    AND.B   #1,D1           ; CHECK LSB (IF 0, EVEN; IF 1, ODD)
    BEQ     WIN_FIGHT       ; BRANCH TO WIN_FIGHT IF EVEN
    BRA     LOSE_FIGHT      ; BRANCH TO LOSE_FIGHT IF ODD

WIN_FIGHT:
    LEA     WIN_FIGHT_MSG,A1 ; LOAD WIN FIGHT MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    ADD.W   #30,POWER       ; INCREASE POWER BY 30 (RECRUIT LOSER PACK)
    RTS

LOSE_FIGHT:
    LEA     LOSE_FIGHT_MSG,A1 ; LOAD LOSE FIGHT MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    SUB.W   #15,HEALTH      ; DECREASE HEALTH BY 15
    SUB.W   #15,ENERGY      ; DECREASE ENERGY BY 15
    SUB.W   #15,POWER       ; DECREASE POWER BY 15
    RTS

*-----------------------------------------------------------
* UPDATE PLAYER STATS
*-----------------------------------------------------------
UPDATE_STATS:
    ; ENSURE STATS DO NOT GO BELOW ZERO
    CMP.W   #0,HEALTH       ; CHECK IF HEALTH < 0
    BGE     CHECK_ENERGY    ; IF NOT, CHECK ENERGY
    MOVE.W  #0,HEALTH       ; SET HEALTH TO 0

CHECK_ENERGY:
    CMP.W   #0,ENERGY       ; CHECK IF ENERGY < 0
    BGE     CHECK_POWER     ; IF NOT, CHECK POWER
    MOVE.W  #0,ENERGY       ; SET ENERGY TO 0

CHECK_POWER:
    CMP.W   #0,POWER        ; CHECK IF POWER < 0
    BGE     UPDATE_END      ; IF NOT, END UPDATE
    MOVE.W  #0,POWER        ; SET POWER TO 0

UPDATE_END:
    RTS

*-----------------------------------------------------------
* CHECK IF GAME IS OVER
*-----------------------------------------------------------
CHECK_GAME_OVER:
    CMP.W   #0,HEALTH       ; CHECK IF HEALTH == 0
    BEQ     GAME_OVER_HEALTH ; IF YES, GAME OVER (HEALTH)
    CMP.W   #0,ENERGY       ; CHECK IF ENERGY == 0
    BEQ     GAME_OVER_ENERGY ; IF YES, GAME OVER (ENERGY)
    CMP.W   #100,POWER      ; CHECK IF POWER >= 100 (WIN CONDITION)
    BGE     WIN_GAME        ; IF YES, WIN THE GAME
    MOVE.B  #1,D0           ; GAME NOT OVER
    RTS

GAME_OVER_HEALTH:
    LEA     GAME_OVER_HEALTH_MSG,A1 ; LOAD GAME OVER (HEALTH) MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.B  #0,D0           ; GAME OVER
    RTS

GAME_OVER_ENERGY:
    LEA     GAME_OVER_ENERGY_MSG,A1 ; LOAD GAME OVER (ENERGY) MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.B  #0,D0           ; GAME OVER
    RTS

WIN_GAME:
    LEA     WIN_MSG,A1      ; LOAD WIN MESSAGE
    MOVE.B  #14,D0          ; PRINT MESSAGE (TRAP #15)
    TRAP    #15
    MOVE.B  #0,D0           ; GAME OVER (WIN)
    RTS

*-----------------------------------------------------------
* ENDL SUBROUTINE (PRINT NEWLINE)
*-----------------------------------------------------------
ENDL:
    MOVEM.L D0/A1,-(A7)     ; SAVE D0 AND A1
    MOVE    #14,D0          ; MOVE LITERAL 14 TO DO
    LEA     CRLF,A1         ; ASSIGN CRLF TO ADDRESS REGISTER A1
    TRAP    #15             ; TRAP AND INTERPRET VALUE IN D0
    MOVEM.L (A7)+,D0/A1     ; RESTORE D0 AND A1
    RTS                     ; RETURN FROM ENDL: SUBROUTINE

*-----------------------------------------------------------
* DATA DECLARATIONS
*-----------------------------------------------------------
WELCOME_MSG:        
    DC.B    'WELCOME TO SURVIVING THE JUNGLE!', $0D, $0A
    DC.B    'EXPLORE THE JUNGLE, MAKE FRIENDS,', $0D, $0A
    DC.B    'BUT BE CAREFUL ABOUT THE UNFRIENDLY ANIMALS.', $0D, $0A
    DC.B    'FIND FOOD, BUT THINK TWICE BEFORE EATING.', $0D, $0A
    DC.B    'SLEEP TO REGAIN ENERGY.', $0D, $0A
    DC.B    'YOUR JOURNEY BEGINS!', $0D, $0A, 0, $0D, $0A, 0
HEALTH_MSG:         DC.B    'HEALTH: ', 0
ENERGY_MSG:         DC.B    'ENERGY: ', 0   
POWER_MSG:          DC.B    'POWER: ', 0
OPTIONS_MSG:        DC.B    'CHOOSE AN ACTION:',$0D, $0A,'1. EXPLORE THE JUNGLE',$0D, $0A,'2. SLEEP',$0D, $0A,'3. FIND FOOD',$0D, $0A, 0
INPUT_MSG:          DC.B    'ENTER YOUR CHOICE (1-3): ', 0  
INVALID_MSG:        DC.B    'INVALID CHOICE! TRY AGAIN.', $0D, $0A, 0
EXPLORE_MSG:        DC.B    'YOU VENTURE INTO THE JUNGLE...', $0D, $0A, 0
ENTER_NUMBER_MSG:   DC.B    'ENTER A NUMBER BETWEEN 1 AND 100: ', 0
EVEN_MSG:           DC.B    'YOU MADE FRIENDS WITH A GROUP OF ANIMALS, NOW YOU HAVE A PACK! POWER INCREASED.', $0D, $0A, 0
ODD_MSG:            DC.B    'YOU GOT INTO A FIGHT WITH ANIMALS! HEALTH DECREASED.', $0D, $0A, 0
INVALID_NUMBER_MSG: DC.B    'INVALID NUMBER! PLEASE ENTER A NUMBER BETWEEN 1 AND 100.', $0D, $0A, 0
SLEEP_MSG:          DC.B    'YOU SLEEP AND REGENERATE ENERGY...', $0D, $0A, 0
FIND_FOOD_MSG:      DC.B    'YOU SEARCH FOR FOOD...', $0D, $0A, 0
GOOD_FOOD_MSG:      DC.B    'YOU FOUND NUTRITIOUS FOOD! HEALTH AND ENERGY INCREASED.', $0D, $0A, 0
POISONOUS_FOOD_MSG: DC.B    'YOU FOUND POISONOUS BERRIES! HEALTH AND ENERGY DECREASED.', $0D, $0A, 0
GAME_OVER_HEALTH_MSG: DC.B  'GAME OVER! YOU DIED.', $0D, $0A, 0
GAME_OVER_ENERGY_MSG: DC.B  'GAME OVER! YOU RAN OUT OF ENERGY.', $0D, $0A, 0
WIN_MSG:            DC.B    'YOU WON! YOUR POWER REACHED 100, YOU ARE THE KING OF THE JUNGLE!', $0D, $0A, 0
CRLF:               DC.B    $0D, $0A, 0 ; CARRIAGE RETURN AND LINE FEED FOR NEWLINE

* MESSAGES FOR FIGHT RIVALING PACKS
FIGHT_PACK_OPTION:  DC.B    '4. FIGHT RIVALING PACKS', $0D, $0A, 0
FIGHT_PACK_MSG:     DC.B    'YOU ENCOUNTER A RIVALING PACK...', $0D, $0A, 0
WIN_FIGHT_MSG:      DC.B    'YOU WIN THE FIGHT AND RECRUIT THE LOSER PACK! POWER INCREASED.', $0D, $0A, 0
LOSE_FIGHT_MSG:     DC.B    'YOU LOSE THE FIGHT AND LOST YOUR PACK! ALL STATS DECREASED.', $0D, $0A, 0

*-----------------------------------------------------------
* END OF GAME
*-----------------------------------------------------------
END:
    SIMHALT
    
    END START 


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
