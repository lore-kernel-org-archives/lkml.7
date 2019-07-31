Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01A8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564603767;
	bh=py4M9JlducIMWI4xOQoln8yquNJgSVWQbeoa9CGoGvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3FLvgsTfjU9P3BKYrq6+ChNXAcQ4j4/b/rJBXnbM7Q2aA8dcak6Oz6fKqLByjRVu
	 T8w8TQ6j5aS+Uyus6wnyzZa9HVS2+qc6x8GgMCFtgvhh80MW4T6i4ZLgb2U4FfEdX/
	 GjtcbR5jzn8JQk5Prvutpc0bXvuIRVt6UkuZZd+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfGaUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:09:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfGaUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ax/tYsqy0KUqm6rYJJsImsNbuFA2izTnRIbkEextaNg=; b=HMan7OGuawZWKAnKftHrCh/WLM
        QEm7fLWMO08uSP2KnYN67zntmY78JgUnQR1rsWmoeh2aUblOxFFCh3F8vlS8Z9krqe8O0J9dVMeYk
        pg5QU0+BNRX8qW4CQCkWxQCJBROAW1MOt5fXQiCykRlxGu8/xcP8hEN3aTMLeH50IzuVk/ksdyMKv
        VBUCKwzpfiEMBdO2IpRPfyWcdIGAfui78NhJ0qFo8GFmjVEYqL3BiYjYhwvAxs/A1BVxjTIlrFEf1
        ttSvO9Cvc+0KGbD41bPwyoqVZL0SJLQy6d6VFRAIcmvZBpzEGo8qklRtlGRiNfjtEK2Ty8RrXgH1K
        27zerGtw==;
Received: from [191.33.152.89] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsuu8-0007qE-Vr; Wed, 31 Jul 2019 20:08:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hsuu6-0007A1-BI; Wed, 31 Jul 2019 17:08:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH 6/6] docs: w1: convert to ReST and add to the kAPI group of docs
Date:   Wed, 31 Jul 2019 17:08:53 -0300
Message-Id: <e9c2a9f3717c0e9ea408b68c198ada62be84532d.1564603513.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564603513.git.mchehab+samsung@kernel.org>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1wire documentation was written with w1 developers in
mind, so, it makes sense to add it together with the driver-api
set.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/stable/sysfs-bus-w1         |  2 +-
 .../ABI/stable/sysfs-driver-w1_ds28e04        |  4 +-
 .../ABI/stable/sysfs-driver-w1_ds28ea00       |  2 +-
 Documentation/index.rst                       |  1 +
 Documentation/w1/index.rst                    | 21 +++++
 .../w1/masters/{ds2482 => ds2482.rst}         | 16 +++-
 .../w1/masters/{ds2490 => ds2490.rst}         |  6 +-
 Documentation/w1/masters/index.rst            | 14 +++
 Documentation/w1/masters/mxc-w1               | 12 ---
 Documentation/w1/masters/mxc-w1.rst           | 17 ++++
 .../w1/masters/{omap-hdq => omap-hdq.rst}     | 12 +--
 .../w1/masters/{w1-gpio => w1-gpio.rst}       | 21 +++--
 Documentation/w1/slaves/index.rst             | 16 ++++
 .../w1/slaves/{w1_ds2406 => w1_ds2406.rst}    |  4 +-
 .../w1/slaves/{w1_ds2413 => w1_ds2413.rst}    |  9 ++
 Documentation/w1/slaves/w1_ds2423             | 47 ----------
 Documentation/w1/slaves/w1_ds2423.rst         | 54 +++++++++++
 .../w1/slaves/{w1_ds2438 => w1_ds2438.rst}    | 10 ++-
 .../w1/slaves/{w1_ds28e04 => w1_ds28e04.rst}  |  5 ++
 .../w1/slaves/{w1_ds28e17 => w1_ds28e17.rst}  | 16 ++--
 .../w1/slaves/{w1_therm => w1_therm.rst}      | 11 ++-
 .../w1/{w1.generic => w1-generic.rst}         | 88 ++++++++++--------
 .../w1/{w1.netlink => w1-netlink.rst}         | 89 +++++++++++--------
 23 files changed, 308 insertions(+), 169 deletions(-)
 create mode 100644 Documentation/w1/index.rst
 rename Documentation/w1/masters/{ds2482 => ds2482.rst} (71%)
 rename Documentation/w1/masters/{ds2490 => ds2490.rst} (98%)
 create mode 100644 Documentation/w1/masters/index.rst
 delete mode 100644 Documentation/w1/masters/mxc-w1
 create mode 100644 Documentation/w1/masters/mxc-w1.rst
 rename Documentation/w1/masters/{omap-hdq => omap-hdq.rst} (90%)
 rename Documentation/w1/masters/{w1-gpio => w1-gpio.rst} (75%)
 create mode 100644 Documentation/w1/slaves/index.rst
 rename Documentation/w1/slaves/{w1_ds2406 => w1_ds2406.rst} (96%)
 rename Documentation/w1/slaves/{w1_ds2413 => w1_ds2413.rst} (81%)
 delete mode 100644 Documentation/w1/slaves/w1_ds2423
 create mode 100644 Documentation/w1/slaves/w1_ds2423.rst
 rename Documentation/w1/slaves/{w1_ds2438 => w1_ds2438.rst} (93%)
 rename Documentation/w1/slaves/{w1_ds28e04 => w1_ds28e04.rst} (93%)
 rename Documentation/w1/slaves/{w1_ds28e17 => w1_ds28e17.rst} (88%)
 rename Documentation/w1/slaves/{w1_therm => w1_therm.rst} (95%)
 rename Documentation/w1/{w1.generic => w1-generic.rst} (59%)
 rename Documentation/w1/{w1.netlink => w1-netlink.rst} (77%)

