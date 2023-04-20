![something](https://i.imgur.com/as5GhAn.png)

## Project Summary
Developed a game in the game engine Unreal Engine v4.27 (UE4) with high accuracy and precision delivery of both auditory and visual stimuli for use in in-unit sEEG studies. The game is a UE4-based implementation of the [popular electronic game](https://en.wikipedia.org/wiki/Simon_(game)). A memory game by design, Simon is a useful tool for studying the neural correlates of auditory working memory, speech perception, and more.

Project goals:
1. optimize UE4 stimulus delivery timing for use in neuroscience experiments
2. create a game that increases engagement and motivation in study participants.

This project was completed as part of the curriculum for a Master's of Science project in Electrical & Computer Engineering (Advisor: Gregory Cogan, Duke University).

## Features
* Uploadable sound files (.WAV,.OGG supported)
* Persistent save slot for settings
* Adjustable game speed via audio delay setting
* Sound priming (caches audio data for optimized playback)
* Frame rate smoothing
* User-defined file names and save directory

### Examples

#### Sample CSV Output
**0**|**Onset**|**Color**|**Position**|**Name**|**Length**|**Delay**|**FPS**
:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:
1|0.183604|Red|TL|sound1|1.4|1.6|31.7124
2|1.78535|Green|TR|sound4|1.4|1.6|32.3526
3|3.39164|Yellow|BR|sound2|1.4|1.6|32.0403
4|5.01839|Blue|BL|sound3|1.4|1.6|32.6082
5|7.58606|Blue|BL|sound3|1.4|1.6|32.3935
6|14.298|Blue|BL|sound3|1.4|1.6|32.3883
7|15.9514|Green|TR|sound4|1.4|1.6|32.5098
8|25.1821|Blue|BL|sound3|1.4|1.6|32.2785
9|26.7974|Green|TR|sound4|1.4|1.6|32.444
10|28.441|Red|TL|sound1|1.4|1.6|32.2311

#### Gameplay
(insert video)


## Download

1. Download the [zip file](https://drive.google.com/file/d/1Cx2oEqHdcQ-lriwse8LaBcMDWhglmOVx/view?usp=sharing) via Google Drive
2. Extract to your directory of choice
3. Optional: Download sample audio files via [Sounds](https://github.com/orbitalhybridization/SimonforNeuro/tree/main/Sounds) from this repo.
4. Inside of the "Simon for Neuro" folder, double-click Simon1.exe
5. Input default settings (Running the program for the first time will take you to settings screen)
6. Click SAVE, then click DONE
7. At Simon main screen click START to play

Enjoy! Game comes with default sounds in Sounds/ subfolder.

## Using the benchmarking tools
### Requirements:
1. Photodiode
2. Microphone
3. DAQ

### Sample data
Sample data available for:
* [.RHD File](https://drive.google.com/drive/folders/1f36aAD_Uoqpxgpse4-SgAn9CM8oxs9nb?usp=share_link)
* [.CSV File](something.com)
* .WAV files in Sounds/ subfolder
