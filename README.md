# Pangolin run

A fast 2D level game built in **Godot 4**, in the spirit of classic *Mario* games, except the hero is a **pangolin**(ancient cool animal that curls) running to save her long-lost love(lol).

Build ure speed up collect buffs along the way defeat the tigers, collect ants and move up the levels by collecting gems

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
