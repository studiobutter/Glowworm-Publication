# Changelogs

## v0.1.13 - Emergency Hotfix

If you only use GitHub update, Please reinstall the app. it will fix the Update Size issue

- Fixes GitHub unable to pull the update correctly

## v0.1.12

This will be the last preview update to be using the old Velopack update, we recently switched to a new system. If you are on Cloudflare Update, please reinstall the app or download and replace the portable app with the current one.

I'll be also stop pushing nupkg to GitHub Releases and instead will only pushing Portable and Setup Packages

- [Velopack] Rework the update system.
- [Backend] Refactoring Code
- [Backend] Clean up dependencies.
- [Velopack] Fix rendering issue when trying to render release notes
- [Backend] Switches to use our Cloudflare Image Provider instead of using a third-party one.
- [UI] Made backdrop darker.
- [Velopack] Improved Markdown rendering.

## v0.1.5

Hi there, never thought I would be publishing a Windows App till now. 

<img width="256" height="256" alt="logo" src="https://github.com/user-attachments/assets/ca56c857-869b-475b-a59d-d947dec0f17e" />

This is Glowworm, a spin off companion app from [Scighost/Starward](https://github.com/Scighost/Starward), This was made so to fix many issue that Starward has alongside making a companion app instead of a full launcher replacement of HoYoPlay.

Features: 
- Screenshot Management (Well obviously just a direct copy, nothing changes)
  - But with Cloud Client Support (Yeah this is new, you can now back up your screenshots from Genshin or ZZZ Cloud)
- Gacha Log Improvements:
  - Update to support [UIGF v4.2a](https://uigf.org/) (Please note that v4.2a is an unofficial version due to it missing supported export for ZZZ export of the new anniversary banners)
  - Improve and fix bug that prevented getting Gacha URL/Data from Zenless Zone Zero
  - Support getting Gacha data from Genshin Impact - Cloud and Zenless Zone Zero - Cloud Official PC Client on top of getting Gacha data from Cloud Web
  - Enable UIGF Importing and exporting for Genshin Impact - Miliastra Wonderland Odes
  - Support Genshin Impact for Google Play and all HoYoverse games for Epic Games

Future plan: I'm planning to work on making a Card Generator that generate a card that you can export and share with others. On top of that, in the future I'm thinking allowing Gacha Data Syncing to sync your data from your PC to Google Drive or our proprietary Gacha Log service which allow you to access the data on every devices from iOS, Android, PC and macOS (if HoYo ever bring Mac support to their games) and uh... Linux? Oh gosh what have I done. 

Web app will be a combination of Star Rail Station, zzz.rng.moe, Paimon.moe, Stardb.gg combined in a website and synced with the app. So expect something like that soon. 

Welp, I yapped too much, so I'll let you guys experience the app initial release. Have fun!