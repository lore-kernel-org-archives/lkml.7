Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD10C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808952133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924215;
	bh=cJdCRxx4auuat9Uv92Go61v6PNk91sD3HHJl+PiZRNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zSIKhc/TbysDT0pwKSkMmc5iwnqA4FIhCxgdaHpGjl3YjhOM9wblPMfyYDAZUFEOA
	 bq0O22BDkIF+/W4hy4EQEnpjDoR9sUZP1b+8vg0IIXp6Ye3dAlOFIIoc8IiCTWTuF2
	 H1r8K8crBjliH49u4Epk9Mm12LpBCMMNT8X71NLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDJTXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:23:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfDJTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QXSBflgdICDavMt3qJi4slib9fkF1Sog++iPiX5VTQo=; b=YnyOmqS0jWp973cXf4fuVCqJk3
        seDyq2dNaeo+TxPgfqOe0/hVnE1wrtPfnYfxPD597nptkitIiXR2vZmuTPauEbnpa7IrONpN0NiYW
        CFrOkBk4cDbFC4HhWdHfOp+eSxNg21xzyOROruzzMwHxj5s66cier/nvxhzEsLEfv+DFNwjo41u7e
        4TzV13cdZ64R+MoS89L/afw3eGXPikdhHR5V134Ujek0bu8Gy+++pur0SlvxWw6XOhg4FuQh0SM8m
        FKMdzGL9JW4S5GgAnoHRIVC86NTbvKWSWmxd5ucKnTVI43of10Lh5MW6InUY6gGj1Hdf/nX0FG+6z
        UcmK44aQ==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoQ-0003RB-Nr; Wed, 10 Apr 2019 19:23:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoJ-0000zf-7J; Wed, 10 Apr 2019 16:23:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 19/21] docs: hwmon: misc files: convert to ReST format
Date:   Wed, 10 Apr 2019 16:22:56 -0300
Message-Id: <213072ae0bb683b5fd2d76dc128c687da78b67ec.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert other files maintained by Guenter to ReST format, in order
to allow them to be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/ina209   |  18 ++++--
 Documentation/hwmon/ina2xx   |  39 +++++++++---
 Documentation/hwmon/jc42     |  55 ++++++++++++++++-
 Documentation/hwmon/lm95234  |  11 +++-
 Documentation/hwmon/ltc4261  |  16 +++--
 Documentation/hwmon/max16065 |  24 +++++++-
 Documentation/hwmon/max6697  |  33 ++++++++++
 Documentation/hwmon/nct6775  | 114 ++++++++++++++++++++++++++++-------
 Documentation/hwmon/smm665   |  42 +++++++++++--
 Documentation/hwmon/tmp401   |  30 ++++++++-
 10 files changed, 328 insertions(+), 54 deletions(-)

diff --git a/Documentation/hwmon/ina209 b/Documentation/hwmon/ina209
index 672501de4509..64322075a145 100644
--- a/Documentation/hwmon/ina209
+++ b/Documentation/hwmon/ina209
@@ -1,16 +1,21 @@
 Kernel driver ina209
-=====================
+====================
 
 Supported chips:
+
   * Burr-Brown / Texas Instruments INA209
+
     Prefix: 'ina209'
+
     Addresses scanned: -
+
     Datasheet:
-        http://www.ti.com/lit/gpn/ina209
+	http://www.ti.com/lit/gpn/ina209
 
-Author: Paul Hays <Paul.Hays@cattail.ca>
-Author: Ira W. Snyder <iws@ovro.caltech.edu>
-Author: Guenter Roeck <linux@roeck-us.net>
+Author:
+	- Paul Hays <Paul.Hays@cattail.ca>
+	- Ira W. Snyder <iws@ovro.caltech.edu>
+	- Guenter Roeck <linux@roeck-us.net>
 
 
 Description
@@ -31,7 +36,7 @@ the I2C bus. See the datasheet for details.
 This tries to expose most monitoring features of the hardware via
 sysfs. It does not support every feature of this chip.
 
