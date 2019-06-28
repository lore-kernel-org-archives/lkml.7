Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25A4C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2D208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561757026;
	bh=qEOeQXxf/wZ+fj2NG9JxVaem3Hrc1KXeeB0QwdZR9J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uaz26szLGTYl9cNY1fDNreN6MxmCPNkptWeeHPM3qhJ8ar93ulMkm9jDbHjsvK8Hk
	 VlVexdOapTgWVh1aUy43/e3M+fGxTMNseIDbiiL1C3qzy9O6/xC5mEXY/wyJ9/brwP
	 QbvTpbaAn2CB6rySCkdNFQFkF1nNvTyP2ZdXIAc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF1VXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:23:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfF1VXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zqctRROUdvt6T9Ch5lO+6tWv2IaafLTrqdrauzV10TM=; b=jpWNTu7+SZmxng8HGL4YL+KPmW
        hotqIWlh2WS7L6A09QUduK8xSpKGDFoOV87Cq4k3zKMNjJJBTFfGzt1nVrzB5lKpY7r0llj9PLiLo
        omcPH05yFPRDBelZgHDe26FzNVtLhtYR6rFYuWfnCh6UUGX9O6wpM/hMJvcmtvuRH2aVZHboB4AY+
        HG34vfrsiHwDRWZ8cQdiKK3B18P3wrmZdP3/t9+mWD9FKuLZsZw/3798l2abyQiZaAkjn8tulkG5e
        +5WTJbiYTLM3frTa58XijAb/qOprJb69wJpeNZZA3fNkai5kGpT9pRg2v5Mj7opLgUySrkK2YBWU8
        K5C/pgsQ==;
Received: from [187.113.3.250] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgyL2-0001VE-Kq; Fri, 28 Jun 2019 21:23:21 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgyKz-0002dq-UE; Fri, 28 Jun 2019 18:23:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/5] docs: misc-devices: convert files without extension to ReST
Date:   Fri, 28 Jun 2019 18:23:13 -0300
Message-Id: <b7dc829809673bd8cffe0e7bbe9c9308681c6fe2.1561756511.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561756511.git.mchehab+samsung@kernel.org>
References: <cover.1561756511.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those files are also text files. Convert them to ReST and add
to the misc-files index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../misc-devices/{eeprom => eeprom.rst}       | 43 +++++++++------
 .../{ics932s401 => ics932s401.rst}            |  7 ++-
 Documentation/misc-devices/index.rst          |  5 ++
 .../misc-devices/{isl29003 => isl29003.rst}   | 15 +++++-
 .../misc-devices/{lis3lv02d => lis3lv02d.rst} | 20 ++++---
 .../misc-devices/{max6875 => max6875.rst}     | 52 ++++++++++++++-----
 MAINTAINERS                                   |  4 +-
 drivers/misc/isl29003.c                       |  2 +-
 drivers/platform/x86/Kconfig                  |  2 +-
 9 files changed, 108 insertions(+), 42 deletions(-)
 rename Documentation/misc-devices/{eeprom => eeprom.rst} (76%)
 rename Documentation/misc-devices/{ics932s401 => ics932s401.rst} (94%)
 rename Documentation/misc-devices/{isl29003 => isl29003.rst} (77%)
 rename Documentation/misc-devices/{lis3lv02d => lis3lv02d.rst} (90%)
 rename Documentation/misc-devices/{max6875 => max6875.rst} (83%)

diff --git a/Documentation/misc-devices/eeprom b/Documentation/misc-devices/eeprom.rst
similarity index 76%
rename from Documentation/misc-devices/eeprom
rename to Documentation/misc-devices/eeprom.rst
index ba692011f221..008249675ccc 100644
--- a/Documentation/misc-devices/eeprom
+++ b/Documentation/misc-devices/eeprom.rst
@@ -1,11 +1,17 @@
+====================
 Kernel driver eeprom
 ====================
 
 Supported chips:
+
   * Any EEPROM chip in the designated address range
+
     Prefix: 'eeprom'
+
     Addresses scanned: I2C 0x50 - 0x57
+
     Datasheets: Publicly available from:
+
                 Atmel (www.atmel.com),
                 Catalyst (www.catsemi.com),
                 Fairchild (www.fairchildsemi.com),
@@ -16,7 +22,9 @@ Supported chips:
                 Xicor (www.xicor.com),
                 and others.
 
-        Chip     Size (bits)    Address
+        ========= ============= ============================================
+        Chip      Size (bits)   Address
+        ========= ============= ============================================
         24C01     1K            0x50 (shadows at 0x51 - 0x57)
         24C01A    1K            0x50 - 0x57 (Typical device on DIMMs)
         24C02     2K            0x50 - 0x57
