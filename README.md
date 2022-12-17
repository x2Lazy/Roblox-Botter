# Roblox-Botter
Make accounts join games and control what they do with chat commands!

<br>

The instructions below are listed in order of steps so make sure to follow them!

<br>

# Requirements:
<ul>
  <li>  <a href="https://www.python.org/"> Python 3.8 > </a> </li>
  <li> <b> Python Packages: </b> time, requests, pathlib, urllib.parse, os, threading </li>
  <li> A Roblox exploit that supports Autoexec <b> (Synapse recommended) </b> </li>
  <li> <a href="http://www.editthiscookie.com/"> Edit this cookie </a> </li>
  <li> <a href="https://wearedevs.net/dinfo/Multiple%20Games"> Muitiple rbx </a> </li>
</ul>

<br>
<br>

# Grabbing the Roblox account's cookie
For this you need <a href="http://www.editthiscookie.com/"> Edit this cookie </a> or simular to browse cookies.

Locate `.ROBLOSECURITY` and copy it's value <br>

<img style="width: auto; height: 600px" src="https://user-images.githubusercontent.com/86912923/203606748-0959fd14-50fa-4391-9df7-44897789b3d6.png"/>
<br><br>

**WARNING** If you log out of the account, the cookie will become invalid! Instead, set `.ROBLOSECURITY`'s value to ` `&nbsp;and click the green arrow icon on the bottom of the menu (Shown in picture above).

<br><br>

## Adding the cookie

In the cookie array, add the cookie's value as a string. <br>

![image](https://user-images.githubusercontent.com/86912923/203607617-8648bfa7-970f-42c0-b399-ba4429e4c520.png)
<br>

To format muitple cookies, I have list an example below.

```
config = {
    "Cookies": [
        ".ROBLOSECURITY Here",
        ".ROBLOSECURITY Here",
        ".ROBLOSECURITY Here"
    ]
}
```
<b> The last line should not incude a `,` at the end of the line otherwise it will result in a syntax error. </b>

After this, change the `Bot` variable to the amount of bots you want! <b>(The max amount is how many cookies you provided)<b>

<br>
<br>

# Adding the bot controler

Locate your exploit's autoexec folder and drag n drop `BotControler.lua` into it. <br>

![image](https://user-images.githubusercontent.com/86912923/203608146-39e8323d-c0af-420c-9abb-56ad4e42f257.png)

<br>
<br>

# Botting a game

Once you have compleated the steps above, copy your Roblox's username (or a friend's) to be added to the permission list in `BotControler.lua`.
Once copyied paste it into the table and save the file. <br>

![image](https://user-images.githubusercontent.com/86912923/203613679-e0904c4e-c6ab-4e61-accd-7fc25e04abab.png)

Open your exploit and MuitRBX, join the game you would like to bot. Once in the game execute a script like <a href="https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source">Infinite Yield</a> and copy the game's Jobid and paste it into the python script and reduce it to the image shown below. <br>

![image](https://user-images.githubusercontent.com/86912923/203609406-c99aa0a2-86c3-48cd-9e6f-0411db7ad9f5.png)

Run the python script and enjoy.

# Commands

<b> NOTE: Player names can be shortened! </b>
Each argument is seperated by `, `

```
Unlock, (true/false) | Wether all players have permission to use the bots.
Come, (PlayerName) | Teleports all bots to a player | Stop `Come, `
Say, (Msg) | Make the bots say a message.
Say, loop, (Msg) | Make the bots spam a message. | Stop `Say, .`
chatmode, (Mode) | Change the Chat mode e.g `All, General`
Rejoin | Make the bots rejoin the game.
Follow, (Player name) | Make the bots follow a player. | Stop `Follow, `
```