diff --git a/Documentation/ABI/stable/sysfs-bus-w1 b/Documentation/ABI/stable/sysfs-bus-w1
index 140d85b4ae92..992dfb183ed0 100644
--- a/Documentation/ABI/stable/sysfs-bus-w1
+++ b/Documentation/ABI/stable/sysfs-bus-w1
@@ -6,6 +6,6 @@ Description:	Bus scanning interval, microseconds component.
 		control systems are attached/generate presence for as short as
 		100 ms - hence the tens-to-hundreds milliseconds scan intervals
 		are required.
-		see Documentation/w1/w1.generic for detailed information.
+		see Documentation/w1/w1-generic.rst for detailed information.
 Users:		any user space application which wants to know bus scanning
 		interval
diff --git a/Documentation/ABI/stable/sysfs-driver-w1_ds28e04 b/Documentation/ABI/stable/sysfs-driver-w1_ds28e04
index 26579ee868c9..3e1c1fa8d54d 100644
--- a/Documentation/ABI/stable/sysfs-driver-w1_ds28e04
+++ b/Documentation/ABI/stable/sysfs-driver-w1_ds28e04
@@ -2,7 +2,7 @@ What:		/sys/bus/w1/devices/.../pio
 Date:		May 2012
 Contact:	Markus Franke <franm@hrz.tu-chemnitz.de>
 Description:	read/write the contents of the two PIO's of the DS28E04-100
-		see Documentation/w1/slaves/w1_ds28e04 for detailed information
+		see Documentation/w1/slaves/w1_ds28e04.rst for detailed information
 Users:		any user space application which wants to communicate with DS28E04-100
 
 
@@ -11,5 +11,5 @@ What:		/sys/bus/w1/devices/.../eeprom
 Date:		May 2012
 Contact:	Markus Franke <franm@hrz.tu-chemnitz.de>
 Description:	read/write the contents of the EEPROM memory of the DS28E04-100
-		see Documentation/w1/slaves/w1_ds28e04 for detailed information
+		see Documentation/w1/slaves/w1_ds28e04.rst for detailed information
 Users:		any user space application which wants to communicate with DS28E04-100
diff --git a/Documentation/ABI/stable/sysfs-driver-w1_ds28ea00 b/Documentation/ABI/stable/sysfs-driver-w1_ds28ea00
index e928def14f28..534e63731a49 100644
--- a/Documentation/ABI/stable/sysfs-driver-w1_ds28ea00
+++ b/Documentation/ABI/stable/sysfs-driver-w1_ds28ea00
@@ -2,5 +2,5 @@ What:		/sys/bus/w1/devices/.../w1_seq
 Date:		Apr 2015
 Contact:	Matt Campbell <mattrcampbell@gmail.com>
 Description:	Support for the DS28EA00 chain sequence function
-		see Documentation/w1/slaves/w1_therm for detailed information
+		see Documentation/w1/slaves/w1_therm.rst for detailed information
 Users:		any user space application which wants to communicate with DS28EA00
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 472b8abe52e9..0a564f3c336e 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -117,6 +117,7 @@ needed).
    target/index
    timers/index
    spi/index
+   w1/index
    watchdog/index
    virtual/index
    input/index
diff --git a/Documentation/w1/index.rst b/Documentation/w1/index.rst
new file mode 100644
index 000000000000..57cba81865e2
--- /dev/null
+++ b/Documentation/w1/index.rst
@@ -0,0 +1,21 @@
+. SPDX-License-Identifier: GPL-2.0
+
+================
+1-Wire Subsystem
+================
+
+.. toctree::
+   :maxdepth: 1
+
+
+   w1-generic.rst
+   w1-netlink.rst
+   masters/index
+   slaves/index
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/w1/masters/ds2482 b/Documentation/w1/masters/ds2482.rst
similarity index 71%
rename from Documentation/w1/masters/ds2482
rename to Documentation/w1/masters/ds2482.rst
index 56f8edace6ac..17ebe8f660cd 100644
--- a/Documentation/w1/masters/ds2482
+++ b/Documentation/w1/masters/ds2482.rst
@@ -1,13 +1,19 @@
+====================
 Kernel driver ds2482
 ====================
 
 Supported chips:
+
   * Maxim DS2482-100, Maxim DS2482-800
+
     Prefix: 'ds2482'
+
     Addresses scanned: None
+
     Datasheets:
-        http://datasheets.maxim-ic.com/en/ds/DS2482-100.pdf
-        http://datasheets.maxim-ic.com/en/ds/DS2482-800.pdf
+
+        - http://datasheets.maxim-ic.com/en/ds/DS2482-100.pdf
+        - http://datasheets.maxim-ic.com/en/ds/DS2482-800.pdf
 
 Author: Ben Gardner <bgardner@wabtec.com>
 
@@ -23,9 +29,11 @@ General Remarks
 ---------------
 
 Valid addresses are 0x18, 0x19, 0x1a, and 0x1b.
+
 However, the device cannot be detected without writing to the i2c bus, so no
 detection is done. You should instantiate the device explicitly.
 
-$ modprobe ds2482
-$ echo ds2482 0x18 > /sys/bus/i2c/devices/i2c-0/new_device
+::
 