-
+======================= =======================================================
 in0_input		shunt voltage (mV)
 in0_input_highest	shunt voltage historical maximum reading (mV)
 in0_input_lowest	shunt voltage historical minimum reading (mV)
@@ -70,6 +75,7 @@ curr1_input		current measurement (mA)
 
 update_interval		data conversion time; affects number of samples used
 			to average results for shunt and bus voltages.
+======================= =======================================================
 
 General Remarks
 ---------------
diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index 0f36c021192d..95badf9c396f 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -2,35 +2,56 @@ Kernel driver ina2xx
 ====================
 
 Supported chips:
+
   * Texas Instruments INA219
+
+
     Prefix: 'ina219'
     Addresses: I2C 0x40 - 0x4f
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/
+
+	       http://www.ti.com/
 
   * Texas Instruments INA220
+
     Prefix: 'ina220'
+
     Addresses: I2C 0x40 - 0x4f
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/
+
+	       http://www.ti.com/
 
   * Texas Instruments INA226
+
     Prefix: 'ina226'
+
     Addresses: I2C 0x40 - 0x4f
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/
+
+	       http://www.ti.com/
 
   * Texas Instruments INA230
+
     Prefix: 'ina230'
+
     Addresses: I2C 0x40 - 0x4f
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/
+
+	       http://www.ti.com/
 
   * Texas Instruments INA231
+
     Prefix: 'ina231'
+
     Addresses: I2C 0x40 - 0x4f
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/
+
+	       http://www.ti.com/
 
 Author: Lothar Felten <lothar.felten@gmail.com>
 
@@ -64,16 +85,20 @@ lower limit of the update_interval is 2 ms, the upper limit is 2253 ms.
 The actual programmed interval may vary from the desired value.
 
 General sysfs entries
--------------
+---------------------
 
+======================= ===============================
 in0_input		Shunt voltage(mV) channel
 in1_input		Bus voltage(mV) channel
 curr1_input		Current(mA) measurement channel
 power1_input		Power(uW) measurement channel
 shunt_resistor		Shunt resistance(uOhm) channel
+======================= ===============================
 
 Sysfs entries for ina226, ina230 and ina231 only
--------------
+------------------------------------------------
 
+======================= ====================================================
 update_interval		data conversion time; affects number of samples used
 			to average results for shunt and bus voltages.
+======================= ====================================================
diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
index b4b671f22453..5b14b49bb6f7 100644
--- a/Documentation/hwmon/jc42
+++ b/Documentation/hwmon/jc42
@@ -2,53 +2,100 @@ Kernel driver jc42
 ==================
 
 Supported chips:
+
   * Analog Devices ADT7408
+
     Datasheets:
+
 	http://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
+
   * Atmel AT30TS00, AT30TS002A/B, AT30TSE004A
+
     Datasheets:
+
 	http://www.atmel.com/Images/doc8585.pdf
+
 	http://www.atmel.com/Images/doc8711.pdf
+
 	http://www.atmel.com/Images/Atmel-8852-SEEPROM-AT30TSE002A-Datasheet.pdf
+
 	http://www.atmel.com/Images/Atmel-8868-DTS-AT30TSE004A-Datasheet.pdf
+
   * IDT TSE2002B3, TSE2002GB2, TSE2004GB2, TS3000B3, TS3000GB0, TS3000GB2,
+
 	TS3001GB2
+
     Datasheets:
+
 	Available from IDT web site
+
   * Maxim MAX6604
+
     Datasheets:
+
 	http://datasheets.maxim-ic.com/en/ds/MAX6604.pdf
+
   * Microchip MCP9804, MCP9805, MCP9808, MCP98242, MCP98243, MCP98244, MCP9843
+
     Datasheets:
+
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22203C.pdf
+
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21977b.pdf
+
 	http://ww1.microchip.com/downloads/en/DeviceDoc/25095A.pdf
+
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21996a.pdf
+
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22153c.pdf
+
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22327A.pdf
+
   * NXP Semiconductors SE97, SE97B, SE98, SE98A
+
     Datasheets:
+
 	http://www.nxp.com/documents/data_sheet/SE97.pdf
+
 	http://www.nxp.com/documents/data_sheet/SE97B.pdf
