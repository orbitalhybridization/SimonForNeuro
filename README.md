![something](https://i.imgur.com/as5GhAn.png)

## Project Summary
SimonForNeuro is a game developed in Unreal Engine v4.27 (UE4) to characterize stimulus delivery delays for both auditory and visual stimuli to be used in sEEG and ECoG studies. The game is a UE4-based implementation of the [popular electronic game, Simon](https://en.wikipedia.org/wiki/Simon_(game)). A memory game by design, Simon is a useful tool for studying the neural correlates of auditory working memory, speech perception, and more. Thus, knowing the inherent timing biases in a powerful game engine like UE4 can help us to determine its accuracy and precision at the neural timescale.

Project goals:
1. optimize UE4 stimulus delivery timing for use in neuroscience experiments
2. create a game that increases engagement and motivation in study participants

This project was completed as part of the curriculum for a Master's of Science project in Electrical & Computer Engineering (Advisor: Gregory Cogan, Duke University). As part of the process, I gave a [short presentation](https://docs.google.com/presentation/d/e/2PACX-1vTYunatrHIF_dEswvlyRBQls0-UcbHC2gGNquG2_JlpQTFi_Uf162eQxXcN1pgXnw/pub?start=false&loop=false&delayms=10000) to a small committee. The eventual goal of the project is to use high-resolution game engines like Unreal to create more entertaining tasks for study participants, many of whom are confined to a hospital bed or room.

## Features
* Uploadable sound files at runtime (.WAV supported)
* Persistent save slot for settings
* Adjustable game speed via audio delay setting
* Sound priming (caches audio data for optimized playback)
* Frame rate smoothing (Unreal Engine 4 feature)
* User-defined file names and save directory
* In-game events logged to CSV during gameplay

### Examples

#### Sample CSV File Output
|0  |463503  |Color |Position     |Name              |Length  |Delay  |FPS    |
|---|--------|------|-------------|------------------|--------|-------|-------|
|1  |6.09E-05|      |NewBlockFlush|                  |        |       |       |
|2  |0.991087|Blue  |TL           |horn              |0.895419|0.99542|119.999|
|3  |1.99112 |Green |TR           |injury            |1.15374 |1.25374|119.999|
|4  |3.24947 |Yellow|BR           |well              |0.988299|1.0883 |119.999|
|5  |4.34116 |Red   |BL           |scare             |1.05506 |1.15506|119.999|
|6  |6.49128 |Blue  |TL           |horn              |0.895419|0.99542|119.999|
|7  |8.12443 |Blue  |TL           |horn_ButtonPress  |0.895419|0.99542|119.998|
|7  |11.0498 |Blue  |TL           |horn              |0.895419|0.99542|119.999|
|8  |12.0582 |Blue  |TL           |horn              |0.895419|0.99542|119.999|
|9  |13.7415 |Blue  |TL           |horn_ButtonPress  |0.895419|0.99542|119.999|
|9  |14.0498 |Blue  |TL           |horn_ButtonPress  |0.895419|0.99542|119.999|
|9  |18.1418 |Blue  |TL           |horn              |0.895419|0.99542|119.999|
|10 |19.1418 |Blue  |TL           |horn              |0.895419|0.99542|119.999|
|11 |20.1501 |Green |TR           |injury            |1.15374 |1.25374|119.999|
|12 |21.8749 |Blue  |TL           |horn_ButtonPress  |0.895419|0.99542|119.998|
|12 |22.2    |Blue  |TL           |horn_ButtonPress  |0.895419|0.99542|119.999|
|12 |23.1169 |Green |TR           |injury_ButtonPress|1.15374 |1.25374|119.999|

Here, NewBlockFlush occurs at each replay of the game after the player loses and chooses to continue. It is meant to flush the stdout stream and act as a marker in the CSV.

#### Gameplay

## Stimulus Timing Benchmarking

| measure               | expected (E(x)) | E(measured) - E(x) | sd      | min      | max      |
| --------------------- | --------------- | ---------------- | ------- | -------- | -------- |
| inter-visual-interval | 1600ms          | +24.3ms            | 23.7ms | 1598ms   | 1798ms   |
| inter-audio-interval  | 1600ms          | +22.1ms            | 14.1ms | 1599ms   | 1665ms   |
| visual length         | 161.3ms         | +29.1ms          | 21.2ms  | 184.9ms  | 385ms    |
| audio length          | 1400ms          | \-3ms            | 0.55ms  | 1396.1ms | 1398.1ms |
| audio-visual sync     | 0ms             | \-52.3ms         | 20.0ms  | \-230ms  | \-30.1ms |
| frame rate            | 31Hz            | +1.1Hz           | 0.668Hz | 28.58Hz  | 32.91Hz  |
| Laptop-DAQ Time         | 0ms             | \-194ms          | 21.2ms  | \-210ms  | 0ms      |

(for more details on methods please see attached report)

## Download

1. Download the [zip file](https://drive.google.com/file/d/1LTJPw0G4KnlJKutK2Uz_2FOtITdgs0gJ/view?usp=sharing) via Google Drive
2. Extract to your directory of choice
3. Optional: Download sample audio files via [Sounds/](https://github.com/orbitalhybridization/SimonforNeuro/tree/main/Sounds) from this repo.
4. Inside of the SimonForNeuro folder, double-click SimonTest1.exe
5. Upon startup, go to SETTINGS and fill in your preferences *(Note: Simon needs four audio files to play, which can be imported in settings)*
7. Click SAVE, then click DONE
8. At Simon main screen, click START to play

Enjoy! Game comes with default sounds in Sounds/ subfolder (see Step 3).

## Using the benchmarking tools
### Requirements:
1. Photodiode
2. Microphone
3. DAQ

### Sample data
Sample data available for:
* [.RHD File](https://drive.google.com/drive/folders/1f36aAD_Uoqpxgpse4-SgAn9CM8oxs9nb?usp=share_link)
* [.CSV File](https://drive.google.com/file/d/1xUiAMbsIjsl6oyi7XvnWN6J1vkybCzFP/view?usp=sharing)
* .WAV files in Sounds/ subfolder

### Tips
* Use the same layout for folders as seen in Sample Intan Data

## Known Issues
* uploading sounds occasionally crashes the game (possibly due to size)

Questions? Feedback? Contact me at [orbitalhybridization@gmail.com](mailto:orbitalhybridization@gmail.com).
