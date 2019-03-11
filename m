Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5949C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA16206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbfCKN04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:56 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCKNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:37 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4bA0-1h1gwa2sTu-001i6H for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 054/114] drivers: platform: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:06 +0100
Message-Id: <1552310346-7629-55-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:NP2r1DiRoddGbD1z8wTYXKmCQg1V5TWPaEdXY9KB5Kk5/9OzgSI
 afvf5t35LvjXu1DmA0vQpfO9p5TUTo8tuMcvO9GK8LxdcX+tyzo0ul020ciCX4f5L9dJENv
 M2C+c+SI/WVFDLdNv0iJt+lSG41sUwkMTlMyNNtyolBMfxnj97XTPSDWauoXqVYWJ8C5epq
 4dSLxXYZKHNFYGYkREF/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FbIjCH+62FM=:nlhupN9EZbGiKe1EETwjr5
 pSiVoIm4AG2+TE7aMvWHIdvwqaF3n35uurxa86z6r9WBH6/kHDR4Ft/OnNo59nV9TzXZ2sTkG
 XdMcV9ivQDErfT16f/lZ60K3O5b6p6+DQs90NzTF1rBuB+60HtYH+G2IxIfmfhU8scYX4L13i
 OpImgYH/itpx7dTMxfmuwSnnTd22//rXJYxg9e3bADPqNIGK8/F/y/35pE+Kyy7FHm4OufWc5
 Hy4SLcNws1rhPv9QicsutHUKBZLswf5Ofk6ev3KYglYqrBz2JMv2q2Bd6M92e7I7NtSOIkAPS
 XnOt86L6gDbhM8GllIdxhAwSUkQuTZqfaG8t0ePr2G7Sm0wZtkWeHXZt/D4VsWrBmYAR4QFb+
 TNV3DpgDQzy04f9z6ybBrJBR4Ns9MSpE+9OrleXqspHS41dw/khbOkS8+8V6AO+nu6y26Cq+M
 RMhqfE3f6aJe2s5epy54VM8fbJHrH9s8SjGpiFbK+rhEcWzZLA/W5fCfO7aKCmhX9r/spMAxV
 Bc5kydBVeaSRD8POA4kYVPQj8+95M9Ylmsn6WDEwYvWUHLgUnIbJWaPqJR9X8wW+JK5HsGAry
 5VnEwSioMCVcHAaRNuxNCt8UKXgkhR+Lq+6xbzumale4exyyHYu4WA7z5DMo2Dx9N6bH8eW+x
 TthPV8h6Psbd+2LY1znoevVQ5qX/rOybUmmIuhykR4irSOlfs+/acf5ayqsDzKfhT4wGFRd2u
 injreOyGIoCb7gMVS0ZNnCXAUJaXA1JNIT7oxg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/platform/chrome/Kconfig |  24 +++---
 drivers/platform/x86/Kconfig    | 165 ++++++++++++++++++++--------------------
 2 files changed, 94 insertions(+), 95 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 5e2fde5..920277e 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -70,16 +70,16 @@ config CROS_EC_SPI
 	  'pre-amble' bytes before the response actually starts.
 
 config CROS_EC_LPC
-        tristate "ChromeOS Embedded Controller (LPC)"
-        depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
-        help
-          If you say Y here, you get support for talking to the ChromeOS EC
-          over an LPC bus. This uses a simple byte-level protocol with a
-          checksum. This is used for userspace access only. The kernel
-          typically has its own communication methods.
+	tristate "ChromeOS Embedded Controller (LPC)"
+	depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
+	help
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  over an LPC bus. This uses a simple byte-level protocol with a
+	  checksum. This is used for userspace access only. The kernel
+	  typically has its own communication methods.
 
-          To compile this driver as a module, choose M here: the
-          module will be called cros_ec_lpc.
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_lpc.
 
 config CROS_EC_LPC_MEC
 	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
@@ -94,9 +94,9 @@ config CROS_EC_LPC_MEC
 	  choose Y here.
 
 config CROS_EC_PROTO