+
 	http://www.nxp.com/documents/data_sheet/SE98.pdf
+
 	http://www.nxp.com/documents/data_sheet/SE98A.pdf
+
   * ON Semiconductor CAT34TS02, CAT6095
+
     Datasheet:
+
 	http://www.onsemi.com/pub_link/Collateral/CAT34TS02-D.PDF
+
 	http://www.onsemi.com/pub/Collateral/CAT6095-D.PDF
+
   * ST Microelectronics STTS424, STTS424E02, STTS2002, STTS2004, STTS3000
+
     Datasheets:
+
 	http://www.st.com/web/en/resource/technical/document/datasheet/CD00157556.pdf
+
 	http://www.st.com/web/en/resource/technical/document/datasheet/CD00157558.pdf
+
 	http://www.st.com/web/en/resource/technical/document/datasheet/CD00266638.pdf
+
 	http://www.st.com/web/en/resource/technical/document/datasheet/CD00225278.pdf
+
 	http://www.st.com/web/en/resource/technical/document/datasheet/DM00076709.pdf
+
   * JEDEC JC 42.4 compliant temperature sensor chips
+
     Datasheet:
+
 	http://www.jedec.org/sites/default/files/docs/4_01_04R19.pdf
 
+
   Common for all chips:
+
     Prefix: 'jc42'
+
     Addresses scanned: I2C 0x18 - 0x1f
 
 Author:
@@ -67,10 +114,10 @@ The driver auto-detects the chips listed above, but can be manually instantiated
 to support other JC 42.4 compliant chips.
 
 Example: the following will load the driver for a generic JC 42.4 compliant
-temperature sensor at address 0x18 on I2C bus #1:
+temperature sensor at address 0x18 on I2C bus #1::
 
-# modprobe jc42
-# echo jc42 0x18 > /sys/bus/i2c/devices/i2c-1/new_device
+	# modprobe jc42
+	# echo jc42 0x18 > /sys/bus/i2c/devices/i2c-1/new_device
 
 A JC 42.4 compliant chip supports a single temperature sensor. Minimum, maximum,
 and critical temperature can be configured. There are alarms for high, low,
@@ -90,6 +137,7 @@ cannot be changed.
 Sysfs entries
 -------------
 
+======================= ===========================================
 temp1_input		Temperature (RO)
 temp1_min		Minimum temperature (RO or RW)
 temp1_max		Maximum temperature (RO or RW)
@@ -101,3 +149,4 @@ temp1_max_hyst		Maximum hysteresis temperature (RO)
 temp1_min_alarm		Temperature low alarm
 temp1_max_alarm		Temperature high alarm
 temp1_crit_alarm	Temperature critical alarm
+======================= ===========================================
diff --git a/Documentation/hwmon/lm95234 b/Documentation/hwmon/lm95234
index 32b777ef224c..e4c14bea5efd 100644
--- a/Documentation/hwmon/lm95234
+++ b/Documentation/hwmon/lm95234
@@ -2,15 +2,22 @@ Kernel driver lm95234
 =====================
 
 Supported chips:
+
   * National Semiconductor / Texas Instruments LM95233
+
     Addresses scanned: I2C 0x18, 0x2a, 0x2b
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/product/lm95233
+
+	       http://www.ti.com/product/lm95233
+
   * National Semiconductor / Texas Instruments LM95234
+
     Addresses scanned: I2C 0x18, 0x4d, 0x4e
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/product/lm95234
 
+	       http://www.ti.com/product/lm95234
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/ltc4261 b/Documentation/hwmon/ltc4261
index 9378a75c6134..c80233f8082e 100644
--- a/Documentation/hwmon/ltc4261
+++ b/Documentation/hwmon/ltc4261
@@ -2,11 +2,16 @@ Kernel driver ltc4261
 =====================
 
 Supported chips:
+
   * Linear Technology LTC4261
+
     Prefix: 'ltc4261'
+
     Addresses scanned: -
+
     Datasheet:
