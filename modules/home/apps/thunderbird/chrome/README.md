# Thunderbird Proton Theme

A modern community project to bring the flat, clean aesthetic of **Proton Mail** to **Mozilla Thunderbird (Version 128+ "Nebula")**.

> [!IMPORTANT]
> **Status: Beta / Work-in-Progress** — Core areas are styled: Mail interface, Tabs, Sidebar, Settings page, Add-ons Manager, Card View, and Notification Buttons. Calendar is not yet themed.

## 📸 Preview
<img width="1512" height="953" alt="demo thunderbird proton theme screenshot" src="https://github.com/user-attachments/assets/7465e9a7-3944-41a0-b5b3-d3c412471ba7" />

## ✨ Features
- **Proton Color Palette:** Uses the authentic Proton dark grays and accent colors.
- **Modern Tab-Bar:** Completely square, flat tabs without default gradients, shadows, or blue lines.
- **Improved Sidebar:** Rounded folder indicators ("Island-Look") without distracting system focus-frames or outlines.
- **Custom Badges:** Unread message counts styled in the original Proton Purple (`#8838ff`).
- **Clean UI:** Minimized borders and dividers for a streamlined experience.
- **Dark Reading Pane:** The full message body is styled dark – including background, text, links, and blockquotes.
- **Styled Settings Page:** The full Preferences/Settings UI is themed dark with Proton colors.
- **Styled Add-ons Manager:** The Add-ons page matches the Settings page style with a flat sidebar.
- **Proton Pink Checkboxes & Radio Buttons:** All XUL checkboxes and radio buttons are colored with Proton Pink via CSS filter.
- **Card View:** Active message card is highlighted with a full Proton Pink background.
- **Notification Buttons:** Privacy notification action buttons (e.g. "Einstellungen") styled in Proton Pink.
- **Accent Color Picker:** Change the accent color via the extension options page (Pink, Purple, Blue, Teal, Orange or custom hex).
- **Architecture Support:** Verified on **aarch64 (ARM)** and standard x86 systems.

## 🗂 File Overview

| File | Purpose |
| :--- | :--- |
| `userChrome.css` | Styles the Thunderbird UI chrome – sidebar, toolbar, tabs, message list, header area, buttons, etc. Place in your profile's `chrome/` folder. |
| `userContent.css` | Styles the Settings page, Add-ons Manager, and message reading pane. Place in your profile's `chrome/` folder. |
| `manifest.json` | XPI extension manifest – defines theme colors, permissions, and links to background script and options page. |
| `style.css` | Additional CSS loaded by the XPI extension via `theme_experiment`. |
| `background.js` | Background script – applies accent color from storage and injects CSS into preferences/addons tabs. |
| `options.html` | Extension options page – color picker UI for changing the accent color. |
| `options.js` | Logic for the options page color picker. |

## 🛠 Installation

There are two ways to install this theme:

### Option A — XPI Extension (Recommended)

1. Download the latest `.xpi` file from the [Releases](https://github.com/tinyprojekt/thunderbird-proton-theme/releases) page.
2. In Thunderbird, go to **Add-ons Manager** → click the ⚙️ gear icon → **Install Add-on From File...**.
3. Select the `.xpi` file.
4. Restart Thunderbird.

To change the accent color: **Add-ons Manager** → **Thunderbird Proton Theme** → **⋯** → **Einstellungen (Options)**.

### Option B — Manual CSS (Advanced)

#### 1. Enable Stylesheets in Thunderbird
1. Open Thunderbird.
2. Go to **Settings** > **General**.
3. Scroll to the bottom and click on **Config Editor...**.
4. Search for `toolkit.legacyUserProfileCustomizations.stylesheets`.
5. Double-click to set it to **true**.

#### 2. Add the CSS files
1. Locate your Thunderbird profile folder:
   - **Windows:** Press `Win + R`, type `%APPDATA%\Thunderbird\Profiles\`
   - **macOS:** `~/Library/Thunderbird/Profiles/`
   - **Linux:** `~/.thunderbird/` (or run `thunderbird --ProfileManager` to find the exact path)
2. Open your active profile folder (usually `[random-string].default-release`).
3. Create a folder named `chrome` (all lowercase) if it doesn't exist.
4. Copy **both** `userChrome.css` and `userContent.css` from this repository into that `chrome` folder.
5. Restart Thunderbird.

> [!TIP]
> **Linux users:** You can also find your profile path by opening Thunderbird, going to **Help** > **Troubleshooting Information**, and looking for the **Profile Directory** entry. Click **Open Directory** to go directly to it.

> [!TIP]
> **macOS:** The `~/Library` folder is hidden by default. In Finder, press `Cmd + Shift + G` and paste `~/Library/Thunderbird/Profiles/` to navigate there directly.

## 🧩 Recommended Add-on: Sender Cleanup

This theme pairs perfectly with the **[Sender Cleanup Add-on](https://github.com/tinyprojekt/thunderbird-sender-cleanup)** – it hides email addresses in the card view and shows only the display name for a cleaner look.

👉 **[View Sender Cleanup Add-on →](https://github.com/tinyprojekt/thunderbird-sender-cleanup)**

## 🎨 Colors
| Element | Hex Code |
| :--- | :--- |
| Background (Dark) | `#16141c` |
| Surface | `#1e2130` |
| Active Elements | `#34384e` |
| Unread Badge | `#8838ff` |
| Proton Pink (Accent) | `#e53265` |
| Proton Green | `#2fd6b5` |
| Text Weak | `#979bb0` |

## 🤝 Contributing
Since this is a Work-in-Progress, I appreciate any help!
- Found a bug? Open an **Issue**.
- Want to style a new element (e.g., the Calendar)? Submit a **Pull Request**.

## ⚖️ Disclaimer
This is an **unofficial community project**. It is not affiliated with, or endorsed by, Proton AG. All trademarks, logos, and design rights of Proton Mail are the property of Proton AG. This theme is inspired by their design language for personal, non-commercial use.

## 📜 License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.