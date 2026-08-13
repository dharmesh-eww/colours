# Splash Screen

## 1. Overview

The Splash Screen is the first screen displayed when the player launches the game.

Its primary purpose is to provide a short, polished introduction while the game initializes all required local resources.

The Splash Screen should feel like a **game launch experience**, not like a traditional application loading screen.

The screen should be visually minimal, smooth, and focused on the game's identity.

The Splash Screen must work completely offline.

---

# 2. Main Responsibilities

The Splash Screen is responsible for:

* Displaying the game branding.
* Providing a smooth launch animation.
* Initializing required local game resources.
* Loading local player progress.
* Loading local settings.
* Preparing required game configuration.
* Checking whether the application is ready to continue.
* Navigating to the appropriate next screen.
* Handling initialization failures gracefully.

The Splash Screen should not contain actual gameplay logic.

---

# 3. UI Structure

The Splash Screen should contain a small number of visual elements.

### Main Elements

* Game background
* Game logo
* Game name
* Optional short tagline
* Loading indicator
* Optional subtle decorative animation

The visual hierarchy should strongly emphasize the game logo/name.

The screen should remain clean and uncluttered.

---

# 4. Visual Style

The visual design should match the overall **premium casual-game style**.

The Splash Screen should use:

* Smooth gradients
* Soft lighting
* Rounded visual elements
* Subtle shadows
* Gentle animations
* Minimal typography
* Color-focused visuals

The game logo should be the primary visual element.

The background can use a subtle animated color gradient that reflects the game's core concept.

The animation should remain lightweight and should not delay application startup unnecessarily.

---

# 5. Color Background

The background should visually communicate the game's color-gradient concept.

Possible approaches include:

* A smooth multi-color gradient.
* Slowly shifting gradient colors.
* Soft blurred color shapes.
* Subtle floating color particles.
* A gentle gradient wave.

The background animation should be slow and relaxing.

It should not distract from the logo.

The actual puzzle colors should remain accurate and should not be altered by decorative effects.

---

# 6. Logo Presentation

The logo should appear as the primary focus.

The logo can initially be hidden or displayed at a reduced scale.

A smooth entrance animation can then bring it into focus.

Possible sequence:

**Logo Scale 0 → Normal Size**

combined with:

**Opacity 0 → Full Opacity**

A small overshoot can be used to create a polished game-like effect.

The animation should be subtle rather than exaggerated.

---

# 7. Game Name

The game name should appear near the logo.

It should use:

* Large typography
* Strong readability
* Rounded or modern styling
* Appropriate spacing

The name should not overpower the logo.

If the logo already contains the game name, displaying the name separately may not be necessary.

---

# 8. Tagline

A short tagline can optionally be displayed below the game name.

The tagline should communicate the core concept without explaining the entire game.

For example:

> Find the perfect gradient.

The tagline should be optional and should not delay the transition to the next screen.

---

# 9. Loading Indicator

A loading indicator can be displayed near the bottom portion of the screen.

It should communicate that the game is preparing itself.

The loading indicator should be subtle.

Possible styles include:

* Animated dots
* Circular progress indicator
* Gradient progress animation
* Small pulsing indicator

The loading indicator should not imply a network operation because the game is completely offline.

It represents **local initialization only**.

---

# 10. Offline Initialization

All initialization performed during Splash Screen execution must be local.

Possible initialization tasks include:

* Reading local player data.
* Reading local settings.
* Loading game configuration.
* Loading level metadata.
* Preparing predefined level data.
* Initializing puzzle generation configuration.
* Initializing audio configuration.
* Preparing theme configuration.
* Restoring required local game state.

No network request should be made.

---

# 11. Local Progress Loading

The Splash Screen can initialize the player's locally stored progress.

The progress may include:

* Highest unlocked level.
* Completed levels.
* Star ratings.
* Best scores.
* Best moves.
* Best times.
* Daily challenge progress.
* Achievement progress.
* Player settings.

If no previous progress exists, the game should create a new default local player state.

---

# 12. First Launch

The game should detect whether this is the player's first launch.

For a new installation:

1. Initialize default settings.
2. Create initial player progress.
3. Set the first level as unlocked.
4. Initialize statistics.
5. Initialize achievement state.
6. Initialize daily challenge state.
7. Save the initial local state.
8. Continue to the Home Screen.

The player should not be required to create an account.

---

# 13. Returning Player

For an existing player:

1. Load local settings.
2. Load local progress.
3. Load level completion data.
4. Restore relevant preferences.
5. Prepare required local configuration.
6. Continue to the Home Screen.

The game should preserve the player's progress across launches.

---

# 14. Initialization Sequence

The initialization process should follow a predictable sequence.

### Step 1 — Application Start

The operating system launches the application.

### Step 2 — Display Splash UI

The Splash Screen is displayed immediately.

### Step 3 — Start Visual Animation

The logo and background begin their entrance animations.

### Step 4 — Initialize Local Services

Required local game services are initialized.

### Step 5 — Load Local Settings

Player preferences are loaded.

### Step 6 — Load Local Progress

Player progression data is loaded.

### Step 7 — Prepare Game Configuration

Required puzzle and game configuration is prepared.

### Step 8 — Validate Local Data

Loaded data is checked for validity.

### Step 9 — Finish Initialization

The game determines that the required local resources are ready.

### Step 10 — Navigate

The player is taken to the next appropriate screen.

---

# 15. Navigation

Under normal conditions, the Splash Screen should navigate to the Home Screen.

The Splash Screen should not remain visible after initialization is complete.

The transition should be smooth.

Possible transition styles include:

* Fade
* Scale
* Cross-fade
* Gradient transition

