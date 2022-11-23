import time, requests, pathlib, urllib.parse, os, threading

currentpath = str(pathlib.Path(__file__).parent.absolute())


def startroblox(PlaceID: int, JobID: str, Cookie: str):
    print("checking latest version of ROBLOX... ", end="")

    version = requests.get("http://setup.roblox.com/version.txt").content.decode("ascii")
    path = os.getenv("LOCALAPPDATA") + "\\Roblox\\Versions\\" + version

    print("done! (" + version + ")")

    if not os.path.exists(path):
        print("updating ROBLOX, please wait... ", end="")

        bootstrapper = requests.get("http://setup.roblox.com/RobloxPlayerLauncher.exe")
        open(currentpath + "\\RobloxPlayerLauncher.exe", "wb").write(bootstrapper.content)
        os.system('"' + currentpath + '\\RobloxPlayerLauncher.exe" -install')

        print("done!")

    print("fetching CSRF token... ", end="")

    req = requests.post(
        "https://auth.roblox.com/v1/authentication-ticket",
        headers={"Cookie": ".ROBLOSECURITY=" + Cookie}
    )

    csrf = req.headers['x-csrf-token']
    print("done!")

    print("fetching authentication ticket... ", end="")

    req = requests.post(
        "https://auth.roblox.com/v1/authentication-ticket",
        headers=
        {
            "Cookie": ".ROBLOSECURITY=" + Cookie,
            "Origin": "https://www.roblox.com",
            "Referer": "https://www.roblox.com/",
            "X-CSRF-TOKEN": csrf
        }
    )

    ticket = req.headers['rbx-authentication-ticket']
    print("done!")

    print("\nstarting ROBLOX... ")

    timestamp = '{0:.0f}'.format(round(time.time() * 1000))
    url = urllib.parse.quote(
        #"https://assetgame.roblox.com/game/PlaceLauncher.ashx?request=RequestPrivateGame&browserTrackerId=147062882894&placeId=142823291&accessCode=700a7d2c-2c91-48c3-86fd-a5e75d03569d&linkCode=77685428874983661291575613020671 browsertrackerid:147062882894 robloxLocale:en_us gameLocale:en_us channel: LaunchExp:InApp"
        f'https://assetgame.roblox.com/game/PlaceLauncher.ashx?request=RequestGame{"Job"}&browserTrackerId=147062882894&placeId={PlaceID}{"&gameId=" + JobID}&isPlayTogetherGame=false+browsertrackerid:147062882894+robloxLocale:en_us+gameLocale:en_us+channel:'
    )

    os.startfile(f"roblox-player:1+launchmode:play+gameinfo:{ticket}+launchtime:{timestamp}+placelauncherurl:{url}")

    time.sleep(5)


config = {
    "Cookies": [
        ".ROBLOSECURITY Here"
    ]
}

""" 
I recommend using this browser extension:

    https://chrome.google.com/webstore/detail/roblox-multi-accounts/cmeicimcdhgohgjmpmcdpakjjdohhocg
    

You could use the cookies for 

for Cookie in config["Cookies"]:
    startroblox(PlaceID, JobID, Cookie)
    time.sleep(4)

"""

PlaceID, JobID = 11513432564, "eb075857-5214-4d15-a8db-a8ce496105c1"
Bots = 10
TimeBetween = 10 # Time to sleep after each join. (Seconds)

for i in range(Bots):
    Cookie = config["Cookies"][i]
    threading.Thread(target=startroblox, args=(PlaceID, JobID, Cookie)).start()
    time.sleep(TimeBetween)
