# Quartz Landing Page Brief

This document outlines the strategic branding, copywriting, visual direction, and content architecture for the Quartz website.

## 1. App Positioning Statement
**Quartz** is a gamified screen-time manager and digital wellness sanctuary that helps Gen Z users break the infinite doomscroll cycle by turning focus into currency and attention into gameplay.

---

## 2. Core Messaging & Copywriting

### Headline
> **Reduce Noise. Regain Focus.**

### Subheadline
> Break the infinite doomscroll loop. Shield your feeds, complete focus arcade challenges to earn screen time, and stack Prismas as you master your attention.

### Value Propositions (Top 3 Benefits)
1. **Take Back Control of Your Feed (Doomscroll Quota)**
   * *The Problem:* Social algorithms are designed to keep you scrolling forever.
   * *The Solution:* Set a strict daily doomscroll quota. Once it's gone, your distracting apps are natively locked.
2. **Train in the Attention Gym (Focus Arcade)**
   * *The Problem:* Cold-turkey blocking feels restrictive and frustrating.
   * *The Solution:* Re-earn scroll quota by playing mind-training arcade mini-games like Memory Pattern, Word Search, Connect Dots, and Wave Runner.
3. **Earn via Compounding Focus Surges (Prismas)**
   * *The Problem:* Good digital habits lack immediate rewards.
   * *The Solution:* Maintain your focus monitor to grow your dopamine balance multiplier (up to 2.0x). Convert remaining quota into **Prismas** at midnight to prove your dedication and maintain your streak.

---

## 3. Recommended Page Sections

### I. Hero Section (The Portal)
* **Visuals:** High-fidelity glow effects centering on the 3D crystal asset (`crystal.png`) floating in a true-black void.
* **Copy:** 
  * Main Headline: "Reduce Noise. Regain Focus."
  * Subheadline: "The gamified attention tracker that natively blocks doomscrolling."
* **CTAs:** Primary glowing button: **Download Quartz on TestFlight** (pointing to `https://testflight.apple.com/join/G8ufCuTB`). Secondary button linking to "How it Works".

### II. Core Mechanism (The Doomscroll Quota & Native Shield)
* **Visuals:** Left-aligned copy with right-aligned floating iOS screenshot of the main circular timer dial (`06_home page_play.png`).
* **Copy:** Explains the Screen Time API integration. Explain how the app shields social media and gaming feeds natively during active focus sessions.

### III. The Attention Gym (Re-earn Your Time)
* **Visuals:** Two-column grid showing detail cards for the arcade games alongside the gym grid screenshot (`07_game.png`).
* **Copy:** "Refine your mind." Explain that instead of cheating or bypassing blocks, you can play focus-based arcade challenges to add +10 minutes to your daily doomscroll quota.
  * **Memory Pattern:** Remember the grid sequence and repeat it.
  * **Word Search:** Beat the clock hunting hidden words.
  * **Connect Dots:** Connect node paths without overlap.
  * **Wave Runner:** Dodge spikes and ride the wave.

### IV. Focus Economy (Compounding Multipliers & Prismas)
* **Visuals:** A dark sleek table showing the compounding effect: as focus time goes up (from 0 to 300 minutes), your multiplier rises from 1.0x to 2.0x.
* **Copy:** "Dopamine balancing by design." Describe how keeping focus active increases your attention multiplier, compounding the Prismas you earn at midnight. Warn that turning focus off early destroys the streak and voids the surge multiplier.

### V. Leaderboard & Competition (Compete & Reflect)
* **Visuals:** Leaderboard card layout showing user ranks and streak badges (`08_rank.png`).
* **Copy:** Mindful phone use is better with friends. Track streaks, climb the attention leaderboard, and reflect on daily digital habits.

### VI. Frequently Asked Questions (FAQ)
* **Q: What is Quartz?**  
  *A: Quartz is a focus and digital wellness app that helps you understand and reduce excessive scrolling habits.*
* **Q: How does Quartz help me focus?**  
  *A: Quartz provides screen-time monitoring, focus-building activities, streaks, and reflection tools to help you build healthier digital habits.*
* **Q: Who is Quartz for?**  
  *A: Anyone who finds themselves stuck in endless scrolling and wants to be more intentional with their time and attention.*
* **Q: Does Quartz sell my data?**  
  *A: Absolutely not. Quartz operates natively on your device via iOS Screen Time protocols, preserving your absolute privacy.*

---

## 4. Visual Identity & Brand System

* **Primary Background:** `#000000` (True Black) for a premium, high-contrast digital look.
* **Colors & Accents:**
  * **Core Neon Purple/Violet:** `rgba(166, 38, 242, 1.0)` / `#a626f2` (Main brand and streak token color).
  * **Core Neon Blue:** `rgba(19, 7, 245, 1.0)` / `#1307f5` (Focus active state and selected navigation accent).
  * **Neon Magenta:** `rgba(242, 46, 158, 1.0)` / `#f22e9e` (Memory Game color).
  * **Neon Green:** `rgba(51, 224, 107, 1.0)` / `#33e06b` (Word Search and active balance rewards).
  * **Neon Cyan:** `rgba(2, 129, 255, 1.0)` / `#0281ff` (Connect Dots and active shield indicator).
* **Typography:** Modern, technical, and clean sans-serif stack (e.g., Inter, Outfit, or system UI sans-serif) to match the app's clean HUD layout.
* **Aesthetic Feel:** Premium, glassmorphic card overlays, neon glowing drop-shadows, and smooth micro-animations.

---

## 5. Asset Mapping
* `content/static/assets/crystal.png` $\rightarrow$ Hero Section / Quartz Coin.
* `content/static/assets/06_home page_play.png` $\rightarrow$ Doomscroll Quota / Focus Monitor section.
* `content/static/assets/07_game.png` $\rightarrow$ Attention Gym / Focus Arcade section.
* `content/static/assets/08_rank.png` $\rightarrow$ Compete & Reflect / Leaderboard section.
* `content/static/assets/design system.png` $\rightarrow$ Reference styling.

---

## 6. Feedback & Clarification Questions
Before we build the site, please let us know:
1. **Currency Name:** Confirm if we should write about "Prismas" or "Quartz" (the app model uses `boahKhuldiBalance`, the localizations say "Prismas", and the UI label says "Quartz" or "Prismas").
2. **Typography Font:** Do you prefer a free font like **Inter** or **Outfit** loaded from Google Fonts for the website?
3. **Emergency Unpause:** Do you want us to highlight the "Emergency Unpause" button (which breaks streaks but unlocks the phone in an emergency) as a key feature?
