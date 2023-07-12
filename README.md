# RedFish OS

```diff
+ Refactoring SailFish OS 4.5.0.19 while it is running on a Sony Xperia 10 II smartphone.
```

> __Note__: support for others smartphone like Sony Xperia 10 III or IV, Gigaset GS5 and its variant in particular the Volla and the Rephone one, could be added as far as concrete support and mainteneirs will be available. 

---

### Fund raising

As much as you are interested in this project, you can concretely support a specific task or just provide a free donation.

* [PayPal.me](https://www.paypal.com/paypalme/rfoglietta) to Roberto Foglietta aka @rfoglietta on PayPal Me platform
* [Donation Form](https://tinyurl.com/robang74) to Roberto Foglietta aka @robang74 on PayPal Italia

Roberto Foglietta is the document-id real persona name behind on-line `Roberto A. Foglietta` authotship brand, usually presented as:

```
(C) 2023, Roberto A. Foglietta <roberto.foglietta@gmail.com>
```

in the files headers, in the ChangeLogs, in the documents authoship or referal sections, at end of websites, etc.

> __Note__: the report of activities and related proof of expences will be submited to those contributed, only. On regular basis monthly, quarterly or yearly depending on the amount of support they trusted to delegate to my management. Those nominative reports will be sent with the friendly clause to not publicly disclose those data before three years the date of the report.

---

### About SailFish OS

> __Warning__: the SailFish OS is **not** *open source* **nor** *software libre* but largerly based on several FOSS projects.

* [SailFish OS on Wikipedia](https://en.wikipedia.org/wiki/Sailfish_OS)

Therefore it cannot be *almost* redistributed AS-IS even if can be downloaded for free (gratis) from the Jolla Shop:  

* [Jolla SailFish OS download shop](https://shop.jolla.com/)
* [Jolla how to flash SFOS with Linux](https://jolla.com/how-to-install-sailfish-x-on-xperia-10-ii-on-linux/)
* [Jolla reverting Xperia back to Android](https://docs.sailfishos.org/Support/Help_Articles/Managing_Sailfish_OS/Reinstalling_Sailfish_OS/#reverting-xperia-back-to-android-os)
* [Jolla SailFish OS website](https://sailfishos.org/)
* [Jolla offial documentation](https://docs.sailfishos.org/)

The paid licensed version adds the support for Android integrating the proprietary [Alien Dalvik](https://en.wikipedia.org/wiki/Dalvik_Turbo_virtual_machine) middle-ware framework plus some others features. The zero-budget version is supported by its related community:

* [Community Forum](https://forum.sailfishos.org/)
* [Community apps repository](https://sailfish.openrepos.net/)
* [Patch Manager Web Catalog](http://coderus.openrepos.net/pm2/)

Few components in SailFish OS are proprietary and because the package downloaded from their shop contains such proprietary software and vendor firmware. Some other proprietary software and vendor firmare cames from Sony Open Device AOSP.

Instead, the boot images are compositions of binaries from on open source and software libre projects, only. Therefore the boot images can be freely redistribute as far as those redistribuite them fulfil the FOSS licenses obbligations related to that binaries. 

> __Note__  The alternative to fullfil yourself that obbligations is to link this page which the aim is to collect all those FOSS contributes. However, you have to check by yourself if these list of resources is complete and updated respect the boot image that you wish to distribute.

---

### About Xperia 10 II

The Sony Xperia 10 II (codename `pdx201`) is a mid-range smartphone from Sony. It was announced in February 2020 and released in May 2020 and it [has been added](https://developer.sony.com/posts/xperia-10-ii-added-to-sonys-open-devices-program/) on Sony Open Device program on June 2020.

---

### About Open Device program

* https://developerworld.wpp.developer.sony.com/open-source/aosp-on-xperia-open-devices

* https://opendevices.ix5.org

---

### Useful documentation

* [Start Quick Quide](forum/start-quick-guide.md) - An end-users step-by-step guide for a quick start

* [SFOS install on Xperias](https://gitlab.com/Olf0/sailfishX) - A guide for installing SailfishX on Sony Xperias

* [degoogle](https://github.com/robang74/degoogle) - A huge list of alternatives to Google products. Privacy tips, tricks, and links.

* [awesome SFOS](https://github.com/robang74/awesome-sailfishos) - A curated list of awesome Sailfish OS resources
  
* [Equivalents in SFOS](https://github.com/robang74/equivalentsinsailfish): a list of Android apps and their Sailfish equivalents

---

### Flashing toos

* [Sony Emma flashing tool for Windows 10](https://developerworld.wpp.developer.sony.com/file/download/download-the-flash-tool/)

* [XperiFirm: a Xperia Firmware Downloader v5.6.5 on XDA Forums](https://forum.xda-developers.com/t/tool-xperifirm-xperia-firmware-downloader-v5-6-5.2834142/)

Sony Emma flashing tool does not seems able to run on a GNU/Linux distribution but the XperiFirm does:

```
$ sudo apt-get install mono-complete
$ sudo cert-sync /etc/ssl/certs/ca-certificates.crt
$ sudo certmgr -ssl -m https://software.sonymobile.com

$ url=https://forum.xda-developers.com/attachments/xperifirm-5-6-5-by-igor-eisberg-zip.5488139/
$ wget $url -O xperifirm-5-6-5-by-igor-eisberg-zip
$ unzip xperifirm-5-6-5-by-igor-eisberg-zip

$ mono XperiFirm-x64.exe
```

The last command executed after having extracted the .exe out of the archive. Unfortunately, XperiFirm can download just few AOSP versions compared to Sony Emma.

---

### List of components available on Github

* [hibrys boot](https://github.com/robang74/hybris-boot) - This project enables the building of boot images for Google Android fastboot based devices.

* [yamui](https://github.com/robang74/yamui) - Yet Another Minimal UI. Tool for displaying graphical notifications in minimal evironments like early boot / initrd

* [busybox-static](https://github.com/robang74/sailfish-os-busybox) - The busybox config and RPM spec for SailFish OS

* [fsck.auto](https://github.com/robang74/fsck.auto) - This is a simple b/ash script for busybox fsck.auto to check block device partition file system type.

* [Patch Manager](https://github.com/robang74/patchmanager) - The Patch Manager page in Settings:System for Sailfish OS

* [lipstick](https://github.com/robang74/lipstick) - The lipstick aims to offers an easy to modify user experiences for varying mobile device form factors, e.g. handsets, netbooks, tablets. User interface components are written in [QML](https://doc.qt.io/qt-6/qml-tutorial.html). Here an example of QML application: [home-example](https://github.com/robang74/lipstick-example-home).

* [device tree](https://github.com/robang74/android_device_sony_pdx201) - The device tree for the Sony Xperia 10 II

* [vendor's blobs](https://github.com/robang74/proprietary_vendor_sony_pdx201) - Vendor's proprietary blobs for Sony Xperia 10 II

* [patches by ichthyosaurus](https://github.com/robang74/sailfish-public-patch-sources) - Sources for all ichthyosaurus Sailfish OS patches

* [Waydroid packaging](https://github.com/robang74/waydroid) - Waydroid packaging for Sailfish OS

* [SailJail sandbox](https://github.com/robang74/sailjail) - SailJail is a thin Firejail wrapper and it command is used to create Sailfish OS application sandboxes

* [SailJail permissions](https://github.com/robang74/sailjail-permissions) - SailFish OS application sandboxing and permissions system built on top of FireJail.
This project enables the building of boot images for Google Android fastboot based devices.
* [mce-tools](https://github.com/robang74/mce) - mcetool command line executable to set some SailFish OS parameter about timeouts and power management.

* [advance camera](https://github.com/robang74/harbour-advanced-camera) - Advanced Camera application for SailFish OS.

* [Sony Open Telephony](https://github.com/robang74/SonyOpenTelephony) - A boot-time modem flasher for the appropriate firmware configurations for SIMs subscriptions.

* [ofono fork](https://github.com/robang74/ofono) - An oFono fork with QRTR support, the Qualcomm IPC router protocol which is used to communicate with services provided by other hardware blocks in the system.

* [connman iptables](https://github.com/robang74/sailfish-connman-plugin-iptables) - The connman plugin that provides d-bus API for controlling iptables rules. 


---

## License

Almost all the files are under MIT license or GPLv2 or v3 and the others are in the public domain. Instead, the composition of these files is protected by the GPLv3 license under the effects of the Copyright Act, title 17. U.S.C. § 101.

> Under the Copyright Act, a compilation [EdN: "composition" is used here as synonym because compilation might confuse the reader about code compiling] is defined as a "collection and assembling of preexisting materials or of data [EdN: source code, as well] that are selected in such a way that the resulting work as a whole constitutes an original work of authorship."

This means that everyone can use a single MIT licensed file or a part of it under the MIT license terms. Instead, using two of them or two parts of them implies that you are using a subset of this collection. Thus a derived work of this collection which is licensed under the GPLv3 also.

The GPLv3 license applies to the composition unless you are the original copyright owner or the author of a specific unmodified file. This means that every one that can legally claim rights about the original files maintains its rights, obviously. So, it should not need to complain with the GPLv3 license applied to the composition. Unless, the composition is adopted for the part which had not the rights, before.

Some pages, documents, software or firmare components can make an exception to the above general approch due to their specific copyright and license restriction. In doubt follow the thumb rule of the fair use. Here a list of them: 

* Vendor's proprietary blobs for Sony Xperia 10 II (github repository)

For further information or requests about licensing and how to obtain your own business-like fork, please write to the project maintainer:

* [Roberto A. Foglietta](roberto.foglietta@gmail.com)

Have fun! <3 