+  $ modprobe ds2482
+  $ echo ds2482 0x18 > /sys/bus/i2c/devices/i2c-0/new_device
diff --git a/Documentation/w1/masters/ds2490 b/Documentation/w1/masters/ds2490.rst
similarity index 98%
rename from Documentation/w1/masters/ds2490
rename to Documentation/w1/masters/ds2490.rst
index 3e091151dd80..7e5b50f9c0f5 100644
--- a/Documentation/w1/masters/ds2490
+++ b/Documentation/w1/masters/ds2490.rst
@@ -1,7 +1,9 @@
+====================
 Kernel driver ds2490
 ====================
 
 Supported chips:
+
   * Maxim DS2490 based
 
 Author: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
@@ -18,6 +20,7 @@ which has 0x81 family ID integrated chip and DS2490
 low-level operational chip.
 
 Notes and limitations.
+
 - The weak pullup current is a minimum of 0.9mA and maximum of 6.0mA.
 - The 5V strong pullup is supported with a minimum of 5.9mA and a
   maximum of 30.4 mA.  (From DS2490.pdf)
@@ -65,4 +68,5 @@ Notes and limitations.
   reattaching would clear the problem.  usbmon output in the guest and
   host did not explain the problem.  My guess is a bug in either qemu
   or the host OS and more likely the host OS.
--- 03-06-2008 David Fries <David@Fries.net>
+
+03-06-2008 David Fries <David@Fries.net>
diff --git a/Documentation/w1/masters/index.rst b/Documentation/w1/masters/index.rst
new file mode 100644
index 000000000000..4442a98850ad
--- /dev/null
+++ b/Documentation/w1/masters/index.rst
@@ -0,0 +1,14 @@
+. SPDX-License-Identifier: GPL-2.0
+
+=====================
+1-wire Master Drivers
+=====================
+
+.. toctree::
+   :maxdepth: 1
+
+   ds2482
+   ds2490
+   mxc-w1
+   omap-hdq
+   w1-gpio
diff --git a/Documentation/w1/masters/mxc-w1 b/Documentation/w1/masters/mxc-w1
deleted file mode 100644
index 38be1ad65532..000000000000
--- a/Documentation/w1/masters/mxc-w1
+++ /dev/null
@@ -1,12 +0,0 @@
-Kernel driver mxc_w1
-====================
-
-Supported chips:
-  * Freescale MX27, MX31 and probably other i.MX SoCs
-    Datasheets:
-        http://www.freescale.com/files/32bit/doc/data_sheet/MCIMX31.pdf?fpsp=1
-	http://cache.freescale.com/files/dsp/doc/archive/MCIMX27.pdf?fsrch=1&WT_TYPE=
-	Data%20Sheets&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation
-
-Author: Originally based on Freescale code, prepared for mainline by
-	Sascha Hauer <s.hauer@pengutronix.de>
diff --git a/Documentation/w1/masters/mxc-w1.rst b/Documentation/w1/masters/mxc-w1.rst
new file mode 100644
index 000000000000..334f9893103f
--- /dev/null
+++ b/Documentation/w1/masters/mxc-w1.rst
@@ -0,0 +1,17 @@
+====================
+Kernel driver mxc_w1
+====================
+
+Supported chips:
+
+  * Freescale MX27, MX31 and probably other i.MX SoCs
+
+    Datasheets:
+
+        - http://www.freescale.com/files/32bit/doc/data_sheet/MCIMX31.pdf?fpsp=1
+	- http://cache.freescale.com/files/dsp/doc/archive/MCIMX27.pdf?fsrch=1&WT_TYPE=Data%20Sheets&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation
+
+Author:
+
+	Originally based on Freescale code, prepared for mainline by
+	Sascha Hauer <s.hauer@pengutronix.de>
diff --git a/Documentation/w1/masters/omap-hdq b/Documentation/w1/masters/omap-hdq.rst
similarity index 90%
rename from Documentation/w1/masters/omap-hdq
rename to Documentation/w1/masters/omap-hdq.rst
index 234522709a5f..345298a59e50 100644
--- a/Documentation/w1/masters/omap-hdq
+++ b/Documentation/w1/masters/omap-hdq.rst
@@ -1,9 +1,10 @@
-Kernel driver for omap HDQ/1-wire module.
+========================================
+Kernel driver for omap HDQ/1-wire module
 ========================================
 
 Supported chips:
 ================
-	HDQ/1-wire controller on the TI OMAP 2430/3430 platforms.
+HDQ/1-wire controller on the TI OMAP 2430/3430 platforms.
 
 A useful link about HDQ basics:
 ===============================
@@ -40,9 +41,10 @@ driver(drivers/w1/slaves/w1_bq27000.c) sets the ID to 1.
 Please note to load both the modules with a different ID if required, but note
 that the ID used should be same for both master and slave driver loading.
 
-e.g:
-insmod omap_hdq.ko W1_ID=2
-inamod w1_bq27000.ko F_ID=2
+e.g::
+
+  insmod omap_hdq.ko W1_ID=2
+  inamod w1_bq27000.ko F_ID=2
 
 The driver also supports 1-wire mode. In this mode, there is no need to
 pass slave ID as parameter. The driver will auto-detect slaves connected
diff --git a/Documentation/w1/masters/w1-gpio b/Documentation/w1/masters/w1-gpio.rst
similarity index 75%
rename from Documentation/w1/masters/w1-gpio
rename to Documentation/w1/masters/w1-gpio.rst
index 623961d9e83f..18fdb7366372 100644
--- a/Documentation/w1/masters/w1-gpio
+++ b/Documentation/w1/masters/w1-gpio.rst
@@ -1,3 +1,4 @@
+=====================
 Kernel driver w1-gpio
 =====================
 