@@ -24,7 +32,7 @@ Supported chips:
                                 (additional data at 0x51, 0x53, 0x55, 0x57)
         24C08     8K            0x50, 0x54 (additional data at 0x51, 0x52,
                                 0x53, 0x55, 0x56, 0x57)
-        24C16    16K            0x50 (additional data at 0x51 - 0x57)
+        24C16     16K           0x50 (additional data at 0x51 - 0x57)
         Sony      2K            0x57
 
         Atmel     34C02B  2K    0x50 - 0x57, SW write protect at 0x30-37
@@ -33,14 +41,15 @@ Supported chips:
         Fairchild 34W02   2K    0x50 - 0x57, SW write protect at 0x30-37
         Microchip 24AA52  2K    0x50 - 0x57, SW write protect at 0x30-37
         ST        M34C02  2K    0x50 - 0x57, SW write protect at 0x30-37
+        ========= ============= ============================================
 
 
 Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Jean Delvare <jdelvare@suse.de>,
-        Greg Kroah-Hartman <greg@kroah.com>,
-        IBM Corp.
+        - Frodo Looijaard <frodol@dds.nl>,
+        - Philip Edelbrock <phil@netroedge.com>,
+        - Jean Delvare <jdelvare@suse.de>,
+        - Greg Kroah-Hartman <greg@kroah.com>,
+        - IBM Corp.
 
 Description
 -----------
@@ -74,23 +83,25 @@ this address will write protect the memory array permanently, and the
 device will no longer respond at the 0x30-37 address. The eeprom driver
 does not support this register.
 
-Lacking functionality:
+Lacking functionality
+---------------------
 
 * Full support for larger devices (24C04, 24C08, 24C16). These are not
-typically found on a PC. These devices will appear as separate devices at
-multiple addresses.
+  typically found on a PC. These devices will appear as separate devices at
+  multiple addresses.
 
 * Support for really large devices (24C32, 24C64, 24C128, 24C256, 24C512).
-These devices require two-byte address fields and are not supported.
+  These devices require two-byte address fields and are not supported.
 
 * Enable Writing. Again, no technical reason why not, but making it easy
-to change the contents of the EEPROMs (on DIMMs anyway) also makes it easy
-to disable the DIMMs (potentially preventing the computer from booting)
-until the values are restored somehow.
+  to change the contents of the EEPROMs (on DIMMs anyway) also makes it easy
+  to disable the DIMMs (potentially preventing the computer from booting)
+  until the values are restored somehow.
 
-Use:
+Use
+---
 
 After inserting the module (and any other required SMBus/i2c modules), you