-        http://cds.linear.com/docs/Datasheet/42612fb.pdf
+
+	http://cds.linear.com/docs/Datasheet/42612fb.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -26,9 +31,10 @@ which can be safely used to identify the chip. You will have to instantiate
 the devices explicitly.
 
 Example: the following will load the driver for an LTC4261 at address 0x10
-on I2C bus #1:
-$ modprobe ltc4261
-$ echo ltc4261 0x10 > /sys/bus/i2c/devices/i2c-1/new_device
+on I2C bus #1::
+
+	$ modprobe ltc4261
+	$ echo ltc4261 0x10 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs entries
@@ -51,6 +57,7 @@ the proximity of the ADIN2 pin to the OV pin. ADIN2 is, however, not available
 on all chip variants. To ensure that the alarm condition is reported to the user,
 report it with both voltage sensors.
 
+======================= =============================
 in1_input		ADIN2 voltage (mV)
 in1_min_alarm		ADIN/ADIN2 Undervoltage alarm
 in1_max_alarm		ADIN/ADIN2 Overvoltage alarm
@@ -61,3 +68,4 @@ in2_max_alarm		ADIN/ADIN2 Overvoltage alarm
 
 curr1_input		SENSE current (mA)
 curr1_alarm		SENSE overcurrent alarm
+======================= =============================
diff --git a/Documentation/hwmon/max16065 b/Documentation/hwmon/max16065
index 208a29e43010..fa5c852a178c 100644
--- a/Documentation/hwmon/max16065
+++ b/Documentation/hwmon/max16065
@@ -1,29 +1,49 @@
 Kernel driver max16065
 ======================
 
+
 Supported chips:
+
   * Maxim MAX16065, MAX16066
+
     Prefixes: 'max16065', 'max16066'
+
     Addresses scanned: -
+
     Datasheet:
+
 	http://datasheets.maxim-ic.com/en/ds/MAX16065-MAX16066.pdf
+
  *  Maxim MAX16067
+
     Prefix: 'max16067'
+
     Addresses scanned: -
+
     Datasheet:
+
 	http://datasheets.maxim-ic.com/en/ds/MAX16067.pdf
+
  *  Maxim MAX16068
+
     Prefix: 'max16068'
+
     Addresses scanned: -
+
     Datasheet:
+
 	http://datasheets.maxim-ic.com/en/ds/MAX16068.pdf
+
  *  Maxim MAX16070/MAX16071
+
     Prefixes: 'max16070', 'max16071'
+
     Addresses scanned: -
+
     Datasheet:
+
 	http://datasheets.maxim-ic.com/en/ds/MAX16070-MAX16071.pdf
 
-
 Author: Guenter Roeck <linux@roeck-us.net>
 
 
@@ -73,6 +93,7 @@ turn into a brick.
 Sysfs entries
 -------------
 
+======================= ========================================================
 in[0-11]_input		Input voltage measurements.
 
 in12_input		Voltage on CSP (Current Sense Positive) pin.
@@ -103,3 +124,4 @@ curr1_input		Current sense input; only if the chip supports current
 
 curr1_alarm		Overcurrent alarm; only if the chip supports current
 			sensing and if current sensing is enabled.
+======================= ========================================================
diff --git a/Documentation/hwmon/max6697 b/Documentation/hwmon/max6697
index 6594177ededa..ffc5a7d8d33b 100644
--- a/Documentation/hwmon/max6697
+++ b/Documentation/hwmon/max6697
@@ -2,38 +2,69 @@ Kernel driver max6697
 =====================
 
 Supported chips:
+
   * Maxim MAX6581
+
     Prefix: 'max6581'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6581.pdf
+
   * Maxim MAX6602
+
     Prefix: 'max6602'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6602.pdf
+
   * Maxim MAX6622
+
     Prefix: 'max6622'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6622.pdf
+
   * Maxim MAX6636
+
     Prefix: 'max6636'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6636.pdf
+
   * Maxim MAX6689
+
     Prefix: 'max6689'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6689.pdf
+
   * Maxim MAX6693
+
     Prefix: 'max6693'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6693.pdf
+
   * Maxim MAX6694
+
     Prefix: 'max6694'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6694.pdf
+
   * Maxim MAX6697