-        bool
-        help
-          ChromeOS EC communication protocol helpers.
+	bool
+	help
+	  ChromeOS EC communication protocol helpers.
 
 config CROS_KBD_LED_BACKLIGHT
 	tristate "Backlight LED support for Chrome OS keyboards"
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index a1ed131..4970b3d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -27,7 +27,7 @@ config ACER_WMI
 	depends on ACPI_WMI
 	select INPUT_SPARSEKMAP
 	# Acer WMI depends on ACPI_VIDEO when ACPI is enabled
-        select ACPI_VIDEO if ACPI
+	select ACPI_VIDEO if ACPI
 	---help---
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
 	  wireless radio and bluetooth control, and on some laptops,
@@ -37,18 +37,18 @@ config ACER_WMI
 	  here.
 
 config ACER_WIRELESS
-        tristate "Acer Wireless Radio Control Driver"
-        depends on ACPI
-        depends on INPUT
-        ---help---
-          The Acer Wireless Radio Control handles the airplane mode hotkey
-          present on new Acer laptops.
+	tristate "Acer Wireless Radio Control Driver"
+	depends on ACPI
+	depends on INPUT
+	---help---
+	  The Acer Wireless Radio Control handles the airplane mode hotkey
+	  present on new Acer laptops.
 
-          Say Y or M here if you have an Acer notebook with an airplane mode
-          hotkey.
+	  Say Y or M here if you have an Acer notebook with an airplane mode
+	  hotkey.
 
-          If you choose to compile this driver as a module the module will be
-          called acer-wireless.
+	  If you choose to compile this driver as a module the module will be
+	  called acer-wireless.
 
 config ACERHDF
 	tristate "Acer Aspire One temperature and fan driver"
@@ -78,10 +78,10 @@ config ALIENWARE_WMI
 	depends on NEW_LEDS
 	depends on ACPI_WMI
 	---help---
-	 This is a driver for controlling Alienware BIOS driven
-	 features.  It exposes an interface for controlling the AlienFX
-	 zones on Alienware machines that don't contain a dedicated AlienFX
-	 USB MCU such as the X51 and X51-R2.
+	  This is a driver for controlling Alienware BIOS driven
+	  features.  It exposes an interface for controlling the AlienFX
+	  zones on Alienware machines that don't contain a dedicated AlienFX
+	  USB MCU such as the X51 and X51-R2.
 
 config ASUS_LAPTOP
 	tristate "Asus Laptop Extras"
@@ -146,12 +146,12 @@ config DELL_SMBIOS_WMI
 	select DELL_WMI_DESCRIPTOR
 	depends on DELL_SMBIOS
 	---help---
-	This provides an implementation for the Dell SMBIOS calling interface
-	communicated over ACPI-WMI.
+	  This provides an implementation for the Dell SMBIOS calling interface
+	  communicated over ACPI-WMI.
 
-	If you have a Dell computer from >2007 you should say Y here.
-	If you aren't sure and this module doesn't work for your computer
-	it just won't load.
+	  If you have a Dell computer from >2007 you should say Y here.
+	  If you aren't sure and this module doesn't work for your computer
+	  it just won't load.
 
 config DELL_SMBIOS_SMM
 	bool "Dell SMBIOS driver SMM backend"
@@ -159,12 +159,12 @@ config DELL_SMBIOS_SMM
 	depends on DCDBAS
 	depends on DELL_SMBIOS
 	---help---
-	This provides an implementation for the Dell SMBIOS calling interface
-	communicated over SMI/SMM.
+	  This provides an implementation for the Dell SMBIOS calling interface
+	  communicated over SMI/SMM.
 
-	If you have a Dell computer from <=2017 you should say Y here.
-	If you aren't sure and this module doesn't work for your computer
-	it just won't load.
+	  If you have a Dell computer from <=2017 you should say Y here.
+	  If you aren't sure and this module doesn't work for your computer
+	  it just won't load.
 
 config DELL_LAPTOP
 	tristate "Dell Laptop Extras"
@@ -254,12 +254,11 @@ config DELL_RBU
 	select FW_LOADER
 	select FW_LOADER_USER_HELPER
 	help