-should have some EEPROM directories in /sys/bus/i2c/devices/* of names such
+should have some EEPROM directories in ``/sys/bus/i2c/devices/*`` of names such
 as "0-0050". Inside each of these is a series of files, the eeprom file
 contains the binary data from EEPROM.
diff --git a/Documentation/misc-devices/ics932s401 b/Documentation/misc-devices/ics932s401.rst
similarity index 94%
rename from Documentation/misc-devices/ics932s401
rename to Documentation/misc-devices/ics932s401.rst
index bdac67ff6e3f..613ee54a9c21 100644
--- a/Documentation/misc-devices/ics932s401
+++ b/Documentation/misc-devices/ics932s401.rst
@@ -1,10 +1,15 @@
+========================
 Kernel driver ics932s401
-======================
+========================
 
 Supported chips:
+
   * IDT ICS932S401
+
     Prefix: 'ics932s401'
+
     Addresses scanned: I2C 0x69
+
     Datasheet: Publicly available at the IDT website
 
 Author: Darrick J. Wong
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index dfd1f45a3127..a57f92dfe49a 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -14,4 +14,9 @@ fit into other categories.
 .. toctree::
    :maxdepth: 2
 
+   eeprom
    ibmvmc
+   ics932s401
+   isl29003
+   lis3lv02d
+   max6875
diff --git a/Documentation/misc-devices/isl29003 b/Documentation/misc-devices/isl29003.rst
similarity index 77%
rename from Documentation/misc-devices/isl29003
rename to Documentation/misc-devices/isl29003.rst
index 80b952fd32ff..0cc38aed6c00 100644
--- a/Documentation/misc-devices/isl29003
+++ b/Documentation/misc-devices/isl29003.rst
@@ -1,10 +1,15 @@
+======================
 Kernel driver isl29003
-=====================
+======================
 
 Supported chips:
+
 * Intersil ISL29003
+
 Prefix: 'isl29003'
+
 Addresses scanned: none
+
 Datasheet:
 http://www.intersil.com/data/fn/fn7464.pdf
 
@@ -37,25 +42,33 @@ Sysfs entries
 -------------
 
 range:
+        == ===========================
 	0: 0 lux to 1000 lux (default)
 	1: 0 lux to 4000 lux
 	2: 0 lux to 16,000 lux
 	3: 0 lux to 64,000 lux
+        == ===========================
 
 resolution:
+        == =====================
 	0: 2^16 cycles (default)
 	1: 2^12 cycles
 	2: 2^8 cycles
 	3: 2^4 cycles
+        == =====================
 
 mode:
+        == =================================================
 	0: diode1's current (unsigned 16bit) (default)
 	1: diode1's current (unsigned 16bit)
 	2: difference between diodes (l1 - l2, signed 15bit)
+        == =================================================
 
 power_state:
+        == =================================================
 	0: device is disabled (default)
 	1: device is enabled
+        == =================================================
 
 lux (read only):
 	returns the value from the last sensor reading
diff --git a/Documentation/misc-devices/lis3lv02d b/Documentation/misc-devices/lis3lv02d.rst
similarity index 90%
rename from Documentation/misc-devices/lis3lv02d
rename to Documentation/misc-devices/lis3lv02d.rst
index f89960a0ff95..959bd2b822cf 100644
--- a/Documentation/misc-devices/lis3lv02d
+++ b/Documentation/misc-devices/lis3lv02d.rst
@@ -1,3 +1,4 @@
+=======================
 Kernel driver lis3lv02d
 =======================
 
@@ -8,8 +9,8 @@ Supported chips:
     LIS331DLH (16 bits)
 
 Authors:
-        Yan Burman <burman.yan@gmail.com>
-	Eric Piel <eric.piel@tremplin-utc.net>
+        - Yan Burman <burman.yan@gmail.com>
+	- Eric Piel <eric.piel@tremplin-utc.net>
 
 
 Description
@@ -25,11 +26,15 @@ neverball). The accelerometer data is readable via
 to mg values (1/1000th of earth gravity).
 
 Sysfs attributes under /sys/devices/platform/lis3lv02d/:
-position - 3D position that the accelerometer reports. Format: "(x,y,z)"
-rate - read reports the sampling rate of the accelerometer device in HZ.
+
+position
+      - 3D position that the accelerometer reports. Format: "(x,y,z)"
+rate
+      - read reports the sampling rate of the accelerometer device in HZ.
 	write changes sampling rate of the accelerometer device.
 	Only values which are supported by HW are accepted.
-selftest - performs selftest for the chip as specified by chip manufacturer.
+selftest
+      - performs selftest for the chip as specified by chip manufacturer.
 
 This driver also provides an absolute input class device, allowing
 the laptop to act as a pinball machine-esque joystick. Joystick device can be
@@ -69,11 +74,12 @@ Axes orientation
 For better compatibility between the various laptops. The values reported by
 the accelerometer are converted into a "standard" organisation of the axes
 (aka "can play neverball out of the box"):
+
  * When the laptop is horizontal the position reported is about 0 for X and Y
-	and a positive value for Z
+   and a positive value for Z
  * If the left side is elevated, X increases (becomes positive)
  * If the front side (where the touchpad is) is elevated, Y decreases
-	(becomes negative)
+   (becomes negative)
  * If the laptop is put upside-down, Z becomes negative
 
 If your laptop model is not recognized (cf "dmesg"), you can send an
diff --git a/Documentation/misc-devices/max6875 b/Documentation/misc-devices/max6875.rst
similarity index 83%
rename from Documentation/misc-devices/max6875
rename to Documentation/misc-devices/max6875.rst
index 2f2bd0b17b5d..ad419ac22a5b 100644
--- a/Documentation/misc-devices/max6875
+++ b/Documentation/misc-devices/max6875.rst
@@ -1,12 +1,16 @@
+=====================
 Kernel driver max6875
 =====================
 
 Supported chips:
+
   * Maxim MAX6874, MAX6875
+
     Prefix: 'max6875'
+
     Addresses scanned: None (see below)
-    Datasheet:
-        http://pdfserv.maxim-ic.com/en/ds/MAX6874-MAX6875.pdf
+
+    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6874-MAX6875.pdf
 
 Author: Ben Gardner <bgardner@wabtec.com>
 
@@ -24,9 +28,13 @@ registers.
 
 The Maxim MAX6874 is a similar, mostly compatible device, with more inputs
 and outputs:
-             vin     gpi    vout
+
+===========  ===     ===    ====
+-            vin     gpi    vout
+===========  ===     ===    ====
 MAX6874        6       4       8
 MAX6875        4       3       5
+===========  ===     ===    ====
 
 See the datasheet for more information.
 
@@ -41,13 +49,16 @@ General Remarks
 ---------------
 
 Valid addresses for the MAX6875 are 0x50 and 0x52.
+
 Valid addresses for the MAX6874 are 0x50, 0x52, 0x54 and 0x56.
+
 The driver does not probe any address, so you explicitly instantiate the
 devices.
 
-Example:
-$ modprobe max6875
-$ echo max6875 0x50 > /sys/bus/i2c/devices/i2c-0/new_device
+Example::
+
+  $ modprobe max6875
+  $ echo max6875 0x50 > /sys/bus/i2c/devices/i2c-0/new_device
 
 The MAX6874/MAX6875 ignores address bit 0, so this driver attaches to multiple
 addresses.  For example, for address 0x50, it also reserves 0x51.
@@ -58,52 +69,67 @@ Programming the chip using i2c-dev
 ----------------------------------
 
 Use the i2c-dev interface to access and program the chips.
+
 Reads and writes are performed differently depending on the address range.
 
 The configuration registers are at addresses 0x00 - 0x45.
+
 Use i2c_smbus_write_byte_data() to write a register and
 i2c_smbus_read_byte_data() to read a register.
+
 The command is the register number.
 
 Examples:
-To write a 1 to register 0x45:
+
+To write a 1 to register 0x45::
+
   i2c_smbus_write_byte_data(fd, 0x45, 1);
 
-To read register 0x45:
+To read register 0x45::
+
   value = i2c_smbus_read_byte_data(fd, 0x45);
 
 
 The configuration EEPROM is at addresses 0x8000 - 0x8045.
+
 The user EEPROM is at addresses 0x8100 - 0x82ff.
 
 Use i2c_smbus_write_word_data() to write a byte to EEPROM.
 
 The command is the upper byte of the address: 0x80, 0x81, or 0x82.
-The data word is the lower part of the address or'd with data << 8.
+The data word is the lower part of the address or'd with data << 8::
+
   cmd = address >> 8;
   val = (address & 0xff) | (data << 8);
 
 Example:
-To write 0x5a to address 0x8003:
+
+To write 0x5a to address 0x8003::
+
   i2c_smbus_write_word_data(fd, 0x80, 0x5a03);
 
 
 Reading data from the EEPROM is a little more complicated.
+
 Use i2c_smbus_write_byte_data() to set the read address and then
 i2c_smbus_read_byte() or i2c_smbus_read_i2c_block_data() to read the data.
 
 Example:
-To read data starting at offset 0x8100, first set the address:
+
+To read data starting at offset 0x8100, first set the address::
+
   i2c_smbus_write_byte_data(fd, 0x81, 0x00);
 
-And then read the data
+And then read the data::
+
   value = i2c_smbus_read_byte(fd);
 
-  or
+or::
 
   count = i2c_smbus_read_i2c_block_data(fd, 0x84, 16, buffer);
 
 The block read should read 16 bytes.
+
 0x84 is the block read command.
 
 See the datasheet for more details.
diff --git a/MAINTAINERS b/MAINTAINERS
index a49698b3becd..5d4da1035a03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8956,7 +8956,7 @@ F:	include/linux/leds.h
 LEGACY EEPROM DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 S:	Maintained
-F:	Documentation/misc-devices/eeprom
+F:	Documentation/misc-devices/eeprom.rst
 F:	drivers/misc/eeprom/eeprom.c
 
 LEGO MINDSTORMS EV3
@@ -9242,7 +9242,7 @@ F:	Documentation/memory-barriers.txt
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
-F:	Documentation/misc-devices/lis3lv02d
+F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
 F:	drivers/platform/x86/hp_accel.c
 
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index 5d0d0c3bad85..c12406f610d5 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -3,7 +3,7 @@
  *  isl29003.c - Linux kernel module for
  * 	Intersil ISL29003 ambient light sensor
  *
- *  See file:Documentation/misc-devices/isl29003
+ *  See file:Documentation/misc-devices/isl29003.rst
  *
  *  Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
  *
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e09aa0087024..7fdfe107fe33 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -341,7 +341,7 @@ config HP_ACCEL
 
 	  Support for a led indicating disk protection will be provided as
 	  hp::hddprotect. For more information on the feature, refer to
-	  Documentation/misc-devices/lis3lv02d.
+	  Documentation/misc-devices/lis3lv02d.rst.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called hp_accel.
-- 
2.21.0