@@ -16,28 +17,30 @@ Documentation/devicetree/bindings/w1/w1-gpio.txt
 Example (mach-at91)
 -------------------
 
-#include <linux/gpio/machine.h>
-#include <linux/w1-gpio.h>
+::
 
-static struct gpiod_lookup_table foo_w1_gpiod_table = {
+  #include <linux/gpio/machine.h>
+  #include <linux/w1-gpio.h>
+
+  static struct gpiod_lookup_table foo_w1_gpiod_table = {
 	.dev_id = "w1-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("at91-gpio", AT91_PIN_PB20, NULL, 0,
 			GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN),
 	},
-};
+  };
 
-static struct w1_gpio_platform_data foo_w1_gpio_pdata = {
+  static struct w1_gpio_platform_data foo_w1_gpio_pdata = {
 	.ext_pullup_enable_pin	= -EINVAL,
-};
+  };
 
-static struct platform_device foo_w1_device = {
+  static struct platform_device foo_w1_device = {
 	.name			= "w1-gpio",
 	.id			= -1,
 	.dev.platform_data	= &foo_w1_gpio_pdata,
-};
+  };
 
-...
+  ...
 	at91_set_GPIO_periph(foo_w1_gpio_pdata.pin, 1);
 	at91_set_multi_drive(foo_w1_gpio_pdata.pin, 1);
 	gpiod_add_lookup_table(&foo_w1_gpiod_table);
diff --git a/Documentation/w1/slaves/index.rst b/Documentation/w1/slaves/index.rst
new file mode 100644
index 000000000000..d0697b202f09
--- /dev/null
+++ b/Documentation/w1/slaves/index.rst
@@ -0,0 +1,16 @@
+. SPDX-License-Identifier: GPL-2.0
+
+====================
+1-wire Slave Drivers
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   w1_ds2406
+   w1_ds2413
+   w1_ds2423
+   w1_ds2438
+   w1_ds28e04
+   w1_ds28e17
+   w1_therm
diff --git a/Documentation/w1/slaves/w1_ds2406 b/Documentation/w1/slaves/w1_ds2406.rst
similarity index 96%
rename from Documentation/w1/slaves/w1_ds2406
rename to Documentation/w1/slaves/w1_ds2406.rst
index 8137fe6f6c3d..d3e68266084f 100644
--- a/Documentation/w1/slaves/w1_ds2406
+++ b/Documentation/w1/slaves/w1_ds2406.rst
@@ -1,7 +1,9 @@
+=======================
 w1_ds2406 kernel driver
 =======================
 
 Supported chips:
+
   * Maxim DS2406 (and other family 0x12) addressable switches
 
 Author: Scott Alfter <scott@alfter.us>
@@ -9,7 +11,7 @@ Author: Scott Alfter <scott@alfter.us>
 Description
 -----------
 
-The w1_ds2406 driver allows connected devices to be switched on and off. 
+The w1_ds2406 driver allows connected devices to be switched on and off.
 These chips also provide 128 bytes of OTP EPROM, but reading/writing it is
 not supported.  In TSOC-6 form, the DS2406 provides two switch outputs and
 can be provided with power on a dedicated input.  In TO-92 form, it provides
diff --git a/Documentation/w1/slaves/w1_ds2413 b/Documentation/w1/slaves/w1_ds2413.rst
similarity index 81%
rename from Documentation/w1/slaves/w1_ds2413
rename to Documentation/w1/slaves/w1_ds2413.rst
index 936263a8ccb4..c15bb5b919b7 100644
--- a/Documentation/w1/slaves/w1_ds2413
+++ b/Documentation/w1/slaves/w1_ds2413.rst
@@ -1,11 +1,16 @@
+=======================
 Kernel driver w1_ds2413
 =======================
 
 Supported chips:
+
   * Maxim DS2413 1-Wire Dual Channel Addressable Switch
 
 supported family codes:
+
+        ================        ====
         W1_FAMILY_DS2413        0x3A
+        ================        ====
 
 Author: Mariusz Bialonczyk <manio@skyboo.net>
 
@@ -20,11 +25,13 @@ Reading state
 The "state" file provides one-byte value which is in the same format as for
 the chip PIO_ACCESS_READ command (refer the datasheet for details):
 
+======== =============================================================
 Bit 0:   PIOA Pin State
 Bit 1:   PIOA Output Latch State
 Bit 2:   PIOB Pin State
 Bit 3:   PIOB Output Latch State
 Bit 4-7: Complement of Bit 3 to Bit 0 (verified by the kernel module)
+======== =============================================================
 
 This file is readonly.
 
@@ -34,9 +41,11 @@ You can set the PIO pins using the "output" file.
 It is writable, you can write one-byte value to this sysfs file.
 Similarly the byte format is the same as for the PIO_ACCESS_WRITE command:
 
+======== ======================================
 Bit 0:   PIOA
 Bit 1:   PIOB
 Bit 2-7: No matter (driver will set it to "1"s)
+======== ======================================
 
 
 The chip has some kind of basic protection against transmission errors.
