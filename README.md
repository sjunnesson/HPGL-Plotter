# PlotterHPGL
Library and examples to interface a HPGL plotter such as HP7550a to processing. 

To use just download the whole repository and put it in your Processing folder. There is a couple of exampels that shows the capabilities of the library in the examples folder. Hopefully they should be self explanatory. 

##Hardware

You need a USB to DB25 converter to interface to a HP7550a. Im using this [this](http://www.amazon.com/gp/product/B00NHYTE7Q/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1) bought at Amazon. It has the ch340 chipset inside that needs this drivers:

Chinese manufacturer: http://www.wch.cn/downloads.php?name=pro&proid=5

and then on OSX you need to do:

1. Install the CH340 driver
2. Run this command in Terminal: sudo nvram boot-args="kext-dev-mode=1"
3. Reboot

this sequence is originaly created by  [Alexandre de Pellegrin](http://javacolors.blogspot.com/2014/08/dccduino-usb-drivers-ch340-ch341-chipset.html)

On the Plotter you need to setup this configuration:

* Baudrate 9600
* Handshake: Xon/Xoff Direct
* Data flow: Local Standalone (this seems to reset after power down of plotter on my machine)
* Bypass: OFF
* Duplex: Full
* Parity: 8-bits OFF

To access the submenu for this settings on the HP7550a press:

1. "Next Display"
2. "Enter"
3. "Next Display"
4. "Serial"

Feel free to fork, reuse and redistrube as you wish. 

Happy plotting