+
     Prefix: 'max6697'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6697.pdf
+
   * Maxim MAX6698
+
     Prefix: 'max6698'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6698.pdf
+
   * Maxim MAX6699
+
     Prefix: 'max6699'
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6699.pdf
 
 Author:
+
     Guenter Roeck <linux@roeck-us.net>
 
 Description
@@ -50,9 +81,11 @@ The driver provides the following sysfs attributes. temp1 is the local (chip)
 temperature, temp[2..n] are remote temperatures. The actually supported
 per-channel attributes are chip type and channel dependent.
 
+================ == ==========================================================
 tempX_input      RO temperature
 tempX_max        RW temperature maximum threshold
 tempX_max_alarm  RO temperature maximum threshold alarm
 tempX_crit       RW temperature critical threshold
 tempX_crit_alarm RO temperature critical threshold alarm
 tempX_fault      RO temperature diode fault (remote sensors only)
+================ == ==========================================================
diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
index bd59834d310f..1d0315c40952 100644
--- a/Documentation/hwmon/nct6775
+++ b/Documentation/hwmon/nct6775
@@ -1,52 +1,90 @@
-Note
-====
-
-This driver supersedes the NCT6775F and NCT6776F support in the W83627EHF
-driver.
-
 Kernel driver NCT6775
 =====================
 
+.. note::
+
+    This driver supersedes the NCT6775F and NCT6776F support in the W83627EHF
+    driver.
+
 Supported chips:
+
   * Nuvoton NCT6102D/NCT6104D/NCT6106D
+
     Prefix: 'nct6106'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from the Nuvoton web site
+
   * Nuvoton NCT5572D/NCT6771F/NCT6772F/NCT6775F/W83677HG-I
+
     Prefix: 'nct6775'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT5573D/NCT5577D/NCT6776D/NCT6776F
+
     Prefix: 'nct6776'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT5532D/NCT6779D
+
     Prefix: 'nct6779'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT6791D
+
     Prefix: 'nct6791'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT6792D
+
     Prefix: 'nct6792'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT6793D
+
     Prefix: 'nct6793'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT6795D
+
     Prefix: 'nct6795'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT6796D
+
     Prefix: 'nct6796'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
 
+
+
 Authors:
-        Guenter Roeck <linux@roeck-us.net>
+
+	Guenter Roeck <linux@roeck-us.net>
 
 Description
 -----------
@@ -96,10 +134,14 @@ The mode works for fan1-fan5.
 sysfs attributes
 ----------------
 
-pwm[1-7] - this file stores PWM duty cycle or DC value (fan speed) in range:
+pwm[1-7]
+    - this file stores PWM duty cycle or DC value (fan speed) in range:
+
 	   0 (lowest speed) to 255 (full)
 
-pwm[1-7]_enable - this file controls mode of fan/temperature control:
+pwm[1-7]_enable
+    - this file controls mode of fan/temperature control:
+
 	* 0 Fan control disabled (fans set to maximum speed)
 	* 1 Manual mode, write to pwm[0-5] any value 0-255
 	* 2 "Thermal Cruise" mode
@@ -107,15 +149,19 @@ pwm[1-7]_enable - this file controls mode of fan/temperature control:
 	* 4 "Smart Fan III" mode (NCT6775F only)
 	* 5 "Smart Fan IV" mode
 
-pwm[1-7]_mode - controls if output is PWM or DC level
-        * 0 DC output
-        * 1 PWM output
+pwm[1-7]_mode
+    - controls if output is PWM or DC level
+
+	* 0 DC output
+	* 1 PWM output
 
 Common fan control attributes
 -----------------------------
 
-pwm[1-7]_temp_sel	Temperature source. Value is temperature sensor index.
+pwm[1-7]_temp_sel
+			Temperature source. Value is temperature sensor index.
 			For example, select '1' for temp1_input.
+
 pwm[1-7]_weight_temp_sel
 			Secondary temperature source. Value is temperature
 			sensor index. For example, select '1' for temp1_input.
@@ -126,13 +172,16 @@ following attributes.
 
 pwm[1-7]_weight_duty_step
 			Duty step size.