diff --git a/Documentation/w1/slaves/w1_ds2423 b/Documentation/w1/slaves/w1_ds2423
deleted file mode 100644
index 3f98b505a0ee..000000000000
--- a/Documentation/w1/slaves/w1_ds2423
+++ /dev/null
@@ -1,47 +0,0 @@
-Kernel driver w1_ds2423
-=======================
-
-Supported chips:
-  * Maxim DS2423 based counter devices.
-
-supported family codes:
-	W1_THERM_DS2423	0x1D
-
-Author: Mika Laitio <lamikr@pilppa.org>
-
-Description
------------
-
-Support is provided through the sysfs w1_slave file. Each opening and
-read sequence of w1_slave file initiates the read of counters and ram
-available in DS2423 pages 12 - 15.
-
-Result of each page is provided as an ASCII output where each counter
-value and associated ram buffer is outpputed to own line.
-
-Each lines will contain the values of 42 bytes read from the counter and
-memory page along the crc=YES or NO for indicating whether the read operation
-was successful and CRC matched.
-If the operation was successful, there is also in the end of each line
-a counter value expressed as an integer after c=
-
-Meaning of 42 bytes represented is following:
- - 1 byte from ram page
- - 4 bytes for the counter value
- - 4 zero bytes
- - 2 bytes for crc16 which was calculated from the data read since the previous crc bytes
- - 31 remaining bytes from the ram page
- - crc=YES/NO indicating whether read was ok and crc matched
- - c=<int> current counter value
-
-example from the successful read:
-00 02 00 00 00 00 00 00 00 6d 38 00 ff ff 00 00 fe ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=2
-00 02 00 00 00 00 00 00 00 e0 1f 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=2
-00 29 c6 5d 18 00 00 00 00 04 37 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=408798761
-00 05 00 00 00 00 00 00 00 8d 39 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff crc=YES c=5
-
-example from the read with crc errors:
-00 02 00 00 00 00 00 00 00 6d 38 00 ff ff 00 00 fe ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=2
-00 02 00 00 22 00 00 00 00 e0 1f 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=NO
-00 e1 61 5d 19 00 00 00 00 df 0b 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=NO
-00 05 00 00 20 00 00 00 00 8d 39 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff crc=NO
diff --git a/Documentation/w1/slaves/w1_ds2423.rst b/Documentation/w1/slaves/w1_ds2423.rst
new file mode 100644
index 000000000000..755d659ad997
--- /dev/null
+++ b/Documentation/w1/slaves/w1_ds2423.rst
@@ -0,0 +1,54 @@
+Kernel driver w1_ds2423
+=======================
+
+Supported chips:
+
+  * Maxim DS2423 based counter devices.
+
+supported family codes:
+
+        ===============	====
+	W1_THERM_DS2423	0x1D
+        ===============	====
+
+Author: Mika Laitio <lamikr@pilppa.org>
+
+Description
+-----------
+
+Support is provided through the sysfs w1_slave file. Each opening and
+read sequence of w1_slave file initiates the read of counters and ram
+available in DS2423 pages 12 - 15.
+
+Result of each page is provided as an ASCII output where each counter
+value and associated ram buffer is outpputed to own line.
+
+Each lines will contain the values of 42 bytes read from the counter and
+memory page along the crc=YES or NO for indicating whether the read operation
+was successful and CRC matched.
+If the operation was successful, there is also in the end of each line
+a counter value expressed as an integer after c=
+
+Meaning of 42 bytes represented is following:
+
+ - 1 byte from ram page
+ - 4 bytes for the counter value
+ - 4 zero bytes
+ - 2 bytes for crc16 which was calculated from the data read since the previous crc bytes
+ - 31 remaining bytes from the ram page
+ - crc=YES/NO indicating whether read was ok and crc matched
+ - c=<int> current counter value
+
+example from the successful read::
+
+  00 02 00 00 00 00 00 00 00 6d 38 00 ff ff 00 00 fe ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=2
+  00 02 00 00 00 00 00 00 00 e0 1f 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=2
+  00 29 c6 5d 18 00 00 00 00 04 37 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=408798761
+  00 05 00 00 00 00 00 00 00 8d 39 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff crc=YES c=5
+
+example from the read with crc errors::
+
+  00 02 00 00 00 00 00 00 00 6d 38 00 ff ff 00 00 fe ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=YES c=2
+  00 02 00 00 22 00 00 00 00 e0 1f 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=NO
+  00 e1 61 5d 19 00 00 00 00 df 0b 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff 00 00 ff ff crc=NO
+  00 05 00 00 20 00 00 00 00 8d 39 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff crc=NO
diff --git a/Documentation/w1/slaves/w1_ds2438 b/Documentation/w1/slaves/w1_ds2438.rst
similarity index 93%
rename from Documentation/w1/slaves/w1_ds2438
rename to Documentation/w1/slaves/w1_ds2438.rst
index e64f65a09387..a29309a3f8e5 100644
--- a/Documentation/w1/slaves/w1_ds2438
+++ b/Documentation/w1/slaves/w1_ds2438.rst
@@ -2,10 +2,13 @@ Kernel driver w1_ds2438
 =======================
 
 Supported chips:
+
   * Maxim DS2438 Smart Battery Monitor
 
 supported family codes:
+        ================        ====
         W1_FAMILY_DS2438        0x26
+        ================        ====
 
 Author: Mariusz Bialonczyk <manio@skyboo.net>
 
@@ -56,8 +59,11 @@ Opening and reading this file initiates the CONVERT_V (voltage conversion)
 command of the chip.
 
 Depending on a sysfs filename a different input for the A/D will be selected:
-vad: general purpose A/D input (VAD)
-vdd: battery input (VDD)
+
+vad:
+    general purpose A/D input (VAD)
+vdd:
+    battery input (VDD)
 
 After the voltage conversion the value is returned as decimal ASCII.
 Note: To get a volts the value has to be divided by 100.
