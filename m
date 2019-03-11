Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD302230D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfCKNby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:31:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYeV3-1hXm7o3pRr-00Vhhw for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:27 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 003/114] drivers: input: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:15 +0100
Message-Id: <1552310346-7629-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:gVd7Z+s2o4jEpLuMSsh7OjrZ6t5x+m6KEEx2CKmSUpTJERBjQsJ
 o7gYIx/MAqrjlMcdn4a455tpRAlKSgoeaQ3QZwYoHuZaVU+D5xpDgAh9l7XE2PNXWdrnQMQ
 tt6flQ0ysdKP87vjiuc569VkRhHy+Hmm6JOtqF6c6WS/3paNMMaJa4NM9Q7bQPgo+iX7lwh
 thUeXfbN82tybSwLnJqZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7UKv2rJSYv8=:DPcrT0Gtbwib+0n//MoyJR
 2lFopdeUP/L/NuuKV5LV/kz3yddYx5AMIJ5pV6ygCH2wieaq3ZtR0Fh9lT/QToHmxCt7cEE5v
 8Z7MOTq1dL9rq8qoOKZ84AC/EV389hFAJOMu2FTjzKj32vO/fGiIeDHYi5OngHWmU2CZuTEiy
 V5qJFix0VXk54DkRs8bKKwoYmb+RyIq3JlrJmnU9IixwY4Xw74lAfTHB3LqHV7vbwdHDAp+uT
 lKDuDvukJSUmelcrFZ3o/exHxAS1uHY94xwXTc1s9bIpTyqcpl/gzbSGNk/JZCcjcKFB8WZTq
 urpqUD6Tazfh+KqMVpzeJPRKnk06c3btHB/ThWuczn6kNtiyDv2QFBA9PMf8WH81qOONRb+5H
 SmZUbaaZwKtSHbwnBg7JxMWtN6fIEgyo3NmOb82Y7p1VXh0BK6jRUnRokhZFTpgPUu3r25CJY
 xXSYfFa3+it1O7jKGd4gp3ZEKldybhuW9zf9t2WonE+c4I891K3/HgfQ+ZPfWaNl+ouVN8PbU
 xhVe43IwwnJOBxalhNxFw9/aJIVeCCC1Hv+QcafJbFRRNXIruuw8BO4cn4n+7v6i+CUKuIh1Y
 znqFvna8uz88KOqq662fdVGSSFhwopl330cj8SIKcRZQRv+bx78tDSkMxIpSGOataLudtNgWP
 h695UU0VW3yfYCn/X+A7HSedRvdHt3y/o1kVnc4Hnlduvd4hFZJ5tK+irGTLztm/MldlTzONS
 Vw5hmyUFCPeOPVRLMB0nh0egZoGVSF/oNxMOsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

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
index 279fb02..9cf3bac 100644
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