+
 pwm[1-7]_weight_temp_step
 			Temperature step size. With each step over
 			temp_step_base, the value of weight_duty_step is added
 			to the current pwm value.
+
 pwm[1-7]_weight_temp_step_base
 			Temperature at which secondary temperature control kicks
 			in.
+
 pwm[1-7]_weight_temp_step_tol
 			Temperature step tolerance.
 
@@ -141,24 +190,35 @@ Thermal Cruise mode (2)
 
 If the temperature is in the range defined by:
 
-pwm[1-7]_target_temp	Target temperature, unit millidegree Celsius
+pwm[1-7]_target_temp
+			Target temperature, unit millidegree Celsius
 			(range 0 - 127000)
+
 pwm[1-7]_temp_tolerance
 			Target temperature tolerance, unit millidegree Celsius
 
-there are no changes to fan speed. Once the temperature leaves the interval, fan
+There are no changes to fan speed. Once the temperature leaves the interval, fan
 speed increases (if temperature is higher that desired) or decreases (if
 temperature is lower than desired), using the following limits and time
 intervals.
 
-pwm[1-7]_start		fan pwm start value (range 1 - 255), to start fan
+pwm[1-7]_start
+			fan pwm start value (range 1 - 255), to start fan
 			when the temperature is above defined range.
-pwm[1-7]_floor		lowest fan pwm (range 0 - 255) if temperature is below
+
+pwm[1-7]_floor
+			lowest fan pwm (range 0 - 255) if temperature is below
 			the defined range. If set to 0, the fan is expected to
 			stop if the temperature is below the defined range.
-pwm[1-7]_step_up_time	milliseconds before fan speed is increased
-pwm[1-7]_step_down_time	milliseconds before fan speed is decreased
-pwm[1-7]_stop_time	how many milliseconds must elapse to switch
+
+pwm[1-7]_step_up_time
+			milliseconds before fan speed is increased
+
+pwm[1-7]_step_down_time
+			milliseconds before fan speed is decreased
+
+pwm[1-7]_stop_time
+			how many milliseconds must elapse to switch
 			corresponding fan off (when the temperature was below
 			defined range).
 
@@ -167,7 +227,9 @@ Speed Cruise mode (3)
 
 This modes tries to keep the fan speed constant.
 
-fan[1-7]_target		Target fan speed
+fan[1-7]_target
+			Target fan speed
+
 fan[1-7]_tolerance
 			Target speed tolerance
 
@@ -188,16 +250,22 @@ critical temperature mode, in which the fans should run at full speed.
 pwm[1-7]_auto_point[1-7]_pwm
 			pwm value to be set if temperature reaches matching
 			temperature range.
+
 pwm[1-7]_auto_point[1-7]_temp
 			Temperature over which the matching pwm is enabled.
+
 pwm[1-7]_temp_tolerance
 			Temperature tolerance, unit millidegree Celsius
+
 pwm[1-7]_crit_temp_tolerance
 			Temperature tolerance for critical temperature,
 			unit millidegree Celsius
 
-pwm[1-7]_step_up_time	milliseconds before fan speed is increased
-pwm[1-7]_step_down_time	milliseconds before fan speed is decreased
+pwm[1-7]_step_up_time
+			milliseconds before fan speed is increased
+
+pwm[1-7]_step_down_time
+			milliseconds before fan speed is decreased
 
 Usage Notes
 -----------
diff --git a/Documentation/hwmon/smm665 b/Documentation/hwmon/smm665
index a341eeedab75..a0e27f62b57b 100644
--- a/Documentation/hwmon/smm665
+++ b/Documentation/hwmon/smm665
@@ -2,31 +2,57 @@ Kernel driver smm665
 ====================
 
 Supported chips:
+
   * Summit Microelectronics SMM465
+
     Prefix: 'smm465'
+
     Addresses scanned: -
+
     Datasheet:
+
       http://www.summitmicro.com/prod_select/summary/SMM465/SMM465DS.pdf
+
   * Summit Microelectronics SMM665, SMM665B
+
     Prefix: 'smm665'
+
     Addresses scanned: -