diff --git a/Documentation/w1/slaves/w1_ds28e04 b/Documentation/w1/slaves/w1_ds28e04.rst
similarity index 93%
rename from Documentation/w1/slaves/w1_ds28e04
rename to Documentation/w1/slaves/w1_ds28e04.rst
index 7819b65cfa48..b12b118890d3 100644
--- a/Documentation/w1/slaves/w1_ds28e04
+++ b/Documentation/w1/slaves/w1_ds28e04.rst
@@ -1,11 +1,16 @@
+========================
 Kernel driver w1_ds28e04
 ========================
 
 Supported chips:
+
   * Maxim DS28E04-100 4096-Bit Addressable 1-Wire EEPROM with PIO
 
 supported family codes:
+
+        =================	====
 	W1_FAMILY_DS28E04	0x1C
+        =================	====
 
 Author: Markus Franke, <franke.m@sebakmt.com> <franm@hrz.tu-chemnitz.de>
 
diff --git a/Documentation/w1/slaves/w1_ds28e17 b/Documentation/w1/slaves/w1_ds28e17.rst
similarity index 88%
rename from Documentation/w1/slaves/w1_ds28e17
rename to Documentation/w1/slaves/w1_ds28e17.rst
index 7fcfad5b4a37..e2d9f96d8f2c 100644
--- a/Documentation/w1/slaves/w1_ds28e17
+++ b/Documentation/w1/slaves/w1_ds28e17.rst
@@ -1,11 +1,16 @@
+========================
 Kernel driver w1_ds28e17
 ========================
 
 Supported chips:
+
   * Maxim DS28E17 1-Wire-to-I2C Master Bridge
 
 supported family codes:
+
+        =================  ====
 	W1_FAMILY_DS28E17  0x19
+        =================  ====
 
 Author: Jan Kandziora <jjj@gmx.de>
 
@@ -20,11 +25,11 @@ a DS28E17 can be accessed by the kernel or userspace tools as if they were
 connected to a "native" I2C bus master.
 
 
-An udev rule like the following
--------------------------------------------------------------------------------
-SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", ATTRS{name}=="w1-19-*", \
-        SYMLINK+="i2c-$attr{name}"
--------------------------------------------------------------------------------
+An udev rule like the following::
+
+  SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", ATTRS{name}=="w1-19-*", \
+          SYMLINK+="i2c-$attr{name}"
+
 may be used to create stable /dev/i2c- entries based on the unique id of the
 DS28E17 chip.
 
@@ -65,4 +70,3 @@ structure is created.
 
 
 See https://github.com/ianka/w1_ds28e17 for even more information.
-
diff --git a/Documentation/w1/slaves/w1_therm b/Documentation/w1/slaves/w1_therm.rst
similarity index 95%
rename from Documentation/w1/slaves/w1_therm
rename to Documentation/w1/slaves/w1_therm.rst
index d1f93af36f38..90531c340a07 100644
--- a/Documentation/w1/slaves/w1_therm
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -1,7 +1,9 @@
+======================
 Kernel driver w1_therm
-====================
+======================
 
 Supported chips:
+
   * Maxim ds18*20 based temperature sensors.
   * Maxim ds1825 based temperature sensors.
 
@@ -13,12 +15,16 @@ Description
 
 w1_therm provides basic temperature conversion for ds18*20 devices, and the
 ds28ea00 device.
-supported family codes:
+
+Supported family codes:
+
+====================	====
 W1_THERM_DS18S20	0x10
 W1_THERM_DS1822		0x22
 W1_THERM_DS18B20	0x28
 W1_THERM_DS1825		0x3B
 W1_THERM_DS28EA00	0x42
+====================	====
 
 Support is provided through the sysfs w1_slave file.  Each open and
 read sequence will initiate a temperature conversion then provide two
@@ -51,6 +57,7 @@ If so, it will activate the master's strong pullup.
 In case the detection of parasite devices using this command fails
 (seems to be the case with some DS18S20) the strong pullup can
 be force-enabled.
