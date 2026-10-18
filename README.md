# Pangolin run

A fast 2D side-scrolling platformer built in **Godot 4**, in the spirit of classic *Sonic* games, except the hero is a **pangolin** running to save her long-lost love.

Build up speed, sprint across the level, eat termites to curl into an armoured rolliing ball, and knock out the tigers in your way before you reach the goal.

---

## Gameplay

| Element | What it does |
| --- | --- |
| **Pangolin (player)** | Momentum-based movement: she accelerates up to walking or sprinting speed and slides to a stop when you let go. |
| **Variable jump** | Tap space for a short hop, hold it for a full jump (letting go early halves your upward speed). |
| **Mystery blocks** | Jump into one from below. It bonks, greys out and pops out a **termite**. Each block works once. |
| **Termite (power-up)** | Eating it turns the pangolin into a **rolling ball** for **5 seconds**, a Sonic-style spin attack. The sprite spins at the right speed for how fast you're moving (w = v / r). |
| **Ants (collectibles)** | They patrol back and forth and turn around at walls and ledges. Touch one normally and you die. Hit one while rolling and you **destroy it**. |
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

1. Install **Godot 4.7** or newer, the standard (non- ,NET) build. The project was saved with the `4.7` / Forward+ feature set.
2. Clone the repo:
   ```bash
   git clone https://github.com/Araadh3111/pangolin-runrun.git
   ```
3. Open Godot → **Import** → choose `pangolin-runrun/pangolin-run/project.godot`.
4. Press **F5**. The main scene is `main.tscn`.

> The project turns on the **Godot Super-Wakatime** editor plugin (`addons/godot_super-wakatime`), which tracks coding time. Godot may ask for a WakaTime API key the first time you open it. You can skip that, or switch the plugin off under *Project → Project Settings → Plugins*

---

## Project structure 
```
├── README.md
├── LICENSE                     # MIT
└── pangolin-run/               # Godot project root
    ├── project.godot           # config, input map, main scene
    │
    ├── main.tscn               # ★ main level (Parallax2D bg + TileMapLayer + entities)
    ├── player.tscn / .gd       # pangolin: movement, sprint, roll power-up, HUD, win/die
    ├── tiger.tscn / .gd        # patrolling enemy with ledge detection (EdgeCheck raycast)
    ├── ant.tscn / .gd          # collectible, increments ant counter
    ├── mystery_block.tscn/.gd  # bump-from-below block that spawns a termite
    ├── termite.tscn / .gd      # power-up, triggers player.power_up()
    ├── goal.tscn / .gd         # end-of-level trigger, calls player.win()
    │
    ├── game.tscn               # prototype / practice level (not the main scene)
    ├── player_2.tscn / .gd     # prototype knight player used in game.tscn
    ├── slime.tscn / .gd        # prototype enemy (wall-bounce raycasts + killzone)
    ├── coin.tscn / .gd         # prototype collectible
    ├── killzone.tscn / .gd     # slow-mo death + scene reload (used by slime)
    ├── platform.tscn           # moving platform (AnimatableBody2D)
    │
    ├── Assets/Images/          # Kenney "Pixel Platformer" pack + custom art
    │   ├── Pangolin.png        # player sprite
    │   ├── rolling.png         # rolling-ball sprite
    │   ├── tuger.png           # tiger sprite
    │   ├── background.png      # parallax background
    │   ├── new tile map.png    # level tileset
    │   ├── Tiles/, Tilemap/, Tiled/, Construct 3/   # Kenney pack files
    │   └── siddak- Sprites/    # Aseprite source files for the pangolin
    ├── Assets(SIDDAK)/         # fonts, music, SFX, prototype sprites
    ├── Scenes(SIDDAK)/         # (empty)
    ├── scripts(SIDDAK)/        # (empty)
    └── addons/godot_super-wakatime/
```

## How the pieces talk to each other

- The player is in the **`player`** group. Every trigger (`ant`, `termite`, `goal`, `tiger` hitbox, `mystery_block` bump zone_ checks `body.is_in_group("player")` and then calls a method on the player: `collect_ant()`, `power_up()`, `win()` or `die()`.
- **Power-up state** is kept on the player (`powered`, plus a one-shot 5 s `PowerTimer`). The tiger reads `body.powered` to decide who wins the collision.
- **Mystery block → termite:** when bumped, the block tweens a little "bonk", spawns `termite.tscn` with `call_deferred`, and tweens it up one block (54 px). It keeps `monitoring` off until the termite has finished rising, so the player can't grab it mid-animation.
- **Death** reloads the scene with `get_tree().reload_current_scene()`. The prototype killzone first runs at 0.5x time scale for 0.6 s.

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

Tiger patrol speed is 200 (`tiger.gd`).

## Status and to-do

The core loop works: run, collect, power up, defeat enemies, reach the goal. What's still open:

- [ ] Hook up sound effects and music. `jump`, `coin`, `hurt`, `power_up`, `explosion` and `time_for_adventure.mp3` are already in `Assets(SIDDAK)` but nothing plays them in the main level yet.
- [ ] Death feedback in the main level (right now it reloads instantly, with no hurt animation or sound).
- [ ] Animated pangolin sprite (run / jump / idle) to replace the single static frame.
- [ ] The story: intro or ending showing the pangolin finding her lost love.
- [ ] More levels and a title screen.
- [ ] Devide whether to keep or remove the prototype files (`game.tscn`, `player_2`, `slime`, `coin`, `killzone`, `platform`).
- [ ] Fill in or remove the empty `Scenes(SIDDAK)/` and `scripts(SIDDAK)/` folders, and maybe move the root-level scenes and scripts into them.

---

## Credits 

- **Development:** Araadh, Rishu and Siddak Puri
- **Tiles, characters and backgrounds:** [Pixel Platformer] (https://www.kenney.nl) by **Kenney** (CCO)
- **Prototype assets** (knight, slime, coins, platforms, PixelOperator8 font, SFX, *Time for Adventure* music):
Brackeys' Platformer asset bundle
- **Pangolin, rolling-ball and tiger sprites:** made by the team (Aseprite)
- **Engine:** [Godot Engine](https://godotengine.org)

## License

The code is released under the [MIT License](LICENSE) © 2026 Araadh. Third-party assets keep their own licenses (see `Assets/Images/License.txt`).
