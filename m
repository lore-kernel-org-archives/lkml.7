Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D1CC33C9C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE4C208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306486;
	bh=Yw0ufUfHulq2vo62DxjQC9ecbJjIe6mu7X7ZCdJA4Kw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OTbBwaxLB4l27A4YK5xYsCO5j6tBq6OlW1x6es2ZIw7Xw7uBXfAdbf1g1vS9ZYhi+
	 ZgIzkQsUapwLwdd+Ufn72Lj/2QlDWKm/Ue0IdF3ktRjEdt6L+UI5C9BbHxy+GbgxWa
	 wv04ZnW4B7ErxDYRRJNhGoyzXyW9oKiJ1o09Iglo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKUDVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUDVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:21:19 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7DAF208D4;
        Thu, 21 Nov 2019 03:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306478;
        bh=Yw0ufUfHulq2vo62DxjQC9ecbJjIe6mu7X7ZCdJA4Kw=;
        h=From:To:Cc:Subject:Date:From;
        b=ndIRK9KtLvVPbG5pQPibGSA8dHAvfqMJV2UKRIDk8AsHjG7VhEtRK77HO3dmPcecV
         c1meTyTSBZK6lAcuAsXky0SYv+a649ySRKcm9dyo0ZbinDZaek0VdSIspdBBQf0Rqv
         drtXz2EX/OgBKBhqLNBiYze4erNKdxHXSdpINttA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:21:14 +0100
Message-Id: <1574306475-11966-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/platform/x86/Kconfig | 174 +++++++++++++++++++++----------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 27d5b40fb717..e1892d2a07d2 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -28,7 +28,7 @@ config ACER_WMI
 	depends on ACPI_WMI
 	select INPUT_SPARSEKMAP
 	# Acer WMI depends on ACPI_VIDEO when ACPI is enabled
-        select ACPI_VIDEO if ACPI
+	select ACPI_VIDEO if ACPI
 	---help---
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
 	  wireless radio and bluetooth control, and on some laptops,
@@ -38,18 +38,18 @@ config ACER_WMI
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
@@ -79,10 +79,10 @@ config ALIENWARE_WMI
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
@@ -134,10 +134,10 @@ config DELL_SMBIOS
 	depends on DCDBAS || DCDBAS=n
 	depends on ACPI_WMI || ACPI_WMI=n
 	---help---
-	This provides support for the Dell SMBIOS calling interface.
-	If you have a Dell computer you should enable this option.
+	  This provides support for the Dell SMBIOS calling interface.
+	  If you have a Dell computer you should enable this option.
 
-	Be sure to select at least one backend for it to work properly.
+	  Be sure to select at least one backend for it to work properly.
 
 config DELL_SMBIOS_WMI
 	bool "Dell SMBIOS driver WMI backend"
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
@@ -180,8 +180,8 @@ config DELL_LAPTOP
 	select LEDS_TRIGGERS
 	select LEDS_TRIGGER_AUDIO
 	---help---
-	This driver adds support for rfkill and backlight control to Dell
-	laptops (except for some models covered by the Compal driver).
+	  This driver adds support for rfkill and backlight control to Dell
+	  laptops (except for some models covered by the Compal driver).
 
 config DELL_WMI
 	tristate "Dell WMI notifications"
@@ -254,11 +254,11 @@ config DELL_RBU
 	select FW_LOADER
 	select FW_LOADER_USER_HELPER
 	help
-	 Say m if you want to have the option of updating the BIOS for your
-	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
-	 supporting application to communicate with the BIOS regarding the new
-	 image for the image update to take effect.
-	 See <file:Documentation/admin-guide/dell_rbu.rst> for more details on the driver.
+	  Say m if you want to have the option of updating the BIOS for your
+	  DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
+	  supporting application to communicate with the BIOS regarding the new
+	  image for the image update to take effect.
+	  See <file:Documentation/admin-guide/dell_rbu.rst> for more details on the driver.
 
 
 config FUJITSU_LAPTOP
@@ -281,21 +281,21 @@ config FUJITSU_LAPTOP
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
+	   * Lifebook P1510/P1610/P1620/Txxxx
+	   * Stylistic ST5xxx
+	   * Possibly other Fujitsu tablet models
 
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
@@ -350,11 +350,11 @@ config HP_WIRELESS
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
@@ -363,11 +363,11 @@ config HP_WMI
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
@@ -377,11 +377,11 @@ config LG_LAPTOP
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
@@ -795,17 +795,17 @@ config MSI_WMI
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
 	depends on ACPI_WMI
 	depends on INPUT
 	help
-	 Say Y here if you want to support WMI-based hotkeys on PEAQ 2-in-1s.
+	  Say Y here if you want to support WMI-based hotkeys on PEAQ 2-in-1s.
 
 config TOPSTAR_LAPTOP
 	tristate "Topstar Laptop Extras"
@@ -1012,11 +1012,11 @@ config INTEL_MID_POWER_BUTTON
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
@@ -1071,17 +1071,17 @@ config IBM_RTL
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
@@ -1120,10 +1120,10 @@ config SAMSUNG_LAPTOP
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
@@ -1158,7 +1158,7 @@ config APPLE_GMUX
 	  control is supported by the driver.
 
 config INTEL_RST
-        tristate "Intel Rapid Start Technology Driver"
+	tristate "Intel Rapid Start Technology Driver"
 	depends on ACPI
 	---help---
 	  This driver provides support for modifying paramaters on systems
@@ -1170,7 +1170,7 @@ config INTEL_RST
 	  as usual.
 
 config INTEL_SMARTCONNECT
-        tristate "Intel Smart Connect disabling driver"
+	tristate "Intel Smart Connect disabling driver"
 	depends on ACPI
 	---help---
 	  Intel Smart Connect is a technology intended to permit devices to
@@ -1355,6 +1355,6 @@ config SYSTEM76_ACPI
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
-       def_bool y
-       depends on PCI
-       select COMMON_CLK
+	def_bool y
+	depends on PCI
+	select COMMON_CLK
-- 
2.7.4

