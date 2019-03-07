Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3BA20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCGBu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:50:27 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:40121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCGBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:50:24 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrOq7-1ghjMx4BNP-00oX59; Thu, 07 Mar 2019 02:50:21 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH v2] drivers: input: Kconfig: pedantic formatting
Date:   Thu,  7 Mar 2019 02:50:12 +0100
Message-Id: <1551923412-7174-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551923412-7174-1-git-send-email-info@metux.net>
References: <1551898105-17927-1-git-send-email-info@metux.net>
 <1551923412-7174-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:TnTqRhUeqgicRjtUyLwt6PBoacNC2bLAZT7c7ifpcV2j9Wx+jPj
 LReZ4EqjZ4DpMM8kpuc9TBqLUFeCIsGxNe1LGiN9i4qDXUodr72fCc7/39u5dkHgkskJw+f
 zt7rOqVSg3JRzIq5QKLJ1hZ26oUpF5CZF0uSDI20dhjQeJMVo1i4u+eJIxywyoOSh7xZ0t/
 fVrqjQtICElpdsEhwV5vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r58Gt+m8Pr0=:qmkfQcDPPGgLXy/atwCy1W
 EcqToUJXjiVU7mYo7btnV+0V5NiViYIkGFF3qn1LwKVpoC0yN+Z9npFmcCyG3vsFXBUXQmAt0
 EJ8/tktZm8sJmvwDYFhpKcblf2cE9KPkYUz0vFNCpug5PrwD8DUh8/RKKJgb7BlgfxQKn2Skj
 X6RcqrBnzNSxNzID98qROQv3MXYrk+jlI6zXA9FPQkHmXBNb2wbN/40BhHPnK2ZO3WCdi9nmw
 3bXbkf/3u5zqsAvLIm5gwXoa8SqQS5956Q4Ih65WU/JrIZfMGSJ5txbx+hwycK02W5uQ3BC0T
 fuq+Ssdr5qN5rpJqzN5p4Zv/OoLLcIfJaTQroNuZ0s/U6dmnobKStG2TSm64y6jLHw8Tl5mwG
 ffxCJBSR82NSNb1S8I/eVRTX/8m3+3R/IsnUfovEGXctkkbogAaeFPxJTVBtUGoLZ/UQ1UQwe
 Ng3E5ZV1E57slEKEXSCDk1BDC7LPOPn3YkS5Q+9zJXbZQVvzHOE5+FARNQZ4SPM22Ivob7vme
 4PN7G3LTggMVHB/Dd3JhR5wwJI36niD/e4IV/VAlBvPTTn72Zo3WGi5kWvoXh7ikcDHgMRq/f
 71Ba1wbjwtVsuxOpssHLO4Xq3yIDuJ9ordeJ0JSC1lMSug4Pw3apmeUaKONHBY+aiDWYGnm8r
 E69Df8KUHYCPIOcA9E0Q6ZgnxUFMkt5VNr4wCRoF+ClwWFv9ho2FRFs3jNSpMv0VGdr/GBI80
 ysA7rKYyGt810iWhlqBPqPw8xPsZ10UpqfcR3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/Kconfig    | 16 ++++++++--------
 drivers/input/misc/Kconfig        | 26 +++++++++++++-------------
 drivers/input/mouse/Kconfig       | 26 +++++++++++++-------------
 drivers/input/serio/Kconfig       |  2 +-
 drivers/input/tablet/Kconfig      | 20 ++++++++++----------
 drivers/input/touchscreen/Kconfig |  2 +-
 6 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a878351..ef39f5c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -138,14 +138,14 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
 	  left-hand column.
 
 config KEYBOARD_QT1070
-       tristate "Atmel AT42QT1070 Touch Sensor Chip"
-       depends on I2C
-       help
-         Say Y here if you want to use Atmel AT42QT1070 QTouch
-         Sensor chip as input device.
-
-         To compile this driver as a module, choose M here:
-         the module will be called qt1070
+	tristate "Atmel AT42QT1070 Touch Sensor Chip"
+	depends on I2C
+	help
+	  Say Y here if you want to use Atmel AT42QT1070 QTouch
+	  Sensor chip as input device.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called qt1070
 
 config KEYBOARD_QT2160
 	tristate "Atmel AT42QT2160 Touch Sensor Chip"
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