+
     Datasheet:
+
       http://www.summitmicro.com/prod_select/summary/SMM665/SMM665B_2089_20.pdf
+
   * Summit Microelectronics SMM665C
+
     Prefix: 'smm665c'
+
     Addresses scanned: -
+
     Datasheet:
+
       http://www.summitmicro.com/prod_select/summary/SMM665C/SMM665C_2125.pdf
+
   * Summit Microelectronics SMM764
+
     Prefix: 'smm764'
+
     Addresses scanned: -
+
     Datasheet:
+
       http://www.summitmicro.com/prod_select/summary/SMM764/SMM764_2098.pdf
+
   * Summit Microelectronics SMM766, SMM766B
+
     Prefix: 'smm766'
+
     Addresses scanned: -
+
     Datasheets:
+
       http://www.summitmicro.com/prod_select/summary/SMM766/SMM766_2086.pdf
+
       http://www.summitmicro.com/prod_select/summary/SMM766B/SMM766B_2122.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
@@ -36,9 +62,10 @@ Module Parameters
 -----------------
 
 * vref: int
-  Default: 1250 (mV)
-  Reference voltage on VREF_ADC pin in mV. It should not be necessary to set
-  this parameter unless a non-default reference voltage is used.
+    Default: 1250 (mV)
+
+    Reference voltage on VREF_ADC pin in mV. It should not be necessary to set
+    this parameter unless a non-default reference voltage is used.
 
 
 Description
@@ -64,9 +91,10 @@ the devices explicitly. When instantiating the device, you have to specify
 its configuration register address.
 
 Example: the following will load the driver for an SMM665 at address 0x57
-on I2C bus #1:
-$ modprobe smm665
-$ echo smm665 0x57 > /sys/bus/i2c/devices/i2c-1/new_device
+on I2C bus #1::
+
+	$ modprobe smm665
+	$ echo smm665 0x57 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs entries
@@ -84,6 +112,7 @@ max otherwise. For details please see the SMM665 datasheet.
 
 For SMM465 and SMM764, values for Channel E and F are reported but undefined.
 
+======================= =======================================================
 in1_input		12V input voltage (mV)
 in2_input		3.3V (VDD) input voltage (mV)
 in3_input		Channel A voltage (mV)
@@ -155,3 +184,4 @@ temp1_min		Mimimum chip temperature
 temp1_max		Maximum chip temperature
 temp1_crit		Critical chip temperature
 temp1_crit_alarm	Temperature critical alarm
+======================= =======================================================
diff --git a/Documentation/hwmon/tmp401 b/Documentation/hwmon/tmp401
index 2d9ca42213cf..bd865bbdb38d 100644
--- a/Documentation/hwmon/tmp401
+++ b/Documentation/hwmon/tmp401
@@ -2,33 +2,59 @@ Kernel driver tmp401
 ====================
 
 Supported chips:
+
   * Texas Instruments TMP401
+
     Prefix: 'tmp401'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp401.html
+
   * Texas Instruments TMP411
+
     Prefix: 'tmp411'
+
     Addresses scanned: I2C 0x4c, 0x4d, 0x4e
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp411.html
+
   * Texas Instruments TMP431
+
     Prefix: 'tmp431'
+
     Addresses scanned: I2C 0x4c, 0x4d
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp431.html
+
   * Texas Instruments TMP432
+
     Prefix: 'tmp432'
+
     Addresses scanned: I2C 0x4c, 0x4d
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp432.html
+
   * Texas Instruments TMP435
+
     Prefix: 'tmp435'
+
     Addresses scanned: I2C 0x48 - 0x4f
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp435.html
+
   * Texas Instruments TMP461
+
     Prefix: 'tmp461'
+
     Datasheet: http://www.ti.com/product/tmp461
 
+
+
 Authors:
-         Hans de Goede <hdegoede@redhat.com>
-	 Andre Prendel <andre.prendel@gmx.de>
+
+	- Hans de Goede <hdegoede@redhat.com>
+	- Andre Prendel <andre.prendel@gmx.de>
 
 Description
 -----------
-- 
2.20.1

