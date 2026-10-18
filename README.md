# Pangolin run

A fast 2D level game built in **Godot 4**, in the spirit of classic *Mario* games, except the hero is a **Pangolin**(ancient cool animal that curls) running to save her long-lost love(lol).

Build your speed up by collecting buffs along the way to defeat the tigers, collect ants and move up the levels by collecting gems!

---
## Image Section

### Start Menu
<img width="1147" height="657" alt="image" src="https://github.com/user-attachments/assets/3339fc89-bc17-4838-ab65-28b7855c9e43" />

### Desert (1st level)
<img width="1161" height="658" alt="image" src="https://github.com/user-attachments/assets/2ccbd5f9-0856-496b-87e7-4dbb1a8043a7" />
<img width="1172" height="656" alt="image" src="https://github.com/user-attachments/assets/20c8a99e-2674-48ba-b562-8dafd28aaea7" />
<img width="1145" height="665" alt="image" src="https://github.com/user-attachments/assets/c5bbee0a-ea40-4eb6-b2dc-fdedc3e44951" />
<img width="1187" height="665" alt="image" src="https://github.com/user-attachments/assets/42d2259a-a165-4e8d-ab2d-7c9039f147b8" />


### Tunnel (2nd Level)(very hard)
<img width="1160" height="646" alt="image" src="https://github.com/user-attachments/assets/65bc7c9a-2b62-4eaa-ae38-28cdb602a20c" />
<img width="1158" height="647" alt="image" src="https://github.com/user-attachments/assets/6de344d0-b5b2-43ae-ba69-6417978812ba" />
<img width="1197" height="662" alt="image" src="https://github.com/user-attachments/assets/cb752f0c-fa25-48c0-8644-2034661bf64c" />

<img width="1172" height="667" alt="image" src="https://github.com/user-attachments/assets/32ef4da5-1a01-4068-9387-8572f68fd55b" />


---
## Gameplay

| Element | What it does |
| --- | --- |
| **Pangolin (player)** | Momentum-based movement: she accelerates up to walking or sprinting speed and slides to a stop when you let go. |
| **Variable jump** | Tap space for a short hop, hold it for a full jump. |
| **Mystery blocks** | Jump into one from below. It bonks, greys out and pops out a **termite**. Each block works once and provides u a buff that helps u kill the tigers. |
| **Termite (power-up)** | Eating it turns the pangolin into a **rolling ball** for **5 seconds**, a Sonic-style spin attack. The sprite spins at the right speed for how fast you're moving (w = v / r). |
| **Tigers (enemies)** | They patrol back and forth and turn around at walls and ledges. Touch one normally and you die. Hit one while rolling and you **destroy it**. |
| **Pits** | Falling below the level (y > 1200) restarts it. |
| **Goal** | Touch it to win. You'll see a **"You Win!"** screen with your ant count, and can press **R** to play again. |

The main level (`main.tscn`) is about 6,500 px wide. It has a parallax background, 4 tigers, 4 ants, 2 mystery blocks and the goal at the far right.

## Controls

| Action | Keys |
| --- | --- |
| Move left | `A` / `←` |
| Move right | `D` / `→` |
| Jump (hold for higher) | `Space` |
| Sprint | `Shift` |
| Restart (after winning) | `R` |

--- 

## Menus

### Start screen
The game now opens on an animated title screen (`start_screen.tscn`, the main scene). The desert scrolls in the background while the pangolin runs and a tiger chases her. Music fades in when it loads.

| Button | What it does |
| --- | --- |
| **PLAY** | Starts Level 1 (Desert) |
| **LEVEL 2** | Jumps straight to Level 2 (Tunnel) |
| **QUIT** | Closes the game |

Pressing `Space` on the title screen also starts Level 1.

### Pause menu
Press `Esc` during Level 1 to pause.

| Button | What it does |
| --- | --- |
| **Resume** | Back to the game |
| **Restart** | Restarts the level |
| **Title** | Goes back to the start screen |
| **Quit** | Closes the game |

---

## Levels

| Level | Scene | What's in it |
| --- | --- | --- |
| **1 - Desert** | `main.tscn` | 5 tigers, 4 ants, 1 mystery block |
| **2 - Tunnel** | `level_2.tscn` | 6 tigers, 4 ants, 2 mystery blocks, new tunnel background and tiles |

Reaching the goal in Level 1 shows **"Level Complete!"** and moves you to Level 2 after 2 seconds. Beating Level 2 shows **"You Win!"**, and pressing `R` takes you back to the title screen.

---

## Sound

- Jump, ant pickup, power-up and level-complete sounds (`Assets/Audio/`)
- Background music and button sounds on the start screen

---

## Animation

- The pangolin has a 3-frame walk cycle and stops animating when standing still
- Tigers have a 3-frame walk cycle
- Mystery blocks shimmer until you hit them
- Ants use a custom pixel-art sprite (`Assets(rishu)/Separate/Ant/ant1.png`)

## Running the project

1. Install **Godot 4.77** or newer,.The project was saved with the `4.7` / Forward+ feature set.
2. Clone the repo:
   ```bash
   git clone https://github.com/Araadh3111/pangolin-runrun.git
   ```
3. Open Godot → **Import** → choose `pangolin-runrun/pangolin-run/project.godot`.
4. Press **F5**. The main scene is `main.tscn`.

---

## Project structure 
```
├── README.md
├── LICENSE                     
└── pangolin-run/              
    ├── project.godot           
    │
    ├── main.tscn               
    ├── player.tscn / .gd       
    ├── tiger.tscn / .gd       
    ├── ant.tscn / .gd         
    ├── mystery_block.tscn/.gd  
    ├── termite.tscn / .gd      
    ├── goal.tscn / .gd         
    │
    ├── game.tscn               
    ├── player_2.tscn / .gd     
    ├── slime.tscn / .gd       
    ├── coin.tscn / .gd         
    ├── killzone.tscn / .gd    
    ├── platform.tscn           
    │
    ├── Assets/Images/          
    │   ├── Pangolin.png        
    │   ├── rolling.png         
    │   ├── tuger.png           
    │   ├── background.png      
    │   ├── new tile map.png    
    │   ├── Tiles/, Tilemap/, Tiled/, Construct 3/   
    │   └── siddak- Sprites/    
    ├── Assets(SIDDAK)/         
    ├── Scenes(SIDDAK)/         
    ├── scripts(SIDDAK)/        
    └── addons/godot_super-wakatime/
```

## Updates
This Game Will be released on itch.io very soon and we will add new features adn finish it

### Movement tuning (`player.gd`)

| Constant | Value |
| --- | --- |
| `WALK_SPEED` | 250 |
| `SPRINT_SPEED` | 450 |
| `ACCELERATION` | 1500 | 
| `Friction` | 600 |
| `JUMP_VELOCITY` | -600 |
| `FALL_LIMIT` | 1200 |
| `BALL_RADIUS` | 36 |

Tiger patrol speed is 250 (`tiger.gd`).


## Credits 

- **Development:** Araadh and Siddak
- **Tiles, characters and backgrounds:** Rishu And Siddak puri
- **Prototype assets** (knight, slime, coins, platforms, PixelOperator8 font, SFX, *Time for Adventure* music):
Brackeys' Platformer asset bundle
- **Pangolin, rolling-ball and tiger sprites:** Rishu, Siddak (Aseprite)
- **Engine:** [Godot Engine](https://godotengine.org)

## License

The code is released under the [MIT License](LICENSE) © 2026 Araadh. Third-party assets keep their own licenses (see `Assets/Images/License.txt`).