+
 If the strong pullup is enabled, the master's strong pullup will be
 driven when the conversion is taking place, provided the master driver
 does support the strong pullup (or it falls back to a pullup
diff --git a/Documentation/w1/w1.generic b/Documentation/w1/w1-generic.rst
similarity index 59%
rename from Documentation/w1/w1.generic
rename to Documentation/w1/w1-generic.rst
index c51b1ab012d0..da4e8b4e9b01 100644
--- a/Documentation/w1/w1.generic
+++ b/Documentation/w1/w1-generic.rst
@@ -1,5 +1,7 @@
-The 1-wire (w1) subsystem
-------------------------------------------------------------------
+=========================================
+Introduction to the 1-wire (w1) subsystem
+=========================================
+
 The 1-wire bus is a simple master-slave bus that communicates via a single
 signal wire (plus ground, so two wires).
 
@@ -12,14 +14,16 @@ communication with slaves.
 All w1 slave devices must be connected to a w1 bus master device.
 
 Example w1 master devices:
-    DS9490 usb device
-    W1-over-GPIO
-    DS2482 (i2c to w1 bridge)
-    Emulated devices, such as a RS232 converter, parallel port adapter, etc
+
+    - DS9490 usb device
+    - W1-over-GPIO
+    - DS2482 (i2c to w1 bridge)
+    - Emulated devices, such as a RS232 converter, parallel port adapter, etc
 
 
 What does the w1 subsystem do?
-------------------------------------------------------------------
+------------------------------
+
 When a w1 master driver registers with the w1 subsystem, the following occurs:
 
  - sysfs entries for that w1 master are created
@@ -43,24 +47,28 @@ be read, since no device was selected.
 
 
 W1 device families
-------------------------------------------------------------------
+------------------
+
 Slave devices are handled by a driver written for a family of w1 devices.
 
 A family driver populates a struct w1_family_ops (see w1_family.h) and
 registers with the w1 subsystem.
 
 Current family drivers:
-w1_therm - (ds18?20 thermal sensor family driver)
+
+w1_therm
+  - (ds18?20 thermal sensor family driver)
     provides temperature reading function which is bound to ->rbin() method
     of the above w1_family_ops structure.
 
-w1_smem - driver for simple 64bit memory cell provides ID reading method.
+w1_smem
+  - driver for simple 64bit memory cell provides ID reading method.
 
 You can call above methods by reading appropriate sysfs files.
 
 
 What does a w1 master driver need to implement?
-------------------------------------------------------------------
+-----------------------------------------------
 
 The driver for w1 bus master must provide at minimum two functions.
 
@@ -75,25 +83,26 @@ See struct w1_bus_master definition in w1.h for details.
 
 
 w1 master sysfs interface
-------------------------------------------------------------------
-<xx-xxxxxxxxxxxx>  - A directory for a found device. The format is family-serial
-bus                - (standard) symlink to the w1 bus
-driver             - (standard) symlink to the w1 driver
-w1_master_add      - (rw) manually register a slave device
-w1_master_attempts - (ro) the number of times a search was attempted
-w1_master_max_slave_count
-                   - (rw) maximum number of slaves to search for at a time
-w1_master_name     - (ro) the name of the device (w1_bus_masterX)
-w1_master_pullup   - (rw) 5V strong pullup 0 enabled, 1 disabled
-w1_master_remove   - (rw) manually remove a slave device
-w1_master_search   - (rw) the number of searches left to do,
-		     -1=continual (default)
-w1_master_slave_count
-                   - (ro) the number of slaves found
-w1_master_slaves   - (ro) the names of the slaves, one per line
-w1_master_timeout  - (ro) the delay in seconds between searches
-w1_master_timeout_us
-                   - (ro) the delay in microseconds beetwen searches
+-------------------------
+
+========================= =====================================================
+<xx-xxxxxxxxxxxx>         A directory for a found device. The format is
+                          family-serial
+bus                       (standard) symlink to the w1 bus
+driver                    (standard) symlink to the w1 driver
+w1_master_add             (rw) manually register a slave device
+w1_master_attempts        (ro) the number of times a search was attempted
+w1_master_max_slave_count (rw) maximum number of slaves to search for at a time
+w1_master_name            (ro) the name of the device (w1_bus_masterX)
+w1_master_pullup          (rw) 5V strong pullup 0 enabled, 1 disabled
+w1_master_remove          (rw) manually remove a slave device
+w1_master_search          (rw) the number of searches left to do,
+                          -1=continual (default)
+w1_master_slave_count     (ro) the number of slaves found
+w1_master_slaves          (ro) the names of the slaves, one per line
+w1_master_timeout         (ro) the delay in seconds between searches
+w1_master_timeout_us      (ro) the delay in microseconds beetwen searches
+========================= =====================================================
 
 If you have a w1 bus that never changes (you don't add or remove devices),
 you can set the module parameter search_count to a small positive number
@@ -111,11 +120,14 @@ decrements w1_master_search by 1 (down to 0) and increments
 w1_master_attempts by 1.
 
 w1 slave sysfs interface
-------------------------------------------------------------------
-bus                - (standard) symlink to the w1 bus
-driver             - (standard) symlink to the w1 driver
-name               - the device name, usually the same as the directory name
-w1_slave           - (optional) a binary file whose meaning depends on the
-                     family driver
-rw		   - (optional) created for slave devices which do not have
-		     appropriate family driver. Allows to read/write binary data.
+------------------------
+
+=================== ============================================================
+bus                 (standard) symlink to the w1 bus
+driver              (standard) symlink to the w1 driver
+name                the device name, usually the same as the directory name
+w1_slave            (optional) a binary file whose meaning depends on the
+                    family driver
+rw		    (optional) created for slave devices which do not have
+		    appropriate family driver. Allows to read/write binary data.
+=================== ============================================================
diff --git a/Documentation/w1/w1.netlink b/Documentation/w1/w1-netlink.rst
similarity index 77%
rename from Documentation/w1/w1.netlink
rename to Documentation/w1/w1-netlink.rst
index 94ad4c420828..aaa13243a5e4 100644
--- a/Documentation/w1/w1.netlink
+++ b/Documentation/w1/w1-netlink.rst
@@ -1,22 +1,26 @@
-Userspace communication protocol over connector [1].
+===============================================
+Userspace communication protocol over connector
+===============================================
 
-
-Message types.
+Message types
 =============
 
 There are three types of messages between w1 core and userspace:
+
 1. Events. They are generated each time a new master or slave device
-	is found either due to automatic or requested search.
+   is found either due to automatic or requested search.
 2. Userspace commands.
 3. Replies to userspace commands.
 
 
-Protocol.
+Protocol
 ========
 
-[struct cn_msg] - connector header.
+::
+
+  [struct cn_msg] - connector header.
 	Its length field is equal to size of the attached data
-[struct w1_netlink_msg] - w1 netlink header.
+  [struct w1_netlink_msg] - w1 netlink header.
 	__u8 type 	- message type.
 			W1_LIST_MASTERS
 				list current bus masters
@@ -40,7 +44,7 @@ Protocol.
 		} mst;
 	} id;
 
