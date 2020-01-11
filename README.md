**Raspberry Pi, cooling Fan Script written in bash**

Hi, this project involves controling of cooling raspberry pi device by fan. 
I decided to use fan to work with raspberry pi 4, because this device gets hot very easily.
I decided also to write script, "one and only heart of this repository ;)", which automaticly turns on and turns off fan in specific cases, because noise of fan, which I use is annoying for me, if works too long time.
The cases of turning on/off fan are simple: Fan is turned on, when CPU makes too hot (for example 60 degrees of Celcius) and fan is turned off, when CPU is cooled (i.e. 35 dC).

You can find fan used by me on link (nobody paid me for this advertisement):
https://botland.com.pl/pl/obudowy-do-raspberry-pi/14776-obudowa-raspberry-pi-4b-z-wentylatorem-czarna.html
If You see well, You will also find how to connect fan to raspberry pi's pins, on site from link, but this connection does not allow to turning on/off fan, wherever You want- 5v output from raspberry pi's pin is not controlable, always on hight state.

To control fan, I had to connect fan to raspberry pi's ground through a transistor, which works as switcher in my case. I used of this tutorial and it should be good enough:
https://howchoo.com/g/ote2mjkzzta/control-raspberry-pi-fan-temperature-python
Attention! One different is that instead of using pin number 11, I chose pin number 40 (in executing script and on physical board of course) to control fan wiring through resistance to transistor's base.

![image](https://github.com/wojtaszek23/RPI-Fan-Cooling/blob/master/my_wires_schema.png)

![image](https://github.com/wojtaszek23/RPI-Fan-Cooling/blob/master/wire_fot1.jpg)

![image](https://github.com/wojtaszek23/RPI-Fan-Cooling/blob/master/wire_fot2.jpg)

![image](https://github.com/wojtaszek23/RPI-Fan-Cooling/blob/master/wire_fot3.jpg)

*How-to-use:* Just clone fanCooling.sh script to localisation on Your device, wherever You want and launch it in console.
If You would like to start script in background on system booting, which I recommend, You can do it by execute the following:
-type sudo nano /etc/rc.local and paste following line before line with command "exit 0":
-----------------------------------------------------------------------------------------
sudo /[absolute path to fanCooling.sh script]/fanCooling.sh >> /[absolute path to localisation, where You want to store log]/log.txt &
--------------------------------------------------------------------------------------------------------------------------------------

replace text inside [ ] with localisation chosen by You; reboot Your device and script should work on boot and print logs since now.

*Additional bibliography:*

To access to gpio in my script, I used of article (first half of it):
https://forbot.pl/blog/kurs-raspberry-pi-podstawy-gpio-skrypty-id23593

To write properly booting as a background with logging informations about current state of working of script I used of site from link:
https://www.dexterindustries.com/howto/run-a-program-on-your-raspberry-pi-at-startup/?fbclid=IwAR0uOeVI1-HqQO57YWMcnUQxRgIIbTqzqwewER8bJ58E01Hh3qtfbcBjth

To write bash script with properly syntax and working fine I used some googling and stackoverflow ;)

Thanks for visiting :)