-	 Say m if you want to have the option of updating the BIOS for your
-	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
-	 supporting application to communicate with the BIOS regarding the new
-	 image for the image update to take effect.
-	 See <file:Documentation/dell_rbu.txt> for more details on the driver.
-
+	  Say m if you want to have the option of updating the BIOS for your
+	  DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
+	  supporting application to communicate with the BIOS regarding the new
+	  image for the image update to take effect.
+	  See <file:Documentation/dell_rbu.txt> for more details on the driver.
 
 config FUJITSU_LAPTOP
 	tristate "Fujitsu Laptop Extras"
@@ -281,21 +280,21 @@ config FUJITSU_LAPTOP
 	  If you have a Fujitsu laptop, say Y or M here.
 
 config FUJITSU_TABLET
-       tristate "Fujitsu Tablet Extras"
-       depends on ACPI
-       depends on INPUT
-       ---help---
-         This is a driver for tablets built by Fujitsu:
+	tristate "Fujitsu Tablet Extras"
+	depends on ACPI
+	depends on INPUT
+	---help---
+	  This is a driver for tablets built by Fujitsu:
 
-           * Lifebook P1510/P1610/P1620/Txxxx
-           * Stylistic ST5xxx
-           * Possibly other Fujitsu tablet models
+	  * Lifebook P1510/P1610/P1620/Txxxx
+	  * Stylistic ST5xxx
+	  * Possibly other Fujitsu tablet models
 
-         It adds support for the panel buttons, docking station detection,
-         tablet/notebook mode detection for convertible and
-         orientation detection for docked slates.
+	  It adds support for the panel buttons, docking station detection,
+	  tablet/notebook mode detection for convertible and
+	  orientation detection for docked slates.
 
-         If you have a Fujitsu convertible or slate, say Y or M here.
+	  If you have a Fujitsu convertible or slate, say Y or M here.
 
 config AMILO_RFKILL
 	tristate "Fujitsu-Siemens Amilo rfkill support"
@@ -350,11 +349,11 @@ config HP_WIRELESS
 	depends on ACPI
 	depends on INPUT
 	help
-	 This driver provides supports for new HP wireless button for Windows 8.
-	 On such systems the driver should load automatically (via ACPI alias).
+	  This driver provides supports for new HP wireless button for Windows 8.
+	  On such systems the driver should load automatically (via ACPI alias).
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called hp-wireless.
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp-wireless.
 
 config HP_WMI
 	tristate "HP WMI extras"
@@ -363,11 +362,11 @@ config HP_WMI
 	depends on RFKILL || RFKILL = n
 	select INPUT_SPARSEKMAP
 	help
-	 Say Y here if you want to support WMI-based hotkeys on HP laptops and
-	 to read data from WMI such as docking or ambient light sensor state.
+	  Say Y here if you want to support WMI-based hotkeys on HP laptops and
+	  to read data from WMI such as docking or ambient light sensor state.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called hp-wmi.
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp-wmi.
 
 config LG_LAPTOP
 	tristate "LG Laptop Extras"
@@ -377,11 +376,11 @@ config LG_LAPTOP
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	help
-	 This driver adds support for hotkeys as well as control of keyboard
-	 backlight, battery maximum charge level and various other ACPI
-	 features.
+	  This driver adds support for hotkeys as well as control of keyboard
+	  backlight, battery maximum charge level and various other ACPI
+	  features.
 
-	 If you have an LG Gram laptop, say Y or M here.
+	  If you have an LG Gram laptop, say Y or M here.
 
 config MSI_LAPTOP
 	tristate "MSI Laptop Extras"
@@ -788,10 +787,10 @@ config MSI_WMI
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
 	help
-	 Say Y here if you want to support WMI-based hotkeys on MSI laptops.
+	  Say Y here if you want to support WMI-based hotkeys on MSI laptops.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called msi-wmi.
+	  To compile this driver as a module, choose M here: the module will
+	  be called msi-wmi.
 
 config PEAQ_WMI
 	tristate "PEAQ 2-in-1 WMI hotkey driver"
@@ -799,7 +798,7 @@ config PEAQ_WMI
 	depends on INPUT
 	select INPUT_POLLDEV
 	help