The transition should match the game's overall visual language.

---

# 16. Minimum Splash Duration

The Splash Screen should avoid disappearing immediately if initialization finishes extremely quickly.

A small minimum display duration can be used to ensure that the launch experience feels intentional.

However, the Splash Screen should not artificially keep the player waiting for a long period.

The goal is:

**Fast initialization + smooth presentation**

rather than:

**Artificial loading time**

---

# 17. Maximum Splash Duration

The Splash Screen should not become stuck indefinitely.

If local initialization takes longer than expected, the game should continue displaying an appropriate loading state.

If a recoverable initialization problem occurs, the game should attempt to recover locally.

There should be no dependency on an internet connection to resolve initialization.

---

# 18. Initialization Failure

The game should handle local initialization failures gracefully.

Potential causes include:

* Corrupted local data.
* Invalid saved progress.
* Missing local configuration.
* Storage-related issues.
* Unexpected application state.

The game should attempt safe recovery where possible.

For example, invalid non-critical data can be replaced with default values.

Critical player progress should not be discarded automatically unless recovery is impossible.

---

# 19. Corrupted Progress Handling

If saved progress cannot be parsed or validated:

1. Detect the invalid data.
2. Attempt to recover valid portions.
3. Preserve recoverable player progress.
4. Replace only invalid data with safe defaults.
5. Continue application startup where possible.

The game should avoid crashing because of invalid local progress.

---

# 20. Animation Behavior

The Splash Screen animation should be short and smooth.

A recommended sequence is:

### Phase 1 — Background

The background appears with a soft fade.

### Phase 2 — Logo

The logo fades and scales into view.

### Phase 3 — Branding

The game name or tagline appears subtly.

### Phase 4 — Loading

The loading indicator provides minimal feedback while local initialization occurs.

### Phase 5 — Exit

The entire Splash Screen transitions smoothly into the Home Screen.

The total animation should feel like one continuous experience.

---

# 21. Animation Principles

Animations should follow these principles:

* Smooth
* Short
* Consistent
* Lightweight
* Non-blocking
* Natural

Animations should not interfere with initialization.

The visual animation and initialization process should be independent.

If initialization finishes before the animation completes, the game can wait for the minimum visual duration before navigating.

If initialization takes longer, the animation can continue in a looping state.

---

# 22. Loading State

While local initialization is running, the Splash Screen can maintain a loading state.

The loading state should not expose technical information such as:

* Database loading
* Preference loading
* Configuration initialization

The player only needs to know that the game is starting.

---

# 23. Error Presentation

Technical error details should not be displayed directly to the player.

If a serious startup problem cannot be recovered automatically, the game can present a simple friendly error state.

The error state should provide appropriate recovery options such as:

* Retry
* Continue with default local data
* Reset corrupted non-critical data

The game should avoid showing raw technical exceptions.

---

# 24. Offline Requirement

The Splash Screen must never:

* Wait for an internet connection.
* Check whether the internet is available.
* Call a remote API.
* Download configuration.
* Download level data.
* Authenticate a player.
* Wait for cloud synchronization.

Everything required for normal startup must already exist locally or be generated locally.

---

# 25. Performance Requirements

The Splash Screen should start quickly.

Initialization should avoid unnecessary work.

Only resources required for the initial application experience should be prepared during startup.

Heavy resources that are not required immediately should be initialized later when appropriate.

The goal is to keep:

* Startup time low.
* Memory usage reasonable.
* First frame rendering fast.
* Animations smooth.

---

# 26. Screen Exit Conditions

The Splash Screen can exit when:

* Required local initialization is complete.
* Local player state is available.
* Required settings are loaded.
* Required game configuration is ready.
* Minimum visual presentation time has been satisfied.

Once these conditions are met, the game proceeds to the Home Screen.

---

# 27. First Launch vs Returning Launch

The Splash Screen should support two primary startup paths.

### First Launch

**Splash → Initialize Defaults → Create Local Player State → Home**

### Returning Launch

**Splash → Load Local State → Validate State → Home**

The visual experience should remain consistent for both cases.

---

# 28. Data Safety

The Splash Screen should not modify important player progress unnecessarily.

Initialization should primarily:

* Read existing data.
* Validate data.
* Create missing defaults.
* Prepare runtime state.

Any modification to persistent player progress should be intentional and safe.

---

# 29. Responsibility Boundary

The Splash Screen is responsible for **application startup preparation**.

It is not responsible for:

* Puzzle gameplay.
* Puzzle generation during active gameplay.
* Tile movement.
* Score calculation during a level.
* Level selection behavior.
* Game completion behavior.
* Achievement presentation.
* Statistics presentation.

Those responsibilities belong to their respective game systems and screens.

---

# 30. Expected User Experience

The player experience should be:

**Launch**

↓

**Beautiful game identity appears**

↓

**Short smooth animation**

↓

**Local game data loads silently**

↓

**Game becomes ready**

↓

**Smooth transition to Home**

The player should feel that the game starts quickly and smoothly.

---

# 31. Acceptance Criteria

The Splash Screen is considered complete when:

* The game launches directly into the Splash Screen.
* The Splash Screen works completely offline.
* No network request is required.
* The game logo is displayed correctly.
* The visual animation is smooth.
* Local settings are loaded.
* Local progress is loaded.
* First-launch data is initialized correctly.
* Existing progress is preserved.
* Invalid local data is handled safely.
* Initialization does not block the UI unnecessarily.
* The Splash Screen does not remain visible indefinitely.
* The game transitions smoothly to the Home Screen.
* Startup works correctly after closing and reopening the application.
* Startup works correctly in airplane mode.
* Startup does not require user authentication.
