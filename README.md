# RedFish OS

```diff
+ Refactoring SailFish OS 4.5.0.21 while it is running on a Sony Xperia 10 II smartphone.
```

> :warning: **Warning**
> 
> despite the same name this project is **NOT** related to this one: [RedFishOS by Richard Guerci](https://redfish.github.io/redfish-os/).

Support for other smartphones like Sony Xperia 10 III or IV, Gigaset GS5 and its variants in particular the Rephone, can be added as far as concrete support will be specifically received. While the support for open hardware platforms like Pine64 or Librem smartphones can be added depending on the availability of developers and maintainers.

---

### Fund raising

As much as you are interested in this project, you can concretely support a specific task or just provide a free donation.

* [PayPal.me](https://www.paypal.com/paypalme/rfoglietta) to Roberto Foglietta aka @rfoglietta on PayPal Me platform
* [Donation Form](https://tinyurl.com/robang74) to Roberto Foglietta aka @robang74 on PayPal Italia

Roberto Foglietta is the document-id real persona name behind on-line `Roberto A. Foglietta` authorship brand, usually presented as:

```
(C) 2023, Roberto A. Foglietta <roberto.foglietta@gmail.com>
```

in the files headers, in the Change Logs, in the documents authorship or referal sections, on the websites footers, etc.

> :information_source: **Note**
> 
> The report of activities and related proof of expenses will be submitted to those contributed, only. On a regular basis: monthly, quarterly or yearly depending on the amount of support. Those nominative reports will be sent with the friendly clause to not publicly disclose those data before three years the date of the report.

---

### About SFOS refactoring

> :information_source: **Disclaimer**
>
> Since the beginning, the first stage has been planned in such a way to put RFOS in the most independent position from Jolla Oy, not necessarily against their interests or their profit opportunities. This is because there is no reason to depend on a private company or at least as little as possible, as short as possible. An approach that is good for the SFOS community also because it brings more freedom for everyone wishing to continue using the apps developed for SFOS. Therefore this project is **not** directly related to Jolla Oy nor with **any** of its business affiliates.

Refactoring the SFOS is the main aim of this project and therefore it deserves a [dedicated page](forum/todo/sailfishos-refactoring-begins.md), in brief the list of macro-activities for the **first stage**:

* 1.1. a recovery boot mode always available on-demand at users request or automatically when the system is badly bricked;

* 1.2. a system patch manager that can un/apply persistent patches on the root filesystem for system services configuration;

* 1.3. a early-boot backup/restore scripts suite with the related after-flashing system configuration shell script.
  
Without these facilities fully working, there is no reasonable chance to operate in a traceable and efficient way at OS level.

<sup>________</sup>

The **second stage** of the refactoring process can be divided in few other macro-activities:

* 2.1. using the recovery image to create a basic root filesystem from scratch based on full features busybox;

* 2.2. including an advanced RPM tool like `yum` in order to leverage the CentOS 8 and Fedora 8 repositories to install a set of packages that will create a fully working root filesystem back-compatible with the last available version (4.5.0.21) of SaiFish OS;

* 2.3. adding on the top of the RedFish OS the Jolla software layer related to the graphics UI, apps markets and the Alien Dalvik support (optional) in order to provide a fully back-compatibility system, at least for the most significant SFOS apps currently available.

<sup>________</sup>

Regarding the **third stage**, the agenda is still not fully defined but these macro-activities should be accounted:

* 3.1. about the Jolla software layer, considering that `devel-su` and partially `silica` are closed source proprietary software which cannot be further developed, customised, bug-fixed and adapted/ported without the support of Jolla Oy a SWOT analysis needs to be conducted in order to evaluate alternatives which can reasonable support the apps developed for SFOS with a {zero, minimal, automatic} adaptation.

  > :information_source: **Note**
  >
  > Thanks to Jonas Karlsson aka @Mohjive, [Glacier](https://nemomobile.net/glacier-home/) has been identified as an alternative UI which has not been evaluated, yet.

* 3.2. about the support for Android apps a SWOT analysis needs to be conducted in order to evaluate alternatives to Alien Dalvik + MicroG and their effective impact in separating the RedFish OS from the SailFish OS user experience, as little as possible and for the better as much as possible.

  > :information_source: **Note**
  >
  > Some SFOS end-users reported that [WayDroid](https://waydro.id/) can be a feasible alternative to Alien Dalvik but currently it is not completely supported by SFOS which seems reasonable considering that SFOS is bounded with Alien Dalvik (included in the per-users-per-device paying license) and SFOS runs on a customised root filesystem which may imply a sort of adaptation / integration for WayDroid smooth functioning.

* 3.3. about the [SailJail](https://github.com/sailfishos/sailjail) based on [FireJail](https://github.com/netblue30/firejail) approach to constraint the apps privileges and user approval for accessing the hardware functionalities a SWOT analysis needs to be conducted in order to evaluate a less work-intensive alternative.

  > :information_source: **Note**
  >
  > At the moment, a SFOS app to be compliant with SailJail needs to use a limited set of API validated by Jolla. This approach has two great shortcomings which are quite obvious: a. the app developers are supposed to collaborate in keeping SFOS secure and end-users data private and b. the API validation is a skilled work intensive task that requires continuous or frequent updates, as frequently updates as the apps market grows. It is crystal clear that this design cannot scale up in any profitable nor sustainable way.

<sup>________</sup>

Finally the **fourth stage** will be about:

* 4.1. developing and testing alternatives to every closed source software running on top of RedFish OS; 

* 4.2. granting a good enough bug-free maturity level starting from the OS level up to the apps level;

* 4.3. moving in the direction to emancipate the hardware support from binary proprietary closed-source firmware and blobs mainly included into the AOSP trying to leverage the [DivestOS Mobile support for Sony smartphones](https://divestos.org/pages/devices):

  * [Sony Xperia XA2 and XA2 Ultra](https://www.gsmarena.com/compare.php3?idPhone1=8986&idPhone2=8985) (sony legacy, jolla supported)

  * [Sony Xperia 10 and 10 plus](https://www.gsmarena.com/compare.php3?&idPhone1=9353&idPhone2=9591) (sony legacy, jolla supported)

  * [Sony Xperia XZ2 and XZ3](https://www.gsmarena.com/compare.php3?idPhone1=9081&idPhone2=9232) (sony maintained)

  which unfortunately at the moment supports few [Sony Open Devices smartphones](https://developerworld.wpp.developer.sony.com/open-source/aosp-on-xperia-open-devices/get-started/supported-devices-and-functionality/) and not the most recent [officially supported by Jolla SailFish OS](https://shop.jolla.com/).

As you can read the first stage is well defined in its aims and partially completed while the others progressively less and less granularly defined. As usual in modern project management best practices, the further stages of a product development will be completely defined when the previous will be completed. Moreover, some tasks can be moved from the current stage to the next if a scope change or integration need will arise. In the moment that some people will join the developing team, a project management tool will be used.

---

### About SailFish OS

> :warning: **Warning**
> 
> __Warning__: the SailFish OS is **not** *open source* **nor** *software libre* but largely based on several FOSS projects.

* [SailFish OS on Wikipedia](https://en.wikipedia.org/wiki/Sailfish_OS)

Therefore it cannot be *almost* redistributed AS-IS even if can be downloaded for free (gratis) from the Jolla Shop:  

* [Jolla SailFish OS shop](https://shop.jolla.com/) for downloading the image
* [Jolla how to flash SFOS with Linux](https://jolla.com/how-to-install-sailfish-x-on-xperia-10-ii-on-linux/) or its [backup](./Jolla)
* [SailFish OS official documentation](https://docs.sailfishos.org/) or its [mirror](https://github.com/robang74/docs.sailfishos.org)
* [SailFish OS official website](https://sailfishos.org/)

The paid licensed version adds the support for Android apps integrating the proprietary [Alien Dalvik](https://en.wikipedia.org/wiki/Dalvik_Turbo_virtual_machine) middle-ware framework plus some other features like the support for Microsoft Exchange. Instead, the zero-budget version is supported by the SFOS community:

* [Community Forum](https://forum.sailfishos.org/)
* [Community apps repository](https://sailfish.openrepos.net/)
* [Patch Manager Web Catalog](http://coderus.openrepos.net/pm2/)
* [Patches by robang74](patches/README.md)

Few components in SailFish OS are proprietary and the package downloaded from Jolla shop contains such proprietary software and vendor firmware. While the framework to build the images is an open source project:

* [MER project Wiki page](https://wiki.merproject.org/wiki/Main_Page)

Some other proprietary software and vendor firmwares came from Sony Open Device AOSP. Instead, the boot images are compositions of binaries from open source and software libre projects, only. Therefore the boot images can be freely redistributed as long as those redistributing them fulfil the FOSS licenses obligations related to that binaries. 

> :information_source: **Note**
>
> In case you wish to redistribute the SFOS images, the alternative to fulfill by yourself those obligations is to link this page which one of the aims is to collect all those FOSS contributions. However, you have to check by yourself if this list of resources is complete and updated with respect to the boot image that you wish to distribute. Usually, it is not unless you have paid for it.

---

### About Xperia 10 II

The [Sony Xperia 10 II](https://www.gsmarena.com/compare.php3?idPhone1=10095&idPhone2=10698) (codename `pdx201`) is a mid-range smartphone which was announced in February 2020, released in May 2020 and included [in June 2020](https://developer.sony.com/posts/xperia-10-ii-added-to-sonys-open-devices-program/) in the [Sony Open Device program](https://developer.sony.com/open-source/aosp-on-xperia-open-devices).

---

### About Open Device program

* [ASOP on Xperia Open Devices](https://developerworld.wpp.developer.sony.com/open-source/aosp-on-xperia-open-devices)
* [Open Devices at ix5.org](https://opendevices.ix5.org)

---

### Useful documentation

* [Sony Xperia flashing guide](forum/knowhow/flashing-tools-for-Xperia-phones.md) - Some practical knowledge about flashing tools.
* [Quick First Setup Guide](forum/quick-first-setup-guide.md) - A step-by-step guide for the first setup after SFOS flashing.
* [Quick Start Guide](forum/quick-start-guide.md) - An end-users step-by-step guide for a quick start with SailFish OS.
* [SFOS install on Xperias](https://gitlab.com/Olf0/sailfishX) - A guide for installing SailFish OS on Sony Xperias by Olf0.
* [de-google](https://github.com/robang74/degoogle) - A huge list of alternatives to Google products. Privacy tips, tricks, and links.
* [Awesome SFOS](https://github.com/robang74/awesome-sailfishos) - A curated list of awesome Sailfish OS resources.
* [Equivalents in SFOS](https://github.com/robang74/equivalentsinsailfish): A list of Android apps and their Sailfish equivalents.
* [FAQ for SFOS porting guide](https://github.com/robang74/hadk-faq) - A collection of knowledge about HADK guide.
* [SFOS community forum know-how](./forum/README.md) - A collection of yet un-organised posts and documents.
* [SFOS rootfs integrity check](4.5.0.21/README.md) - An analysis about how to keep root filesystem changes under control.

---

### List of components available on Github

* [hibrys boot](https://github.com/robang74/hybris-boot) - This project enables the building of boot images for Google Android fastboot based devices.
* [yamui](https://github.com/robang74/yamui) - Yet Another Minimal UI. Tool for displaying graphical notifications in minimal environments like early boot/initrd, build-able by Github action :exclamation:
* [busybox for SFOS](https://github.com/robang74/sailfish-os-busybox) - The busybox config and RPM spec for SailFish OS, buildable by Github action :exclamation:
* [fsck.auto](https://github.com/robang74/fsck.auto) - This is a simple b/ash script for busybox fsck.auto to check block device partition file system type.
* [Patch Manager](https://github.com/robang74/patchmanager) - The Patch Manager page in Settings:System for Sailfish OS, buildable by Github action :exclamation:
* [lipstick](https://github.com/robang74/lipstick) - The lipstick aims to offer an easy to modify user experiences for varying mobile device form factors, e.g. handsets, netbooks, tablets. User interface components are written in [QML](https://doc.qt.io/qt-6/qml-tutorial.html). Here is an example of a QML application: [home example](https://github.com/robang74/lipstick-example-home). Here is another simple one with instructions: [hello world](https://github.com/robang74/hello-world-for-sailfish).
* [device tree](https://github.com/robang74/android_device_sony_pdx201) - The device tree for the Sony Xperia 10 II
* [vendor's blobs](https://github.com/robang74/proprietary_vendor_sony_pdx201) - Vendor's proprietary blobs for Sony Xperia 10 II
* [patches by ichthyosaurus](https://github.com/robang74/sailfish-public-patch-sources) - Sources for all ichthyosaurus Sailfish OS patches
* [Waydroid packaging](https://github.com/robang74/waydroid) - Waydroid packaging for Sailfish OS
* [SailJail sandbox](https://github.com/robang74/sailjail) - SailJail is a thin Firejail wrapper and it command is used to create Sailfish OS application sandboxes
* [SailJail permissions](https://github.com/robang74/sailjail-permissions) - SailFish OS application sandboxing and permissions system built on top of FireJail.This project enables the building of boot images for Google Android fastboot based devices.
* [mce-tools](https://github.com/robang74/mce) - mcetool command line executable to set some SailFish OS parameters about timeouts and power management.
* [Advanced Camera](https://github.com/robang74/harbour-advanced-camera) - Advanced Camera application for SailFish OS.
* [Sony Open Telephony](https://github.com/robang74/SonyOpenTelephony) - A boot-time modem flasher for the appropriate firmware configurations for SIMs subscriptions.
* [ofono fork](https://github.com/robang74/ofono) - An oFono fork with QRTR support, the Qualcomm IPC router protocol which is used to communicate with services provided by other hardware blocks in the system.
* [connman iptables](https://github.com/robang74/sailfish-connman-plugin-iptables) - The connman plugin that provides d-bus API for controlling iptables rules. 
* [Github actions for SFOS apps](https://github.com/robang74/github-sfos-apps-build) - Github actions for building SailFish OS apps  :exclamation:
* [SailFish OS git repositories](https://github.com/sailfishos) - A collection of 907 git repositories about SailFish OS.
* [SailFish OS git mirrors](https://github.com/sailfishos-mirror) - A collection of 517 git repository mirrors for SailFish OS.
* [SailFish OS porting](https://gitlab.com/sailfishos-porters-ci) - Gitlab page that contains several unofficial SFOS portings.

---

## License

Almost all the files are under one of many FOSS licenses and the others are in the public domain. Instead, the composition of these files is protected by the GPLv3 license under the effects of the Copyright Act, title 17. U.S.C. § 101.

> Under the Copyright Act, a compilation [EdN: "composition" is used here as synonym because compilation might confuse the technical reader about code compiling] is defined as a "collection and assembling of preexisting materials or of data [EdN: data includes source code, as well] that are selected in such a way that the resulting work as a whole constitutes an original work of authorship."

This means, for example, that everyone can use a single MIT licensed file or a part of it under the MIT license terms. Instead, using two of them or two parts of them implies that you are using a subset of this collection which is a derived work of this collection which is licensed under the GPLv3, also.

The GPLv3 license applies to the composition unless you are the original author of a specific unmodified file. This means that every one that can legally claim rights about the original files maintains its rights, obviously. Therefore the original authors do not need to undergo the GPLv3 license applied to the composition and they maintains their original right in full. Unless, they use the entire composition or a part of it for which they had not the rights, before.

Some files, documents, software or firmware components can make an exception to the above general approach due to their specific copyright and license restrictions. In doubt, follow the thumb rule of fair use. Here is a list of them:

* Vendor's proprietary blobs for Sony Xperia 10 II ([github repository fork](https://github.com/robang74/proprietary_vendor_sony_pdx201))
* Jolla's copyright backup documentation ([Jolla folder](https://github.com/robang74/redfishos/tree/main/Jolla#about-jolla-folder))

For further information or requests about licensing and how to obtain a fork suitable for your own business, please write to the project maintainer and copyleft owner:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 💙 [Roberto A. Foglietta](roberto.foglietta@gmail.com)

**Have fun!** R-
