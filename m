Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA19C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22742063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfCFSs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:48:29 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfCFSs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:48:29 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N32y5-1gwcid3kDd-013Osu; Wed, 06 Mar 2019 19:48:26 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH] drivers: input: Kconfig: pedantic claenups
Date:   Wed,  6 Mar 2019 19:48:25 +0100
Message-Id: <1551898105-17927-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:oMMcBcO3CEjzMnFlxGDcrHN+opJcEYKUkzzPYJG6Gju3b1f/Vl0
 vqqnF6Y/5Eh1M6eApEo4QNnScVhZbMV+rWuZ9VZA4TU3u0LZFBNDACl1ajp5rsC0g/I4F8o
 F/+Jeh4e2sm03qg3kc+1VaSU24XsWWAgQ6ITI+9Ds2c1O09vwXd1lV1mfunMt4huzqusHg1
 /b8ti6+KWYDkko1G/WGUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4R3wsB8m/g=:q9tQ6XrsbSKHym7Wss4xMQ
 M1zJbkaMnXCQmiGd895FRgP5rvxoPjK83PDWTU4e4ZZ4y+x1E20RCPf10HEImon9nNfAAFc8P
 r8pm70VieVB2UunCQqEG7E6dX4fWxBESgYaAVBpZXXIT25zSkwDOLHJvNIKr8ZTY6zsXy7I7D
 MPdWibv0MSnKLvzF8nRnIXhHwUx5aAnCz9ZsEl0iF/FGYt1yPLPSjaFXaW+mRvpIs+YL4h9Sl
 SWLNs1KxL2Hw8gatiTAj3fiqjyRwzKOTcbDgIoh4aTCAiChK8HUfHFuvpIZ0gYAKv7mOUXdaD
 cZmNMviEqwYA/GWU2WaAm54bJmfmdhBkEqpPn+agV9JAdOTYT7Wi6RyBMahF5rAZowyMDy2Em
 eoxp8xy0IXz6Nf1gM27Ejl84qzbEebiwMdN5kT6OGy89Ddrf4PMyDhkdYyvFoOJbHh9NTaD/L
 3ltFnfq86khDNSrguJRUG5fnozFTY4g1llNBdNbIFuGNkYC8+sV0P0KtQpjfG30jM1Qgct9nT
 7GitibyIK6cpqRf+MqhiWVOJuTEfy0hmu9Lqlxkr943hLIb+KlcQIta3hU8yhz6IXM+EmGOuf
 PQgKY/Hl89NKvu+WzvtDCi972xY1+W3dAWwAdhikU8lB8P72vEnPj/rYedHFf/kYiDtvlPUyg
 Z8F8g4swz2HmMvezLf32Yrgof0pdJcd1Yi1h3Z7ZzrlEhrUWJwfrp2cm3venAZuxXS2HiO63P
 FIdhIhPFeYH0bo+Sy7X2orbXdv1c1KazBa+dTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/misc/Kconfig        | 26 +++++++++++++-------------
 drivers/input/mouse/Kconfig       | 26 +++++++++++++-------------
 drivers/input/serio/Kconfig       |  2 +-
 drivers/input/tablet/Kconfig      | 20 ++++++++++----------
 drivers/input/touchscreen/Kconfig |  2 +-
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2b..0ffafc0 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -240,13 +240,13 @@ config INPUT_APANEL
 	select INPUT_POLLDEV
 	select CHECK_SIGNATURE
 	help
-	 Say Y here for support of the Application Panel buttons, used on
-	 Fujitsu Lifebook. These are attached to the mainboard through
-	 an SMBus interface managed by the I2C Intel ICH (i801) driver,
-	 which you should also build for this kernel.
+	  Say Y here for support of the Application Panel buttons, used on
+	  Fujitsu Lifebook. These are attached to the mainboard through
+	  an SMBus interface managed by the I2C Intel ICH (i801) driver,
+	  which you should also build for this kernel.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called apanel.
+	  To compile this driver as a module, choose M here: the module will
+	  be called apanel.
 
 config INPUT_GP2A
 	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
@@ -273,12 +273,12 @@ config INPUT_GPIO_DECODER
 	depends on GPIOLIB || COMPILE_TEST
 	select INPUT_POLLDEV
 	help
-	 Say Y here if you want driver to read status of multiple GPIO
-	 lines and report the encoded value as an absolute integer to
-	 input subsystem.
+	  Say Y here if you want driver to read status of multiple GPIO
+	  lines and report the encoded value as an absolute integer to
+	  input subsystem.
 
