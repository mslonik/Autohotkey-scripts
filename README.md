# Autohotkey-scripts
Autohotkey (AHK) scripts written for various purposes by mslonik. My web page: http://mslonik.pl.

## MicrosoftWord_MacroKeyboard

## NumpadMouse
This is slightly enhanced version of a script which is available in official AHK help file: `AutoHotkey Script Showcase` -> `Using Keyboard Numpad as a Mouse -- by deguix`.

Using Keyboard Numpad as a Mouse -- by deguix
http://www.autohotkey.com
This script makes mousing with your keyboard almost as easy
as using a real mouse (maybe even easier for some tasks).
It supports up to five mouse buttons and the turning of the
mouse wheel.  It also features customizable movement speed,
acceleration, and "axis inversion".

o----------------------------------------------------------------------------------------o

|Using Keyboard Numpad as a Mouse                                                        |

(----------------------------------------------------------------------------------------)

| ver. 1.0 by deguix  / A Script file for AutoHotkey 1.0.22+                             |
|                    --------------------------------------------------------------------|
|                                                                                        |
| This script is an example of use of AutoHotkey. It uses the remapping of numpad keys   |
| of a keyboard to transform it into a mouse. Some features are the acceleration which   |
| enables you to increase the mouse movement when holding a key for a long time, and the |
| rotation which makes the numpad mouse to "turn". I.e. NumpadDown as NumpadUp and       |
| vice-versa. See the list of keys used below:                                           |
|                                                                                        |
|----------------------------------------------------------------------------------------|
| Keys                  | Description                                                    |
|----------------------------------------------------------------------------------------|
| ScrollLock (toggle on)| Activates numpad mouse mode.                                   |
|-----------------------|----------------------------------------------------------------|
| Numpad0               | Left mouse button click.                                       |
| Numpad5               | Middle mouse button click.                                     |
| NumpadDot             | Right mouse button click.                                      |
| NumpadDiv/NumpadMult  | X1/X2 mouse button click. (Win 2k+)                            |
| NumpadSub/NumpadAdd   | Moves up/down the mouse wheel.                                 |
|                       |                                                                |
|-----------------------|----------------------------------------------------------------|
| NumLock (toggled off) | Activates mouse movement mode.                                 |
|-----------------------|----------------------------------------------------------------|
| NumpadEnd/Down/PgDn/  | Mouse movement.                                                |
| /Left/Right/Home/Up/  |                                                                |
| /PgUp                 |                                                                |
|                       |                                                                |
|-----------------------|----------------------------------------------------------------|
| NumLock (toggled on)  | Activates mouse speed adj. mode.                               |
|-----------------------|----------------------------------------------------------------|
| Numpad7/Numpad1       | Inc./dec. acceleration per button press.                       |
| Numpad8/Numpad2       | Inc./dec. initial speed per button press.                      |
| Numpad9/Numpad3       | Inc./dec. maximum speed per button press.                      |
| !Numpad7/^Numpad1     | Inc./dec. wheel acceleration per button press*.                |
| !Numpad8/^Numpad2     | Inc./dec. wheel initial speed per button press*.               |
| !Numpad9/^Numpad3     | Inc./dec. wheel maximum speed per button press*.               |
| Numpad4/Numpad6       | Inc./dec. rotation angle to right in degrees. (i.e. 180° =     |
|                       | = inversed controls).                                          |
|----------------------------------------------------------------------------------------|
| * = These options are affected by the mouse wheel speed    |
| adjusted on Control Panel. If you don't have a mouse with  |
| wheel, the default is 3 +/- lines per option button press. |
o------------------------------------------------------------o
| Change log                                                 |
|------------------------------------------------------------|
| 1.01 by mslonik       | Added saving of config param into  |
|                       | file (NumpadMouse.ini):            |
|                       |    MouseSpeed                      |
|                       |    MouseAccelerationSpeed          |
|                       |    MouseMaxSpeed                   |
|                       |    MouseWheelSpeed                 |
|                       |    MouseWheelAccelerationSpeed     |
|                       |    MouseWheelMaxSpeed              |
|                       |    MouseRotationAngle              |
|                       | Added tooltips for ScrollLock and  |
|                       | NumLock                            |
|------------------------------------------------------------|
| 1.02 by mslonik       | Added menu info about app.         |
|------------------------------------------------------------|
| 1.03 by mslonik       | Added X2 (NumPadMul) to center     |
|                       | cursor within active window area.  |
|                       | Optimized saving of parameters     |
o------------------------------------------------------------o

Information available at AHK forum: https://www.autohotkey.com/boards/viewtopic.php?t=68050

## Otagle
Description available at AHK forum: https://www.autohotkey.com/boards/viewtopic.php?t=69690
YouTube video dedicated to this solution: https://youtu.be/5zKbTOXBqEs

This is a proof of the following concept: free (as in freedom) solution analogue to commercially available “elgato stream deck” (https://www.elgato.com/en/gaming/stream-deck).

The components:
* Hardware:
  * LCD combined with a touchscreen designed for Raspberry Pi, resolution: 1024 x 600 pixels.
      * Acrylic frame with nice brackets.
* Software:
  * Installed Autohotkey (AHK) language interpreter.
    * Script called OTAGLE as anagram to “elgato” (etymology: “a cat” in Spanish).

## PolishDiactric
Enable input of diacritic / diactric letters (https://en.wikipedia.org/wiki/Diacritic)  without touching of AltGr (right Alt key). 

In some countries, e.g. Poland, there is no country specific keyboard layout, instead a "programmers keyboard" is used. Instead the default "latin" keboard layout is applied, but right Alt key (AltGr) if pressed prior to a key for which diactric exists, then such key code is entered (see https://en.wikipedia.org/wiki/AltGr_key#Polish for further details). In situation when AltGr is not located conveniently or ones thumb is aking / disabled, this could be cumbersome.

Thanks to this script it is possible to enter diactric keys instead of usage of AltGr:
* double press a key corresponding to specific diacritic key, e.g. ee converts into ę;
* AltGr toggles SUSPEND of this script (if on, keyboard acts as default, if off see above line);
* special sequence for double letters within words: <letter><letter><letter>, e.g. zaaawansowany converts into zaawansowany

To sum up:
* e -> e
* ee -> ę
* eee -> ee

Why this script was prepared:
a. "programmers keyboard" and Polish diactric marks combined with old ANSI 101 keys keyboards (without Windows key and context key) where AltGr is unergonomically shifted to the right side of keyboard,
b. all other "programmers keyboard" when one doesn't want to press AltGr.

The "PolishDiactric" contains the following 4 scripts. It's recommended to use by default PolishDiacritic2.ahk only. The other scripts are left for educational purposes mainly.

* PolishDiacritic1.ahk <- the 1st attempt to fulfill above requirements; 
  - e -> e
  - ee -> ę
  - e  e -> ee

* PolishDiacritic2.ahk
  - e -> e
  - ee -> ę
  - eee -> ee
  Information about this particular script at AHK forum: https://www.autohotkey.com/boards/viewtopic.php?t=67840

* PolishDiacritic3.ahk <- variant of above, but instead of hotstrings attempt to carry on with input buffers
  - e -> e
  - ee -> ę
  - eee -> ee

* PolishDiacritic4.ahk <- variant of above, attempt to apply arrays; not finished.
  - e -> e
  - ee -> ę
  - eee -> ee
