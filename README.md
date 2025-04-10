# 🚀 Asteroid Welcome System (AWS)

Asteroid Welcome System is a lightweight and customizable welcome screen for Garry's Mod servers.  
It greets players with a smooth, responsive UI featuring a server logo, avatar integration, welcome message, and useful links.

---

## ✨ Features

- 🎨 Customizable modern UI (blur background, split screen)
- 📥 Dynamic image downloading via `http.Fetch`
- 💬 Personalized welcome message with player name
- 🔗 Link buttons (Discord, Website, etc.)
- 🎮 "Play" button to close the interface and enter the game
- 🧱 Modular file structure and namespaced logic

---

## 🧠 Structure

```
lua/
├── autorun/
│ └── asteroid-welcome-system.lua # Addon init
├── core/
│ ├── cl_core.lua # UI logic
│ └── cl_imageFetcher.lua # Image download system (client-side)
```

---

## ✅ To-Do / Future Ideas

- Add animation transitions (fade, slide)
- Display playtime or rank
- Background music option

---

## 📖 License

This project is licensed under the **GNU General Public License v3.0 (GPLv3)**.

You are free to:
- Use
- Modify
- Share
- Distribute

Under the following conditions:
- **Derivatives must be licensed under GPLv3** as well.
- You **must provide access to the source code** of any modifications you distribute.
- You **cannot redistribute this addon in a proprietary/commercial closed-source form.**

Read more about this license here:  
🔗 [https://www.gnu.org/licenses/gpl-3.0.en.html](https://www.gnu.org/licenses/gpl-3.0.en.html)

---

Built with ❤️ by TheObtey