-	 To compile this driver as a module, choose M here: the module
-	 will be called gpio_decoder.
+	  To compile this driver as a module, choose M here: the module
+	  will be called gpio_decoder.
 
 config INPUT_IXP4XX_BEEPER
 	tristate "IXP4XX Beeper support"
@@ -543,8 +543,8 @@ config INPUT_PCF50633_PMU
 	tristate "PCF50633 PMU events"
 	depends on MFD_PCF50633
 	help
-	 Say Y to include support for delivering  PMU events via  input
-	 layer on NXP PCF50633.
+	  Say Y to include support for delivering  PMU events via  input
+	  layer on NXP PCF50633.
 
 config INPUT_PCF8574
 	tristate "PCF8574 Keypad input device"
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 566a1e3..8b7a7e0 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -91,14 +91,14 @@ config MOUSE_PS2_SYNAPTICS_SMBUS
 	  If unsure, say Y.
 
 config MOUSE_PS2_CYPRESS
-       bool "Cypress PS/2 mouse protocol extension" if EXPERT
-       default y
-       depends on MOUSE_PS2
-       help
-         Say Y here if you have a Cypress PS/2 Trackpad connected to
-         your system.
+	bool "Cypress PS/2 mouse protocol extension" if EXPERT
+	default y
+	depends on MOUSE_PS2
+	help
+	  Say Y here if you have a Cypress PS/2 Trackpad connected to
+	  your system.
 
-         If unsure, say Y.
+	  If unsure, say Y.
 
 config MOUSE_PS2_LIFEBOOK
 	bool "Fujitsu Lifebook PS/2 mouse protocol extension" if EXPERT
@@ -285,19 +285,19 @@ config MOUSE_ELAN_I2C_I2C
 	depends on MOUSE_ELAN_I2C
 	default y
 	help
-	   Say Y here if Elan Touchpad in your system is connected to
-	   a standard I2C controller.
+	  Say Y here if Elan Touchpad in your system is connected to
+	  a standard I2C controller.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
 config MOUSE_ELAN_I2C_SMBUS
 	bool "Enable SMbus support"
 	depends on MOUSE_ELAN_I2C
 	help
-	   Say Y here if Elan Touchpad in your system is connected to
-	   a SMbus adapter.
+	  Say Y here if Elan Touchpad in your system is connected to
+	  a SMbus adapter.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
 config MOUSE_INPORT
 	tristate "InPort/MS/ATIXL busmouse"
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index c9c7224..b29cb49 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -7,7 +7,7 @@ config SERIO
 	help
 	  Say Yes here if you have any input device that uses serial I/O to
 	  communicate with the system. This includes the
-	  		* standard AT keyboard and PS/2 mouse *
+	                * standard AT keyboard and PS/2 mouse *
 	  as well as serial mice, Sun keyboards, some joysticks and 6dof
 	  devices and more.
 
diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
index a2b9f97..df427d1 100644
--- a/drivers/input/tablet/Kconfig
+++ b/drivers/input/tablet/Kconfig
@@ -38,16 +38,16 @@ config TABLET_USB_AIPTEK
 	  module will be called aiptek.
 
 config TABLET_USB_GTCO
-        tristate "GTCO CalComp/InterWrite USB Support"
-        depends on USB && INPUT
-        help
-          Say Y here if you want to use the USB version of the GTCO
-          CalComp/InterWrite Tablet.  Make sure to say Y to "Mouse support"
-          (CONFIG_INPUT_MOUSEDEV) and/or "Event interface support"
-          (CONFIG_INPUT_EVDEV) as well.
-
-          To compile this driver as a module, choose M here: the
-          module will be called gtco.
+	tristate "GTCO CalComp/InterWrite USB Support"
+	depends on USB && INPUT
+	help
+	  Say Y here if you want to use the USB version of the GTCO
+	  CalComp/InterWrite Tablet.  Make sure to say Y to "Mouse support"
+	  (CONFIG_INPUT_MOUSEDEV) and/or "Event interface support"
+	  (CONFIG_INPUT_EVDEV) as well.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gtco.
 
 config TABLET_USB_HANWANG
 	tristate "Hanwang Art Master III tablet support (USB)"
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 068dbbc..11ca597 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -632,7 +632,7 @@ config TOUCHSCREEN_HP600
 	depends on SH_HP6XX && SH_ADC
 	help
 	  Say Y here if you have a HP Jornada 620/660/680/690 and want to
-          support the built-in touchscreen.
+	  support the built-in touchscreen.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called hp680_ts_input.
-- 
1.9.1

