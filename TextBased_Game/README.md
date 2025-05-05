Surviving the Jungle

Overview

Surviving the Jungle is a text-based adventure game written in 68000 Assembly language. The player starts with full health and energy, aiming to gain influence (power) in the jungle to become its ruler. Through various choices, players can befriend animals to increase power, fight them and risk injury, find beneficial or harmful food, sleep to regenerate energy, or battle rival packs.

Game Mechanics





Stats:





Health: Starts at 100. Depletes when fighting animals, eating poisonous food, or losing fights. Increases with nutritious food.



Energy: Starts at 100. Depletes during exploration, fighting, or searching for food. Regenerates by sleeping or eating nutritious food.



Power: Starts at 0. Increases by befriending animals or winning fights against rival packs. Decreases when losing fights.



Actions:





Explore the Jungle: Enter a number (1-100). Even numbers result in befriending animals (+10 power, -10 energy). Odd numbers lead to fights (-20 health, -15 energy).



Sleep: Regenerates 40 energy.



Find Food: Enter a number (1-100). Even numbers yield nutritious food (+20 health, +25 energy). Odd numbers yield poisonous food (-20 health, -40 energy).



Fight Rival Packs (available if power > 0): Enter a number (1-100). Even numbers result in winning (+30 power). Odd numbers result in losing (-15 health, -15 energy, -15 power).



Game Over Conditions:





Health reaches 0: Player dies.



Energy reaches 0: Player runs out of energy.



Power reaches 100: Player wins, becoming the king of the jungle.

Requirements





A 68000 Assembly emulator or environment (e.g., Easy68K).



The provided assembly code file (SurvivingTheJungle.asm).

Installation





Download the assembly code file (SurvivingTheJungle.asm).



Open the file in a 68000 Assembly emulator like Easy68K.



Assemble and run the program.

How to Play





Start the game to see the welcome message and initial stats (Health: 100, Energy: 100, Power: 0).



Each turn, view your stats and choose an action by entering a number (1-3, or 1-4 if power > 0).



For actions requiring a number (Explore, Find Food, Fight Rival Packs), input a number between 1 and 100.



Continue making choices until you win (Power ≥ 100) or lose (Health or Energy = 0).

File Structure





SurvivingTheJungle.asm: The main 68000 Assembly source code containing the game logic, subroutines, and data declarations.

Code Structure





Initialization: Sets initial values for health, energy, and power.



Main Loop: Displays stats, options, gets input, processes actions, updates stats, and checks game-over conditions.



Subroutines:





INIT_GAME: Initializes game variables.



WELCOME: Displays the welcome message.



DISPLAY_STATS: Shows current health, energy, and power.



DISPLAY_OPTIONS: Lists available actions.



GET_INPUT and PROCESS_INPUT: Handle player input and route to appropriate actions.



EXPLORE_JUNGLE, SLEEP_SUB, FIND_FOOD_SUB, FIGHT_PACKS: Implement core game actions.



UPDATE_STATS: Ensures stats stay non-negative.



CHECK_GAME_OVER: Checks for win/loss conditions.



ENDL: Prints a newline for formatting.



Data: Messages for game events, options, and outcomes.

Notes





The game uses a simple even/odd mechanic for randomness, based on player-entered numbers.



Invalid inputs (e.g., numbers outside 1-100 or incorrect action choices) prompt an error message and allow retry.



The program uses TRAP #15 for I/O operations, compatible with 68000 emulators.

Author





Name: Lasha Japaridze



Student at SETU Carlow



Date: February 28th