-	 Say Y here if you want to support WMI-based hotkeys on PEAQ 2-in-1s.
+	  Say Y here if you want to support WMI-based hotkeys on PEAQ 2-in-1s.
 
 config TOPSTAR_LAPTOP
 	tristate "Topstar Laptop Extras"
@@ -1002,11 +1001,11 @@ config INTEL_MID_POWER_BUTTON
 	  If unsure, say N.
 
 config INTEL_MFLD_THERMAL
-       tristate "Thermal driver for Intel Medfield platform"
-       depends on MFD_INTEL_MSIC && THERMAL
-       help
-         Say Y here to enable thermal driver support for the  Intel Medfield
-         platform.
+	tristate "Thermal driver for Intel Medfield platform"
+	depends on MFD_INTEL_MSIC && THERMAL
+	help
+	  Say Y here to enable thermal driver support for the  Intel Medfield
+	  platform.
 
 config INTEL_IPS
 	tristate "Intel Intelligent Power Sharing"
@@ -1061,17 +1060,17 @@ config IBM_RTL
 	tristate "Device driver to enable PRTL support"
 	depends on PCI
 	---help---
-	 Enable support for IBM Premium Real Time Mode (PRTM).
-	 This module will allow you the enter and exit PRTM in the BIOS via
-	 sysfs on platforms that support this feature.  System in PRTM will
-	 not receive CPU-generated SMIs for recoverable errors.  Use of this
-	 feature without proper support may void your hardware warranty.
+	  Enable support for IBM Premium Real Time Mode (PRTM).
+	  This module will allow you the enter and exit PRTM in the BIOS via
+	  sysfs on platforms that support this feature.  System in PRTM will
+	  not receive CPU-generated SMIs for recoverable errors.  Use of this
+	  feature without proper support may void your hardware warranty.
 
-	 If the proper BIOS support is found the driver will load and create
-	 /sys/devices/system/ibm_rtl/.  The "state" variable will indicate
-	 whether or not the BIOS is in PRTM.
-	 state = 0 (BIOS SMIs on)
-	 state = 1 (BIOS SMIs off)
+	  If the proper BIOS support is found the driver will load and create
+	  /sys/devices/system/ibm_rtl/.  The "state" variable will indicate
+	  whether or not the BIOS is in PRTM.
+	  state = 0 (BIOS SMIs on)
+	  state = 1 (BIOS SMIs off)
 
 config XO1_RFKILL
 	tristate "OLPC XO-1 software RF kill switch"
@@ -1110,10 +1109,10 @@ config SAMSUNG_LAPTOP
 	  will be called samsung-laptop.
 
 config MXM_WMI
-       tristate "WMI support for MXM Laptop Graphics"
-       depends on ACPI_WMI
-       ---help---
-          MXM is a standard for laptop graphics cards, the WMI interface
+	tristate "WMI support for MXM Laptop Graphics"
+	depends on ACPI_WMI
+	---help---
+	  MXM is a standard for laptop graphics cards, the WMI interface
 	  is required for switchable nvidia graphics machines
 
 config INTEL_OAKTRAIL
@@ -1149,7 +1148,7 @@ config APPLE_GMUX
 	  control is supported by the driver.
 
 config INTEL_RST
-        tristate "Intel Rapid Start Technology Driver"
+	tristate "Intel Rapid Start Technology Driver"
 	depends on ACPI
 	---help---
 	  This driver provides support for modifying paramaters on systems
@@ -1161,7 +1160,7 @@ config INTEL_RST
 	  as usual.
 
 config INTEL_SMARTCONNECT
-        tristate "Intel Smart Connect disabling driver"
+	tristate "Intel Smart Connect disabling driver"
 	depends on ACPI
 	---help---
 	  Intel Smart Connect is a technology intended to permit devices to
@@ -1320,6 +1319,6 @@ config PCENGINES_APU2
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
-       def_bool y
-       depends on PCI
-       select COMMON_CLK
+	def_bool y
+	depends on PCI
+	select COMMON_CLK
-- 
1.9.1