-[struct w1_netlink_cmd] - command for given master or slave device.
+  [struct w1_netlink_cmd] - command for given master or slave device.
 	__u8 cmd	- command opcode.
 			W1_CMD_READ 	- read command
 			W1_CMD_WRITE	- write command
@@ -71,18 +75,18 @@ when it is added to w1 core.
 Currently replies to userspace commands are only generated for read
 command request. One reply is generated exactly for one w1_netlink_cmd
 read request. Replies are not combined when sent - i.e. typical reply
-messages looks like the following:
+messages looks like the following::
 
-[cn_msg][w1_netlink_msg][w1_netlink_cmd]
-cn_msg.len = sizeof(struct w1_netlink_msg) +
+  [cn_msg][w1_netlink_msg][w1_netlink_cmd]
+  cn_msg.len = sizeof(struct w1_netlink_msg) +
 	     sizeof(struct w1_netlink_cmd) +
 	     cmd->len;
-w1_netlink_msg.len = sizeof(struct w1_netlink_cmd) + cmd->len;
-w1_netlink_cmd.len = cmd->len;
+  w1_netlink_msg.len = sizeof(struct w1_netlink_cmd) + cmd->len;
+  w1_netlink_cmd.len = cmd->len;
 
 Replies to W1_LIST_MASTERS should send a message back to the userspace
 which will contain list of all registered master ids in the following
-format:
+format::
 
 	cn_msg (CN_W1_IDX.CN_W1_VAL as id, len is equal to sizeof(struct
 	w1_netlink_msg) plus number of masters multiplied by 4)
@@ -90,39 +94,47 @@ format:
 		number of masters multiplied by 4 (u32 size))
 	id0 ... idN
 
-	Each message is at most 4k in size, so if number of master devices
-	exceeds this, it will be split into several messages.
+Each message is at most 4k in size, so if number of master devices
+exceeds this, it will be split into several messages.
 
 W1 search and alarm search commands.
-request:
-[cn_msg]
-  [w1_netlink_msg type = W1_MASTER_CMD
-  	id is equal to the bus master id to use for searching]
-  [w1_netlink_cmd cmd = W1_CMD_SEARCH or W1_CMD_ALARM_SEARCH]
 
-reply:
+request::
+
+  [cn_msg]
+    [w1_netlink_msg type = W1_MASTER_CMD
+	id is equal to the bus master id to use for searching]
+    [w1_netlink_cmd cmd = W1_CMD_SEARCH or W1_CMD_ALARM_SEARCH]
+
+reply::
+
   [cn_msg, ack = 1 and increasing, 0 means the last message,
-  	seq is equal to the request seq]
+	seq is equal to the request seq]
   [w1_netlink_msg type = W1_MASTER_CMD]
   [w1_netlink_cmd cmd = W1_CMD_SEARCH or W1_CMD_ALARM_SEARCH
 	len is equal to number of IDs multiplied by 8]
   [64bit-id0 ... 64bit-idN]
+
 Length in each header corresponds to the size of the data behind it, so
 w1_netlink_cmd->len = N * 8; where N is number of IDs in this message.
-	Can be zero.
-w1_netlink_msg->len = sizeof(struct w1_netlink_cmd) + N * 8;
-cn_msg->len = sizeof(struct w1_netlink_msg) +
+Can be zero.
+
+::
+
+  w1_netlink_msg->len = sizeof(struct w1_netlink_cmd) + N * 8;
+  cn_msg->len = sizeof(struct w1_netlink_msg) +
 	      sizeof(struct w1_netlink_cmd) +
 	      N*8;
 
-W1 reset command.
-[cn_msg]
-  [w1_netlink_msg type = W1_MASTER_CMD
-  	id is equal to the bus master id to use for searching]
-  [w1_netlink_cmd cmd = W1_CMD_RESET]
+W1 reset command::
 
+  [cn_msg]
+    [w1_netlink_msg type = W1_MASTER_CMD
+	id is equal to the bus master id to use for searching]
+    [w1_netlink_cmd cmd = W1_CMD_RESET]
 
-Command status replies.
+
+Command status replies
 ======================
 
 Each command (either root, master or slave with or without w1_netlink_cmd
@@ -150,7 +162,7 @@ All w1_netlink_cmd command structures are handled in every w1_netlink_msg,
 even if there were errors, only length mismatch interrupts message processing.
 
 
-Operation steps in w1 core when new command is received.
+Operation steps in w1 core when new command is received
 =======================================================
 
 When new message (w1_netlink_msg) is received w1 core detects if it is
@@ -167,7 +179,7 @@ When all commands (w1_netlink_cmd) are processed master device is unlocked
 and next w1_netlink_msg header processing started.
 
 
-Connector [1] specific documentation.
+Connector [1] specific documentation
 ====================================
 
 Each connector message includes two u32 fields as "address".
@@ -180,10 +192,11 @@ Sequence number for reply is the same as was in request, and
 acknowledge number is set to seq+1.
 
 
-Additional documantion, source code examples.
-============================================
+Additional documentation, source code examples
+==============================================
 
 1. Documentation/driver-api/connector.rst
 2. http://www.ioremap.net/archive/w1
-This archive includes userspace application w1d.c which uses
-read/write/search commands for all master/slave devices found on the bus.
+
+   This archive includes userspace application w1d.c which uses
+   read/write/search commands for all master/slave devices found on the bus.
-- 
2.21.0

