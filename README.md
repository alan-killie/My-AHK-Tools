🛠️ My-AHK-Tools
"I have no idea what I'm doing. I'm just vibing and making scripts so my computer behaves the way I want."

Welcome to my collection of AutoHotkey scripts. Most of them started as a minor annoyance that I decided to spend three hours "fixing" with code.

📋 What’s in here?
I’m organising these by the problem they solve, mostly so I don't lose them:

- /Windows-Util: general system tweaks and input improvements.
- /Reaper: scripts tuned for the REAPER DAW workflow.
- /App-Specific: scripts that only exist because I needed a thing for one specific app.

🧩 Included scripts
- Windows-Util/ScrollOverTaskView.ahk: switch virtual desktops by scrolling over the Task View button.
- Windows-Util/Scroll Lock - Speed Scroll.ahk: multiply wheel movement by 10 while Scroll Lock is enabled.
- Reaper/REAPER_CentreFx.ahk: keep floating FX windows centred in the middle of the screen.

🛠️ How to use these
1. Install AutoHotkey v2.
2. Download or clone the repo.
3. Run the script you want by double-clicking it, or add it to your Windows startup folder if you want it to launch automatically.
4. If a script needs a tweak, open the file and edit the config values near the top.

⚙️ Quick config notes
- Most scripts keep their important values near the top of the file so they are easy to edit.
- If a script uses a sound file, path, or desktop name, that is usually defined in the first block of code.
- Reaper window centering is tuned for FX windows, but the matching rules can be adjusted if you use a different plugin layout.

⚠️ The "I'm Just Vibing" Disclaimer
These scripts work on my machine. If they summon a demon on yours or make your computer sentient, that is between you and the code. I’m learning as I go, so expect:

- variable names that make sense only at 2 AM
- the occasional "Invalid variable declaration" Google spiral
- minimal logic, maximum vibes

This repo is intentionally lightweight and script-first. The goal is to make my setup less annoying, not to turn it into a software product.
