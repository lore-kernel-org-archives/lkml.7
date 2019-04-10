Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB44FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615982075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924250;
	bh=/nUTeb0wpDKmqRul2IsgaQyxZWH9JeQGwzAJYHSOqxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yv10xCMMQRCFnIzHnluGrq5U+5+tZgJaJmFYURU1d5JA0UApeEf6ou+nubstOryLL
	 SGC6FmM//0GUGpsAN2AHVIIzafK2V0bWlfvlcKNKKapPVWHQ4vF0t2vgWsAPDZ462n
	 6aZVFfvF+yJgROubNKP3l8aeQTDVT5s5b3EcQr9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDJTYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:24:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDJTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tNcxfjliIglyc1RLNUUXIQL+h69h8cFJbo5XwgNMyiU=; b=RL1PNw4DohI1v1etsVavwsBCey
        BJTLXxVNo7Wt+yGybG2NDMjowwCM2ezO8dNGkpizqx5ANpDzFVnQR5Z6A0GeDA+ZVmaLcvlc+Vhei
        E+HpLnFQY66u505bFyHOZ3pUMIXEERWTtZrhiTdILINdQ3c/M2eUJgM7bPTarno2gYRe5jENBiAc/
        MUGwUHs8PFF1f1/yzO/WjRVMxeWG68avVlADIkpeWQaNeSbHGPVFwTw9JAaohSujQLdZ6fyO2cA+n
        f/k5M0zE0WnQp9NaGyOHFAWyfeirBVI6s87dNF8tATx5QAXuDkWC73bUs/CKPSZobQMxff58BeD4h
        kgMY7K8g==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoM-0003Qy-HQ; Wed, 10 Apr 2019 19:23:09 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoJ-0000zk-8i; Wed, 10 Apr 2019 16:23:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 20/21] docs: hwmon: convert remaining files to ReST format
Date:   Wed, 10 Apr 2019 16:22:57 -0300
Message-Id: <dba0bbd265579e7fa91384f296b19296a6863d16.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all other hwmon files to ReST format, in order to allow
them to be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/ab8500               |   8 +-
 Documentation/hwmon/abituguru            |  97 ++--
 Documentation/hwmon/abituguru-datasheet  | 160 +++---
 Documentation/hwmon/abituguru3           |  36 +-
 Documentation/hwmon/abx500               |   8 +-
 Documentation/hwmon/acpi_power_meter     |  23 +-
 Documentation/hwmon/ad7314               |   9 +
 Documentation/hwmon/adc128d818           |   7 +-
 Documentation/hwmon/adm1021              |  44 +-
 Documentation/hwmon/adm1025              |  13 +-
 Documentation/hwmon/adm1026              |  24 +-
 Documentation/hwmon/adm1031              |  16 +-
 Documentation/hwmon/adm9240              |  50 +-
 Documentation/hwmon/ads7828              |  29 +-
 Documentation/hwmon/adt7410              |  49 +-
 Documentation/hwmon/adt7411              |  20 +-
 Documentation/hwmon/adt7462              |  10 +-
 Documentation/hwmon/adt7470              |   8 +-
 Documentation/hwmon/adt7475              |  38 +-
 Documentation/hwmon/amc6821              |  19 +-
 Documentation/hwmon/asb100               |  50 +-
 Documentation/hwmon/ds1621               | 154 +++--
 Documentation/hwmon/ds620                |  12 +-
 Documentation/hwmon/emc1403              |  33 +-
 Documentation/hwmon/emc6w201             |   5 +
 Documentation/hwmon/f71805f              |  36 +-
 Documentation/hwmon/f71882fg             |  56 +-
 Documentation/hwmon/ftsteutates          |  14 +-
 Documentation/hwmon/g760a                |   4 +
 Documentation/hwmon/g762                 |  65 ++-
 Documentation/hwmon/gl518sm              |  21 +-
 Documentation/hwmon/hih6130              |  14 +-
 Documentation/hwmon/hwmon-kernel-api.txt | 294 +++++-----
 Documentation/hwmon/ibmaem               |  10 +-
 Documentation/hwmon/ina3221              |  17 +-
 Documentation/hwmon/it87                 | 102 +++-
 Documentation/hwmon/lineage-pem          |  16 +-
 Documentation/hwmon/lm63                 |  24 +-
 Documentation/hwmon/lm70                 |  13 +-
 Documentation/hwmon/lm73                 |  16 +-
 Documentation/hwmon/lm75                 |  96 +++-
 Documentation/hwmon/lm77                 |   9 +-
 Documentation/hwmon/lm78                 |  20 +-
 Documentation/hwmon/lm80                 |  19 +-
 Documentation/hwmon/lm83                 |  16 +-
 Documentation/hwmon/lm85                 |  97 +++-
 Documentation/hwmon/lm87                 |  23 +-
 Documentation/hwmon/lm90                 | 174 +++++-
 Documentation/hwmon/lm92                 |  17 +-
 Documentation/hwmon/lm93                 | 157 ++---
 Documentation/hwmon/lm95245              |  13 +-
 Documentation/hwmon/ltc2945              |  16 +-
 Documentation/hwmon/ltc2990              |  23 +-
 Documentation/hwmon/ltc4151              |  16 +-
 Documentation/hwmon/ltc4215              |  16 +-
 Documentation/hwmon/ltc4245              |  17 +-
 Documentation/hwmon/ltc4260              |  16 +-
 Documentation/hwmon/max1619              |  11 +-
 Documentation/hwmon/max1668              |  14 +-
 Documentation/hwmon/max197               |  36 +-
 Documentation/hwmon/max31722             |  12 +
 Documentation/hwmon/max31790             |   6 +
 Documentation/hwmon/max6639              |  16 +-
 Documentation/hwmon/max6642              |  10 +-
 Documentation/hwmon/max6650              |  16 +-
 Documentation/hwmon/mc13783-adc          |  27 +-
 Documentation/hwmon/mcp3021              |  15 +-
 Documentation/hwmon/mlxreg-fan           |  60 +-
 Documentation/hwmon/nct6683              |  11 +-
 Documentation/hwmon/nct7802              |  11 +-
 Documentation/hwmon/nct7904              |   9 +-
 Documentation/hwmon/npcm750-pwm-fan      |   4 +
 Documentation/hwmon/nsa320               |  15 +-
 Documentation/hwmon/ntc_thermistor       | 123 ++--
 Documentation/hwmon/occ                  |  93 ++-
 Documentation/hwmon/pc87427              |   4 +
 Documentation/hwmon/pcf8591              |  52 +-
 Documentation/hwmon/powr1220             |  12 +-
 Documentation/hwmon/raspberrypi-hwmon    |   3 +
 Documentation/hwmon/sch5636              |   3 +
 Documentation/hwmon/scpi-hwmon           |   7 +-
 Documentation/hwmon/sht15                |  28 +-
 Documentation/hwmon/sht21                |  24 +-
 Documentation/hwmon/sht3x                |  42 +-
 Documentation/hwmon/shtc1                |  19 +-
 Documentation/hwmon/sis5595              |  40 +-
 Documentation/hwmon/smsc47b397           | 158 +++--
 Documentation/hwmon/smsc47m1             |  43 +-
 Documentation/hwmon/smsc47m192           |  97 ++--
 Documentation/hwmon/submitting-patches   |  15 +-
 Documentation/hwmon/sysfs-interface      | 696 ++++++++++++++++-------
 Documentation/hwmon/tc654                |   9 +-
 Documentation/hwmon/tc74                 |   3 +
 Documentation/hwmon/thmc50               |  36 +-
 Documentation/hwmon/tmp102               |   5 +
 Documentation/hwmon/tmp103               |   5 +
 Documentation/hwmon/tmp108               |   5 +
 Documentation/hwmon/tmp421               |  26 +-
 Documentation/hwmon/twl4030-madc-hwmon   |   8 +-
 Documentation/hwmon/userspace-tools      |   3 +
 Documentation/hwmon/via686a              |  30 +-
 Documentation/hwmon/w83627ehf            | 160 ++++--
 Documentation/hwmon/w83627hf             |  65 ++-
 Documentation/hwmon/w83773g              |  12 +-
 Documentation/hwmon/w83781d              | 330 ++++++-----
 Documentation/hwmon/w83792d              | 112 ++--
 Documentation/hwmon/w83795               | 221 +++----
 Documentation/hwmon/w83l785ts            |   9 +-
 Documentation/hwmon/w83l786ng            |  42 +-
 Documentation/hwmon/xgene-hwmon          |  24 +-
 110 files changed, 3503 insertions(+), 1703 deletions(-)

diff --git a/Documentation/hwmon/ab8500 b/Documentation/hwmon/ab8500
index cf169c8ef4e3..d87c61151239 100644
--- a/Documentation/hwmon/ab8500
+++ b/Documentation/hwmon/ab8500
@@ -2,14 +2,18 @@ Kernel driver ab8500
 ====================
 
 Supported chips:
+
   * ST-Ericsson AB8500
+
     Prefix: 'ab8500'
+
     Addresses scanned: -
+
     Datasheet: http://www.stericsson.com/developers/documentation.jsp
 
 Authors:
-        Martin Persson <martin.persson@stericsson.com>
-        Hongbo Zhang <hongbo.zhang@linaro.org>
+	- Martin Persson <martin.persson@stericsson.com>
+	- Hongbo Zhang <hongbo.zhang@linaro.org>
 
 Description
 -----------
diff --git a/Documentation/hwmon/abituguru b/Documentation/hwmon/abituguru
index 44013d23b3f0..d8243c827de9 100644
--- a/Documentation/hwmon/abituguru
+++ b/Documentation/hwmon/abituguru
@@ -2,69 +2,85 @@ Kernel driver abituguru
 =======================
 
 Supported chips:
+
   * Abit uGuru revision 1 & 2 (Hardware Monitor part only)
+
     Prefix: 'abituguru'
+
     Addresses scanned: ISA 0x0E0
+
     Datasheet: Not available, this driver is based on reverse engineering.
-	A "Datasheet" has been written based on the reverse engineering it
-	should be available in the same dir as this file under the name
-	abituguru-datasheet.
+    A "Datasheet" has been written based on the reverse engineering it
+    should be available in the same dir as this file under the name
+    abituguru-datasheet.
+
     Note:
 	The uGuru is a microcontroller with onboard firmware which programs
 	it to behave as a hwmon IC. There are many different revisions of the
 	firmware and thus effectivly many different revisions of the uGuru.
 	Below is an incomplete list with which revisions are used for which
 	Motherboards:
-	uGuru 1.00    ~ 1.24    (AI7, KV8-MAX3, AN7) (1)
-	uGuru 2.0.0.0 ~ 2.0.4.2 (KV8-PRO)
-	uGuru 2.1.0.0 ~ 2.1.2.8 (AS8, AV8, AA8, AG8, AA8XE, AX8)
-	uGuru 2.2.0.0 ~ 2.2.0.6 (AA8 Fatal1ty)
-	uGuru 2.3.0.0 ~ 2.3.0.9 (AN8)
-	uGuru 3.0.0.0 ~ 3.0.x.x (AW8, AL8, AT8, NI8 SLI, AT8 32X, AN8 32X,
-				 AW9D-MAX) (2)
-	1) For revisions 2 and 3 uGuru's the driver can autodetect the
-	   sensortype (Volt or Temp) for bank1 sensors, for revision 1 uGuru's
-	   this does not always work. For these uGuru's the autodetection can
-	   be overridden with the bank1_types module param. For all 3 known
-	   revison 1 motherboards the correct use of this param is:
-	   bank1_types=1,1,0,0,0,0,0,2,0,0,0,0,2,0,0,1
-	   You may also need to specify the fan_sensors option for these boards
-	   fan_sensors=5
-	2) There is a separate abituguru3 driver for these motherboards,
-	   the abituguru (without the 3 !) driver will not work on these
-	   motherboards (and visa versa)!
+
+	- uGuru 1.00    ~ 1.24    (AI7, KV8-MAX3, AN7) [1]_
+	- uGuru 2.0.0.0 ~ 2.0.4.2 (KV8-PRO)
+	- uGuru 2.1.0.0 ~ 2.1.2.8 (AS8, AV8, AA8, AG8, AA8XE, AX8)
+	- uGuru 2.2.0.0 ~ 2.2.0.6 (AA8 Fatal1ty)
+	- uGuru 2.3.0.0 ~ 2.3.0.9 (AN8)
+	- uGuru 3.0.0.0 ~ 3.0.x.x (AW8, AL8, AT8, NI8 SLI, AT8 32X, AN8 32X,
+	  AW9D-MAX) [2]_
+
+.. [1]  For revisions 2 and 3 uGuru's the driver can autodetect the
+	sensortype (Volt or Temp) for bank1 sensors, for revision 1 uGuru's
+	this does not always work. For these uGuru's the autodetection can
+	be overridden with the bank1_types module param. For all 3 known
+	revison 1 motherboards the correct use of this param is:
+	bank1_types=1,1,0,0,0,0,0,2,0,0,0,0,2,0,0,1
+	You may also need to specify the fan_sensors option for these boards
+	fan_sensors=5
+
+.. [2]  There is a separate abituguru3 driver for these motherboards,
+	the abituguru (without the 3 !) driver will not work on these
+	motherboards (and visa versa)!
 
 Authors:
-	Hans de Goede <j.w.r.degoede@hhs.nl>,
-	(Initial reverse engineering done by Olle Sandberg
-	 <ollebull@gmail.com>)
+	- Hans de Goede <j.w.r.degoede@hhs.nl>,
+	- (Initial reverse engineering done by Olle Sandberg
+	  <ollebull@gmail.com>)
 
 
 Module Parameters
 -----------------
 
-* force: bool		Force detection. Note this parameter only causes the
+* force: bool
+			Force detection. Note this parameter only causes the
 			detection to be skipped, and thus the insmod to
 			succeed. If the uGuru can't be read the actual hwmon
 			driver will not load and thus no hwmon device will get
 			registered.
-* bank1_types: int[]	Bank1 sensortype autodetection override:
-			  -1 autodetect (default)
-			   0 volt sensor
-			   1 temp sensor
-			   2 not connected
-* fan_sensors: int	Tell the driver how many fan speed sensors there are
+* bank1_types: int[]
+			Bank1 sensortype autodetection override:
+
+			  * -1 autodetect (default)
+			  *  0 volt sensor
+			  *  1 temp sensor
+			  *  2 not connected
+* fan_sensors: int
+			Tell the driver how many fan speed sensors there are
 			on your motherboard. Default: 0 (autodetect).
-* pwms: int		Tell the driver how many fan speed controls (fan
+* pwms: int
+			Tell the driver how many fan speed controls (fan
 			pwms) your motherboard has. Default: 0 (autodetect).
-* verbose: int		How verbose should the driver be? (0-3):
-			   0 normal output
-			   1 + verbose error reporting
-			   2 + sensors type probing info (default)
-			   3 + retryable error reporting
+* verbose: int
+			How verbose should the driver be? (0-3):
+
+			   * 0 normal output
+			   * 1 + verbose error reporting
+			   * 2 + sensors type probing info (default)
+			   * 3 + retryable error reporting
+
 			Default: 2 (the driver is still in the testing phase)
 
-Notice if you need any of the first three options above please insmod the
+Notice: if you need any of the first three options above please insmod the
 driver with verbose set to 3 and mail me <j.w.r.degoede@hhs.nl> the output of:
 dmesg | grep abituguru
 
@@ -90,3 +106,8 @@ Known Issues
 ------------
 
 The voltage and frequency control parts of the Abit uGuru are not supported.
+
+.. toctree::
+   :maxdepth: 1
+
+   abituguru-datasheet.rst
diff --git a/Documentation/hwmon/abituguru-datasheet b/Documentation/hwmon/abituguru-datasheet
index 86c0b1251c81..6d5253e2223b 100644
--- a/Documentation/hwmon/abituguru-datasheet
+++ b/Documentation/hwmon/abituguru-datasheet
@@ -1,3 +1,4 @@
+===============
 uGuru datasheet
 ===============
 
@@ -168,34 +169,35 @@ This bank contains 0 sensors, iow the sensor address is ignored (but must be
 written) just use 0. Bank 0x20 contains 3 bytes:
 
 Byte 0:
-This byte holds the alarm flags for sensor 0-7 of Sensor Bank1, with bit 0
-corresponding to sensor 0, 1 to 1, etc.
+  This byte holds the alarm flags for sensor 0-7 of Sensor Bank1, with bit 0
+  corresponding to sensor 0, 1 to 1, etc.
 
 Byte 1:
-This byte holds the alarm flags for sensor 8-15 of Sensor Bank1, with bit 0
-corresponding to sensor 8, 1 to 9, etc.
+  This byte holds the alarm flags for sensor 8-15 of Sensor Bank1, with bit 0
+  corresponding to sensor 8, 1 to 9, etc.
 
 Byte 2:
-This byte holds the alarm flags for sensor 0-5 of Sensor Bank2, with bit 0
-corresponding to sensor 0, 1 to 1, etc.
+  This byte holds the alarm flags for sensor 0-5 of Sensor Bank2, with bit 0
+  corresponding to sensor 0, 1 to 1, etc.
 
 
 Bank 0x21 Sensor Bank1 Values / Readings (R)
 --------------------------------------------
 This bank contains 16 sensors, for each sensor it contains 1 byte.
 So far the following sensors are known to be available on all motherboards:
-Sensor  0 CPU temp
-Sensor  1 SYS temp
-Sensor  3 CPU core volt
-Sensor  4 DDR volt
-Sensor 10 DDR Vtt volt
-Sensor 15 PWM temp
+
+- Sensor  0 CPU temp
+- Sensor  1 SYS temp
+- Sensor  3 CPU core volt
+- Sensor  4 DDR volt
+- Sensor 10 DDR Vtt volt
+- Sensor 15 PWM temp
 
 Byte 0:
-This byte holds the reading from the sensor. Sensors in Bank1 can be both
-volt and temp sensors, this is motherboard specific. The uGuru however does
-seem to know (be programmed with) what kindoff sensor is attached see Sensor
-Bank1 Settings description.
+  This byte holds the reading from the sensor. Sensors in Bank1 can be both
+  volt and temp sensors, this is motherboard specific. The uGuru however does
+  seem to know (be programmed with) what kindoff sensor is attached see Sensor
+  Bank1 Settings description.
 
 Volt sensors use a linear scale, a reading 0 corresponds with 0 volt and a
 reading of 255 with 3494 mV. The sensors for higher voltages however are
@@ -207,96 +209,118 @@ Temp sensors also use a linear scale, a reading of 0 corresponds with 0 degree
 Celsius and a reading of 255 with a reading of 255 degrees Celsius.
 
 
-Bank 0x22 Sensor Bank1 Settings (R)
-Bank 0x23 Sensor Bank1 Settings (W)
------------------------------------
+Bank 0x22 Sensor Bank1 Settings (R) and Bank 0x23 Sensor Bank1 Settings (W)
+---------------------------------------------------------------------------
 
-This bank contains 16 sensors, for each sensor it contains 3 bytes. Each
+Those banks contain 16 sensors, for each sensor it contains 3 bytes. Each
 set of 3 bytes contains the settings for the sensor with the same sensor
 address in Bank 0x21 .
 
 Byte 0:
-Alarm behaviour for the selected sensor. A 1 enables the described behaviour.
-Bit 0: Give an alarm if measured temp is over the warning threshold	(RW) *
-Bit 1: Give an alarm if measured volt is over the max threshold		(RW) **
-Bit 2: Give an alarm if measured volt is under the min threshold	(RW) **
-Bit 3: Beep if alarm							(RW)
-Bit 4: 1 if alarm cause measured temp is over the warning threshold	(R)
-Bit 5: 1 if alarm cause measured volt is over the max threshold		(R)
-Bit 6: 1 if alarm cause measured volt is under the min threshold	(R)
-Bit 7: Volt sensor: Shutdown if alarm persist for more than 4 seconds	(RW)
-       Temp sensor: Shutdown if temp is over the shutdown threshold	(RW)
-
-*  This bit is only honored/used by the uGuru if a temp sensor is connected
-** This bit is only honored/used by the uGuru if a volt sensor is connected
-Note with some trickery this can be used to find out what kinda sensor is
-detected see the Linux kernel driver for an example with many comments on
-how todo this.
+  Alarm behaviour for the selected sensor. A 1 enables the described
+  behaviour.
+
+Bit 0:
+  Give an alarm if measured temp is over the warning threshold		(RW) [1]_
+
+Bit 1:
+  Give an alarm if measured volt is over the max threshold		(RW) [2]_
+
+Bit 2:
+  Give an alarm if measured volt is under the min threshold		(RW) [2]_
+
+Bit 3:
+  Beep if alarm								(RW)
+
+Bit 4:
+  1 if alarm cause measured temp is over the warning threshold		(R)
+
+Bit 5:
+  1 if alarm cause measured volt is over the max threshold		(R)
+
+Bit 6:
+  1 if alarm cause measured volt is under the min threshold		(R)
+
+Bit 7:
+  - Volt sensor: Shutdown if alarm persist for more than 4 seconds	(RW)
+  - Temp sensor: Shutdown if temp is over the shutdown threshold	(RW)
+
+.. [1] This bit is only honored/used by the uGuru if a temp sensor is connected
+
+.. [2] This bit is only honored/used by the uGuru if a volt sensor is connected
+       Note with some trickery this can be used to find out what kinda sensor
+       is detected see the Linux kernel driver for an example with many
+       comments on how todo this.
 
 Byte 1:
-Temp sensor: warning threshold  (scale as bank 0x21)
-Volt sensor: min threshold      (scale as bank 0x21)
+  - Temp sensor: warning threshold  (scale as bank 0x21)
+  - Volt sensor: min threshold      (scale as bank 0x21)
 
 Byte 2:
-Temp sensor: shutdown threshold (scale as bank 0x21)
-Volt sensor: max threshold      (scale as bank 0x21)
+  - Temp sensor: shutdown threshold (scale as bank 0x21)
+  - Volt sensor: max threshold      (scale as bank 0x21)
 
 
-Bank 0x24 PWM outputs for FAN's (R)
-Bank 0x25 PWM outputs for FAN's (W)
------------------------------------
+Bank 0x24 PWM outputs for FAN's (R) and Bank 0x25 PWM outputs for FAN's (W)
+---------------------------------------------------------------------------
 
-This bank contains 3 "sensors", for each sensor it contains 5 bytes.
-Sensor 0 usually controls the CPU fan
-Sensor 1 usually controls the NB (or chipset for single chip) fan
-Sensor 2 usually controls the System fan
+Those banks contain 3 "sensors", for each sensor it contains 5 bytes.
+  - Sensor 0 usually controls the CPU fan
+  - Sensor 1 usually controls the NB (or chipset for single chip) fan
+  - Sensor 2 usually controls the System fan
 
 Byte 0:
-Flag 0x80 to enable control, Fan runs at 100% when disabled.
-low nibble (temp)sensor address at bank 0x21 used for control.
+  Flag 0x80 to enable control, Fan runs at 100% when disabled.
+  low nibble (temp)sensor address at bank 0x21 used for control.
 
 Byte 1:
-0-255 = 0-12v (linear), specify voltage at which fan will rotate when under
-low threshold temp (specified in byte 3)
+  0-255 = 0-12v (linear), specify voltage at which fan will rotate when under
+  low threshold temp (specified in byte 3)
 
 Byte 2:
-0-255 = 0-12v (linear), specify voltage at which fan will rotate when above
-high threshold temp (specified in byte 4)
+  0-255 = 0-12v (linear), specify voltage at which fan will rotate when above
+  high threshold temp (specified in byte 4)
 
 Byte 3:
-Low threshold temp  (scale as bank 0x21)
+  Low threshold temp  (scale as bank 0x21)
 
 byte 4:
-High threshold temp (scale as bank 0x21)
+  High threshold temp (scale as bank 0x21)
 
 
 Bank 0x26 Sensors Bank2 Values / Readings (R)
 ---------------------------------------------
 
 This bank contains 6 sensors (AFAIK), for each sensor it contains 1 byte.
+
 So far the following sensors are known to be available on all motherboards:
-Sensor 0: CPU fan speed
-Sensor 1: NB (or chipset for single chip) fan speed
-Sensor 2: SYS fan speed
+  - Sensor 0: CPU fan speed
+  - Sensor 1: NB (or chipset for single chip) fan speed
+  - Sensor 2: SYS fan speed
 
 Byte 0:
-This byte holds the reading from the sensor. 0-255 = 0-15300 (linear)
+  This byte holds the reading from the sensor. 0-255 = 0-15300 (linear)
 
 
-Bank 0x27 Sensors Bank2 Settings (R)
-Bank 0x28 Sensors Bank2 Settings (W)
-------------------------------------
+Bank 0x27 Sensors Bank2 Settings (R) and Bank 0x28 Sensors Bank2 Settings (W)
+-----------------------------------------------------------------------------
 
-This bank contains 6 sensors (AFAIK), for each sensor it contains 2 bytes.
+Those banks contain 6 sensors (AFAIK), for each sensor it contains 2 bytes.
 
 Byte 0:
-Alarm behaviour for the selected sensor. A 1 enables the described behaviour.
-Bit 0: Give an alarm if measured rpm is under the min threshold	(RW)
-Bit 3: Beep if alarm						(RW)
-Bit 7: Shutdown if alarm persist for more than 4 seconds	(RW)
+  Alarm behaviour for the selected sensor. A 1 enables the described behaviour.
+
+Bit 0:
+  Give an alarm if measured rpm is under the min threshold	(RW)
+
+Bit 3:
+  Beep if alarm							(RW)
+
+Bit 7:
+  Shutdown if alarm persist for more than 4 seconds		(RW)
 
 Byte 1:
-min threshold (scale as bank 0x26)
+  min threshold (scale as bank 0x26)
 
 
 Warning for the adventurous
diff --git a/Documentation/hwmon/abituguru3 b/Documentation/hwmon/abituguru3
index a6ccfe4bb6aa..514f11f41e8b 100644
--- a/Documentation/hwmon/abituguru3
+++ b/Documentation/hwmon/abituguru3
@@ -3,41 +3,51 @@ Kernel driver abituguru3
 
 Supported chips:
   * Abit uGuru revision 3 (Hardware Monitor part, reading only)
+
     Prefix: 'abituguru3'
+
     Addresses scanned: ISA 0x0E0
+
     Datasheet: Not available, this driver is based on reverse engineering.
+
     Note:
 	The uGuru is a microcontroller with onboard firmware which programs
 	it to behave as a hwmon IC. There are many different revisions of the
 	firmware and thus effectivly many different revisions of the uGuru.
 	Below is an incomplete list with which revisions are used for which
 	Motherboards:
-	uGuru 1.00    ~ 1.24    (AI7, KV8-MAX3, AN7)
-	uGuru 2.0.0.0 ~ 2.0.4.2 (KV8-PRO)
-	uGuru 2.1.0.0 ~ 2.1.2.8 (AS8, AV8, AA8, AG8, AA8XE, AX8)
-	uGuru 2.3.0.0 ~ 2.3.0.9 (AN8)
-	uGuru 3.0.0.0 ~ 3.0.x.x (AW8, AL8, AT8, NI8 SLI, AT8 32X, AN8 32X,
-				 AW9D-MAX)
+
+	- uGuru 1.00    ~ 1.24    (AI7, KV8-MAX3, AN7)
+	- uGuru 2.0.0.0 ~ 2.0.4.2 (KV8-PRO)
+	- uGuru 2.1.0.0 ~ 2.1.2.8 (AS8, AV8, AA8, AG8, AA8XE, AX8)
+	- uGuru 2.3.0.0 ~ 2.3.0.9 (AN8)
+	- uGuru 3.0.0.0 ~ 3.0.x.x (AW8, AL8, AT8, NI8 SLI, AT8 32X, AN8 32X,
+	  AW9D-MAX)
+
 	The abituguru3 driver is only for revison 3.0.x.x motherboards,
 	this driver will not work on older motherboards. For older
 	motherboards use the abituguru (without the 3 !) driver.
 
 Authors:
-	Hans de Goede <j.w.r.degoede@hhs.nl>,
-	(Initial reverse engineering done by Louis Kruger)
+	- Hans de Goede <j.w.r.degoede@hhs.nl>,
+	- (Initial reverse engineering done by Louis Kruger)
 
 
 Module Parameters
 -----------------
 
-* force: bool		Force detection. Note this parameter only causes the
+* force: bool
+			Force detection. Note this parameter only causes the
 			detection to be skipped, and thus the insmod to
 			succeed. If the uGuru can't be read the actual hwmon
 			driver will not load and thus no hwmon device will get
 			registered.
-* verbose: bool		Should the driver be verbose?
-			0/off/false  normal output
-			1/on/true    + verbose error reporting (default)
+* verbose: bool
+			Should the driver be verbose?
+
+			* 0/off/false  normal output
+			* 1/on/true    + verbose error reporting (default)
+
 			Default: 1 (the driver is still in the testing phase)
 
 Description
@@ -62,4 +72,4 @@ neither is writing any of the sensor settings and writing / reading the
 fanspeed control registers (FanEQ)
 
 If you encounter any problems please mail me <j.w.r.degoede@hhs.nl> and
-include the output of: "dmesg | grep abituguru"
+include the output of: `dmesg | grep abituguru`
diff --git a/Documentation/hwmon/abx500 b/Documentation/hwmon/abx500
index 319a058cec7c..3d88b2ce0f00 100644
--- a/Documentation/hwmon/abx500
+++ b/Documentation/hwmon/abx500
@@ -2,14 +2,18 @@ Kernel driver abx500
 ====================
 
 Supported chips:
+
   * ST-Ericsson ABx500 series
+
     Prefix: 'abx500'
+
     Addresses scanned: -
+
     Datasheet: http://www.stericsson.com/developers/documentation.jsp
 
 Authors:
-        Martin Persson <martin.persson@stericsson.com>
-        Hongbo Zhang <hongbo.zhang@linaro.org>
+	Martin Persson <martin.persson@stericsson.com>
+	Hongbo Zhang <hongbo.zhang@linaro.org>
 
 Description
 -----------
diff --git a/Documentation/hwmon/acpi_power_meter b/Documentation/hwmon/acpi_power_meter
index c80399a00c50..7665ca6ba957 100644
--- a/Documentation/hwmon/acpi_power_meter
+++ b/Documentation/hwmon/acpi_power_meter
@@ -4,8 +4,11 @@ Kernel driver power_meter
 This driver talks to ACPI 4.0 power meters.
 
 Supported systems:
+
   * Any recent system with ACPI 4.0.
+
     Prefix: 'power_meter'
+
     Datasheet: http://acpi.info/, section 10.4.
 
 Author: Darrick J. Wong
@@ -23,21 +26,21 @@ of Documentation/hwmon/sysfs-interface.
 Special Features
 ----------------
 
-The power[1-*]_is_battery knob indicates if the power supply is a battery.
-Both power[1-*]_average_{min,max} must be set before the trip points will work.
+The `power[1-*]_is_battery` knob indicates if the power supply is a battery.
+Both `power[1-*]_average_{min,max}` must be set before the trip points will work.
 When both of them are set, an ACPI event will be broadcast on the ACPI netlink
 socket and a poll notification will be sent to the appropriate
-power[1-*]_average sysfs file.
+`power[1-*]_average` sysfs file.
 
-The power[1-*]_{model_number, serial_number, oem_info} fields display arbitrary
-strings that ACPI provides with the meter.  The measures/ directory contains
-symlinks to the devices that this meter measures.
+The `power[1-*]_{model_number, serial_number, oem_info}` fields display
+arbitrary strings that ACPI provides with the meter.  The measures/ directory
+contains symlinks to the devices that this meter measures.
 
 Some computers have the ability to enforce a power cap in hardware.  If this is
-the case, the power[1-*]_cap and related sysfs files will appear.  When the
+the case, the `power[1-*]_cap` and related sysfs files will appear.  When the
 average power consumption exceeds the cap, an ACPI event will be broadcast on
 the netlink event socket and a poll notification will be sent to the
-appropriate power[1-*]_alarm file to indicate that capping has begun, and the
+appropriate `power[1-*]_alarm` file to indicate that capping has begun, and the
 hardware has taken action to reduce power consumption.  Most likely this will
 result in reduced performance.
 
@@ -46,6 +49,6 @@ all cases the ACPI event will be broadcast on the ACPI netlink event socket as
 well as sent as a poll notification to a sysfs file.  The events are as
 follows:
 
-power[1-*]_cap will be notified if the firmware changes the power cap.
-power[1-*]_interval will be notified if the firmware changes the averaging
+`power[1-*]_cap` will be notified if the firmware changes the power cap.
+`power[1-*]_interval` will be notified if the firmware changes the averaging
 interval.
diff --git a/Documentation/hwmon/ad7314 b/Documentation/hwmon/ad7314
index 1912549c7467..bf389736bcd1 100644
--- a/Documentation/hwmon/ad7314
+++ b/Documentation/hwmon/ad7314
@@ -2,14 +2,23 @@ Kernel driver ad7314
 ====================
 
 Supported chips:
+
    * Analog Devices AD7314
+
      Prefix: 'ad7314'
+
      Datasheet: Publicly available at Analog Devices website.
+
    * Analog Devices ADT7301
+
      Prefix: 'adt7301'
+
      Datasheet: Publicly available at Analog Devices website.
+
    * Analog Devices ADT7302
+
      Prefix: 'adt7302'
+
      Datasheet: Publicly available at Analog Devices website.
 
 Description
diff --git a/Documentation/hwmon/adc128d818 b/Documentation/hwmon/adc128d818
index 39c95004dabc..6753468932ab 100644
--- a/Documentation/hwmon/adc128d818
+++ b/Documentation/hwmon/adc128d818
@@ -2,11 +2,14 @@ Kernel driver adc128d818
 ========================
 
 Supported chips:
+
   * Texas Instruments ADC818D818
+
     Prefix: 'adc818d818'
+
     Addresses scanned: I2C 0x1d, 0x1e, 0x1f, 0x2d, 0x2e, 0x2f
-    Datasheet: Publicly available at the TI website
-               http://www.ti.com/
+
+    Datasheet: Publicly available at the TI website http://www.ti.com/
 
 Author: Guenter Roeck
 
diff --git a/Documentation/hwmon/adm1021 b/Documentation/hwmon/adm1021
index 02ad96cf9b2b..6cbb0f75fe00 100644
--- a/Documentation/hwmon/adm1021
+++ b/Documentation/hwmon/adm1021
@@ -2,51 +2,91 @@ Kernel driver adm1021
 =====================
 
 Supported chips:
+
   * Analog Devices ADM1021
+
     Prefix: 'adm1021'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the Analog Devices website
+
   * Analog Devices ADM1021A/ADM1023
+
     Prefix: 'adm1023'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the Analog Devices website
+
   * Genesys Logic GL523SM
+
     Prefix: 'gl523sm'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet:
+
   * Maxim MAX1617
+
     Prefix: 'max1617'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the Maxim website
+
   * Maxim MAX1617A
+
     Prefix: 'max1617a'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the Maxim website
+
   * National Semiconductor LM84
+
     Prefix: 'lm84'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the National Semiconductor website
+
   * Philips NE1617
+
     Prefix: 'max1617' (probably detected as a max1617)
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the Philips website
+
   * Philips NE1617A
+
     Prefix: 'max1617' (probably detected as a max1617)
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the Philips website
+
   * TI THMC10
+
     Prefix: 'thmc10'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the TI website
+
   * Onsemi MC1066
+
     Prefix: 'mc1066'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the Onsemi website
 
 
 Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>
+	- Frodo Looijaard <frodol@dds.nl>,
+	- Philip Edelbrock <phil@netroedge.com>
 
 Module Parameters
 -----------------
diff --git a/Documentation/hwmon/adm1025 b/Documentation/hwmon/adm1025
index 99f05049c68a..283e65e348a5 100644
--- a/Documentation/hwmon/adm1025
+++ b/Documentation/hwmon/adm1025
@@ -2,23 +2,32 @@ Kernel driver adm1025
 =====================
 
 Supported chips:
+
   * Analog Devices ADM1025, ADM1025A
+
     Prefix: 'adm1025'
+
     Addresses scanned: I2C 0x2c - 0x2e
+
     Datasheet: Publicly available at the Analog Devices website
+
   * Philips NE1619
+
     Prefix: 'ne1619'
+
     Addresses scanned: I2C 0x2c - 0x2d
+
     Datasheet: Publicly available at the Philips website
 
 The NE1619 presents some differences with the original ADM1025:
+
   * Only two possible addresses (0x2c - 0x2d).
   * No temperature offset register, but we don't use it anyway.
   * No INT mode for pin 16. We don't play with it anyway.
 
 Authors:
-        Chen-Yuan Wu <gwu@esoft.com>,
-        Jean Delvare <jdelvare@suse.de>
+	- Chen-Yuan Wu <gwu@esoft.com>,
+	- Jean Delvare <jdelvare@suse.de>
 
 Description
 -----------
diff --git a/Documentation/hwmon/adm1026 b/Documentation/hwmon/adm1026
index d8fabe0c23ac..35d63e6498a3 100644
--- a/Documentation/hwmon/adm1026
+++ b/Documentation/hwmon/adm1026
@@ -3,28 +3,36 @@ Kernel driver adm1026
 
 Supported chips:
   * Analog Devices ADM1026
+
     Prefix: 'adm1026'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.onsemi.com/PowerSolutions/product.do?id=ADM1026
+
+	       http://www.onsemi.com/PowerSolutions/product.do?id=ADM1026
 
 Authors:
-        Philip Pokorny <ppokorny@penguincomputing.com> for Penguin Computing
-        Justin Thiessen <jthiessen@penguincomputing.com>
+	- Philip Pokorny <ppokorny@penguincomputing.com> for Penguin Computing
+	- Justin Thiessen <jthiessen@penguincomputing.com>
 
 Module Parameters
 -----------------
 
 * gpio_input: int array (min = 1, max = 17)
-  List of GPIO pins (0-16) to program as inputs
+    List of GPIO pins (0-16) to program as inputs
+
 * gpio_output: int array (min = 1, max = 17)
-  List of GPIO pins (0-16) to program as outputs
+    List of GPIO pins (0-16) to program as outputs
+
 * gpio_inverted: int array (min = 1, max = 17)
-  List of GPIO pins (0-16) to program as inverted
+    List of GPIO pins (0-16) to program as inverted
+
 * gpio_normal: int array (min = 1, max = 17)
-  List of GPIO pins (0-16) to program as normal/non-inverted
+    List of GPIO pins (0-16) to program as normal/non-inverted
+
 * gpio_fan: int array (min = 1, max = 8)
-  List of GPIO pins (0-7) to program as fan tachs
+    List of GPIO pins (0-7) to program as fan tachs
 
 
 Description
diff --git a/Documentation/hwmon/adm1031 b/Documentation/hwmon/adm1031
index a143117c99cb..a677c3ab5574 100644
--- a/Documentation/hwmon/adm1031
+++ b/Documentation/hwmon/adm1031
@@ -3,20 +3,28 @@ Kernel driver adm1031
 
 Supported chips:
   * Analog Devices ADM1030
+
     Prefix: 'adm1030'
+
     Addresses scanned: I2C 0x2c to 0x2e
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/en/prod/0%2C2877%2CADM1030%2C00.html
+
+	       http://www.analog.com/en/prod/0%2C2877%2CADM1030%2C00.html
 
   * Analog Devices ADM1031
+
     Prefix: 'adm1031'
+
     Addresses scanned: I2C 0x2c to 0x2e
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/en/prod/0%2C2877%2CADM1031%2C00.html
+
+	       http://www.analog.com/en/prod/0%2C2877%2CADM1031%2C00.html
 
 Authors:
-        Alexandre d'Alton <alex@alexdalton.org>
-        Jean Delvare <jdelvare@suse.de>
+	- Alexandre d'Alton <alex@alexdalton.org>
+	- Jean Delvare <jdelvare@suse.de>
 
 Description
 -----------
diff --git a/Documentation/hwmon/adm9240 b/Documentation/hwmon/adm9240
index 9b174fc700cc..91063b0f4c6f 100644
--- a/Documentation/hwmon/adm9240
+++ b/Documentation/hwmon/adm9240
@@ -2,30 +2,43 @@ Kernel driver adm9240
 =====================
 
 Supported chips:
+
   * Analog Devices ADM9240
+
     Prefix: 'adm9240'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: Publicly available at the Analog Devices website
-    http://www.analog.com/UploadedFiles/Data_Sheets/79857778ADM9240_0.pdf
+
+	http://www.analog.com/UploadedFiles/Data_Sheets/79857778ADM9240_0.pdf
 
   * Dallas Semiconductor DS1780
+
     Prefix: 'ds1780'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: Publicly available at the Dallas Semiconductor (Maxim) website
-    http://pdfserv.maxim-ic.com/en/ds/DS1780.pdf
+
+	http://pdfserv.maxim-ic.com/en/ds/DS1780.pdf
 
   * National Semiconductor LM81
+
     Prefix: 'lm81'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: Publicly available at the National Semiconductor website
-    http://www.national.com/ds.cgi/LM/LM81.pdf
+
+	http://www.national.com/ds.cgi/LM/LM81.pdf
 
 Authors:
-    Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>,
-    Michiel Rook <michiel@grendelproject.nl>,
-    Grant Coady <gcoady.lk@gmail.com> with guidance
-        from Jean Delvare <jdelvare@suse.de>
+    - Frodo Looijaard <frodol@dds.nl>,
+    - Philip Edelbrock <phil@netroedge.com>,
+    - Michiel Rook <michiel@grendelproject.nl>,
+    - Grant Coady <gcoady.lk@gmail.com> with guidance
+      from Jean Delvare <jdelvare@suse.de>
 
 Interface
 ---------
@@ -87,11 +100,13 @@ rpm = (22500 * 60) / (count * divider)
 Automatic fan clock divider
 
   * User sets 0 to fan_min limit
+
     - low speed alarm is disabled
     - fan clock divider not changed
     - auto fan clock adjuster enabled for valid fan speed reading
 
   * User sets fan_min limit too low
+
     - low speed alarm is enabled
     - fan clock divider set to max
     - fan_min set to register value 254 which corresponds
@@ -101,18 +116,20 @@ Automatic fan clock divider
     - auto fan clock adjuster disabled
 
   * User sets reasonable fan speed
+
     - low speed alarm is enabled
     - fan clock divider set to suit fan_min
     - auto fan clock adjuster enabled: adjusts fan_min
 
   * User sets unreasonably high low fan speed limit
+
     - resolution of the low speed limit may be reduced
     - alarm will be asserted
     - auto fan clock adjuster enabled: adjusts fan_min
 
-    * fan speed may be displayed as zero until the auto fan clock divider
-      adjuster brings fan speed clock divider back into chip measurement
-      range, this will occur within a few measurement cycles.
+  * fan speed may be displayed as zero until the auto fan clock divider
+    adjuster brings fan speed clock divider back into chip measurement
+    range, this will occur within a few measurement cycles.
 
 Analog Output
 -------------
@@ -122,16 +139,21 @@ power up or reset. This doesn't do much on the test Intel SE440BX-2.
 
 Voltage Monitor
 
+^^^^^^^^^^^^^^^
+
 Voltage (IN) measurement is internally scaled:
 
+    === =========== =========== ========= ==========
     nr  label       nominal     maximum   resolution
-                      mV          mV         mV
+		      mV          mV         mV
+    === =========== =========== ========= ==========
     0   +2.5V        2500        3320       13.0
     1   Vccp1        2700        3600       14.1
     2   +3.3V        3300        4380       17.2
     3     +5V        5000        6640       26.0
     4    +12V       12000       15940       62.5
     5   Vccp2        2700        3600       14.1
+    === =========== =========== ========= ==========
 
 The reading is an unsigned 8-bit value, nominal voltage measurement is
 represented by a reading of 192, being 3/4 of the measurement range.
@@ -159,8 +181,9 @@ Clear the CI latch by writing value 0 to the sysfs intrusion0_alarm file.
 
 Alarm flags reported as 16-bit word
 
+    ===     =============       ==========================
     bit     label               comment
-    ---     -------------       --------------------------
+    ===     =============       ==========================
      0      +2.5 V_Error        high or low limit exceeded
      1      VCCP_Error          high or low limit exceeded
      2      +3.3 V_Error        high or low limit exceeded
@@ -171,6 +194,7 @@ Alarm flags reported as 16-bit word
      8      +12 V_Error         high or low limit exceeded
      9      VCCP2_Error         high or low limit exceeded
     12      Chassis_Error       CI pin went high
+    ===     =============       ==========================
 
 Remaining bits are reserved and thus undefined. It is important to note
 that alarm bits may be cleared on read, user-space may latch alarms and
diff --git a/Documentation/hwmon/ads7828 b/Documentation/hwmon/ads7828
index f6e263e0f607..b830b490cfe4 100644
--- a/Documentation/hwmon/ads7828
+++ b/Documentation/hwmon/ads7828
@@ -2,20 +2,27 @@ Kernel driver ads7828
 =====================
 
 Supported chips:
+
   * Texas Instruments/Burr-Brown ADS7828
+
     Prefix: 'ads7828'
+
     Datasheet: Publicly available at the Texas Instruments website:
-               http://focus.ti.com/lit/ds/symlink/ads7828.pdf
+
+	       http://focus.ti.com/lit/ds/symlink/ads7828.pdf
 
   * Texas Instruments ADS7830
+
     Prefix: 'ads7830'
+
     Datasheet: Publicly available at the Texas Instruments website:
-               http://focus.ti.com/lit/ds/symlink/ads7830.pdf
+
+	       http://focus.ti.com/lit/ds/symlink/ads7830.pdf
 
 Authors:
-        Steve Hardy <shardy@redhat.com>
-        Vivien Didelot <vivien.didelot@savoirfairelinux.com>
-        Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
+	- Steve Hardy <shardy@redhat.com>
+	- Vivien Didelot <vivien.didelot@savoirfairelinux.com>
+	- Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
 
 Platform data
 -------------
@@ -24,16 +31,16 @@ The ads7828 driver accepts an optional ads7828_platform_data structure (defined
 in include/linux/platform_data/ads7828.h). The structure fields are:
 
 * diff_input: (bool) Differential operation
-  set to true for differential mode, false for default single ended mode.
+    set to true for differential mode, false for default single ended mode.
 
 * ext_vref: (bool) External reference
-  set to true if it operates with an external reference, false for default
-  internal reference.
+    set to true if it operates with an external reference, false for default
+    internal reference.
 
 * vref_mv: (unsigned int) Voltage reference
-  if using an external reference, set this to the reference voltage in mV,
-  otherwise it will default to the internal value (2500mV). This value will be
-  bounded with limits accepted by the chip, described in the datasheet.
+    if using an external reference, set this to the reference voltage in mV,
+    otherwise it will default to the internal value (2500mV). This value will be
+    bounded with limits accepted by the chip, described in the datasheet.
 
  If no structure is provided, the configuration defaults to single ended
  operation and internal voltage reference (2.5V).
diff --git a/Documentation/hwmon/adt7410 b/Documentation/hwmon/adt7410
index 9817941e5f19..24caaa83c8ec 100644
--- a/Documentation/hwmon/adt7410
+++ b/Documentation/hwmon/adt7410
@@ -2,26 +2,45 @@ Kernel driver adt7410
 =====================
 
 Supported chips:
+
   * Analog Devices ADT7410
+
     Prefix: 'adt7410'
+
     Addresses scanned: None
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/static/imported-files/data_sheets/ADT7410.pdf
+
+	       http://www.analog.com/static/imported-files/data_sheets/ADT7410.pdf
   * Analog Devices ADT7420
+
     Prefix: 'adt7420'
+
     Addresses scanned: None
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/static/imported-files/data_sheets/ADT7420.pdf
+
+	       http://www.analog.com/static/imported-files/data_sheets/ADT7420.pdf
+
   * Analog Devices ADT7310
+
     Prefix: 'adt7310'
+
     Addresses scanned: None
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/static/imported-files/data_sheets/ADT7310.pdf
+
+	       http://www.analog.com/static/imported-files/data_sheets/ADT7310.pdf
+
   * Analog Devices ADT7320
+
     Prefix: 'adt7320'
+
     Addresses scanned: None
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/static/imported-files/data_sheets/ADT7320.pdf
+
+	       http://www.analog.com/static/imported-files/data_sheets/ADT7320.pdf
 
 Author: Hartmut Knaack <knaack.h@gmx.de>
 
@@ -61,13 +80,15 @@ The device is set to 16 bit resolution and comparator mode.
 sysfs-Interface
 ---------------
 
-temp#_input		- temperature input
-temp#_min		- temperature minimum setpoint
-temp#_max		- temperature maximum setpoint
-temp#_crit		- critical temperature setpoint
-temp#_min_hyst		- hysteresis for temperature minimum (read-only)
-temp#_max_hyst		- hysteresis for temperature maximum (read/write)
-temp#_crit_hyst		- hysteresis for critical temperature (read-only)
-temp#_min_alarm		- temperature minimum alarm flag
-temp#_max_alarm		- temperature maximum alarm flag
-temp#_crit_alarm	- critical temperature alarm flag
+======================== ====================================================
+temp#_input		 temperature input
+temp#_min		 temperature minimum setpoint
+temp#_max		 temperature maximum setpoint
+temp#_crit		 critical temperature setpoint
+temp#_min_hyst		 hysteresis for temperature minimum (read-only)
+temp#_max_hyst		 hysteresis for temperature maximum (read/write)
+temp#_crit_hyst		 hysteresis for critical temperature (read-only)
+temp#_min_alarm		 temperature minimum alarm flag
+temp#_max_alarm		 temperature maximum alarm flag
+temp#_crit_alarm	 critical temperature alarm flag
+======================== ====================================================
diff --git a/Documentation/hwmon/adt7411 b/Documentation/hwmon/adt7411
index 1632960f9745..57ad16fb216a 100644
--- a/Documentation/hwmon/adt7411
+++ b/Documentation/hwmon/adt7411
@@ -2,9 +2,13 @@ Kernel driver adt7411
 =====================
 
 Supported chips:
+
   * Analog Devices ADT7411
+
     Prefix: 'adt7411'
+
     Addresses scanned: 0x48, 0x4a, 0x4b
+
     Datasheet: Publicly available at the Analog Devices website
 
 Author: Wolfram Sang (based on adt7470 by Darrick J. Wong)
@@ -26,15 +30,19 @@ Check the datasheet for details.
 sysfs-Interface
 ---------------
 
-in0_input	- vdd voltage input
-in[1-8]_input	- analog 1-8 input
-temp1_input	- temperature input
+================ =================
+in0_input	 vdd voltage input
+in[1-8]_input	 analog 1-8 input
+temp1_input	 temperature input
+================ =================
 
 Besides standard interfaces, this driver adds (0 = off, 1 = on):
 
-  adc_ref_vdd	- Use vdd as reference instead of 2.25 V
-  fast_sampling	- Sample at 22.5 kHz instead of 1.4 kHz, but drop filters
-  no_average	- Turn off averaging over 16 samples
+  ============== =======================================================
+  adc_ref_vdd	 Use vdd as reference instead of 2.25 V
+  fast_sampling	 Sample at 22.5 kHz instead of 1.4 kHz, but drop filters
+  no_average	 Turn off averaging over 16 samples
+  ============== =======================================================
 
 Notes
 -----
diff --git a/Documentation/hwmon/adt7462 b/Documentation/hwmon/adt7462
index ec660b328275..a7a831118d32 100644
--- a/Documentation/hwmon/adt7462
+++ b/Documentation/hwmon/adt7462
@@ -1,10 +1,14 @@
 Kernel driver adt7462
-======================
+=====================
 
 Supported chips:
+
   * Analog Devices ADT7462
+
     Prefix: 'adt7462'
+
     Addresses scanned: I2C 0x58, 0x5C
+
     Datasheet: Publicly available at the Analog Devices website
 
 Author: Darrick J. Wong
@@ -57,8 +61,8 @@ Besides standard interfaces driver adds the following:
 * pwm#_auto_point1_pwm and temp#_auto_point1_temp and
 * pwm#_auto_point2_pwm and temp#_auto_point2_temp -
 
-point1: Set the pwm speed at a lower temperature bound.
-point2: Set the pwm speed at a higher temperature bound.
+  - point1: Set the pwm speed at a lower temperature bound.
+  - point2: Set the pwm speed at a higher temperature bound.
 
 The ADT7462 will scale the pwm between the lower and higher pwm speed when
 the temperature is between the two temperature boundaries.  PWM values range
diff --git a/Documentation/hwmon/adt7470 b/Documentation/hwmon/adt7470
index fe68e18a0c8d..d225f816e992 100644
--- a/Documentation/hwmon/adt7470
+++ b/Documentation/hwmon/adt7470
@@ -2,9 +2,13 @@ Kernel driver adt7470
 =====================
 
 Supported chips:
+
   * Analog Devices ADT7470
+
     Prefix: 'adt7470'
+
     Addresses scanned: I2C 0x2C, 0x2E, 0x2F
+
     Datasheet: Publicly available at the Analog Devices website
 
 Author: Darrick J. Wong
@@ -56,8 +60,8 @@ Besides standard interfaces driver adds the following:
 * pwm#_auto_point1_pwm and pwm#_auto_point1_temp and
 * pwm#_auto_point2_pwm and pwm#_auto_point2_temp -
 
-point1: Set the pwm speed at a lower temperature bound.
-point2: Set the pwm speed at a higher temperature bound.
+  - point1: Set the pwm speed at a lower temperature bound.
+  - point2: Set the pwm speed at a higher temperature bound.
 
 The ADT7470 will scale the pwm between the lower and higher pwm speed when
 the temperature is between the two temperature boundaries.  PWM values range
diff --git a/Documentation/hwmon/adt7475 b/Documentation/hwmon/adt7475
index 01b46b290532..ef3ea1ea9bc1 100644
--- a/Documentation/hwmon/adt7475
+++ b/Documentation/hwmon/adt7475
@@ -2,28 +2,44 @@ Kernel driver adt7475
 =====================
 
 Supported chips:
+
   * Analog Devices ADT7473
+
     Prefix: 'adt7473'
+
     Addresses scanned: I2C 0x2C, 0x2D, 0x2E
+
     Datasheet: Publicly available at the On Semiconductors website
+
   * Analog Devices ADT7475
+
     Prefix: 'adt7475'
+
     Addresses scanned: I2C 0x2E
+
     Datasheet: Publicly available at the On Semiconductors website
+
   * Analog Devices ADT7476
+
     Prefix: 'adt7476'
+
     Addresses scanned: I2C 0x2C, 0x2D, 0x2E
+
     Datasheet: Publicly available at the On Semiconductors website
+
   * Analog Devices ADT7490
+
     Prefix: 'adt7490'
+
     Addresses scanned: I2C 0x2C, 0x2D, 0x2E
+
     Datasheet: Publicly available at the On Semiconductors website
 
 Authors:
-	Jordan Crouse
-	Hans de Goede
-	Darrick J. Wong (documentation)
-	Jean Delvare
+	- Jordan Crouse
+	- Hans de Goede
+	- Darrick J. Wong (documentation)
+	- Jean Delvare
 
 
 Description
@@ -82,14 +98,16 @@ ADT7490:
 Sysfs Mapping
 -------------
 
-     ADT7490     ADT7476     ADT7475   ADT7473
-     -------     -------     -------   -------
+==== =========== =========== ========= ==========
+in   ADT7490     ADT7476     ADT7475   ADT7473
+==== =========== =========== ========= ==========
 in0  2.5VIN (22) 2.5VIN (22) -         -
 in1  VCCP   (23) VCCP   (23) VCCP (14) VCCP (14)
 in2  VCC    (4)  VCC    (4)  VCC  (4)  VCC  (3)
 in3  5VIN   (20) 5VIN   (20)
 in4  12VIN  (21) 12VIN  (21)
 in5  VTT    (8)
+==== =========== =========== ========= ==========
 
 Special Features
 ----------------
@@ -107,8 +125,8 @@ Fan Speed Control
 
 The driver exposes two trip points per PWM channel.
 
-point1: Set the PWM speed at the lower temperature bound
-point2: Set the PWM speed at the higher temperature bound
+- point1: Set the PWM speed at the lower temperature bound
+- point2: Set the PWM speed at the higher temperature bound
 
 The ADT747x will scale the PWM linearly between the lower and higher PWM
 speed when the temperature is between the two temperature boundaries.
@@ -123,12 +141,12 @@ the PWM control exceeds temp#_max.
 
 At Tmin - hysteresis the PWM output can either be off (0% duty cycle) or at the
 minimum (i.e. auto_point1_pwm). This behaviour can be configured using the
-pwm[1-*]_stall_disable sysfs attribute. A value of 0 means the fans will shut
+`pwm[1-*]_stall_disable sysfs attribute`. A value of 0 means the fans will shut
 off. A value of 1 means the fans will run at auto_point1_pwm.
 
 The responsiveness of the ADT747x to temperature changes can be configured.
 This allows smoothing of the fan speed transition. To set the transition time
-set the value in ms in the temp[1-*]_smoothing sysfs attribute.
+set the value in ms in the `temp[1-*]_smoothing` sysfs attribute.
 
 Notes
 -----
diff --git a/Documentation/hwmon/amc6821 b/Documentation/hwmon/amc6821
index ced8359c50f8..d10eabcbc0f3 100644
--- a/Documentation/hwmon/amc6821
+++ b/Documentation/hwmon/amc6821
@@ -2,9 +2,13 @@ Kernel driver amc6821
 =====================
 
 Supported chips:
+
 	Texas Instruments AMC6821
+
 	Prefix: 'amc6821'
+
 	Addresses scanned: 0x18, 0x19, 0x1a, 0x2c, 0x2d, 0x2e, 0x4c, 0x4d, 0x4e
+
 	Datasheet: http://focus.ti.com/docs/prod/folders/print/amc6821.html
 
 Authors:
@@ -21,10 +25,11 @@ The pwm can be controlled either from software or automatically.
 
 The driver provides the following sensor accesses in sysfs:
 
+======================= ==      ===============================================
 temp1_input		ro	on-chip temperature
 temp1_min		rw	"
 temp1_max		rw	"
-temp1_crit	 	rw	"
+temp1_crit		rw	"
 temp1_min_alarm		ro	"
 temp1_max_alarm		ro	"
 temp1_crit_alarm	ro	"
@@ -32,16 +37,16 @@ temp1_crit_alarm	ro	"
 temp2_input		ro	remote temperature
 temp2_min		rw	"
 temp2_max		rw	"
-temp2_crit	 	rw	"
+temp2_crit		rw	"
 temp2_min_alarm		ro	"
 temp2_max_alarm		ro	"
 temp2_crit_alarm	ro	"
 temp2_fault		ro	"
 
-fan1_input	 	ro	tachometer speed
+fan1_input		ro	tachometer speed
 fan1_min		rw	"
 fan1_max		rw	"
-fan1_fault	 	ro	"
+fan1_fault		ro	"
 fan1_div		rw	Fan divisor can be either 2 or 4.
 
 pwm1			rw	pwm1
@@ -87,6 +92,7 @@ temp2_auto_point3_temp	rw	Above this temperature fan runs at maximum
 				values which depend on temp2_auto_point2_temp
 				and pwm1_auto_point2_pwm. Read it out after
 				writing to get actual value.
+======================= ==      ===============================================
 
 
 Module parameters
@@ -97,6 +103,7 @@ load the module with: init=0.
 
 If your board BIOS doesn't initialize the chip, or you want
 different settings, you can set the following parameters:
-init=1,
-pwminv: 0 default pwm output, 1 inverts pwm output.
+
+- init=1,
+- pwminv: 0 default pwm output, 1 inverts pwm output.
 
diff --git a/Documentation/hwmon/asb100 b/Documentation/hwmon/asb100
index ab7365e139be..311d9f7b6926 100644
--- a/Documentation/hwmon/asb100
+++ b/Documentation/hwmon/asb100
@@ -2,9 +2,13 @@ Kernel driver asb100
 ====================
 
 Supported Chips:
+
   * Asus ASB100 and ASB100-A "Bach"
+
     Prefix: 'asb100'
+
     Addresses scanned: I2C 0x2d
+
     Datasheet: none released
 
 Author: Mark M. Hoffman <mhoffman@lightlink.com>
@@ -41,32 +45,30 @@ processor itself. It is a value in volts.
 
 Alarms: (TODO question marks indicate may or may not work)
 
-0x0001 => in0 (?)
-0x0002 => in1 (?)
-0x0004 => in2
-0x0008 => in3
-0x0010 => temp1 (1)
-0x0020 => temp2
-0x0040 => fan1
-0x0080 => fan2
-0x0100 => in4
-0x0200 => in5 (?) (2)
-0x0400 => in6 (?) (2)
-0x0800 => fan3
-0x1000 => chassis switch
-0x2000 => temp3
+- 0x0001 => in0 (?)
+- 0x0002 => in1 (?)
+- 0x0004 => in2
+- 0x0008 => in3
+- 0x0010 => temp1 [1]_
+- 0x0020 => temp2
+- 0x0040 => fan1
+- 0x0080 => fan2
+- 0x0100 => in4
+- 0x0200 => in5 (?) [2]_
+- 0x0400 => in6 (?) [2]_
+- 0x0800 => fan3
+- 0x1000 => chassis switch
+- 0x2000 => temp3
 
-Alarm Notes:
+.. [1]	This alarm will only trigger if the hysteresis value is 127C.
+	I.e. it behaves the same as w83781d.
 
-(1) This alarm will only trigger if the hysteresis value is 127C.
-I.e. it behaves the same as w83781d.
-
-(2) The min and max registers for these values appear to
-be read-only or otherwise stuck at 0x00.
+.. [2]	The min and max registers for these values appear to
+	be read-only or otherwise stuck at 0x00.
 
 TODO:
-* Experiment with fan divisors > 8.
-* Experiment with temp. sensor types.
-* Are there really 13 voltage inputs? Probably not...
-* Cleanups, no doubt...
+  * Experiment with fan divisors > 8.
+  * Experiment with temp. sensor types.
+  * Are there really 13 voltage inputs? Probably not...
+  * Cleanups, no doubt...
 
diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index fa3407997795..552b37e9dd34 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -2,42 +2,61 @@ Kernel driver ds1621
 ====================
 
 Supported chips:
+
   * Dallas Semiconductor / Maxim Integrated DS1621
+
     Prefix: 'ds1621'
+
     Addresses scanned: none
+
     Datasheet: Publicly available from www.maximintegrated.com
 
   * Dallas Semiconductor DS1625
+
     Prefix: 'ds1625'
+
     Addresses scanned: none
+
     Datasheet: Publicly available from www.datasheetarchive.com
 
   * Maxim Integrated DS1631
+
     Prefix: 'ds1631'
+
     Addresses scanned: none
+
     Datasheet: Publicly available from www.maximintegrated.com
 
   * Maxim Integrated DS1721
+
     Prefix: 'ds1721'
+
     Addresses scanned: none
+
     Datasheet: Publicly available from www.maximintegrated.com
 
   * Maxim Integrated DS1731
+
     Prefix: 'ds1731'
+
     Addresses scanned: none
+
     Datasheet: Publicly available from www.maximintegrated.com
 
 Authors:
-        Christian W. Zuckschwerdt <zany@triq.net>
-        valuable contributions by Jan M. Sendler <sendler@sendler.de>
-        ported to 2.6 by Aurelien Jarno <aurelien@aurel32.net>
-        with the help of Jean Delvare <jdelvare@suse.de>
+      - Christian W. Zuckschwerdt <zany@triq.net>
+      - valuable contributions by Jan M. Sendler <sendler@sendler.de>
+      - ported to 2.6 by Aurelien Jarno <aurelien@aurel32.net>
+	with the help of Jean Delvare <jdelvare@suse.de>
 
 Module Parameters
 ------------------
 
 * polarity int
-  Output's polarity: 0 = active high, 1 = active low
+  Output's polarity:
+
+  * 0 = active high,
+  * 1 = active low
 
 Description
 -----------
@@ -87,28 +106,31 @@ are used internally, however, these flags do get set and cleared as the actual
 temperature crosses the min or max settings (which by default are set to 75
 and 80 degrees respectively).
 
-Temperature Conversion:
------------------------
-DS1621 - 750ms (older devices may take up to 1000ms)
-DS1625 - 500ms
-DS1631 - 93ms..750ms for 9..12 bits resolution, respectively.
-DS1721 - 93ms..750ms for 9..12 bits resolution, respectively.
-DS1731 - 93ms..750ms for 9..12 bits resolution, respectively.
+Temperature Conversion
+----------------------
+
+- DS1621 - 750ms (older devices may take up to 1000ms)
+- DS1625 - 500ms
+- DS1631 - 93ms..750ms for 9..12 bits resolution, respectively.
+- DS1721 - 93ms..750ms for 9..12 bits resolution, respectively.
+- DS1731 - 93ms..750ms for 9..12 bits resolution, respectively.
 
 Note:
 On the DS1621, internal access to non-volatile registers may last for 10ms
 or less (unverified on the other devices).
 
-Temperature Accuracy:
----------------------
-DS1621: +/- 0.5 degree Celsius (from 0 to +70 degrees)
-DS1625: +/- 0.5 degree Celsius (from 0 to +70 degrees)
-DS1631: +/- 0.5 degree Celsius (from 0 to +70 degrees)
-DS1721: +/- 1.0 degree Celsius (from -10 to +85 degrees)
-DS1731: +/- 1.0 degree Celsius (from -10 to +85 degrees)
+Temperature Accuracy
+--------------------
 
-Note:
-Please refer to the device datasheets for accuracy at other temperatures.
+- DS1621: +/- 0.5 degree Celsius (from 0 to +70 degrees)
+- DS1625: +/- 0.5 degree Celsius (from 0 to +70 degrees)
+- DS1631: +/- 0.5 degree Celsius (from 0 to +70 degrees)
+- DS1721: +/- 1.0 degree Celsius (from -10 to +85 degrees)
+- DS1731: +/- 1.0 degree Celsius (from -10 to +85 degrees)
+
+.. Note::
+
+   Please refer to the device datasheets for accuracy at other temperatures.
 
 Temperature Resolution:
 -----------------------
@@ -117,60 +139,67 @@ support, which is achieved via the R0 and R1 config register bits, where:
 
 R0..R1
 ------
- 0  0 => 9 bits, 0.5 degrees Celsius
- 1  0 => 10 bits, 0.25 degrees Celsius
- 0  1 => 11 bits, 0.125 degrees Celsius
- 1  1 => 12 bits, 0.0625 degrees Celsius
 
-Note:
-At initial device power-on, the default resolution is set to 12-bits.
+== ==  ===============================
+R0 R1
+== ==  ===============================
+ 0  0  9 bits, 0.5 degrees Celsius
+ 1  0  10 bits, 0.25 degrees Celsius
+ 0  1  11 bits, 0.125 degrees Celsius
+ 1  1  12 bits, 0.0625 degrees Celsius
+== ==  ===============================
+
+.. Note::
+
+   At initial device power-on, the default resolution is set to 12-bits.
 
 The resolution mode for the DS1631, DS1721, or DS1731 can be changed from
 userspace, via the device 'update_interval' sysfs attribute. This attribute
 will normalize the range of input values to the device maximum resolution
 values defined in the datasheet as follows:
 
+============= ================== ===============
 Resolution    Conversion Time    Input Range
  (C/LSB)       (msec)             (msec)
-------------------------------------------------
+============= ================== ===============
 0.5             93.75              0....94
 0.25            187.5              95...187
 0.125           375                188..375
 0.0625          750                376..infinity
-------------------------------------------------
+============= ================== ===============
 
 The following examples show how the 'update_interval' attribute can be
-used to change the conversion time:
+used to change the conversion time::
 
-$ cat update_interval
-750
-$ cat temp1_input
-22062
-$
-$ echo 300 > update_interval
-$ cat update_interval
-375
-$ cat temp1_input
-22125
-$
-$ echo 150 > update_interval
-$ cat update_interval
-188
-$ cat temp1_input
-22250
-$
-$ echo 1 > update_interval
-$ cat update_interval
-94
-$ cat temp1_input
-22000
-$
-$ echo 1000 > update_interval
-$ cat update_interval
-750
-$ cat temp1_input
-22062
-$
+  $ cat update_interval
+  750
+  $ cat temp1_input
+  22062
+  $
+  $ echo 300 > update_interval
+  $ cat update_interval
+  375
+  $ cat temp1_input
+  22125
+  $
+  $ echo 150 > update_interval
+  $ cat update_interval
+  188
+  $ cat temp1_input
+  22250
+  $
+  $ echo 1 > update_interval
+  $ cat update_interval
+  94
+  $ cat temp1_input
+  22000
+  $
+  $ echo 1000 > update_interval
+  $ cat update_interval
+  750
+  $ cat temp1_input
+  22062
+  $
 
 As shown, the ds1621 driver automatically adjusts the 'update_interval'
 user input, via a step function. Reading back the 'update_interval' value
@@ -182,6 +211,7 @@ via the following function:
    g(x) = 0.5 * [minimum_conversion_time/x]
 
 where:
- -> 'x' = the output from 'update_interval'
- -> 'g(x)' = the resolution in degrees C per LSB.
- -> 93.75ms = minimum conversion time
+
+ - 'x' = the output from 'update_interval'
+ - 'g(x)' = the resolution in degrees C per LSB.
+ - 93.75ms = minimum conversion time
diff --git a/Documentation/hwmon/ds620 b/Documentation/hwmon/ds620
index 1fbe3cd916cc..2d686b17b547 100644
--- a/Documentation/hwmon/ds620
+++ b/Documentation/hwmon/ds620
@@ -2,15 +2,19 @@ Kernel driver ds620
 ===================
 
 Supported chips:
+
   * Dallas Semiconductor DS620
+
     Prefix: 'ds620'
+
     Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.dalsemi.com/
+
+	       http://www.dalsemi.com/
 
 Authors:
-        Roland Stigge <stigge@antcom.de>
-        based on ds1621.c by
-        Christian W. Zuckschwerdt <zany@triq.net>
+	Roland Stigge <stigge@antcom.de>
+	based on ds1621.c by
+	Christian W. Zuckschwerdt <zany@triq.net>
 
 Description
 -----------
diff --git a/Documentation/hwmon/emc1403 b/Documentation/hwmon/emc1403
index a869b0ef6a9d..3a4913b63ef3 100644
--- a/Documentation/hwmon/emc1403
+++ b/Documentation/hwmon/emc1403
@@ -2,28 +2,48 @@ Kernel driver emc1403
 =====================
 
 Supported chips:
+
   * SMSC / Microchip EMC1402, EMC1412
+
     Addresses scanned: I2C 0x18, 0x1c, 0x29, 0x4c, 0x4d, 0x5c
+
     Prefix: 'emc1402'
+
     Datasheets:
-	http://ww1.microchip.com/downloads/en/DeviceDoc/1412.pdf
-	http://ww1.microchip.com/downloads/en/DeviceDoc/1402.pdf
+
+	- http://ww1.microchip.com/downloads/en/DeviceDoc/1412.pdf
+	- http://ww1.microchip.com/downloads/en/DeviceDoc/1402.pdf
+
   * SMSC / Microchip EMC1403, EMC1404, EMC1413, EMC1414
+
     Addresses scanned: I2C 0x18, 0x29, 0x4c, 0x4d
+
     Prefix: 'emc1403', 'emc1404'
+
     Datasheets:
-	http://ww1.microchip.com/downloads/en/DeviceDoc/1403_1404.pdf
-	http://ww1.microchip.com/downloads/en/DeviceDoc/1413_1414.pdf
+
+	- http://ww1.microchip.com/downloads/en/DeviceDoc/1403_1404.pdf
+	- http://ww1.microchip.com/downloads/en/DeviceDoc/1413_1414.pdf
+
   * SMSC / Microchip EMC1422
+
     Addresses scanned: I2C 0x4c
+
     Prefix: 'emc1422'
+
     Datasheet:
-	http://ww1.microchip.com/downloads/en/DeviceDoc/1422.pdf
+
+	- http://ww1.microchip.com/downloads/en/DeviceDoc/1422.pdf
+
   * SMSC / Microchip EMC1423, EMC1424
+
     Addresses scanned: I2C 0x4c
+
     Prefix: 'emc1423', 'emc1424'
+
     Datasheet:
-	http://ww1.microchip.com/downloads/en/DeviceDoc/1423_1424.pdf
+
+	- http://ww1.microchip.com/downloads/en/DeviceDoc/1423_1424.pdf
 
 Author:
     Kalhan Trisal <kalhan.trisal@intel.com
@@ -46,6 +66,7 @@ difference between the limit and its hysteresis is always the same for
 all three limits.
 
 This implementation detail implies the following:
+
 * When setting a limit, its hysteresis will automatically follow, the
   difference staying unchanged. For example, if the old critical limit
   was 80 degrees C, and the hysteresis was 75 degrees C, and you change
diff --git a/Documentation/hwmon/emc6w201 b/Documentation/hwmon/emc6w201
index 757629b12897..a8e1185b9bb6 100644
--- a/Documentation/hwmon/emc6w201
+++ b/Documentation/hwmon/emc6w201
@@ -2,9 +2,13 @@ Kernel driver emc6w201
 ======================
 
 Supported chips:
+
   * SMSC EMC6W201
+
     Prefix: 'emc6w201'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: Not public
 
 Author: Jean Delvare <jdelvare@suse.de>
@@ -38,5 +42,6 @@ Known Systems With EMC6W201
 
 The EMC6W201 is a rare device, only found on a few systems, made in
 2005 and 2006. Known systems with this device:
+
 * Dell Precision 670 workstation
 * Gigabyte 2CEWH mainboard
diff --git a/Documentation/hwmon/f71805f b/Documentation/hwmon/f71805f
index 48a356084bc6..1efe5e5d337c 100644
--- a/Documentation/hwmon/f71805f
+++ b/Documentation/hwmon/f71805f
@@ -2,17 +2,29 @@ Kernel driver f71805f
 =====================
 
 Supported chips:
+
   * Fintek F71805F/FG
+
     Prefix: 'f71805f'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
+
   * Fintek F71806F/FG
+
     Prefix: 'f71872f'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
+
   * Fintek F71872F/FG
+
     Prefix: 'f71872f'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
 
 Author: Jean Delvare <jdelvare@suse.de>
@@ -64,24 +76,26 @@ you can only set the limits in steps of 32 mV (before scaling).
 
 The wirings and resistor values suggested by Fintek are as follow:
 
-        pin                                           expected
-        name    use           R1      R2     divider  raw val.
-
+======= ======= =========== ==== ======= ============ ==============
+in      pin                                           expected
+	name    use           R1      R2     divider  raw val.
+======= ======= =========== ==== ======= ============ ==============
 in0     VCC     VCC3.3V     int.    int.        2.00    1.65 V
 in1     VIN1    VTT1.2V      10K       -        1.00    1.20 V
-in2     VIN2    VRAM        100K    100K        2.00   ~1.25 V (1)
-in3     VIN3    VCHIPSET     47K    100K        1.47    2.24 V (2)
+in2     VIN2    VRAM        100K    100K        2.00   ~1.25 V [1]_
+in3     VIN3    VCHIPSET     47K    100K        1.47    2.24 V [2]_
 in4     VIN4    VCC5V       200K     47K        5.25    0.95 V
 in5     VIN5    +12V        200K     20K       11.00    1.05 V
 in6     VIN6    VCC1.5V      10K       -        1.00    1.50 V
-in7     VIN7    VCORE        10K       -        1.00   ~1.40 V (1)
+in7     VIN7    VCORE        10K       -        1.00   ~1.40 V [1]_
 in8     VIN8    VSB5V       200K     47K        1.00    0.95 V
-in10    VSB     VSB3.3V     int.    int.        2.00    1.65 V (3)
-in9     VBAT    VBATTERY    int.    int.        2.00    1.50 V (3)
+in10    VSB     VSB3.3V     int.    int.        2.00    1.65 V [3]_
+in9     VBAT    VBATTERY    int.    int.        2.00    1.50 V [3]_
+======= ======= =========== ==== ======= ============ ==============
 
-(1) Depends on your hardware setup.
-(2) Obviously not correct, swapping R1 and R2 would make more sense.
-(3) F71872F/FG only.
+.. [1] Depends on your hardware setup.
+.. [2] Obviously not correct, swapping R1 and R2 would make more sense.
+.. [3] F71872F/FG only.
 
 These values can be used as hints at best, as motherboard manufacturers
 are free to use a completely different setup. As a matter of fact, the
diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882fg
index 4c3cb8377d74..5c0b7b0db150 100644
--- a/Documentation/hwmon/f71882fg
+++ b/Documentation/hwmon/f71882fg
@@ -2,60 +2,114 @@ Kernel driver f71882fg
 ======================
 
 Supported chips:
+
   * Fintek F71808E
+
     Prefix: 'f71808e'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Not public
+
   * Fintek F71808A
+
     Prefix: 'f71808a'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Not public
+
   * Fintek F71858FG
+
     Prefix: 'f71858fg'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
+
   * Fintek F71862FG and F71863FG
+
     Prefix: 'f71862fg'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
+
   * Fintek F71869F and F71869E
+
     Prefix: 'f71869'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
+
   * Fintek F71869A
+
     Prefix: 'f71869a'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Not public
+
   * Fintek F71882FG and F71883FG
+
     Prefix: 'f71882fg'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
+
   * Fintek F71889FG
+
     Prefix: 'f71889fg'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
+
   * Fintek F71889ED
+
     Prefix: 'f71889ed'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Should become available on the Fintek website soon
+
   * Fintek F71889A
+
     Prefix: 'f71889a'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Should become available on the Fintek website soon
+
   * Fintek F8000
+
     Prefix: 'f8000'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Not public
+
   * Fintek F81801U
+
     Prefix: 'f71889fg'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Not public
-    Note: This is the 64-pin variant of the F71889FG, they have the
+
+    Note:
+	  This is the 64-pin variant of the F71889FG, they have the
 	  same device ID and are fully compatible as far as hardware
 	  monitoring is concerned.
+
   * Fintek F81865F
+
     Prefix: 'f81865f'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Available from the Fintek website
 
 Author: Hans de Goede <hdegoede@redhat.com>
diff --git a/Documentation/hwmon/ftsteutates b/Documentation/hwmon/ftsteutates
index af54db92391b..58a2483d8d0d 100644
--- a/Documentation/hwmon/ftsteutates
+++ b/Documentation/hwmon/ftsteutates
@@ -1,9 +1,12 @@
 Kernel driver ftsteutates
-=====================
+=========================
 
 Supported chips:
+
   * FTS Teutates
+
     Prefix: 'ftsteutates'
+
     Addresses scanned: I2C 0x73 (7-Bit)
 
 Author: Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>
@@ -11,6 +14,7 @@ Author: Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>
 
 Description
 -----------
+
 The BMC Teutates is the Eleventh generation of Superior System
 monitoring and thermal management solution. It is builds on the basic
 functionality of the BMC Theseus and contains several new features and
@@ -19,9 +23,11 @@ enhancements. It can monitor up to 4 voltages, 16 temperatures and
 implemented in this driver.
 
 To clear a temperature or fan alarm, execute the following command with the
-correct path to the alarm file:
+correct path to the alarm file::
+
 	echo 0 >XXXX_alarm
 
 Specification of the chip can be found here:
-ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&Tools/Linux_SystemMonitoring&Watchdog&GPIO/BMC-Teutates_Specification_V1.21.pdf
-ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&Tools/Linux_SystemMonitoring&Watchdog&GPIO/Fujitsu_mainboards-1-Sensors_HowTo-en-US.pdf
+
+- ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&Tools/Linux_SystemMonitoring&Watchdog&GPIO/BMC-Teutates_Specification_V1.21.pdf
+- ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&Tools/Linux_SystemMonitoring&Watchdog&GPIO/Fujitsu_mainboards-1-Sensors_HowTo-en-US.pdf
diff --git a/Documentation/hwmon/g760a b/Documentation/hwmon/g760a
index cfc894537061..d82952cc8319 100644
--- a/Documentation/hwmon/g760a
+++ b/Documentation/hwmon/g760a
@@ -2,9 +2,13 @@ Kernel driver g760a
 ===================
 
 Supported chips:
+
   * Global Mixed-mode Technology Inc. G760A
+
     Prefix: 'g760a'
+
     Datasheet: Publicly available at the GMT website
+
       http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf
 
 Author: Herbert Valerio Riedel <hvr@gnu.org>
diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762
index 923db9c5b5bc..54574e26df21 100644
--- a/Documentation/hwmon/g762
+++ b/Documentation/hwmon/g762
@@ -21,34 +21,43 @@ documented in Documentation/devicetree/bindings/hwmon/g762.txt or
 using a specific platform_data structure in board initialization
 file (see include/linux/platform_data/g762.h).
 
-  fan1_target: set desired fan speed. This only makes sense in closed-loop
-            fan speed control (i.e. when pwm1_enable is set to 2).
-
-  fan1_input: provide current fan rotation value in RPM as reported by
-            the fan to the device.
-
-  fan1_div: fan clock divisor. Supported value are 1, 2, 4 and 8.
-
-  fan1_pulses: number of pulses per fan revolution. Supported values
-            are 2 and 4.
-
-  fan1_fault: reports fan failure, i.e. no transition on fan gear pin for
-            about 0.7s (if the fan is not voluntarily set off).
-
-  fan1_alarm: in closed-loop control mode, if fan RPM value is 25% out
-            of the programmed value for over 6 seconds 'fan1_alarm' is
-            set to 1.
-
-  pwm1_enable: set current fan speed control mode i.e. 1 for manual fan
-            speed control (open-loop) via pwm1 described below, 2 for
-            automatic fan speed control (closed-loop) via fan1_target
-            above.
-
-  pwm1_mode: set or get fan driving mode: 1 for PWM mode, 0 for DC mode.
-
-  pwm1: get or set PWM fan control value in open-loop mode. This is an
-            integer value between 0 and 255. 0 stops the fan, 255 makes
-            it run at full speed.
+  fan1_target:
+	    set desired fan speed. This only makes sense in closed-loop
+	    fan speed control (i.e. when pwm1_enable is set to 2).
+
+  fan1_input:
+	    provide current fan rotation value in RPM as reported by
+	    the fan to the device.
+
+  fan1_div:
+	    fan clock divisor. Supported value are 1, 2, 4 and 8.
+
+  fan1_pulses:
+	    number of pulses per fan revolution. Supported values
+	    are 2 and 4.
+
+  fan1_fault:
+	    reports fan failure, i.e. no transition on fan gear pin for
+	    about 0.7s (if the fan is not voluntarily set off).
+
+  fan1_alarm:
+	    in closed-loop control mode, if fan RPM value is 25% out
+	    of the programmed value for over 6 seconds 'fan1_alarm' is
+	    set to 1.
+
+  pwm1_enable:
+	    set current fan speed control mode i.e. 1 for manual fan
+	    speed control (open-loop) via pwm1 described below, 2 for
+	    automatic fan speed control (closed-loop) via fan1_target
+	    above.
+
+  pwm1_mode:
+	    set or get fan driving mode: 1 for PWM mode, 0 for DC mode.
+
+  pwm1:
+	    get or set PWM fan control value in open-loop mode. This is an
+	    integer value between 0 and 255. 0 stops the fan, 255 makes
+	    it run at full speed.
 
 Both in PWM mode ('pwm1_mode' set to 1) and DC mode ('pwm1_mode' set to 0),
 when current fan speed control mode is open-loop ('pwm1_enable' set to 1),
diff --git a/Documentation/hwmon/gl518sm b/Documentation/hwmon/gl518sm
index 494bb55b6e72..bf1e0b5e824b 100644
--- a/Documentation/hwmon/gl518sm
+++ b/Documentation/hwmon/gl518sm
@@ -2,27 +2,34 @@ Kernel driver gl518sm
 =====================
 
 Supported chips:
+
   * Genesys Logic GL518SM release 0x00
+
     Prefix: 'gl518sm'
+
     Addresses scanned: I2C 0x2c and 0x2d
+
   * Genesys Logic GL518SM release 0x80
+
     Prefix: 'gl518sm'
+
     Addresses scanned: I2C 0x2c and 0x2d
+
     Datasheet: http://www.genesyslogic.com/
 
 Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Kyösti Mälkki <kmalkki@cc.hut.fi>
-        Hong-Gunn Chew <hglinux@gunnet.org>
-        Jean Delvare <jdelvare@suse.de>
+       - Frodo Looijaard <frodol@dds.nl>,
+       - Kyösti Mälkki <kmalkki@cc.hut.fi>
+       - Hong-Gunn Chew <hglinux@gunnet.org>
+       - Jean Delvare <jdelvare@suse.de>
 
 Description
 -----------
 
-IMPORTANT:
+.. important::
 
-For the revision 0x00 chip, the in0, in1, and in2  values (+5V, +3V,
-and +12V) CANNOT be read. This is a limitation of the chip, not the driver.
+   For the revision 0x00 chip, the in0, in1, and in2  values (+5V, +3V,
+   and +12V) CANNOT be read. This is a limitation of the chip, not the driver.
 
 This driver supports the Genesys Logic GL518SM chip. There are at least
 two revision of this chip, which we call revision 0x00 and 0x80. Revision
diff --git a/Documentation/hwmon/hih6130 b/Documentation/hwmon/hih6130
index 73dae918ea7b..649bd4be4fc2 100644
--- a/Documentation/hwmon/hih6130
+++ b/Documentation/hwmon/hih6130
@@ -2,11 +2,16 @@ Kernel driver hih6130
 =====================
 
 Supported chips:
+
   * Honeywell HIH-6130 / HIH-6131
+
     Prefix: 'hih6130'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Honeywell website
-    http://sensing.honeywell.com/index.php?ci_id=3106&la_id=1&defId=44872
+
+	http://sensing.honeywell.com/index.php?ci_id=3106&la_id=1&defId=44872
 
 Author:
   Iain Paton <ipaton0@gmail.com>
@@ -28,8 +33,11 @@ instantiate I2C devices.
 sysfs-Interface
 ---------------
 
-temp1_input - temperature input
-humidity1_input - humidity input
+temp1_input
+	temperature input
+
+humidity1_input
+	humidity input
 
 Notes
 -----
diff --git a/Documentation/hwmon/hwmon-kernel-api.txt b/Documentation/hwmon/hwmon-kernel-api.txt
index 8bdefb41be30..b56343f5c2c4 100644
--- a/Documentation/hwmon/hwmon-kernel-api.txt
+++ b/Documentation/hwmon/hwmon-kernel-api.txt
@@ -1,5 +1,5 @@
-The Linux Hardware Monitoring kernel API.
-=========================================
+The Linux Hardware Monitoring kernel API
+========================================
 
 Guenter Roeck
 
@@ -21,33 +21,34 @@ The API
 -------
 Each hardware monitoring driver must #include <linux/hwmon.h> and, in most
 cases, <linux/hwmon-sysfs.h>. linux/hwmon.h declares the following
-register/unregister functions:
+register/unregister functions::
 
-struct device *
-hwmon_device_register_with_groups(struct device *dev, const char *name,
-				  void *drvdata,
-				  const struct attribute_group **groups);
+  struct device *
+  hwmon_device_register_with_groups(struct device *dev, const char *name,
+				    void *drvdata,
+				    const struct attribute_group **groups);
 
-struct device *
-devm_hwmon_device_register_with_groups(struct device *dev,
-				       const char *name, void *drvdata,
-				       const struct attribute_group **groups);
+  struct device *
+  devm_hwmon_device_register_with_groups(struct device *dev,
+					 const char *name, void *drvdata,
+					 const struct attribute_group **groups);
 
-struct device *
-hwmon_device_register_with_info(struct device *dev,
-				const char *name, void *drvdata,
-				const struct hwmon_chip_info *info,
-				const struct attribute_group **extra_groups);
+  struct device *
+  hwmon_device_register_with_info(struct device *dev,
+				  const char *name, void *drvdata,
+				  const struct hwmon_chip_info *info,
+				  const struct attribute_group **extra_groups);
 
-struct device *
-devm_hwmon_device_register_with_info(struct device *dev,
-				const char *name,
-				void *drvdata,
-				const struct hwmon_chip_info *info,
-				const struct attribute_group **extra_groups);
+  struct device *
+  devm_hwmon_device_register_with_info(struct device *dev,
+				       const char *name,
+				       void *drvdata,
+				       const struct hwmon_chip_info *info,
+				       const struct attribute_group **extra_groups);
 
-void hwmon_device_unregister(struct device *dev);
-void devm_hwmon_device_unregister(struct device *dev);
+  void hwmon_device_unregister(struct device *dev);
+
+  void devm_hwmon_device_unregister(struct device *dev);
 
 hwmon_device_register_with_groups registers a hardware monitoring device.
 The first parameter of this function is a pointer to the parent device.
@@ -100,78 +101,89 @@ Using devm_hwmon_device_register_with_info()
 hwmon_device_register_with_info() registers a hardware monitoring device.
 The parameters to this function are
 
-struct device *dev	Pointer to parent device
-const char *name	Device name
-void *drvdata		Driver private data
-const struct hwmon_chip_info *info
-			Pointer to chip description.
-const struct attribute_group **extra_groups
-			Null-terminated list of additional non-standard
-			sysfs attribute groups.
+=============================================== ===============================================
+`struct device *dev`				Pointer to parent device
+`const char *name`				Device name
+`void *drvdata`					Driver private data
+`const struct hwmon_chip_info *info`		Pointer to chip description.
+`const struct attribute_group **extra_groups` 	Null-terminated list of additional non-standard
+						sysfs attribute groups.
+=============================================== ===============================================
 
 This function returns a pointer to the created hardware monitoring device
 on success and a negative error code for failure.
 
-The hwmon_chip_info structure looks as follows.
+The hwmon_chip_info structure looks as follows::
 
-struct hwmon_chip_info {
-	const struct hwmon_ops *ops;
-	const struct hwmon_channel_info **info;
-};
+	struct hwmon_chip_info {
+		const struct hwmon_ops *ops;
+		const struct hwmon_channel_info **info;
+	};
 
 It contains the following fields:
 
-* ops:	Pointer to device operations.
-* info: NULL-terminated list of device channel descriptors.
+* ops:
+	Pointer to device operations.
+* info:
+	NULL-terminated list of device channel descriptors.
 
-The list of hwmon operations is defined as:
+The list of hwmon operations is defined as::
 
-struct hwmon_ops {
+  struct hwmon_ops {
 	umode_t (*is_visible)(const void *, enum hwmon_sensor_types type,
 			      u32 attr, int);
 	int (*read)(struct device *, enum hwmon_sensor_types type,
 		    u32 attr, int, long *);
 	int (*write)(struct device *, enum hwmon_sensor_types type,
 		     u32 attr, int, long);
-};
+  };
 
 It defines the following operations.
 
-* is_visible: Pointer to a function to return the file mode for each supported
-  attribute. This function is mandatory.
+* is_visible:
+    Pointer to a function to return the file mode for each supported
+    attribute. This function is mandatory.
 
-* read: Pointer to a function for reading a value from the chip. This function
-  is optional, but must be provided if any readable attributes exist.
+* read:
+    Pointer to a function for reading a value from the chip. This function
+    is optional, but must be provided if any readable attributes exist.
 
-* write: Pointer to a function for writing a value to the chip. This function is
-  optional, but must be provided if any writeable attributes exist.
+* write:
+    Pointer to a function for writing a value to the chip. This function is
+    optional, but must be provided if any writeable attributes exist.
 
 Each sensor channel is described with struct hwmon_channel_info, which is
-defined as follows.
+defined as follows::
 
-struct hwmon_channel_info {
-	enum hwmon_sensor_types type;
-	u32 *config;
-};
+	struct hwmon_channel_info {
+		enum hwmon_sensor_types type;
+		u32 *config;
+	};
 
 It contains following fields:
 
-* type: The hardware monitoring sensor type.
-  Supported sensor types are
-  * hwmon_chip		A virtual sensor type, used to describe attributes
-  *			which are not bound to a specific input or output
-  * hwmon_temp		Temperature sensor
-  * hwmon_in		Voltage sensor
-  * hwmon_curr		Current sensor
-  * hwmon_power		Power sensor
-  * hwmon_energy	Energy sensor
-  * hwmon_humidity	Humidity sensor
-  * hwmon_fan		Fan speed sensor
-  * hwmon_pwm		PWM control
+* type:
+    The hardware monitoring sensor type.
 
-* config: Pointer to a 0-terminated list of configuration values for each
-  sensor of the given type. Each value is a combination of bit values
-  describing the attributes supposed by a single sensor.
+    Supported sensor types are
+
+     ================== ==================================================
+     hwmon_chip		A virtual sensor type, used to describe attributes
+			which are not bound to a specific input or output
+     hwmon_temp		Temperature sensor
+     hwmon_in		Voltage sensor
+     hwmon_curr		Current sensor
+     hwmon_power		Power sensor
+     hwmon_energy	Energy sensor
+     hwmon_humidity	Humidity sensor
+     hwmon_fan		Fan speed sensor
+     hwmon_pwm		PWM control
+     ================== ==================================================
+
+* config:
+    Pointer to a 0-terminated list of configuration values for each
+    sensor of the given type. Each value is a combination of bit values
+    describing the attributes supposed by a single sensor.
 
 As an example, here is the complete description file for a LM75 compatible
 sensor chip. The chip has a single temperature sensor. The driver wants to
@@ -179,48 +191,49 @@ register with the thermal subsystem (HWMON_C_REGISTER_TZ), and it supports
 the update_interval attribute (HWMON_C_UPDATE_INTERVAL). The chip supports
 reading the temperature (HWMON_T_INPUT), it has a maximum temperature
 register (HWMON_T_MAX) as well as a maximum temperature hysteresis register
-(HWMON_T_MAX_HYST).
+(HWMON_T_MAX_HYST)::
 
-static const u32 lm75_chip_config[] = {
-	HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL,
-	0
-};
+	static const u32 lm75_chip_config[] = {
+		HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL,
+		0
+	};
 
-static const struct hwmon_channel_info lm75_chip = {
-	.type = hwmon_chip,
-	.config = lm75_chip_config,
-};
+	static const struct hwmon_channel_info lm75_chip = {
+		.type = hwmon_chip,
+		.config = lm75_chip_config,
+	};
 
-static const u32 lm75_temp_config[] = {
-	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST,
-	0
-};
+	static const u32 lm75_temp_config[] = {
+		HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST,
+		0
+	};
 
-static const struct hwmon_channel_info lm75_temp = {
-	.type = hwmon_temp,
-	.config = lm75_temp_config,
-};
+	static const struct hwmon_channel_info lm75_temp = {
+		.type = hwmon_temp,
+		.config = lm75_temp_config,
+	};
 
-static const struct hwmon_channel_info *lm75_info[] = {
-	&lm75_chip,
-	&lm75_temp,
-	NULL
-};
+	static const struct hwmon_channel_info *lm75_info[] = {
+		&lm75_chip,
+		&lm75_temp,
+		NULL
+	};
 
-static const struct hwmon_ops lm75_hwmon_ops = {
-	.is_visible = lm75_is_visible,
-	.read = lm75_read,
-	.write = lm75_write,
-};
+	static const struct hwmon_ops lm75_hwmon_ops = {
+		.is_visible = lm75_is_visible,
+		.read = lm75_read,
+		.write = lm75_write,
+	};
 
-static const struct hwmon_chip_info lm75_chip_info = {
-	.ops = &lm75_hwmon_ops,
-	.info = lm75_info,
-};
+	static const struct hwmon_chip_info lm75_chip_info = {
+		.ops = &lm75_hwmon_ops,
+		.info = lm75_info,
+	};
 
 A complete list of bit values indicating individual attribute support
 is defined in include/linux/hwmon.h. Definition prefixes are as follows.
 
+=============== =================================================
 HWMON_C_xxxx	Chip attributes, for use with hwmon_chip.
 HWMON_T_xxxx	Temperature attributes, for use with hwmon_temp.
 HWMON_I_xxxx	Voltage attributes, for use with hwmon_in.
@@ -231,57 +244,76 @@ HWMON_E_xxxx	Energy attributes, for use with hwmon_energy.
 HWMON_H_xxxx	Humidity attributes, for use with hwmon_humidity.
 HWMON_F_xxxx	Fan speed attributes, for use with hwmon_fan.
 HWMON_PWM_xxxx	PWM control attributes, for use with hwmon_pwm.
+=============== =================================================
 
 Driver callback functions
 -------------------------
 
 Each driver provides is_visible, read, and write functions. Parameters
-and return values for those functions are as follows.
+and return values for those functions are as follows::
 
-umode_t is_visible_func(const void *data, enum hwmon_sensor_types type,
-			u32 attr, int channel)
+  umode_t is_visible_func(const void *data, enum hwmon_sensor_types type,
+			  u32 attr, int channel)
 
 Parameters:
-	data:	Pointer to device private data structure.
-	type:	The sensor type.
-	attr:	Attribute identifier associated with a specific attribute.
+	data:
+		Pointer to device private data structure.
+	type:
+		The sensor type.
+	attr:
+		Attribute identifier associated with a specific attribute.
 		For example, the attribute value for HWMON_T_INPUT would be
 		hwmon_temp_input. For complete mappings of bit fields to
 		attribute values please see include/linux/hwmon.h.
-	channel:The sensor channel number.
+	channel:
+		The sensor channel number.
 
 Return value:
 	The file mode for this attribute. Typically, this will be 0 (the
 	attribute will not be created), S_IRUGO, or 'S_IRUGO | S_IWUSR'.
 
-int read_func(struct device *dev, enum hwmon_sensor_types type,
-	      u32 attr, int channel, long *val)
+::
+
+	int read_func(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val)
 
 Parameters:
-	dev:	Pointer to the hardware monitoring device.
-	type:	The sensor type.
-	attr:	Attribute identifier associated with a specific attribute.
+	dev:
+		Pointer to the hardware monitoring device.
+	type:
+		The sensor type.
+	attr:
+		Attribute identifier associated with a specific attribute.
 		For example, the attribute value for HWMON_T_INPUT would be
 		hwmon_temp_input. For complete mappings please see
 		include/linux/hwmon.h.
-	channel:The sensor channel number.
-	val:	Pointer to attribute value.
+	channel:
+		The sensor channel number.
+	val:
+		Pointer to attribute value.
 
 Return value:
 	0 on success, a negative error number otherwise.
 
-int write_func(struct device *dev, enum hwmon_sensor_types type,
-	       u32 attr, int channel, long val)
+::
+
+	int write_func(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long val)
 
 Parameters:
-	dev:	Pointer to the hardware monitoring device.
-	type:	The sensor type.
-	attr:	Attribute identifier associated with a specific attribute.
+	dev:
+		Pointer to the hardware monitoring device.
+	type:
+		The sensor type.
+	attr:
+		Attribute identifier associated with a specific attribute.
 		For example, the attribute value for HWMON_T_INPUT would be
 		hwmon_temp_input. For complete mappings please see
 		include/linux/hwmon.h.
-	channel:The sensor channel number.
-	val:	The value to write to the chip.
+	channel:
+		The sensor channel number.
+	val:
+		The value to write to the chip.
 
 Return value:
 	0 on success, a negative error number otherwise.
@@ -317,25 +349,25 @@ Standard functions, similar to DEVICE_ATTR_{RW,RO,WO}, have _show and _store
 appended to the provided function name.
 
 SENSOR_DEVICE_ATTR and its variants define a struct sensor_device_attribute
-variable. This structure has the following fields.
+variable. This structure has the following fields::
 
-struct sensor_device_attribute {
-	struct device_attribute dev_attr;
-	int index;
-};
+	struct sensor_device_attribute {
+		struct device_attribute dev_attr;
+		int index;
+	};
 
 You can use to_sensor_dev_attr to get the pointer to this structure from the
 attribute read or write function. Its parameter is the device to which the
 attribute is attached.
 
 SENSOR_DEVICE_ATTR_2 and its variants define a struct sensor_device_attribute_2
-variable, which is defined as follows.
+variable, which is defined as follows::
 
-struct sensor_device_attribute_2 {
-	struct device_attribute dev_attr;
-	u8 index;
-	u8 nr;
-};
+	struct sensor_device_attribute_2 {
+		struct device_attribute dev_attr;
+		u8 index;
+		u8 nr;
+	};
 
 Use to_sensor_dev_attr_2 to get the pointer to this structure. Its parameter
 is the device to which the attribute is attached.
diff --git a/Documentation/hwmon/ibmaem b/Documentation/hwmon/ibmaem
index 1e0d59e000b4..f07a14a1c2f5 100644
--- a/Documentation/hwmon/ibmaem
+++ b/Documentation/hwmon/ibmaem
@@ -1,15 +1,21 @@
 Kernel driver ibmaem
-======================
+====================
 
 This driver talks to the IBM Systems Director Active Energy Manager, known
 henceforth as AEM.
 
 Supported systems:
+
   * Any recent IBM System X server with AEM support.
+
     This includes the x3350, x3550, x3650, x3655, x3755, x3850 M2,
-    x3950 M2, and certain HC10/HS2x/LS2x/QS2x blades.  The IPMI host interface
+    x3950 M2, and certain HC10/HS2x/LS2x/QS2x blades.
+
+    The IPMI host interface
     driver ("ipmi-si") needs to be loaded for this driver to do anything.
+
     Prefix: 'ibmaem'
+
     Datasheet: Not available
 
 Author: Darrick J. Wong
diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 4b82cbfb551c..9eb983c24402 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -2,11 +2,16 @@ Kernel driver ina3221
 =====================
 
 Supported chips:
+
   * Texas Instruments INA3221
+
     Prefix: 'ina3221'
+
     Addresses: I2C 0x40 - 0x43
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/
+
+	       http://www.ti.com/
 
 Author: Andrew F. Davis <afd@ti.com>
 
@@ -21,17 +26,19 @@ and power are calculated host-side from these.
 Sysfs entries
 -------------
 
+======================= =======================================================
 in[123]_label           Voltage channel labels
 in[123]_enable          Voltage channel enable controls
 in[123]_input           Bus voltage(mV) channels
 curr[123]_input         Current(mA) measurement channels
 shunt[123]_resistor     Shunt resistance(uOhm) channels
 curr[123]_crit          Critical alert current(mA) setting, activates the
-                          corresponding alarm when the respective current
-                          is above this value
+			corresponding alarm when the respective current
+			is above this value
 curr[123]_crit_alarm    Critical alert current limit exceeded
 curr[123]_max           Warning alert current(mA) setting, activates the
-                          corresponding alarm when the respective current
-                          average is above this value.
+			corresponding alarm when the respective current
+			average is above this value.
 curr[123]_max_alarm     Warning alert current limit exceeded
 in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
+======================= =======================================================
diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index fff6f6bf55bc..2d83f23bee93 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -2,105 +2,179 @@ Kernel driver it87
 ==================
 
 Supported chips:
+
   * IT8603E/IT8623E
+
     Prefix: 'it8603'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8620E
+
     Prefix: 'it8620'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
   * IT8628E
+
     Prefix: 'it8628'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8705F
+
     Prefix: 'it87'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Once publicly available at the ITE website, but no longer
+
   * IT8712F
+
     Prefix: 'it8712'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Once publicly available at the ITE website, but no longer
+
   * IT8716F/IT8726F
+
     Prefix: 'it8716'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Once publicly available at the ITE website, but no longer
+
   * IT8718F
+
     Prefix: 'it8718'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Once publicly available at the ITE website, but no longer
+
   * IT8720F
+
     Prefix: 'it8720'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8721F/IT8758E
+
     Prefix: 'it8721'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8728F
+
     Prefix: 'it8728'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8732F
+
     Prefix: 'it8732'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8771E
+
     Prefix: 'it8771'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8772E
+
     Prefix: 'it8772'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8781F
+
     Prefix: 'it8781'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8782F
+
     Prefix: 'it8782'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8783E/F
+
     Prefix: 'it8783'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8786E
+
     Prefix: 'it8786'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * IT8790E
+
     Prefix: 'it8790'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: Not publicly available
+
   * SiS950   [clone of IT8705F]
+
     Prefix: 'it87'
+
     Addresses scanned: from Super I/O config space (8 I/O ports)
+
     Datasheet: No longer be available
 
+
 Authors:
-    Christophe Gauthron
-    Jean Delvare <jdelvare@suse.de>
+    - Christophe Gauthron
+    - Jean Delvare <jdelvare@suse.de>
 
 
 Module Parameters
 -----------------
 
 * update_vbat: int
-
-  0 if vbat should report power on value, 1 if vbat should be updated after
-  each read. Default is 0. On some boards the battery voltage is provided
-  by either the battery or the onboard power supply. Only the first reading
-  at power on will be the actual battery voltage (which the chip does
-  automatically). On other boards the battery voltage is always fed to
-  the chip so can be read at any time. Excessive reading may decrease
-  battery life but no information is given in the datasheet.
+    0 if vbat should report power on value, 1 if vbat should be updated after
+    each read. Default is 0. On some boards the battery voltage is provided
+    by either the battery or the onboard power supply. Only the first reading
+    at power on will be the actual battery voltage (which the chip does
+    automatically). On other boards the battery voltage is always fed to
+    the chip so can be read at any time. Excessive reading may decrease
+    battery life but no information is given in the datasheet.
 
 * fix_pwm_polarity int
-
-  Force PWM polarity to active high (DANGEROUS). Some chips are
-  misconfigured by BIOS - PWM values would be inverted. This option tries
-  to fix this. Please contact your BIOS manufacturer and ask him for fix.
+    Force PWM polarity to active high (DANGEROUS). Some chips are
+    misconfigured by BIOS - PWM values would be inverted. This option tries
+    to fix this. Please contact your BIOS manufacturer and ask him for fix.
 
 
 Hardware Interfaces
diff --git a/Documentation/hwmon/lineage-pem b/Documentation/hwmon/lineage-pem
index 83b2ddc160c8..10c271dc20e8 100644
--- a/Documentation/hwmon/lineage-pem
+++ b/Documentation/hwmon/lineage-pem
@@ -2,11 +2,16 @@ Kernel driver lineage-pem
 =========================
 
 Supported devices:
+
   * Lineage Compact Power Line Power Entry Modules
+
     Prefix: 'lineage-pem'
+
     Addresses scanned: -
+
     Documentation:
-        http://www.lineagepower.com/oem/pdf/CPLI2C.pdf
+
+	http://www.lineagepower.com/oem/pdf/CPLI2C.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -31,9 +36,10 @@ which can be safely used to identify the chip. You will have to instantiate
 the devices explicitly.
 
 Example: the following will load the driver for a Lineage PEM at address 0x40
-on I2C bus #1:
-$ modprobe lineage-pem
-$ echo lineage-pem 0x40 > /sys/bus/i2c/devices/i2c-1/new_device
+on I2C bus #1::
+
+	$ modprobe lineage-pem
+	$ echo lineage-pem 0x40 > /sys/bus/i2c/devices/i2c-1/new_device
 
 All Lineage CPL power entry modules have a built-in I2C bus master selector
 (PCA9541). To ensure device access, this driver should only be used as client
@@ -51,6 +57,7 @@ Input voltage, input current, input power, and fan speed measurement is only
 supported on newer devices. The driver detects if those attributes are supported,
 and only creates respective sysfs entries if they are.
 
+======================= ===============================
 in1_input		Output voltage (mV)
 in1_min_alarm		Output undervoltage alarm
 in1_max_alarm		Output overvoltage alarm
@@ -75,3 +82,4 @@ temp1_crit
 temp1_alarm
 temp1_crit_alarm
 temp1_fault
+======================= ===============================
diff --git a/Documentation/hwmon/lm63 b/Documentation/hwmon/lm63
index 4a00461512a6..f478132b0408 100644
--- a/Documentation/hwmon/lm63
+++ b/Documentation/hwmon/lm63
@@ -2,26 +2,43 @@ Kernel driver lm63
 ==================
 
 Supported chips:
+
   * National Semiconductor LM63
+
     Prefix: 'lm63'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM63.html
+
+	       http://www.national.com/pf/LM/LM63.html
+
   * National Semiconductor LM64
+
     Prefix: 'lm64'
+
     Addresses scanned: I2C 0x18 and 0x4e
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM64.html
+
+	       http://www.national.com/pf/LM/LM64.html
+
   * National Semiconductor LM96163
+
     Prefix: 'lm96163'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM96163.html
+
+	       http://www.national.com/pf/LM/LM96163.html
+
 
 Author: Jean Delvare <jdelvare@suse.de>
 
 Thanks go to Tyan and especially Alex Buckingham for setting up a remote
 access to their S4882 test platform for this driver.
+
   http://www.tyan.com/
 
 Description
@@ -32,6 +49,7 @@ and control.
 
 The LM63 is basically an LM86 with fan speed monitoring and control
 capabilities added. It misses some of the LM86 features though:
+
  - No low limit for local temperature.
  - No critical limit for local temperature.
  - Critical limit for remote temperature can be changed only once. We
diff --git a/Documentation/hwmon/lm70 b/Documentation/hwmon/lm70
index c3a1f2ea017d..f259bc1fcd91 100644
--- a/Documentation/hwmon/lm70
+++ b/Documentation/hwmon/lm70
@@ -2,19 +2,30 @@ Kernel driver lm70
 ==================
 
 Supported chips:
+
   * National Semiconductor LM70
+
     Datasheet: http://www.national.com/pf/LM/LM70.html
+
   * Texas Instruments TMP121/TMP123
+
     Information: http://focus.ti.com/docs/prod/folders/print/tmp121.html
+
   * Texas Instruments TMP122/TMP124
+
     Information: http://www.ti.com/product/tmp122
+
   * National Semiconductor LM71
+
     Datasheet: http://www.ti.com/product/LM71
+
   * National Semiconductor LM74
+
     Datasheet: http://www.ti.com/product/LM74
 
+
 Author:
-        Kaiwan N Billimoria <kaiwan@designergraphix.com>
+	Kaiwan N Billimoria <kaiwan@designergraphix.com>
 
 Description
 -----------
diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
index 8af059dcb642..1d6a46844e85 100644
--- a/Documentation/hwmon/lm73
+++ b/Documentation/hwmon/lm73
@@ -2,13 +2,20 @@ Kernel driver lm73
 ==================
 
 Supported chips:
+
   * Texas Instruments LM73
+
     Prefix: 'lm73'
+
     Addresses scanned: I2C 0x48, 0x49, 0x4a, 0x4c, 0x4d, and 0x4e
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/product/lm73
+
+	       http://www.ti.com/product/lm73
+
 
 Author: Guillaume Ligneul <guillaume.ligneul@gmail.com>
+
 Documentation: Chris Verges <kg4ysn@gmail.com>
 
 
@@ -29,17 +36,18 @@ conversion time via the 'update_interval' sysfs attribute for the
 device.  This attribute will normalize ranges of input values to the
 maximum times defined for the resolution in the datasheet.
 
+    ============= ============= ============
     Resolution    Conv. Time    Input Range
     (C/LSB)       (msec)        (msec)
-    --------------------------------------
+    ============= ============= ============
     0.25          14             0..14
     0.125         28            15..28
     0.0625        56            29..56
     0.03125       112           57..infinity
-    --------------------------------------
+    ============= ============= ============
 
 The following examples show how the 'update_interval' attribute can be
-used to change the conversion time:
+used to change the conversion time::
 
     $ echo 0 > update_interval
     $ cat update_interval
diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
index 010583608f12..6fd4d2df5420 100644
--- a/Documentation/hwmon/lm75
+++ b/Documentation/hwmon/lm75
@@ -2,68 +2,130 @@ Kernel driver lm75
 ==================
 
 Supported chips:
+
   * National Semiconductor LM75
+
     Prefix: 'lm75'
+
     Addresses scanned: I2C 0x48 - 0x4f
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
+
+	       http://www.national.com/
+
   * National Semiconductor LM75A
+
     Prefix: 'lm75a'
+
     Addresses scanned: I2C 0x48 - 0x4f
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
+
+	       http://www.national.com/
+
   * Dallas Semiconductor (now Maxim) DS75, DS1775, DS7505
+
     Prefixes: 'ds75', 'ds1775', 'ds7505'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maximintegrated.com/
+
+	       http://www.maximintegrated.com/
+
   * Maxim MAX6625, MAX6626, MAX31725, MAX31726
+
     Prefixes: 'max6625', 'max6626', 'max31725', 'max31726'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/
+
+	       http://www.maxim-ic.com/
+
   * Microchip (TelCom) TCN75
+
     Prefix: 'tcn75'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Microchip website
-               http://www.microchip.com/
+
+	       http://www.microchip.com/
+
   * Microchip MCP9800, MCP9801, MCP9802, MCP9803
+
     Prefix: 'mcp980x'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Microchip website
-               http://www.microchip.com/
+
+	       http://www.microchip.com/
+
   * Analog Devices ADT75
+
     Prefix: 'adt75'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/adt75
+
+	       http://www.analog.com/adt75
+
   * ST Microelectronics STDS75
+
     Prefix: 'stds75'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the ST website
-               http://www.st.com/internet/analog/product/121769.jsp
+
+	       http://www.st.com/internet/analog/product/121769.jsp
+
   * ST Microelectronics STLM75
+
     Prefix: 'stlm75'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the ST website
+
 	       https://www.st.com/resource/en/datasheet/stlm75.pdf
+
   * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75C, TMP175, TMP275
+
     Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75c', 'tmp275'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Texas Instruments website
-               http://www.ti.com/product/tmp100
-               http://www.ti.com/product/tmp101
-               http://www.ti.com/product/tmp105
-               http://www.ti.com/product/tmp112
-               http://www.ti.com/product/tmp75
-               http://www.ti.com/product/tmp75c
-               http://www.ti.com/product/tmp175
-               http://www.ti.com/product/tmp275
+
+	       http://www.ti.com/product/tmp100
+
+	       http://www.ti.com/product/tmp101
+
+	       http://www.ti.com/product/tmp105
+
+	       http://www.ti.com/product/tmp112
+
+	       http://www.ti.com/product/tmp75
+
+	       http://www.ti.com/product/tmp75c
+
+	       http://www.ti.com/product/tmp175
+
+	       http://www.ti.com/product/tmp275
+
   * NXP LM75B
+
     Prefix: 'lm75b'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the NXP website
-               http://www.nxp.com/documents/data_sheet/LM75B.pdf
+
+	       http://www.nxp.com/documents/data_sheet/LM75B.pdf
 
 Author: Frodo Looijaard <frodol@dds.nl>
 
diff --git a/Documentation/hwmon/lm77 b/Documentation/hwmon/lm77
index bfc915fe3639..4ed3fe6b999a 100644
--- a/Documentation/hwmon/lm77
+++ b/Documentation/hwmon/lm77
@@ -2,11 +2,17 @@ Kernel driver lm77
 ==================
 
 Supported chips:
+
   * National Semiconductor LM77
+
     Prefix: 'lm77'
+
     Addresses scanned: I2C 0x48 - 0x4b
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
+
+	       http://www.national.com/
+
 
 Author: Andras BALI <drewie@freemail.hu>
 
@@ -25,6 +31,7 @@ register on the chip, which means that the relative difference between
 the limit and its hysteresis is always the same for all 3 limits.
 
 This implementation detail implies the following:
+
 * When setting a limit, its hysteresis will automatically follow, the
   difference staying unchanged. For example, if the old critical limit
   was 80 degrees C, and the hysteresis was 75 degrees C, and you change
diff --git a/Documentation/hwmon/lm78 b/Documentation/hwmon/lm78
index 4dd47731789f..cb7a4832f35e 100644
--- a/Documentation/hwmon/lm78
+++ b/Documentation/hwmon/lm78
@@ -2,19 +2,31 @@ Kernel driver lm78
 ==================
 
 Supported chips:
+
   * National Semiconductor LM78 / LM78-J
+
     Prefix: 'lm78'
+
     Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
+
+	       http://www.national.com/
+
   * National Semiconductor LM79
+
     Prefix: 'lm79'
+
     Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
 
-Authors: Frodo Looijaard <frodol@dds.nl>
-         Jean Delvare <jdelvare@suse.de>
+	       http://www.national.com/
+
+
+Authors:
+	- Frodo Looijaard <frodol@dds.nl>
+	- Jean Delvare <jdelvare@suse.de>
 
 Description
 -----------
diff --git a/Documentation/hwmon/lm80 b/Documentation/hwmon/lm80
index a60b43efc32b..c53186abd82e 100644
--- a/Documentation/hwmon/lm80
+++ b/Documentation/hwmon/lm80
@@ -2,20 +2,31 @@ Kernel driver lm80
 ==================
 
 Supported chips:
+
   * National Semiconductor LM80
+
     Prefix: 'lm80'
+
     Addresses scanned: I2C 0x28 - 0x2f
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
+
+	       http://www.national.com/
+
   * National Semiconductor LM96080
+
     Prefix: 'lm96080'
+
     Addresses scanned: I2C 0x28 - 0x2f
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
+
+	       http://www.national.com/
+
 
 Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>
+       - Frodo Looijaard <frodol@dds.nl>,
+       - Philip Edelbrock <phil@netroedge.com>
 
 Description
 -----------
diff --git a/Documentation/hwmon/lm83 b/Documentation/hwmon/lm83
index 50be5cb26de9..ecf83819960e 100644
--- a/Documentation/hwmon/lm83
+++ b/Documentation/hwmon/lm83
@@ -2,16 +2,24 @@ Kernel driver lm83
 ==================
 
 Supported chips:
+
   * National Semiconductor LM83
+
     Prefix: 'lm83'
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM83.html
+
+	       http://www.national.com/pf/LM/LM83.html
+
   * National Semiconductor LM82
+
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM82.html
 
+	       http://www.national.com/pf/LM/LM82.html
 
 Author: Jean Delvare <jdelvare@suse.de>
 
@@ -34,13 +42,17 @@ fact that any of these motherboards do actually have an LM83, please
 contact us. Note that the LM90 can easily be misdetected as a LM83.
 
 Confirmed motherboards:
+    ===		=====
     SBS         P014
     SBS         PSL09
+    ===		=====
 
 Unconfirmed motherboards:
+    =========== ==========
     Gigabyte    GA-8IK1100
     Iwill       MPX2
     Soltek      SL-75DRV5
+    =========== ==========
 
 The LM82 is confirmed to have been found on most AMD Geode reference
 designs and test platforms.
diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
index 2329c383efe4..faa92f54431c 100644
--- a/Documentation/hwmon/lm85
+++ b/Documentation/hwmon/lm85
@@ -2,49 +2,85 @@ Kernel driver lm85
 ==================
 
 Supported chips:
+
   * National Semiconductor LM85 (B and C versions)
+
     Prefix: 'lm85b' or 'lm85c'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.national.com/pf/LM/LM85.html
+
   * Texas Instruments LM96000
+
     Prefix: 'lm9600'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.ti.com/lit/ds/symlink/lm96000.pdf
+
   * Analog Devices ADM1027
+
     Prefix: 'adm1027'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADM1027
+
   * Analog Devices ADT7463
+
     Prefix: 'adt7463'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADT7463
+
   * Analog Devices ADT7468
+
     Prefix: 'adt7468'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADT7468
+
   * SMSC EMC6D100, SMSC EMC6D101
+
     Prefix: 'emc6d100'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-    Datasheet: http://www.smsc.com/media/Downloads_Public/discontinued/6d100.pdf 
+
+    Datasheet: http://www.smsc.com/media/Downloads_Public/discontinued/6d100.pdf
+
   * SMSC EMC6D102
+
     Prefix: 'emc6d102'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.smsc.com/main/catalog/emc6d102.html
+
   * SMSC EMC6D103
+
     Prefix: 'emc6d103'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.smsc.com/main/catalog/emc6d103.html
+
   * SMSC EMC6D103S
+
     Prefix: 'emc6d103s'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.smsc.com/main/catalog/emc6d103s.html
 
 Authors:
-        Philip Pokorny <ppokorny@penguincomputing.com>,
-        Frodo Looijaard <frodol@dds.nl>,
-        Richard Barrington <rich_b_nz@clear.net.nz>,
-        Margit Schubert-While <margitsw@t-online.de>,
-        Justin Thiessen <jthiessen@penguincomputing.com>
+       - Philip Pokorny <ppokorny@penguincomputing.com>,
+       - Frodo Looijaard <frodol@dds.nl>,
+       - Richard Barrington <rich_b_nz@clear.net.nz>,
+       - Margit Schubert-While <margitsw@t-online.de>,
+       - Justin Thiessen <jthiessen@penguincomputing.com>
 
 Description
 -----------
@@ -177,38 +213,50 @@ Each temperature sensor is associated with a Zone. There are three
 sensors and therefore three zones (# 1, 2 and 3). Each zone has the following
 temperature configuration points:
 
-* temp#_auto_temp_off - temperature below which fans should be off or spinning very low.
-* temp#_auto_temp_min - temperature over which fans start to spin.
-* temp#_auto_temp_max - temperature when fans spin at full speed.
-* temp#_auto_temp_crit - temperature when all fans will run full speed.
+* temp#_auto_temp_off
+	- temperature below which fans should be off or spinning very low.
+* temp#_auto_temp_min
+	- temperature over which fans start to spin.
+* temp#_auto_temp_max
+	- temperature when fans spin at full speed.
+* temp#_auto_temp_crit
+	- temperature when all fans will run full speed.
 
-* PWM Control
+PWM Control
+^^^^^^^^^^^
 
 There are three PWM outputs. The LM85 datasheet suggests that the
 pwm3 output control both fan3 and fan4. Each PWM can be individually
 configured and assigned to a zone for its control value. Each PWM can be
 configured individually according to the following options.
 
-* pwm#_auto_pwm_min - this specifies the PWM value for temp#_auto_temp_off
-                      temperature. (PWM value from 0 to 255)
+* pwm#_auto_pwm_min
+	- this specifies the PWM value for temp#_auto_temp_off
+	  temperature. (PWM value from 0 to 255)
 
-* pwm#_auto_pwm_minctl - this flags selects for temp#_auto_temp_off temperature
-                         the behaviour of fans. Write 1 to let fans spinning at
-			 pwm#_auto_pwm_min or write 0 to let them off.
+* pwm#_auto_pwm_minctl
+	- this flags selects for temp#_auto_temp_off temperature
+	  the behaviour of fans. Write 1 to let fans spinning at
+	  pwm#_auto_pwm_min or write 0 to let them off.
 
-NOTE: It has been reported that there is a bug in the LM85 that causes the flag
-to be associated with the zones not the PWMs. This contradicts all the
-published documentation. Setting pwm#_min_ctl in this case actually affects all
-PWMs controlled by zone '#'.
+.. note::
 
-* PWM Controlling Zone selection
+	It has been reported that there is a bug in the LM85 that causes
+	the flag to be associated with the zones not the PWMs. This
+	contradicts all the published documentation. Setting pwm#_min_ctl
+	in this case actually affects all PWMs controlled by zone '#'.
 
-* pwm#_auto_channels - controls zone that is associated with PWM
+PWM Controlling Zone selection
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+* pwm#_auto_channels
+	- controls zone that is associated with PWM
 
 Configuration choices:
 
-   Value     Meaning
-  ------  ------------------------------------------------
+========== =============================================
+Value      Meaning
+========== =============================================
       1    Controlled by Zone 1
       2    Controlled by Zone 2
       3    Controlled by Zone 3
@@ -217,6 +265,7 @@ Configuration choices:
       0    PWM always 0%  (off)
      -1    PWM always 100%  (full on)
      -2    Manual control (write to 'pwm#' to set)
+========== =============================================
 
 The National LM85's have two vendor specific configuration
 features. Tach. mode and Spinup Control. For more details on these,
diff --git a/Documentation/hwmon/lm87 b/Documentation/hwmon/lm87
index a2339fd9acb9..72fcb577ef2a 100644
--- a/Documentation/hwmon/lm87
+++ b/Documentation/hwmon/lm87
@@ -2,23 +2,32 @@ Kernel driver lm87
 ==================
 
 Supported chips:
+
   * National Semiconductor LM87
+
     Prefix: 'lm87'
+
     Addresses scanned: I2C 0x2c - 0x2e
+
     Datasheet: http://www.national.com/pf/LM/LM87.html
+
   * Analog Devices ADM1024
+
     Prefix: 'adm1024'
+
     Addresses scanned: I2C 0x2c - 0x2e
+
     Datasheet: http://www.analog.com/en/prod/0,2877,ADM1024,00.html
 
+
 Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Mark Studebaker <mdsxyz123@yahoo.com>,
-        Stephen Rousset <stephen.rousset@rocketlogix.com>,
-        Dan Eaton <dan.eaton@rocketlogix.com>,
-        Jean Delvare <jdelvare@suse.de>,
-        Original 2.6 port Jeff Oliver
+	- Frodo Looijaard <frodol@dds.nl>,
+	- Philip Edelbrock <phil@netroedge.com>,
+	- Mark Studebaker <mdsxyz123@yahoo.com>,
+	- Stephen Rousset <stephen.rousset@rocketlogix.com>,
+	- Dan Eaton <dan.eaton@rocketlogix.com>,
+	- Jean Delvare <jdelvare@suse.de>,
+	- Original 2.6 port Jeff Oliver
 
 Description
 -----------
diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
index 8122675d30f6..953315987c06 100644
--- a/Documentation/hwmon/lm90
+++ b/Documentation/hwmon/lm90
@@ -2,132 +2,256 @@ Kernel driver lm90
 ==================
 
 Supported chips:
+
   * National Semiconductor LM90
+
     Prefix: 'lm90'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM90.html
+
+	       http://www.national.com/pf/LM/LM90.html
+
   * National Semiconductor LM89
+
     Prefix: 'lm89' (no auto-detection)
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/mpf/LM/LM89.html
+
+	       http://www.national.com/mpf/LM/LM89.html
+
   * National Semiconductor LM99
+
     Prefix: 'lm99'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM99.html
+
+	       http://www.national.com/pf/LM/LM99.html
+
   * National Semiconductor LM86
+
     Prefix: 'lm86'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/mpf/LM/LM86.html
+
+	       http://www.national.com/mpf/LM/LM86.html
+
   * Analog Devices ADM1032
+
     Prefix: 'adm1032'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: Publicly available at the ON Semiconductor website
-               http://www.onsemi.com/PowerSolutions/product.do?id=ADM1032
+
+	       http://www.onsemi.com/PowerSolutions/product.do?id=ADM1032
+
   * Analog Devices ADT7461
+
     Prefix: 'adt7461'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: Publicly available at the ON Semiconductor website
-               http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461
+
+	       http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461
+
   * Analog Devices ADT7461A
+
     Prefix: 'adt7461a'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: Publicly available at the ON Semiconductor website
-               http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461A
+
+	       http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461A
+
   * ON Semiconductor NCT1008
+
     Prefix: 'nct1008'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: Publicly available at the ON Semiconductor website
-               http://www.onsemi.com/PowerSolutions/product.do?id=NCT1008
+
+	       http://www.onsemi.com/PowerSolutions/product.do?id=NCT1008
+
   * Maxim MAX6646
+
     Prefix: 'max6646'
+
     Addresses scanned: I2C 0x4d
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+
   * Maxim MAX6647
+
     Prefix: 'max6646'
+
     Addresses scanned: I2C 0x4e
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+
   * Maxim MAX6648
+
     Prefix: 'max6646'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3500
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3500
+
   * Maxim MAX6649
+
     Prefix: 'max6646'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+
   * Maxim MAX6657
+
     Prefix: 'max6657'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
   * Maxim MAX6658
+
     Prefix: 'max6657'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
   * Maxim MAX6659
+
     Prefix: 'max6659'
+
     Addresses scanned: I2C 0x4c, 0x4d, 0x4e
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
   * Maxim MAX6680
+
     Prefix: 'max6680'
+
     Addresses scanned: I2C 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
-                           0x4c, 0x4d and 0x4e
+
+			   0x4c, 0x4d and 0x4e
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3370
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3370
+
   * Maxim MAX6681
+
     Prefix: 'max6680'
+
     Addresses scanned: I2C 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
-                           0x4c, 0x4d and 0x4e
+
+			   0x4c, 0x4d and 0x4e
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3370
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3370
+
   * Maxim MAX6692
+
     Prefix: 'max6646'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3500
+
+	       http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3500
+
   * Maxim MAX6695
+
     Prefix: 'max6695'
+
     Addresses scanned: I2C 0x18
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/datasheet/index.mvp/id/4199
+
+	       http://www.maxim-ic.com/datasheet/index.mvp/id/4199
+
   * Maxim MAX6696
+
     Prefix: 'max6695'
+
     Addresses scanned: I2C 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
-                           0x4c, 0x4d and 0x4e
+
+			   0x4c, 0x4d and 0x4e
+
     Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/datasheet/index.mvp/id/4199
+
+	       http://www.maxim-ic.com/datasheet/index.mvp/id/4199
+
   * Winbond/Nuvoton W83L771W/G
+
     Prefix: 'w83l771'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: No longer available
+
   * Winbond/Nuvoton W83L771AWG/ASG
+
     Prefix: 'w83l771'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Not publicly available, can be requested from Nuvoton
+
   * Philips/NXP SA56004X
+
     Prefix: 'sa56004'
+
     Addresses scanned: I2C 0x48 through 0x4F
+
     Datasheet: Publicly available at NXP website
-               http://ics.nxp.com/products/interface/datasheet/sa56004x.pdf
+
+	       http://ics.nxp.com/products/interface/datasheet/sa56004x.pdf
+
   * GMT G781
+
     Prefix: 'g781'
+
     Addresses scanned: I2C 0x4c, 0x4d
+
     Datasheet: Not publicly available from GMT
+
   * Texas Instruments TMP451
+
     Prefix: 'tmp451'
+
     Addresses scanned: I2C 0x4c
+
     Datasheet: Publicly available at TI website
-               http://www.ti.com/litv/pdf/sbos686
 
+	       http://www.ti.com/litv/pdf/sbos686
 
 Author: Jean Delvare <jdelvare@suse.de>
 
diff --git a/Documentation/hwmon/lm92 b/Documentation/hwmon/lm92
index cfa99a353b8c..c131b923ed36 100644
--- a/Documentation/hwmon/lm92
+++ b/Documentation/hwmon/lm92
@@ -2,22 +2,35 @@ Kernel driver lm92
 ==================
 
 Supported chips:
+
   * National Semiconductor LM92
+
     Prefix: 'lm92'
+
     Addresses scanned: I2C 0x48 - 0x4b
+
     Datasheet: http://www.national.com/pf/LM/LM92.html
+
   * National Semiconductor LM76
+
     Prefix: 'lm92'
+
     Addresses scanned: none, force parameter needed
+
     Datasheet: http://www.national.com/pf/LM/LM76.html
+
   * Maxim MAX6633/MAX6634/MAX6635
+
     Prefix: 'max6635'
+
     Addresses scanned: none, force parameter needed
+
     Datasheet: http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3074
 
+
 Authors:
-        Abraham van der Merwe <abraham@2d3d.co.za>
-        Jean Delvare <jdelvare@suse.de>
+       - Abraham van der Merwe <abraham@2d3d.co.za>
+       - Jean Delvare <jdelvare@suse.de>
 
 
 Description
diff --git a/Documentation/hwmon/lm93 b/Documentation/hwmon/lm93
index f3b2ad2ceb01..49d199b45b67 100644
--- a/Documentation/hwmon/lm93
+++ b/Documentation/hwmon/lm93
@@ -2,20 +2,29 @@ Kernel driver lm93
 ==================
 
 Supported chips:
+
   * National Semiconductor LM93
+
     Prefix 'lm93'
+
     Addresses scanned: I2C 0x2c-0x2e
+
     Datasheet: http://www.national.com/ds.cgi/LM/LM93.pdf
+
   * National Semiconductor LM94
+
     Prefix 'lm94'
+
     Addresses scanned: I2C 0x2c-0x2e
+
     Datasheet: http://www.national.com/ds.cgi/LM/LM94.pdf
 
+
 Authors:
-	Mark M. Hoffman <mhoffman@lightlink.com>
-	Ported to 2.6 by Eric J. Bowersox <ericb@aspsys.com>
-	Adapted to 2.6.20 by Carsten Emde <ce@osadl.org>
-	Modified for mainline integration by Hans J. Koch <hjk@hansjkoch.de>
+	- Mark M. Hoffman <mhoffman@lightlink.com>
+	- Ported to 2.6 by Eric J. Bowersox <ericb@aspsys.com>
+	- Adapted to 2.6.20 by Carsten Emde <ce@osadl.org>
+	- Modified for mainline integration by Hans J. Koch <hjk@hansjkoch.de>
 
 Module Parameters
 -----------------
@@ -67,7 +76,8 @@ LM94 are not supported.
 User Interface
 --------------
 
-#PROCHOT:
+#PROCHOT
+^^^^^^^^
 
 The LM93 can monitor two #PROCHOT signals.  The results are found in the
 sysfs files prochot1, prochot2, prochot1_avg, prochot2_avg, prochot1_max,
@@ -86,7 +96,8 @@ prochot2_interval.  The values in these files specify the intervals for
 list will cause the driver to use the next largest interval.  The available
 intervals are (in seconds):
 
-#PROCHOT intervals: 0.73, 1.46, 2.9, 5.8, 11.7, 23.3, 46.6, 93.2, 186, 372
+#PROCHOT intervals:
+	0.73, 1.46, 2.9, 5.8, 11.7, 23.3, 46.6, 93.2, 186, 372
 
 It is possible to configure the LM93 to logically short the two #PROCHOT
 signals.  I.e. when #P1_PROCHOT is asserted, the LM93 will automatically
@@ -105,16 +116,15 @@ contains a value controlling the duty cycle for the PWM signal used when
 the override function is enabled.  This value ranges from 0 to 15, with 0
 indicating minimum duty cycle and 15 indicating maximum.
 
-#VRD_HOT:
+#VRD_HOT
+^^^^^^^^
 
 The LM93 can monitor two #VRD_HOT signals. The results are found in the
 sysfs files vrdhot1 and vrdhot2. There is one value per file: a boolean for
 which 1 indicates #VRD_HOT is asserted and 0 indicates it is negated. These
 files are read-only.
 
-Smart Tach Mode:
-
-(from the datasheet)
+Smart Tach Mode (from the datasheet)::
 
 	If a fan is driven using a low-side drive PWM, the tachometer
 	output of the fan is corrupted. The LM93 includes smart tachometer
@@ -127,7 +137,8 @@ the fan tachometer with a pwm) to the sysfs file fan<n>_smart_tach.  A zero
 will disable the function for that fan.  Note that Smart tach mode cannot be
 enabled if the PWM output frequency is 22500 Hz (see below).
 
-Manual PWM:
+Manual PWM
+^^^^^^^^^^
 
 The LM93 has a fixed or override mode for the two PWM outputs (although, there
 are still some conditions that will override even this mode - see section
@@ -141,7 +152,8 @@ will cause the driver to use the next largest value.  Also note: when manual
 PWM mode is disabled, the value of pwm1 and pwm2 indicates the current duty
 cycle chosen by the h/w.
 
-PWM Output Frequency:
+PWM Output Frequency
+^^^^^^^^^^^^^^^^^^^^
 
 The LM93 supports several different frequencies for the PWM output channels.
 The sysfs files pwm1_freq and pwm2_freq are used to select the frequency. The
@@ -149,9 +161,11 @@ frequency values are constrained by the hardware.  Selecting a value which is
 not available will cause the driver to use the next largest value.  Also note
 that this parameter has implications for the Smart Tach Mode (see above).
 
-PWM Output Frequencies (in Hz): 12, 36, 48, 60, 72, 84, 96, 22500 (default)
+PWM Output Frequencies (in Hz):
+	12, 36, 48, 60, 72, 84, 96, 22500 (default)
 
-Automatic PWM:
+Automatic PWM
+^^^^^^^^^^^^^
 
 The LM93 is capable of complex automatic fan control, with many different
 points of configuration.  To start, each PWM output can be bound to any
@@ -163,14 +177,16 @@ The eight control sources are: temp1-temp4 (aka "zones" in the datasheet),
 in the sysfs files pwm<n>_auto_channels, where a "1" enables the binding, and
 a "0" disables it. The h/w default is 0x0f (all temperatures bound).
 
-	0x01 - Temp 1
-	0x02 - Temp 2
-	0x04 - Temp 3
-	0x08 - Temp 4
-	0x10 - #PROCHOT 1
-	0x20 - #PROCHOT 2
-	0x40 - #VRDHOT 1
-	0x80 - #VRDHOT 2
+	====== ===========
+	0x01   Temp 1
+	0x02   Temp 2
+	0x04   Temp 3
+	0x08   Temp 4
+	0x10   #PROCHOT 1
+	0x20   #PROCHOT 2
+	0x40   #VRDHOT 1
+	0x80   #VRDHOT 2
+	====== ===========
 
 The function y = f(x) takes a source temperature x to a PWM output y.  This
 function of the LM93 is derived from a base temperature and a table of 12
@@ -180,7 +196,9 @@ degrees C, with the value of offset <i> for temperature value <n> being
 contained in the file temp<n>_auto_offset<i>.  E.g. if the base temperature
 is 40C:
 
+     ========== ======================= =============== =======
      offset #	temp<n>_auto_offset<i>	range		pwm
+     ========== ======================= =============== =======
 	 1		0		-		 25.00%
 	 2		0		-		 28.57%
 	 3		1		40C - 41C	 32.14%
@@ -193,7 +211,8 @@ is 40C:
 	10		2		54C - 56C	 57.14%
 	11		2		56C - 58C	 71.43%
 	12		2		58C - 60C	 85.71%
-					> 60C		100.00%
+	-		-		> 60C		100.00%
+     ========== ======================= =============== =======
 
 Valid offsets are in the range 0C <= x <= 7.5C in 0.5C increments.
 
@@ -213,7 +232,8 @@ temp<n>_auto_pwm_min.  Note, there are only two minimums: one each for temp[12]
 and temp[34].  Therefore, any change to e.g. temp1_auto_pwm_min will also
 affect temp2_auto_pwm_min.
 
-PWM Spin-Up Cycle:
+PWM Spin-Up Cycle
+^^^^^^^^^^^^^^^^^
 
 A spin-up cycle occurs when a PWM output is commanded from 0% duty cycle to
 some value > 0%.  The LM93 supports a minimum duty cycle during spin-up.  These
@@ -225,10 +245,11 @@ the spin-up time in seconds.  The available spin-up times are constrained by
 the hardware.  Selecting a value which is not available will cause the driver
 to use the next largest value.
 
-Spin-up Durations: 0 (disabled, h/w default), 0.1, 0.25, 0.4, 0.7, 1.0,
-		   2.0, 4.0
+Spin-up Durations:
+	0 (disabled, h/w default), 0.1, 0.25, 0.4, 0.7, 1.0, 2.0, 4.0
 
-#PROCHOT and #VRDHOT PWM Ramping:
+#PROCHOT and #VRDHOT PWM Ramping
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 If the #PROCHOT or #VRDHOT signals are asserted while bound to a PWM output
 channel, the LM93 will ramp the PWM output up to 100% duty cycle in discrete
@@ -237,9 +258,11 @@ one value each in seconds: pwm_auto_prochot_ramp and pwm_auto_vrdhot_ramp.
 The available ramp times are constrained by the hardware.  Selecting a value
 which is not available will cause the driver to use the next largest value.
 
-Ramp Times: 0 (disabled, h/w default) to 0.75 in 0.05 second intervals
+Ramp Times:
+	0 (disabled, h/w default) to 0.75 in 0.05 second intervals
 
-Fan Boost:
+Fan Boost
+^^^^^^^^^
 
 For each temperature channel, there is a boost temperature: if the channel
 exceeds this limit, the LM93 will immediately drive both PWM outputs to 100%.
@@ -249,7 +272,8 @@ limit is reached, the temperature channel must drop below this value before
 the boost function is disabled.  This temperature is also expressed in degrees
 C in the sysfs files temp<n>_auto_boost_hyst.
 
-GPIO Pins:
+GPIO Pins
+^^^^^^^^^
 
 The LM93 can monitor the logic level of four dedicated GPIO pins as well as the
 four tach input pins.  GPIO0-GPIO3 correspond to (fan) tach 1-4, respectively.
@@ -260,50 +284,29 @@ LSB is GPIO0, and the MSB is GPIO7.
 LM93 Unique sysfs Files
 -----------------------
 
-	file			description
-	-------------------------------------------------------------
-
-	prochot<n>		current #PROCHOT %
-
-	prochot<n>_avg		moving average #PROCHOT %
-
-	prochot<n>_max		limit #PROCHOT %
-
-	prochot_short		enable or disable logical #PROCHOT pin short
-
-	prochot<n>_override	force #PROCHOT assertion as PWM
-
-	prochot_override_duty_cycle
-				duty cycle for the PWM signal used when
-				#PROCHOT is overridden
-
-	prochot<n>_interval	#PROCHOT PWM sampling interval
-
-	vrdhot<n>		0 means negated, 1 means asserted
-
-	fan<n>_smart_tach	enable or disable smart tach mode
-
-	pwm<n>_auto_channels	select control sources for PWM outputs
-
-	pwm<n>_auto_spinup_min	minimum duty cycle during spin-up
-
-	pwm<n>_auto_spinup_time	duration of spin-up
-
-	pwm_auto_prochot_ramp	ramp time per step when #PROCHOT asserted
-
-	pwm_auto_vrdhot_ramp	ramp time per step when #VRDHOT asserted
-
-	temp<n>_auto_base	temperature channel base
-
-	temp<n>_auto_offset[1-12]
-				temperature channel offsets
-
-	temp<n>_auto_offset_hyst
-				temperature channel offset hysteresis
-
-	temp<n>_auto_boost	temperature channel boost (PWMs to 100%) limit
-
-	temp<n>_auto_boost_hyst	temperature channel boost hysteresis
-
-	gpio			input state of 8 GPIO pins; read-only
-
+=========================== ===============================================
+file			    description
+=========================== ===============================================
+prochot<n>		    current #PROCHOT %
+prochot<n>_avg		    moving average #PROCHOT %
+prochot<n>_max		    limit #PROCHOT %
+prochot_short		    enable or disable logical #PROCHOT pin short
+prochot<n>_override	    force #PROCHOT assertion as PWM
+prochot_override_duty_cycle duty cycle for the PWM signal used when
+			    #PROCHOT is overridden
+prochot<n>_interval	    #PROCHOT PWM sampling interval
+vrdhot<n>		    0 means negated, 1 means asserted
+fan<n>_smart_tach	    enable or disable smart tach mode
+pwm<n>_auto_channels	    select control sources for PWM outputs
+pwm<n>_auto_spinup_min	    minimum duty cycle during spin-up
+pwm<n>_auto_spinup_time	    duration of spin-up
+pwm_auto_prochot_ramp	    ramp time per step when #PROCHOT asserted
+pwm_auto_vrdhot_ramp	    ramp time per step when #VRDHOT asserted
+temp<n>_auto_base	    temperature channel base
+temp<n>_auto_offset[1-12]   temperature channel offsets
+temp<n>_auto_offset_hyst    temperature channel offset hysteresis
+temp<n>_auto_boost	    temperature channel boost (PWMs to 100%)
+			    limit
+temp<n>_auto_boost_hyst     temperature channel boost hysteresis
+gpio			    input state of 8 GPIO pins; read-only
+=========================== ===============================================
diff --git a/Documentation/hwmon/lm95245 b/Documentation/hwmon/lm95245
index d755901f58c4..566d1dc8c5a6 100644
--- a/Documentation/hwmon/lm95245
+++ b/Documentation/hwmon/lm95245
@@ -1,16 +1,23 @@
 Kernel driver lm95245
-==================
+=====================
 
 Supported chips:
+
   * TI LM95235
+
     Addresses scanned: I2C 0x18, 0x29, 0x4c
+
     Datasheet: Publicly available at the TI website
-               http://www.ti.com/lit/ds/symlink/lm95235.pdf
+
+	       http://www.ti.com/lit/ds/symlink/lm95235.pdf
+
   * TI / National Semiconductor LM95245
+
     Addresses scanned: I2C 0x18, 0x19, 0x29, 0x4c, 0x4d
+
     Datasheet: Publicly available at the TI website
-               http://www.ti.com/lit/ds/symlink/lm95245.pdf
 
+	       http://www.ti.com/lit/ds/symlink/lm95245.pdf
 
 Author: Alexander Stein <alexander.stein@systec-electronic.com>
 
diff --git a/Documentation/hwmon/ltc2945 b/Documentation/hwmon/ltc2945
index f8d0f7f19adb..20c884985367 100644
--- a/Documentation/hwmon/ltc2945
+++ b/Documentation/hwmon/ltc2945
@@ -2,11 +2,16 @@ Kernel driver ltc2945
 =====================
 
 Supported chips:
+
   * Linear Technology LTC2945
+
     Prefix: 'ltc2945'
+
     Addresses scanned: -
+
     Datasheet:
-        http://cds.linear.com/docs/en/datasheet/2945fa.pdf
+
+	http://cds.linear.com/docs/en/datasheet/2945fa.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -26,9 +31,10 @@ which can be safely used to identify the chip. You will have to instantiate
 the devices explicitly.
 
 Example: the following will load the driver for an LTC2945 at address 0x10
-on I2C bus #1:
-$ modprobe ltc2945
-$ echo ltc2945 0x10 > /sys/bus/i2c/devices/i2c-1/new_device
+on I2C bus #1::
+
+	$ modprobe ltc2945
+	$ echo ltc2945 0x10 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs entries
@@ -45,6 +51,7 @@ Current Sense register. The reported value assumes that a 1 mOhm sense resistor
 is installed. If a different sense resistor is installed, calculate the real
 current by dividing the reported value by the sense resistor value in mOhm.
 
+======================= ========================================================
 in1_input		VIN voltage (mV). Voltage is measured either at
 			SENSE+ or VDD pin depending on chip configuration.
 in1_min			Undervoltage threshold
@@ -82,3 +89,4 @@ power1_input_highest	Historical maximum power use
 power1_reset_history	Write 1 to reset power1 history
 power1_min_alarm	Low power alarm
 power1_max_alarm	High power alarm
+======================= ========================================================
diff --git a/Documentation/hwmon/ltc2990 b/Documentation/hwmon/ltc2990
index 3ed68f676c0f..e0a369e679d3 100644
--- a/Documentation/hwmon/ltc2990
+++ b/Documentation/hwmon/ltc2990
@@ -1,14 +1,23 @@
 Kernel driver ltc2990
 =====================
 
+
 Supported chips:
+
   * Linear Technology LTC2990
+
     Prefix: 'ltc2990'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc2990
 
-Author: Mike Looijmans <mike.looijmans@topic.nl>
-        Tom Levens <tom.levens@cern.ch>
+
+
+Author:
+
+	- Mike Looijmans <mike.looijmans@topic.nl>
+	- Tom Levens <tom.levens@cern.ch>
 
 
 Description
@@ -31,17 +40,21 @@ devices explicitly.
 Sysfs attributes
 ----------------
 
+============= ==================================================
 in0_input     Voltage at Vcc pin in millivolt (range 2.5V to 5V)
-temp1_input   Internal chip temperature in millidegrees Celcius
+temp1_input   Internal chip temperature in millidegrees Celsius
+============= ==================================================
 
 A subset of the following attributes are visible, depending on the measurement
 mode of the chip.
 
+============= ==========================================================
 in[1-4]_input Voltage at V[1-4] pin in millivolt
-temp2_input   External temperature sensor TR1 in millidegrees Celcius
-temp3_input   External temperature sensor TR2 in millidegrees Celcius
+temp2_input   External temperature sensor TR1 in millidegrees Celsius
+temp3_input   External temperature sensor TR2 in millidegrees Celsius
 curr1_input   Current in mA across V1-V2 assuming a 1mOhm sense resistor
 curr2_input   Current in mA across V3-V4 assuming a 1mOhm sense resistor
+============= ==========================================================
 
 The "curr*_input" measurements actually report the voltage drop across the
 input pins in microvolts. This is equivalent to the current through a 1mOhm
diff --git a/Documentation/hwmon/ltc4151 b/Documentation/hwmon/ltc4151
index 43c667e6677a..c39229b19624 100644
--- a/Documentation/hwmon/ltc4151
+++ b/Documentation/hwmon/ltc4151
@@ -2,11 +2,16 @@ Kernel driver ltc4151
 =====================
 
 Supported chips:
+
   * Linear Technology LTC4151
+
     Prefix: 'ltc4151'
+
     Addresses scanned: -
+
     Datasheet:
-        http://www.linear.com/docs/Datasheet/4151fc.pdf
+
+	http://www.linear.com/docs/Datasheet/4151fc.pdf
 
 Author: Per Dalen <per.dalen@appeartv.com>
 
@@ -25,9 +30,10 @@ which can be safely used to identify the chip. You will have to instantiate
 the devices explicitly.
 
 Example: the following will load the driver for an LTC4151 at address 0x6f
-on I2C bus #0:
-# modprobe ltc4151
-# echo ltc4151 0x6f > /sys/bus/i2c/devices/i2c-0/new_device
+on I2C bus #0::
+
+	# modprobe ltc4151
+	# echo ltc4151 0x6f > /sys/bus/i2c/devices/i2c-0/new_device
 
 
 Sysfs entries
@@ -40,8 +46,10 @@ Current reading provided by this driver is reported as obtained from the Current
 Sense register. The reported value assumes that a 1 mOhm sense resistor is
 installed.
 
+======================= ==================
 in1_input		VDIN voltage (mV)
 
 in2_input		ADIN voltage (mV)
 
 curr1_input		SENSE current (mA)
+======================= ==================
diff --git a/Documentation/hwmon/ltc4215 b/Documentation/hwmon/ltc4215
index c196a1846259..8d5044d99bab 100644
--- a/Documentation/hwmon/ltc4215
+++ b/Documentation/hwmon/ltc4215
@@ -2,11 +2,16 @@ Kernel driver ltc4215
 =====================
 
 Supported chips:
+
   * Linear Technology LTC4215
+
     Prefix: 'ltc4215'
+
     Addresses scanned: 0x44
+
     Datasheet:
-        http://www.linear.com/pc/downloadDocument.do?navId=H0,C1,C1003,C1006,C1163,P17572,D12697
+
+	http://www.linear.com/pc/downloadDocument.do?navId=H0,C1,C1003,C1006,C1163,P17572,D12697
 
 Author: Ira W. Snyder <iws@ovro.caltech.edu>
 
@@ -26,9 +31,10 @@ of the possible addresses are unfriendly to probing. You will have to
 instantiate the devices explicitly.
 
 Example: the following will load the driver for an LTC4215 at address 0x44
-on I2C bus #0:
-$ modprobe ltc4215
-$ echo ltc4215 0x44 > /sys/bus/i2c/devices/i2c-0/new_device
+on I2C bus #0::
+
+	$ modprobe ltc4215
+	$ echo ltc4215 0x44 > /sys/bus/i2c/devices/i2c-0/new_device
 
 
 Sysfs entries
@@ -38,6 +44,7 @@ The LTC4215 has built-in limits for overvoltage, undervoltage, and
 undercurrent warnings. This makes it very likely that the reference
 circuit will be used.
 
+======================= =========================
 in1_input		input voltage
 in2_input		output voltage
 
@@ -49,3 +56,4 @@ curr1_max_alarm		overcurrent alarm
 
 power1_input		power usage
 power1_alarm		power bad alarm
+======================= =========================
diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
index 4ca7a9da09f9..3dafd08a4e87 100644
--- a/Documentation/hwmon/ltc4245
+++ b/Documentation/hwmon/ltc4245
@@ -2,11 +2,16 @@ Kernel driver ltc4245
 =====================
 
 Supported chips:
+
   * Linear Technology LTC4245
+
     Prefix: 'ltc4245'
+
     Addresses scanned: 0x20-0x3f
+
     Datasheet:
-        http://www.linear.com/pc/downloadDocument.do?navId=H0,C1,C1003,C1006,C1140,P19392,D13517
+
+	http://www.linear.com/pc/downloadDocument.do?navId=H0,C1,C1003,C1006,C1140,P19392,D13517
 
 Author: Ira W. Snyder <iws@ovro.caltech.edu>
 
@@ -27,9 +32,10 @@ of the possible addresses are unfriendly to probing. You will have to
 instantiate the devices explicitly.
 
 Example: the following will load the driver for an LTC4245 at address 0x23
-on I2C bus #1:
-$ modprobe ltc4245
-$ echo ltc4245 0x23 > /sys/bus/i2c/devices/i2c-1/new_device
+on I2C bus #1::
+
+	$ modprobe ltc4245
+	$ echo ltc4245 0x23 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs entries
@@ -42,6 +48,7 @@ This driver uses the values in the datasheet to change the register values
 into the values specified in the sysfs-interface document. The current readings
 rely on the sense resistors listed in Table 2: "Sense Resistor Values".
 
+======================= =======================================================
 in1_input		12v input voltage (mV)
 in2_input		5v  input voltage (mV)
 in3_input		3v  input voltage (mV)
@@ -80,6 +87,7 @@ power1_input		12v power usage (mW)
 power2_input		5v  power usage (mW)
 power3_input		3v  power usage (mW)
 power4_input		Vee (-12v) power usage (mW)
+======================= =======================================================
 
 
 Note 1
@@ -96,6 +104,7 @@ slowly, -EAGAIN will be returned when you read the sysfs attribute containing
 the sensor reading.
 
 The LTC4245 chip can be configured to sample all GPIO pins with two methods:
+
 1) platform data -- see include/linux/platform_data/ltc4245.h
 2) OF device tree -- add the "ltc4245,use-extra-gpios" property to each chip
 
diff --git a/Documentation/hwmon/ltc4260 b/Documentation/hwmon/ltc4260
index c4ff4ad998b2..4c335b6a51d1 100644
--- a/Documentation/hwmon/ltc4260
+++ b/Documentation/hwmon/ltc4260
@@ -2,11 +2,16 @@ Kernel driver ltc4260
 =====================
 
 Supported chips:
+
   * Linear Technology LTC4260
+
     Prefix: 'ltc4260'
+
     Addresses scanned: -
+
     Datasheet:
-        http://cds.linear.com/docs/en/datasheet/4260fc.pdf
+
+	http://cds.linear.com/docs/en/datasheet/4260fc.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -26,9 +31,10 @@ which can be safely used to identify the chip. You will have to instantiate
 the devices explicitly.
 
 Example: the following will load the driver for an LTC4260 at address 0x10
-on I2C bus #1:
-$ modprobe ltc4260
-$ echo ltc4260 0x10 > /sys/bus/i2c/devices/i2c-1/new_device
+on I2C bus #1::
+
+	$ modprobe ltc4260
+	$ echo ltc4260 0x10 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs entries
@@ -45,6 +51,7 @@ Current Sense register. The reported value assumes that a 1 mOhm sense resistor
 is installed. If a different sense resistor is installed, calculate the real
 current by dividing the reported value by the sense resistor value in mOhm.
 
+======================= =======================
 in1_input		SOURCE voltage (mV)
 in1_min_alarm		Undervoltage alarm
 in1_max_alarm		Overvoltage alarm
@@ -54,3 +61,4 @@ in2_alarm		Power bad alarm
 
 curr1_input		SENSE current (mA)
 curr1_alarm		SENSE overcurrent alarm
+======================= =======================
diff --git a/Documentation/hwmon/max1619 b/Documentation/hwmon/max1619
index 518bae3a80c4..4b3762c4eceb 100644
--- a/Documentation/hwmon/max1619
+++ b/Documentation/hwmon/max1619
@@ -2,15 +2,20 @@ Kernel driver max1619
 =====================
 
 Supported chips:
+
   * Maxim MAX1619
+
     Prefix: 'max1619'
+
     Addresses scanned: I2C 0x18-0x1a, 0x29-0x2b, 0x4c-0x4e
+
     Datasheet: Publicly available at the Maxim website
-               http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
+
+	       http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
 
 Authors:
-        Oleksij Rempel <bug-track@fisher-privat.net>,
-        Jean Delvare <jdelvare@suse.de>
+       - Oleksij Rempel <bug-track@fisher-privat.net>,
+       - Jean Delvare <jdelvare@suse.de>
 
 Description
 -----------
diff --git a/Documentation/hwmon/max1668 b/Documentation/hwmon/max1668
index 8f9d570dbfec..417f17d750e6 100644
--- a/Documentation/hwmon/max1668
+++ b/Documentation/hwmon/max1668
@@ -2,12 +2,17 @@ Kernel driver max1668
 =====================
 
 Supported chips:
+
   * Maxim MAX1668, MAX1805 and MAX1989
+
     Prefix: 'max1668'
+
     Addresses scanned: I2C 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e
+
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX1668-MAX1989.pdf
 
 Author:
+
     David George <david.george@ska.ac.za>
 
 Description
@@ -23,8 +28,9 @@ two ICs.
 The driver is able to distinguish between the devices and creates sysfs
 entries as follows:
 
-MAX1805, MAX1668 and MAX1989:
+- MAX1805, MAX1668 and MAX1989:
 
+=============== == ============================================================
 temp1_input     ro local (ambient) temperature
 temp1_max       rw local temperature maximum threshold for alarm
 temp1_max_alarm ro local temperature maximum threshold alarm
@@ -40,8 +46,11 @@ temp3_max       rw remote temperature 2 maximum threshold for alarm
 temp3_max_alarm ro remote temperature 2 maximum threshold alarm
 temp3_min       rw remote temperature 2 minimum threshold for alarm
 temp3_min_alarm ro remote temperature 2 minimum threshold alarm
+=============== == ============================================================
 
-MAX1668 and MAX1989 only:
+- MAX1668 and MAX1989 only:
+
+=============== == ============================================================
 temp4_input     ro remote temperature 3
 temp4_max       rw remote temperature 3 maximum threshold for alarm
 temp4_max_alarm ro remote temperature 3 maximum threshold alarm
@@ -52,6 +61,7 @@ temp5_max       rw remote temperature 4 maximum threshold for alarm
 temp5_max_alarm ro remote temperature 4 maximum threshold alarm
 temp5_min       rw remote temperature 4 minimum threshold for alarm
 temp5_min_alarm ro remote temperature 4 minimum threshold alarm
+=============== == ============================================================
 
 Module Parameters
 -----------------
diff --git a/Documentation/hwmon/max197 b/Documentation/hwmon/max197
index 8d89b9009df8..02fe19bc3428 100644
--- a/Documentation/hwmon/max197
+++ b/Documentation/hwmon/max197
@@ -1,16 +1,22 @@
-Maxim MAX197 driver
-===================
+Kernel driver max197
+====================
 
 Author:
+
   * Vivien Didelot <vivien.didelot@savoirfairelinux.com>
 
 Supported chips:
+
   * Maxim MAX197
+
     Prefix: 'max197'
+
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX197.pdf
 
   * Maxim MAX199
+
     Prefix: 'max199'
+
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX199.pdf
 
 Description
@@ -26,7 +32,7 @@ Platform data
 -------------
 
 The MAX197 platform data (defined in linux/platform_data/max197.h) should be
-filled with a pointer to a conversion function, defined like:
+filled with a pointer to a conversion function, defined like::
 
     int convert(u8 ctrl);
 
@@ -36,25 +42,29 @@ or a negative error code otherwise.
 
 Control byte format:
 
+======= ========== ============================================
 Bit     Name       Description
 7,6     PD1,PD0    Clock and Power-Down modes
 5       ACQMOD     Internal or External Controlled Acquisition
 4       RNG        Full-scale voltage magnitude at the input
 3       BIP        Unipolar or Bipolar conversion mode
 2,1,0   A2,A1,A0   Channel
+======= ========== ============================================
 
 Sysfs interface
 ---------------
 
-* in[0-7]_input: The conversion value for the corresponding channel.
-                 RO
+  ============== ==============================================================
+  in[0-7]_input  The conversion value for the corresponding channel.
+		 RO
 
-* in[0-7]_min:   The lower limit (in mV) for the corresponding channel.
-                 For the MAX197, it will be adjusted to -10000, -5000, or 0.
-                 For the MAX199, it will be adjusted to -4000, -2000, or 0.
-                 RW
+  in[0-7]_min    The lower limit (in mV) for the corresponding channel.
+		 For the MAX197, it will be adjusted to -10000, -5000, or 0.
+		 For the MAX199, it will be adjusted to -4000, -2000, or 0.
+		 RW
 
-* in[0-7]_max:   The higher limit (in mV) for the corresponding channel.
-                 For the MAX197, it will be adjusted to 0, 5000, or 10000.
-                 For the MAX199, it will be adjusted to 0, 2000, or 4000.
-                 RW
+  in[0-7]_max    The higher limit (in mV) for the corresponding channel.
+		 For the MAX197, it will be adjusted to 0, 5000, or 10000.
+		 For the MAX199, it will be adjusted to 0, 2000, or 4000.
+		 RW
+  ============== ==============================================================
diff --git a/Documentation/hwmon/max31722 b/Documentation/hwmon/max31722
index 090da84538c8..0ab15c00b226 100644
--- a/Documentation/hwmon/max31722
+++ b/Documentation/hwmon/max31722
@@ -2,15 +2,25 @@ Kernel driver max31722
 ======================
 
 Supported chips:
+
   * Maxim Integrated MAX31722
+
     Prefix: 'max31722'
+
     ACPI ID: MAX31722
+
     Addresses scanned: -
+
     Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
+
   * Maxim Integrated MAX31723
+
     Prefix: 'max31723'
+
     ACPI ID: MAX31723
+
     Addresses scanned: -
+
     Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
 
 Author: Tiberiu Breana <tiberiu.a.breana@intel.com>
@@ -31,4 +41,6 @@ Sysfs entries
 
 The following attribute is supported:
 
+======================= =======================================================
 temp1_input		Measured temperature. Read-only.
+======================= =======================================================
diff --git a/Documentation/hwmon/max31790 b/Documentation/hwmon/max31790
index 855e62430da9..84c62a12ef3a 100644
--- a/Documentation/hwmon/max31790
+++ b/Documentation/hwmon/max31790
@@ -2,9 +2,13 @@ Kernel driver max31790
 ======================
 
 Supported chips:
+
   * Maxim MAX31790
+
     Prefix: 'max31790'
+
     Addresses scanned: -
+
     Datasheet: http://pdfserv.maximintegrated.com/en/ds/MAX31790.pdf
 
 Author: Il Han <corone.il.han@gmail.com>
@@ -30,8 +34,10 @@ also be configured to serve as tachometer inputs.
 Sysfs entries
 -------------
 
+================== === =======================================================
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-6]_target    RW  desired fan speed in RPM
 pwm[1-6]_enable    RW  regulator mode, 0=disabled, 1=manual mode, 2=rpm mode
 pwm[1-6]           RW  fan target duty cycle (0-255)
+================== === =======================================================
diff --git a/Documentation/hwmon/max6639 b/Documentation/hwmon/max6639
index dc49f8be7167..3da54225f83c 100644
--- a/Documentation/hwmon/max6639
+++ b/Documentation/hwmon/max6639
@@ -2,14 +2,18 @@ Kernel driver max6639
 =====================
 
 Supported chips:
+
   * Maxim MAX6639
+
     Prefix: 'max6639'
+
     Addresses scanned: I2C 0x2c, 0x2e, 0x2f
+
     Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6639.pdf
 
 Authors:
-    He Changqing <hechangqing@semptian.com>
-    Roland Stigge <stigge@antcom.de>
+    - He Changqing <hechangqing@semptian.com>
+    - Roland Stigge <stigge@antcom.de>
 
 Description
 -----------
@@ -21,19 +25,20 @@ diode-connected transistors.
 
 The following device attributes are implemented via sysfs:
 
+====================== ==== ===================================================
 Attribute              R/W  Contents
-----------------------------------------------------------------------------
+====================== ==== ===================================================
 temp1_input            R    Temperature channel 1 input (0..150 C)
 temp2_input            R    Temperature channel 2 input (0..150 C)
 temp1_fault            R    Temperature channel 1 diode fault
 temp2_fault            R    Temperature channel 2 diode fault
 temp1_max              RW   Set THERM temperature for input 1
-                            (in C, see datasheet)
+			    (in C, see datasheet)
 temp2_max              RW   Set THERM temperature for input 2
 temp1_crit             RW   Set ALERT temperature for input 1
 temp2_crit             RW   Set ALERT temperature for input 2
 temp1_emergency        RW   Set OT temperature for input 1
-                            (in C, see datasheet)
+			    (in C, see datasheet)
 temp2_emergency        RW   Set OT temperature for input 2
 pwm1                   RW   Fan 1 target duty cycle (0..255)
 pwm2                   RW   Fan 2 target duty cycle (0..255)
@@ -47,3 +52,4 @@ temp1_crit_alarm       R    Alarm on ALERT temperature on channel 1
 temp2_crit_alarm       R    Alarm on ALERT temperature on channel 2
 temp1_emergency_alarm  R    Alarm on OT temperature on channel 1
 temp2_emergency_alarm  R    Alarm on OT temperature on channel 2
+====================== ==== ===================================================
diff --git a/Documentation/hwmon/max6642 b/Documentation/hwmon/max6642
index afbd3e4942e2..7e5b7d4f9492 100644
--- a/Documentation/hwmon/max6642
+++ b/Documentation/hwmon/max6642
@@ -2,14 +2,20 @@ Kernel driver max6642
 =====================
 
 Supported chips:
+
   * Maxim MAX6642
+
     Prefix: 'max6642'
+
     Addresses scanned: I2C 0x48-0x4f
+
     Datasheet: Publicly available at the Maxim website
-               http://datasheets.maxim-ic.com/en/ds/MAX6642.pdf
+
+	       http://datasheets.maxim-ic.com/en/ds/MAX6642.pdf
 
 Authors:
-        Per Dalen <per.dalen@appeartv.com>
+
+	Per Dalen <per.dalen@appeartv.com>
 
 Description
 -----------
diff --git a/Documentation/hwmon/max6650 b/Documentation/hwmon/max6650
index dff1d296a48b..74dc3f0caaa2 100644
--- a/Documentation/hwmon/max6650
+++ b/Documentation/hwmon/max6650
@@ -2,19 +2,27 @@ Kernel driver max6650
 =====================
 
 Supported chips:
+
   * Maxim MAX6650
+
     Prefix: 'max6650'
+
     Addresses scanned: none
+
     Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+
   * Maxim MAX6651
+
     Prefix: 'max6651'
+
     Addresses scanned: none
+
     Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
 
 Authors:
-    Hans J. Koch <hjk@hansjkoch.de>
-    John Morris <john.morris@spirentcom.com>
-    Claus Gindhart <claus.gindhart@kontron.com>
+    - Hans J. Koch <hjk@hansjkoch.de>
+    - John Morris <john.morris@spirentcom.com>
+    - Claus Gindhart <claus.gindhart@kontron.com>
 
 Description
 -----------
@@ -28,6 +36,7 @@ The driver is not able to distinguish between the 2 devices.
 
 The driver provides the following sensor accesses in sysfs:
 
+=============== ======= =======================================================
 fan1_input	ro	fan tachometer speed in RPM
 fan2_input	ro	"
 fan3_input	ro	"
@@ -40,6 +49,7 @@ pwm1		rw	relative speed (0-255), 255=max. speed.
 fan1_div	rw	sets the speed range the inputs can handle. Legal
 			values are 1, 2, 4, and 8. Use lower values for
 			faster fans.
+=============== ======= =======================================================
 
 Usage notes
 -----------
diff --git a/Documentation/hwmon/mc13783-adc b/Documentation/hwmon/mc13783-adc
index 05ccc9f159f1..cae70350ba2f 100644
--- a/Documentation/hwmon/mc13783-adc
+++ b/Documentation/hwmon/mc13783-adc
@@ -2,16 +2,25 @@ Kernel driver mc13783-adc
 =========================
 
 Supported chips:
+
   * Freescale MC13783
+
     Prefix: 'mc13783'
+
     Datasheet: https://www.nxp.com/docs/en/data-sheet/MC13783.pdf
+
   * Freescale MC13892
+
     Prefix: 'mc13892'
+
     Datasheet: https://www.nxp.com/docs/en/data-sheet/MC13892.pdf
 
+
+
 Authors:
-    Sascha Hauer <s.hauer@pengutronix.de>
-    Luotao Fu <l.fu@pengutronix.de>
+
+   - Sascha Hauer <s.hauer@pengutronix.de>
+   - Luotao Fu <l.fu@pengutronix.de>
 
 Description
 -----------
@@ -30,9 +39,11 @@ the General Purpose inputs and touchscreen.
 See the following tables for the meaning of the different channels and their
 chip internal scaling:
 
-MC13783:
+- MC13783:
+
+======= =============================================== =============== =======
 Channel	Signal						Input Range	Scaling
--------------------------------------------------------------------------------
+======= =============================================== =============== =======
 0	Battery Voltage (BATT)				2.50 - 4.65V	-2.40V
 1	Battery Current (BATT - BATTISNS)		-50 - 50 mV	x20
 2	Application Supply (BP)				2.50 - 4.65V	-2.40V
@@ -52,10 +63,13 @@ Channel	Signal						Input Range	Scaling
 13	General Purpose TSX2 / Touchscreen X-plate 2	0 - 2.30V	No
 14	General Purpose TSY1 / Touchscreen Y-plate 1	0 - 2.30V	No
 15	General Purpose TSY2 / Touchscreen Y-plate 2	0 - 2.30V	No
+======= =============================================== =============== =======
 
-MC13892:
+- MC13892:
+
+======= =============================================== =============== =======
 Channel	Signal						Input Range	Scaling
--------------------------------------------------------------------------------
+======= =============================================== =============== =======
 0	Battery Voltage (BATT)				0 - 4.8V	/2
 1	Battery Current (BATT - BATTISNSCC)		-60 - 60 mV	x20
 2	Application Supply (BPSNS)			0 - 4.8V	/2
@@ -72,3 +86,4 @@ Channel	Signal						Input Range	Scaling
 13	General Purpose TSX2 / Touchscreen X-plate 2	0 - 2.4V	No
 14	General Purpose TSY1 / Touchscreen Y-plate 1	0 - 2.4V	No
 15	General Purpose TSY2 / Touchscreen Y-plate 2	0 - 2.4V	No
+======= =============================================== =============== =======
diff --git a/Documentation/hwmon/mcp3021 b/Documentation/hwmon/mcp3021
index 74a6b72adf5f..83f4bda2f269 100644
--- a/Documentation/hwmon/mcp3021
+++ b/Documentation/hwmon/mcp3021
@@ -1,17 +1,26 @@
 Kernel driver MCP3021
-======================
+=====================
 
 Supported chips:
+
   * Microchip Technology MCP3021
+
     Prefix: 'mcp3021'
+
     Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/21805a.pdf
+
   * Microchip Technology MCP3221
+
     Prefix: 'mcp3221'
+
     Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/21732c.pdf
 
+
+
 Authors:
-   Mingkai Hu
-   Sven Schuchmann <schuchmann@schleissheimer.de>
+
+   - Mingkai Hu
+   - Sven Schuchmann <schuchmann@schleissheimer.de>
 
 Description
 -----------
diff --git a/Documentation/hwmon/mlxreg-fan b/Documentation/hwmon/mlxreg-fan
index fc531c6978d4..c92b8e885f7e 100644
--- a/Documentation/hwmon/mlxreg-fan
+++ b/Documentation/hwmon/mlxreg-fan
@@ -2,33 +2,39 @@ Kernel driver mlxreg-fan
 ========================
 
 Provides FAN control for the next Mellanox systems:
-QMB700, equipped with 40x200GbE InfiniBand ports;
-MSN3700, equipped with 32x200GbE or 16x400GbE Ethernet ports;
-MSN3410, equipped with 6x400GbE plus 48x50GbE Ethernet ports;
-MSN3800, equipped with 64x1000GbE Ethernet ports;
+
+- QMB700, equipped with 40x200GbE InfiniBand ports;
+- MSN3700, equipped with 32x200GbE or 16x400GbE Ethernet ports;
+- MSN3410, equipped with 6x400GbE plus 48x50GbE Ethernet ports;
+- MSN3800, equipped with 64x1000GbE Ethernet ports;
+
+Author: Vadim Pasternak <vadimp@mellanox.com>
+
 These are the Top of the Rack systems, equipped with Mellanox switch
 board with Mellanox Quantum or Spectrume-2 devices.
 FAN controller is implemented by the programmable device logic.
 
 The default registers offsets set within the programmable device is as
 following:
-- pwm1			0xe3
-- fan1 (tacho1)		0xe4
-- fan2 (tacho2)		0xe5
-- fan3 (tacho3)		0xe6
-- fan4 (tacho4)		0xe7
-- fan5 (tacho5)		0xe8
-- fan6 (tacho6)		0xe9
-- fan7 (tacho7)		0xea
-- fan8 (tacho8)		0xeb
-- fan9 (tacho9)		0xec
-- fan10 (tacho10)	0xed
-- fan11 (tacho11)	0xee
-- fan12 (tacho12)	0xef
+
+======================= ====
+pwm1			0xe3
+fan1 (tacho1)		0xe4
+fan2 (tacho2)		0xe5
+fan3 (tacho3)		0xe6
+fan4 (tacho4)		0xe7
+fan5 (tacho5)		0xe8
+fan6 (tacho6)		0xe9
+fan7 (tacho7)		0xea
+fan8 (tacho8)		0xeb
+fan9 (tacho9)		0xec
+fan10 (tacho10)		0xed
+fan11 (tacho11)		0xee
+fan12 (tacho12)		0xef
+======================= ====
+
 This setup can be re-programmed with other registers.
 
-Author: Vadim Pasternak <vadimp@mellanox.com>
-
 Description
 -----------
 
@@ -48,13 +54,17 @@ thermal's sysfs interfaces.
 /sys files in hwmon subsystem
 -----------------------------
 
-fan[1-12]_fault - RO files for tachometers TACH1-TACH12 fault indication
-fan[1-12]_input - RO files for tachometers TACH1-TACH12 input (in RPM)
-pwm1		- RW file for fan[1-12] target duty cycle (0..255)
+================= == ===================================================
+fan[1-12]_fault   RO files for tachometers TACH1-TACH12 fault indication
+fan[1-12]_input   RO files for tachometers TACH1-TACH12 input (in RPM)
+pwm1		  RW file for fan[1-12] target duty cycle (0..255)
+================= == ===================================================
 
 /sys files in thermal subsystem
 -------------------------------
 
-cur_state	- RW file for current cooling state of the cooling device
-		  (0..max_state)
-max_state	- RO file for maximum cooling state of the cooling device
+================= == ====================================================
+cur_state	  RW file for current cooling state of the cooling device
+		     (0..max_state)
+max_state	  RO file for maximum cooling state of the cooling device
+================= == ====================================================
diff --git a/Documentation/hwmon/nct6683 b/Documentation/hwmon/nct6683
index c1301d4300cd..efbf7e9703ec 100644
--- a/Documentation/hwmon/nct6683
+++ b/Documentation/hwmon/nct6683
@@ -2,13 +2,18 @@ Kernel driver nct6683
 =====================
 
 Supported chips:
+
   * Nuvoton NCT6683D
+
     Prefix: 'nct6683'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
 
 Authors:
-        Guenter Roeck <linux@roeck-us.net>
+
+	Guenter Roeck <linux@roeck-us.net>
 
 Description
 -----------
@@ -50,8 +55,10 @@ Tested Boards and Firmware Versions
 The driver has been reported to work with the following boards and
 firmware versions.
 
+=============== ===============================================
 Board		Firmware version
----------------------------------------------------------------
+=============== ===============================================
 Intel DH87RL	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DH87MC	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DB85FL	NCT6683D EC firmware version 1.0 build 04/03/13
+=============== ===============================================
diff --git a/Documentation/hwmon/nct7802 b/Documentation/hwmon/nct7802
index 5438deb6be02..8b7365a7cb32 100644
--- a/Documentation/hwmon/nct7802
+++ b/Documentation/hwmon/nct7802
@@ -2,13 +2,18 @@ Kernel driver nct7802
 =====================
 
 Supported chips:
+
   * Nuvoton NCT7802Y
+
     Prefix: 'nct7802'
+
     Addresses scanned: I2C 0x28..0x2f
+
     Datasheet: Available from Nuvoton web site
 
 Authors:
-        Guenter Roeck <linux@roeck-us.net>
+
+	Guenter Roeck <linux@roeck-us.net>
 
 Description
 -----------
@@ -25,7 +30,9 @@ Tested Boards and BIOS Versions
 The driver has been reported to work with the following boards and
 BIOS versions.
 
+======================= ===============================================
 Board			BIOS version
----------------------------------------------------------------
+======================= ===============================================
 Kontron COMe-bSC2	CHR2E934.001.GGO
 Kontron COMe-bIP2	CCR2E212
+======================= ===============================================
diff --git a/Documentation/hwmon/nct7904 b/Documentation/hwmon/nct7904
index 57fffe33ebfc..5b2f111582ff 100644
--- a/Documentation/hwmon/nct7904
+++ b/Documentation/hwmon/nct7904
@@ -1,11 +1,16 @@
 Kernel driver nct7904
-====================
+=====================
 
 Supported chip:
+
   * Nuvoton NCT7904D
+
     Prefix: nct7904
+
     Addresses: I2C 0x2d, 0x2e
+
     Datasheet: Publicly available at Nuvoton website
+
 	http://www.nuvoton.com/
 
 Author: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
@@ -25,6 +30,7 @@ Sysfs entries
 
 Currently, the driver supports only the following features:
 
+======================= =======================================================
 in[1-20]_input		Input voltage measurements (mV)
 
 fan[1-12]_input		Fan tachometer measurements (rpm)
@@ -40,6 +46,7 @@ pwm[1-4]_enable		R/W, 1/2 for manual or SmartFan mode
 			previously configured by BIOS (or configuration EEPROM)
 
 pwm[1-4]		R/O in SmartFan mode, R/W in manual control mode
+======================= =======================================================
 
 The driver checks sensor control registers and does not export the sensors
 that are not enabled. Anyway, a sensor that is enabled may actually be not
diff --git a/Documentation/hwmon/npcm750-pwm-fan b/Documentation/hwmon/npcm750-pwm-fan
index 6156ef7398e6..c67af08b6773 100644
--- a/Documentation/hwmon/npcm750-pwm-fan
+++ b/Documentation/hwmon/npcm750-pwm-fan
@@ -2,9 +2,11 @@ Kernel driver npcm750-pwm-fan
 =============================
 
 Supported chips:
+
 	NUVOTON NPCM750/730/715/705
 
 Authors:
+
 	<tomer.maimon@nuvoton.com>
 
 Description:
@@ -15,8 +17,10 @@ controller supports up to 16 tachometer inputs.
 
 The driver provides the following sensor accesses in sysfs:
 
+=============== ======= =====================================================
 fanX_input	ro	provide current fan rotation value in RPM as reported
 			by the fan to the device.
 
 pwmX		rw	get or set PWM fan control value. This is an integer
 			value between 0(off) and 255(full speed).
+=============== ======= =====================================================
diff --git a/Documentation/hwmon/nsa320 b/Documentation/hwmon/nsa320
index fdbd6947799b..4fe75fd2f937 100644
--- a/Documentation/hwmon/nsa320
+++ b/Documentation/hwmon/nsa320
@@ -2,14 +2,23 @@ Kernel driver nsa320_hwmon
 ==========================
 
 Supported chips:
+
   * Holtek HT46R065 microcontroller with onboard firmware that configures
+
 	it to act as a hardware monitor.
+
     Prefix: 'nsa320'
+
     Addresses scanned: none
+
     Datasheet: Not available, driver was reverse engineered based upon the
+
 	Zyxel kernel source
 
+
+
 Author:
+
   Adam Baker <linux@baker-net.org.uk>
 
 Description
@@ -31,8 +40,10 @@ tenths of a degree.
 sysfs-Interface
 ---------------
 
-temp1_input - temperature input
-fan1_input - fan speed
+============= =================
+temp1_input   temperature input
+fan1_input    fan speed
+============= =================
 
 Notes
 -----
diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/ntc_thermistor
index 8b9ff23edc32..d0e7f91726b9 100644
--- a/Documentation/hwmon/ntc_thermistor
+++ b/Documentation/hwmon/ntc_thermistor
@@ -1,22 +1,29 @@
 Kernel driver ntc_thermistor
-=================
+============================
 
 Supported thermistors from Murata:
+
 * Murata NTC Thermistors NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473,
   NCP15WL333, NCP03WF104, NCP15XH103
+
   Prefixes: 'ncp15wb473', 'ncp18wb473', 'ncp21wb473', 'ncp03wb473',
   'ncp15wl333', 'ncp03wf104', 'ncp15xh103'
+
   Datasheet: Publicly available at Murata
 
 Supported thermistors from EPCOS:
+
 * EPCOS NTC Thermistors B57330V2103
+
   Prefixes: b57330v2103
+
   Datasheet: Publicly available at EPCOS
 
 Other NTC thermistors can be supported simply by adding compensation
 tables; e.g., NCP15WL333 support is added by the table ncpXXwl333.
 
 Authors:
+
 	MyungJoo Ham <myungjoo.ham@samsung.com>
 
 Description
@@ -29,57 +36,60 @@ compensation table to get the temperature input.
 The NTC driver provides lookup tables with a linear approximation function
 and four circuit models with an option not to use any of the four models.
 
+Using the following convention::
+
+   $	resistor
+   [TH]	the thermistor
+
 The four circuit models provided are:
 
-	$: resister, [TH]: the thermistor
-
- 1. connect = NTC_CONNECTED_POSITIVE, pullup_ohm > 0
-
-   [pullup_uV]
-       |    |
-      [TH]  $ (pullup_ohm)
-       |    |
-       +----+-----------------------[read_uV]
-       |
-       $ (pulldown_ohm)
-       |
-      --- (ground)
-
- 2. connect = NTC_CONNECTED_POSITIVE, pullup_ohm = 0 (not-connected)
-
-   [pullup_uV]
-       |
-      [TH]
-       |
-       +----------------------------[read_uV]
-       |
-       $ (pulldown_ohm)
-       |
-      --- (ground)
-
- 3. connect = NTC_CONNECTED_GROUND, pulldown_ohm > 0
-
-   [pullup_uV]
-       |
-       $ (pullup_ohm)
-       |
-       +----+-----------------------[read_uV]
-       |    |
-      [TH]  $ (pulldown_ohm)
-       |    |
-      -------- (ground)
-
- 4. connect = NTC_CONNECTED_GROUND, pulldown_ohm = 0 (not-connected)
-
-   [pullup_uV]
-       |
-       $ (pullup_ohm)
-       |
-       +----------------------------[read_uV]
-       |
-      [TH]
-       |
-      --- (ground)
+1. connect = NTC_CONNECTED_POSITIVE, pullup_ohm > 0::
+
+     [pullup_uV]
+	 |    |
+	[TH]  $ (pullup_ohm)
+	 |    |
+	 +----+-----------------------[read_uV]
+	 |
+	 $ (pulldown_ohm)
+	 |
+	-+- (ground)
+
+2. connect = NTC_CONNECTED_POSITIVE, pullup_ohm = 0 (not-connected)::
+
+     [pullup_uV]
+	 |
+	[TH]
+	 |
+	 +----------------------------[read_uV]
+	 |
+	 $ (pulldown_ohm)
+	 |
+	-+- (ground)
+
+3. connect = NTC_CONNECTED_GROUND, pulldown_ohm > 0::
+
+     [pullup_uV]
+	 |
+	 $ (pullup_ohm)
+	 |
+	 +----+-----------------------[read_uV]
+	 |    |
+	[TH]  $ (pulldown_ohm)
+	 |    |
+	-+----+- (ground)
+
+4. connect = NTC_CONNECTED_GROUND, pulldown_ohm = 0 (not-connected)::
+
+     [pullup_uV]
+	 |
+	 $ (pullup_ohm)
+	 |
+	 +----------------------------[read_uV]
+	 |
+	[TH]
+	 |
+	-+- (ground)
 
 When one of the four circuit models is used, read_uV, pullup_uV, pullup_ohm,
 pulldown_ohm, and connect should be provided. When none of the four models
@@ -88,13 +98,14 @@ provide read_ohm and _not_ provide the others.
 
 Sysfs Interface
 ---------------
-name		the mandatory global attribute, the thermistor name.
 
-temp1_type	always 4 (thermistor)
-		RO
+=============== == =============================================================
+name		   the mandatory global attribute, the thermistor name.
+=============== == =============================================================
+temp1_type	RO always 4 (thermistor)
 
-temp1_input	measure the temperature and provide the measured value.
-		(reading this file initiates the reading procedure.)
-		RO
+temp1_input	RO measure the temperature and provide the measured value.
+		   (reading this file initiates the reading procedure.)
+=============== == =============================================================
 
 Note that each NTC thermistor has only _one_ thermistor; thus, only temp1 exists.
diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
index e787596e03fe..bf41c162d70e 100644
--- a/Documentation/hwmon/occ
+++ b/Documentation/hwmon/occ
@@ -2,6 +2,7 @@ Kernel driver occ-hwmon
 =======================
 
 Supported chips:
+
   * POWER8
   * POWER9
 
@@ -37,53 +38,87 @@ Some entries are only present with certain OCC sensor versions or only on
 certain OCCs in the system. The version number is not exported to the user
 but can be inferred.
 
-temp[1-n]_label		OCC sensor ID.
+temp[1-n]_label
+	OCC sensor ID.
+
 [with temperature sensor version 1]
-    temp[1-n]_input	Measured temperature of the component in millidegrees
+
+    temp[1-n]_input
+			Measured temperature of the component in millidegrees
 			Celsius.
+
 [with temperature sensor version >= 2]
-    temp[1-n]_type		The FRU (Field Replaceable Unit) type
+
+    temp[1-n]_type
+				The FRU (Field Replaceable Unit) type
 				(represented by an integer) for the component
 				that this sensor measures.
-    temp[1-n]_fault		Temperature sensor fault boolean; 1 to indicate
+    temp[1-n]_fault
+				Temperature sensor fault boolean; 1 to indicate
 				that a fault is present or 0 to indicate that
 				no fault is present.
+
     [with type == 3 (FRU type is VRM)]
-        temp[1-n]_alarm		VRM temperature alarm boolean; 1 to indicate
+
+	temp[1-n]_alarm
+				VRM temperature alarm boolean; 1 to indicate
 				alarm, 0 to indicate no alarm
+
     [else]
-        temp[1-n]_input		Measured temperature of the component in
+
+	temp[1-n]_input
+				Measured temperature of the component in
 				millidegrees Celsius.
 
-freq[1-n]_label		OCC sensor ID.
-freq[1-n]_input		Measured frequency of the component in MHz.
-
-power[1-n]_input	Latest measured power reading of the component in
+freq[1-n]_label
+			OCC sensor ID.
+freq[1-n]_input
+			Measured frequency of the component in MHz.
+power[1-n]_input
+			Latest measured power reading of the component in
 			microwatts.
-power[1-n]_average	Average power of the component in microwatts.
-power[1-n]_average_interval	The amount of time over which the power average
+power[1-n]_average
+			Average power of the component in microwatts.
+power[1-n]_average_interval
+				The amount of time over which the power average
 				was taken in microseconds.
+
 [with power sensor version < 2]
-    power[1-n]_label	OCC sensor ID.
+
+    power[1-n]_label
+			OCC sensor ID.
+
 [with power sensor version >= 2]
-    power[1-n]_label	OCC sensor ID + function ID + channel in the form
+
+    power[1-n]_label
+			OCC sensor ID + function ID + channel in the form
 			of a string, delimited by underscores, i.e. "0_15_1".
 			Both the function ID and channel are integers that
 			further identify the power sensor.
+
 [with power sensor version 0xa0]
-    power[1-n]_label	OCC sensor ID + sensor type in the form of a string,
+
+    power[1-n]_label
+			OCC sensor ID + sensor type in the form of a string,
 			delimited by an underscore, i.e. "0_system". Sensor
 			type will be one of "system", "proc", "vdd" or "vdn".
 			For this sensor version, OCC sensor ID will be the same
 			for all power sensors.
+
 [present only on "master" OCC; represents the whole system power; only one of
- this type of power sensor will be present]
-    power[1-n]_label		"system"
-    power[1-n]_input		Latest system output power in microwatts.
-    power[1-n]_cap		Current system power cap in microwatts.
-    power[1-n]_cap_not_redundant	System power cap in microwatts when
-					there is not redundant power.
-    power[1-n]_cap_max		Maximum power cap that the OCC can enforce in
+this type of power sensor will be present]
+
+    power[1-n]_label
+				"system"
+    power[1-n]_input
+				Latest system output power in microwatts.
+    power[1-n]_cap
+				Current system power cap in microwatts.
+    power[1-n]_cap_not_redundant
+				System power cap in microwatts when
+				there is not redundant power.
+    power[1-n]_cap_max
+				Maximum power cap that the OCC can enforce in
 				microwatts.
     power[1-n]_cap_min		Minimum power cap that the OCC can enforce in
 				microwatts.
@@ -94,8 +129,11 @@ power[1-n]_average_interval	The amount of time over which the power average
 				ignored, i.e. requesting a power cap of
 				500900000 microwatts will result in a power cap
 				request of 500 watts.
+
     [with caps sensor version > 1]
-        power[1-n]_cap_user_source	Indicates how the user power cap was
+
+	power[1-n]_cap_user_source
+					Indicates how the user power cap was
 					set. This is an integer that maps to
 					system or firmware components that can
 					set the user power cap.
@@ -104,9 +142,12 @@ The following "extn" sensors are exported as a way for the OCC to provide data
 that doesn't fit anywhere else. The meaning of these sensors is entirely
 dependent on their data, and cannot be statically defined.
 
-extn[1-n]_label		ASCII ID or OCC sensor ID.
-extn[1-n]_flags		This is one byte hexadecimal value. Bit 7 indicates the
+extn[1-n]_label
+			ASCII ID or OCC sensor ID.
+extn[1-n]_flags
+			This is one byte hexadecimal value. Bit 7 indicates the
 			type of the label attribute; 1 for sensor ID, 0 for
 			ASCII ID. Other bits are reserved.
-extn[1-n]_input		6 bytes of hexadecimal data, with a meaning defined by
+extn[1-n]_input
+			6 bytes of hexadecimal data, with a meaning defined by
 			the sensor ID.
diff --git a/Documentation/hwmon/pc87427 b/Documentation/hwmon/pc87427
index c313eb66e08a..22d8f62d851f 100644
--- a/Documentation/hwmon/pc87427
+++ b/Documentation/hwmon/pc87427
@@ -2,9 +2,13 @@ Kernel driver pc87427
 =====================
 
 Supported chips:
+
   * National Semiconductor PC87427
+
     Prefix: 'pc87427'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: No longer available
 
 Author: Jean Delvare <jdelvare@suse.de>
diff --git a/Documentation/hwmon/pcf8591 b/Documentation/hwmon/pcf8591
index 447c0702c0ec..e98bd542a441 100644
--- a/Documentation/hwmon/pcf8591
+++ b/Documentation/hwmon/pcf8591
@@ -2,16 +2,21 @@ Kernel driver pcf8591
 =====================
 
 Supported chips:
+
   * Philips/NXP PCF8591
+
     Prefix: 'pcf8591'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the NXP website
-               http://www.nxp.com/pip/PCF8591_6.html
+
+	       http://www.nxp.com/pip/PCF8591_6.html
 
 Authors:
-        Aurelien Jarno <aurelien@aurel32.net>
-        valuable contributions by Jan M. Sendler <sendler@sendler.de>,
-        Jean Delvare <jdelvare@suse.de>
+      - Aurelien Jarno <aurelien@aurel32.net>
+      - valuable contributions by Jan M. Sendler <sendler@sendler.de>,
+      - Jean Delvare <jdelvare@suse.de>
 
 
 Description
@@ -22,24 +27,25 @@ analog output) for the I2C bus produced by Philips Semiconductors (now NXP).
 It is designed to provide a byte I2C interface to up to 4 separate devices.
 
 The PCF8591 has 4 analog inputs programmable as single-ended or
-differential inputs :
+differential inputs:
+
 - mode 0 : four single ended inputs
-        Pins AIN0 to AIN3 are single ended inputs for channels 0 to 3
+	Pins AIN0 to AIN3 are single ended inputs for channels 0 to 3
 
 - mode 1 : three differential inputs
-        Pins AIN3 is the common negative differential input
-        Pins AIN0 to AIN2 are positive differential inputs for channels 0 to 2
+	Pins AIN3 is the common negative differential input
+	Pins AIN0 to AIN2 are positive differential inputs for channels 0 to 2
 
 - mode 2 : single ended and differential mixed
-        Pins AIN0 and AIN1 are single ended inputs for channels 0 and 1
-        Pins AIN2 is the positive differential input for channel 3
-        Pins AIN3 is the negative differential input for channel 3
+	Pins AIN0 and AIN1 are single ended inputs for channels 0 and 1
+	Pins AIN2 is the positive differential input for channel 3
+	Pins AIN3 is the negative differential input for channel 3
 
 - mode 3 : two differential inputs
-        Pins AIN0 is the positive differential input for channel 0
-        Pins AIN1 is the negative differential input for channel 0
-        Pins AIN2 is the positive differential input for channel 1
-        Pins AIN3 is the negative differential input for channel 1
+	Pins AIN0 is the positive differential input for channel 0
+	Pins AIN1 is the negative differential input for channel 0
+	Pins AIN2 is the positive differential input for channel 1
+	Pins AIN3 is the negative differential input for channel 1
 
 See the datasheet for details.
 
@@ -49,10 +55,11 @@ Module parameters
 * input_mode int
 
     Analog input mode:
-         0 = four single ended inputs
-         1 = three differential inputs
-         2 = single ended and differential mixed
-         3 = two differential inputs
+
+	 - 0 = four single ended inputs
+	 - 1 = three differential inputs
+	 - 2 = single ended and differential mixed
+	 - 3 = two differential inputs
 
 
 Accessing PCF8591 via /sys interface
@@ -67,11 +74,12 @@ for details.
 Directories are being created for each instantiated PCF8591:
 
 /sys/bus/i2c/devices/<0>-<1>/
-where <0> is the bus the chip is connected to (e. g. i2c-0)
-and <1> the chip address ([48..4f])
+   where <0> is the bus the chip is connected to (e. g. i2c-0)
+   and <1> the chip address ([48..4f])
 
 Inside these directories, there are such files:
-in0_input, in1_input, in2_input, in3_input, out0_enable, out0_output, name
+
+   in0_input, in1_input, in2_input, in3_input, out0_enable, out0_output, name
 
 Name contains chip name.
 
diff --git a/Documentation/hwmon/powr1220 b/Documentation/hwmon/powr1220
index 21e44f71ae6e..a7fc258da0a8 100644
--- a/Documentation/hwmon/powr1220
+++ b/Documentation/hwmon/powr1220
@@ -1,12 +1,17 @@
 Kernel driver powr1220
-==================
+======================
 
 Supported chips:
+
   * Lattice POWR1220AT8
+
     Prefix: 'powr1220'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Lattice website
-               http://www.latticesemi.com/
+
+	       http://www.latticesemi.com/
 
 Author: Scott Kanowitz <scott.kanowitz@gmail.com>
 
@@ -26,7 +31,9 @@ value over the low measurement range maximum of 2 V.
 
 The input naming convention is as follows:
 
+============== ========
 driver name    pin name
+============== ========
 in0            VMON1
 in1            VMON2
 in2            VMON3
@@ -41,5 +48,6 @@ in10           VMON11
 in11           VMON12
 in12           VCCA
 in13           VCCINP
+============== ========
 
 The ADC readings are updated on request with a minimum period of 1s.
diff --git a/Documentation/hwmon/raspberrypi-hwmon b/Documentation/hwmon/raspberrypi-hwmon
index 3c92e2cb52d6..8038ade36490 100644
--- a/Documentation/hwmon/raspberrypi-hwmon
+++ b/Documentation/hwmon/raspberrypi-hwmon
@@ -2,6 +2,7 @@ Kernel driver raspberrypi-hwmon
 ===============================
 
 Supported boards:
+
   * Raspberry Pi A+ (via GPIO on SoC)
   * Raspberry Pi B+ (via GPIO on SoC)
   * Raspberry Pi 2 B (via GPIO on SoC)
@@ -19,4 +20,6 @@ undervoltage conditions.
 Sysfs entries
 -------------
 
+======================= ==================
 in0_lcrit_alarm		Undervoltage alarm
+======================= ==================
diff --git a/Documentation/hwmon/sch5636 b/Documentation/hwmon/sch5636
index 7b0a01da0717..4aaee3672f13 100644
--- a/Documentation/hwmon/sch5636
+++ b/Documentation/hwmon/sch5636
@@ -2,8 +2,11 @@ Kernel driver sch5636
 =====================
 
 Supported chips:
+
   * SMSC SCH5636
+
     Prefix: 'sch5636'
+
     Addresses scanned: none, address read from Super I/O config space
 
 Author: Hans de Goede <hdegoede@redhat.com>
diff --git a/Documentation/hwmon/scpi-hwmon b/Documentation/hwmon/scpi-hwmon
index 4cfcdf2d5eab..eee7022b44db 100644
--- a/Documentation/hwmon/scpi-hwmon
+++ b/Documentation/hwmon/scpi-hwmon
@@ -2,8 +2,11 @@ Kernel driver scpi-hwmon
 ========================
 
 Supported chips:
+
  * Chips based on ARM System Control Processor Interface
+
    Addresses scanned: -
+
    Datasheet: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/index.html
 
 Author: Punit Agrawal <punit.agrawal@arm.com>
@@ -14,7 +17,7 @@ Description
 This driver supports hardware monitoring for SoC's based on the ARM
 System Control Processor (SCP) implementing the System Control
 Processor Interface (SCPI). The following sensor types are supported
-by the SCP -
+by the SCP:
 
   * temperature
   * voltage
@@ -30,4 +33,4 @@ Usage Notes
 The driver relies on device tree node to indicate the presence of SCPI
 support in the kernel. See
 Documentation/devicetree/bindings/arm/arm,scpi.txt for details of the
-devicetree node.
\ No newline at end of file
+devicetree node.
diff --git a/Documentation/hwmon/sht15 b/Documentation/hwmon/sht15
index 5e3207c3b177..485abe037f6c 100644
--- a/Documentation/hwmon/sht15
+++ b/Documentation/hwmon/sht15
@@ -2,29 +2,37 @@ Kernel driver sht15
 ===================
 
 Authors:
+
   * Wouter Horre
   * Jonathan Cameron
   * Vivien Didelot <vivien.didelot@savoirfairelinux.com>
   * Jerome Oufella <jerome.oufella@savoirfairelinux.com>
 
 Supported chips:
+
   * Sensirion SHT10
+
     Prefix: 'sht10'
 
   * Sensirion SHT11
+
     Prefix: 'sht11'
 
   * Sensirion SHT15
+
     Prefix: 'sht15'
 
   * Sensirion SHT71
+
     Prefix: 'sht71'
 
   * Sensirion SHT75
+
     Prefix: 'sht75'
 
 Datasheet: Publicly available at the Sensirion website
-http://www.sensirion.ch/en/pdf/product_information/Datasheet-humidity-sensor-SHT1x.pdf
+
+	http://www.sensirion.ch/en/pdf/product_information/Datasheet-humidity-sensor-SHT1x.pdf
 
 Description
 -----------
@@ -63,11 +71,13 @@ Platform data
 Sysfs interface
 ---------------
 
-* temp1_input:     temperature input
-* humidity1_input: humidity input
-* heater_enable:   write 1 in this attribute to enable the on-chip heater,
-                   0 to disable it. Be careful not to enable the heater
-                   for too long.
-* temp1_fault:     if 1, this means that the voltage is low (below 2.47V) and
-                   measurement may be invalid.
-* humidity1_fault: same as temp1_fault.
+================== ==========================================================
+temp1_input        temperature input
+humidity1_input    humidity input
+heater_enable      write 1 in this attribute to enable the on-chip heater,
+		   0 to disable it. Be careful not to enable the heater
+		   for too long.
+temp1_fault        if 1, this means that the voltage is low (below 2.47V) and
+		   measurement may be invalid.
+humidity1_fault    same as temp1_fault.
+================== ==========================================================
diff --git a/Documentation/hwmon/sht21 b/Documentation/hwmon/sht21
index 8b3cdda541c1..f1f5da030108 100644
--- a/Documentation/hwmon/sht21
+++ b/Documentation/hwmon/sht21
@@ -2,19 +2,33 @@ Kernel driver sht21
 ===================
 
 Supported chips:
+
   * Sensirion SHT21
+
     Prefix: 'sht21'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Sensirion website
+
     http://www.sensirion.com/file/datasheet_sht21
 
+
+
   * Sensirion SHT25
+
     Prefix: 'sht25'
+
     Addresses scanned: none
+
     Datasheet: Publicly available at the Sensirion website
+
     http://www.sensirion.com/file/datasheet_sht25
 
+
+
 Author:
+
   Urs Fleisch <urs.fleisch@sensirion.com>
 
 Description
@@ -33,9 +47,13 @@ in the board setup code.
 sysfs-Interface
 ---------------
 
-temp1_input - temperature input
-humidity1_input - humidity input
-eic - Electronic Identification Code
+temp1_input
+	- temperature input
+
+humidity1_input
+	- humidity input
+eic
+	- Electronic Identification Code
 
 Notes
 -----
diff --git a/Documentation/hwmon/sht3x b/Documentation/hwmon/sht3x
index d9daa6ab1e8e..978a7117e4b2 100644
--- a/Documentation/hwmon/sht3x
+++ b/Documentation/hwmon/sht3x
@@ -2,14 +2,19 @@ Kernel driver sht3x
 ===================
 
 Supported chips:
+
   * Sensirion SHT3x-DIS
+
     Prefix: 'sht3x'
+
     Addresses scanned: none
+
     Datasheet: https://www.sensirion.com/file/datasheet_sht3x_digital
 
 Author:
-  David Frey <david.frey@sensirion.com>
-  Pascal Sachs <pascal.sachs@sensirion.com>
+
+  - David Frey <david.frey@sensirion.com>
+  - Pascal Sachs <pascal.sachs@sensirion.com>
 
 Description
 -----------
@@ -24,6 +29,7 @@ addresses 0x44 or 0x45, depending on the wiring. See
 Documentation/i2c/instantiating-devices for methods to instantiate the device.
 
 There are two options configurable by means of sht3x_platform_data:
+
 1. blocking (pull the I2C clock line down while performing the measurement) or
    non-blocking mode. Blocking mode will guarantee the fastest result but
    the I2C bus will be busy during that time. By default, non-blocking mode
@@ -35,12 +41,15 @@ There are two options configurable by means of sht3x_platform_data:
 The sht3x sensor supports a single shot mode as well as 5 periodic measure
 modes, which can be controlled with the update_interval sysfs interface.
 The allowed update_interval in milliseconds are as follows:
-  *     0   single shot mode
-  *  2000   0.5 Hz periodic measurement
-  *  1000   1   Hz periodic measurement
-  *   500   2   Hz periodic measurement
-  *   250   4   Hz periodic measurement
-  *   100  10   Hz periodic measurement
+
+    ===== ======= ====================
+       0          single shot mode
+    2000   0.5 Hz periodic measurement
+    1000   1   Hz periodic measurement
+     500   2   Hz periodic measurement
+     250   4   Hz periodic measurement
+     100  10   Hz periodic measurement
+    ===== ======= ====================
 
 In the periodic measure mode, the sensor automatically triggers a measurement
 with the configured update interval on the chip. When a temperature or humidity
@@ -53,6 +62,7 @@ low.
 sysfs-Interface
 ---------------
 
+=================== ============================================================
 temp1_input:        temperature input
 humidity1_input:    humidity input
 temp1_max:          temperature max value
@@ -64,13 +74,15 @@ temp1_min_hyst:     temperature hysteresis value for min limit
 humidity1_min:      humidity min value
 humidity1_min_hyst: humidity hysteresis value for min limit
 temp1_alarm:        alarm flag is set to 1 if the temperature is outside the
-                    configured limits. Alarm only works in periodic measure mode
+		    configured limits. Alarm only works in periodic measure mode
 humidity1_alarm:    alarm flag is set to 1 if the humidity is outside the
-                    configured limits. Alarm only works in periodic measure mode
+		    configured limits. Alarm only works in periodic measure mode
 heater_enable:      heater enable, heating element removes excess humidity from
-                    sensor
-                        0: turned off
-                        1: turned on
+		    sensor:
+
+			- 0: turned off
+			- 1: turned on
 update_interval:    update interval, 0 for single shot, interval in msec
-                    for periodic measurement. If the interval is not supported
-                    by the sensor, the next faster interval is chosen
+		    for periodic measurement. If the interval is not supported
+		    by the sensor, the next faster interval is chosen
+=================== ============================================================
diff --git a/Documentation/hwmon/shtc1 b/Documentation/hwmon/shtc1
index 6b1e05458f0f..aa116332ba26 100644
--- a/Documentation/hwmon/shtc1
+++ b/Documentation/hwmon/shtc1
@@ -2,17 +2,29 @@ Kernel driver shtc1
 ===================
 
 Supported chips:
+
   * Sensirion SHTC1
+
     Prefix: 'shtc1'
+
     Addresses scanned: none
+
     Datasheet: http://www.sensirion.com/file/datasheet_shtc1
 
+
+
   * Sensirion SHTW1
+
     Prefix: 'shtw1'
+
     Addresses scanned: none
+
     Datasheet: Not publicly available
 
+
+
 Author:
+
   Johannes Winkelmann <johannes.winkelmann@sensirion.com>
 
 Description
@@ -28,6 +40,7 @@ address 0x70. See Documentation/i2c/instantiating-devices for methods to
 instantiate the device.
 
 There are two options configurable by means of shtc1_platform_data:
+
 1. blocking (pull the I2C clock line down while performing the measurement) or
    non-blocking mode. Blocking mode will guarantee the fastest result but
    the I2C bus will be busy during that time. By default, non-blocking mode
@@ -39,5 +52,7 @@ There are two options configurable by means of shtc1_platform_data:
 sysfs-Interface
 ---------------
 
-temp1_input - temperature input
-humidity1_input - humidity input
+temp1_input
+	- temperature input
+humidity1_input
+	- humidity input
diff --git a/Documentation/hwmon/sis5595 b/Documentation/hwmon/sis5595
index 4f8877a34f37..5acba6b0c0db 100644
--- a/Documentation/hwmon/sis5595
+++ b/Documentation/hwmon/sis5595
@@ -2,49 +2,67 @@ Kernel driver sis5595
 =====================
 
 Supported chips:
+
   * Silicon Integrated Systems Corp. SiS5595 Southbridge Hardware Monitor
+
     Prefix: 'sis5595'
+
     Addresses scanned: ISA in PCI-space encoded address
+
     Datasheet: Publicly available at the Silicon Integrated Systems Corp. site.
 
+
+
 Authors:
-        Kyösti Mälkki <kmalkki@cc.hut.fi>,
-        Mark D. Studebaker <mdsxyz123@yahoo.com>,
-        Aurelien Jarno <aurelien@aurel32.net> 2.6 port
+
+      - Kyösti Mälkki <kmalkki@cc.hut.fi>,
+      - Mark D. Studebaker <mdsxyz123@yahoo.com>,
+      - Aurelien Jarno <aurelien@aurel32.net> 2.6 port
 
    SiS southbridge has a LM78-like chip integrated on the same IC.
    This driver is a customized copy of lm78.c
 
    Supports following revisions:
+
+       =============== =============== ==============
        Version         PCI ID          PCI Revision
+       =============== =============== ==============
        1               1039/0008       AF or less
        2               1039/0008       B0 or greater
+       =============== =============== ==============
 
    Note: these chips contain a 0008 device which is incompatible with the
-        5595. We recognize these by the presence of the listed
-        "blacklist" PCI ID and refuse to load.
+	5595. We recognize these by the presence of the listed
+	"blacklist" PCI ID and refuse to load.
 
+   =================== =============== ================
    NOT SUPPORTED       PCI ID          BLACKLIST PCI ID
-        540            0008            0540
-        550            0008            0550
+   =================== =============== ================
+	540            0008            0540
+	550            0008            0550
        5513            0008            5511
        5581            0008            5597
        5582            0008            5597
        5597            0008            5597
-        630            0008            0630
-        645            0008            0645
-        730            0008            0730
-        735            0008            0735
+	630            0008            0630
+	645            0008            0645
+	730            0008            0730
+	735            0008            0735
+   =================== =============== ================
 
 
 Module Parameters
 -----------------
+
+======================= =====================================================
 force_addr=0xaddr	Set the I/O base address. Useful for boards
 			that don't set the address in the BIOS. Does not do a
 			PCI force; the device must still be present in lspci.
 			Don't use this unless the driver complains that the
 			base address is not set.
+
 			Example: 'modprobe sis5595 force_addr=0x290'
+======================= =====================================================
 
 
 Description
diff --git a/Documentation/hwmon/smsc47b397 b/Documentation/hwmon/smsc47b397
index 3a43b6948924..600194cf1804 100644
--- a/Documentation/hwmon/smsc47b397
+++ b/Documentation/hwmon/smsc47b397
@@ -2,29 +2,38 @@ Kernel driver smsc47b397
 ========================
 
 Supported chips:
+
   * SMSC LPC47B397-NC
+
   * SMSC SCH5307-NS
+
   * SMSC SCH5317
+
     Prefix: 'smsc47b397'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: In this file
 
-Authors: Mark M. Hoffman <mhoffman@lightlink.com>
-         Utilitek Systems, Inc.
+Authors:
+
+       - Mark M. Hoffman <mhoffman@lightlink.com>
+       - Utilitek Systems, Inc.
 
 November 23, 2004
 
-The following specification describes the SMSC LPC47B397-NC[1] sensor chip
+The following specification describes the SMSC LPC47B397-NC [1]_ sensor chip
 (for which there is no public datasheet available). This document was
 provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
 by Mark M. Hoffman <mhoffman@lightlink.com>.
 
-[1] And SMSC SCH5307-NS and SCH5317, which have different device IDs but are
-otherwise compatible.
+.. [1] And SMSC SCH5307-NS and SCH5317, which have different device IDs but are
+       otherwise compatible.
 
-* * * * *
+-------------------------------------------------------------------------
 
-Methods for detecting the HP SIO and reading the thermal data on a dc7100.
+Methods for detecting the HP SIO and reading the thermal data on a dc7100
+-------------------------------------------------------------------------
 
 The thermal information on the dc7100 is contained in the SIO Hardware Monitor
 (HWM). The information is accessed through an index/data pair. The index/data
@@ -35,18 +44,22 @@ and 0x61 (LSB). Currently we are using 0x480 for the HWM Base Address and
 
 Reading temperature information.
 The temperature information is located in the following registers:
+
+=============== ======= =======================================================
 Temp1		0x25	(Currently, this reflects the CPU temp on all systems).
 Temp2		0x26
 Temp3		0x27
 Temp4		0x80
+=============== ======= =======================================================
 
 Programming Example
-The following is an example of how to read the HWM temperature registers:
-MOV	DX,480H
-MOV	AX,25H
-OUT	DX,AL
-MOV	DX,481H
-IN	AL,DX
+The following is an example of how to read the HWM temperature registers::
+
+	MOV	DX,480H
+	MOV	AX,25H
+	OUT	DX,AL
+	MOV	DX,481H
+	IN	AL,DX
 
 AL contains the data in hex, the temperature in Celsius is the decimal
 equivalent.
@@ -55,25 +68,32 @@ Ex: If AL contains 0x2A, the temperature is 42 degrees C.
 
 Reading tach information.
 The fan speed information is located in the following registers:
+
+=============== ======= ======= =================================
 		LSB	MSB
 Tach1		0x28	0x29	(Currently, this reflects the CPU
 				fan speed on all systems).
 Tach2		0x2A	0x2B
 Tach3		0x2C	0x2D
 Tach4		0x2E	0x2F
+=============== ======= ======= =================================
 
-Important!!!
-Reading the tach LSB locks the tach MSB.
-The LSB Must be read first.
+.. Important::
+
+	Reading the tach LSB locks the tach MSB.
+	The LSB Must be read first.
+
+How to convert the tach reading to RPM
+--------------------------------------
 
-How to convert the tach reading to RPM.
 The tach reading (TCount) is given by: (Tach MSB * 256) + (Tach LSB)
 The SIO counts the number of 90kHz (11.111us) pulses per revolution.
 RPM = 60/(TCount * 11.111us)
 
-Example:
-Reg 0x28 = 0x9B
-Reg 0x29 = 0x08
+Example::
+
+	Reg 0x28 = 0x9B
+	Reg 0x29 = 0x08
 
 TCount = 0x89B = 2203
 
@@ -81,21 +101,28 @@ RPM = 60 / (2203 * 11.11111 E-6) = 2451 RPM
 
 Obtaining the SIO version.
 
-CONFIGURATION SEQUENCE
+Configuration Sequence
+----------------------
+
 To program the configuration registers, the following sequence must be followed:
 1. Enter Configuration Mode
 2. Configure the Configuration Registers
 3. Exit Configuration Mode.
 
 Enter Configuration Mode
+^^^^^^^^^^^^^^^^^^^^^^^^
+
 To place the chip into the Configuration State The config key (0x55) is written
 to the CONFIG PORT (0x2E).
 
 Configuration Mode
+^^^^^^^^^^^^^^^^^^
+
 In configuration mode, the INDEX PORT is located at the CONFIG PORT address and
 the DATA PORT is at INDEX PORT address + 1.
 
 The desired configuration registers are accessed in two steps:
+
 a.	Write the index of the Logical Device Number Configuration Register
 	(i.e., 0x07) to the INDEX PORT and then write the number of the
 	desired logical device to the DATA PORT.
@@ -104,30 +131,35 @@ b.	Write the address of the desired configuration register within the
 	logical device to the INDEX PORT and then write or read the config-
 	uration register through the DATA PORT.
 
-Note: If accessing the Global Configuration Registers, step (a) is not required.
+Note:
+	If accessing the Global Configuration Registers, step (a) is not required.
 
 Exit Configuration Mode
+^^^^^^^^^^^^^^^^^^^^^^^
+
 To exit the Configuration State the write 0xAA to the CONFIG PORT (0x2E).
 The chip returns to the RUN State.  (This is important).
 
 Programming Example
-The following is an example of how to read the SIO Device ID located at 0x20
+^^^^^^^^^^^^^^^^^^^
 
-; ENTER CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,055H
-OUT	DX,AL
-; GLOBAL CONFIGURATION  REGISTER
-MOV	DX,02EH
-MOV	AL,20H
-OUT	DX,AL
-; READ THE DATA
-MOV	DX,02FH
-IN	AL,DX
-; EXIT CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,0AAH
-OUT	DX,AL
+The following is an example of how to read the SIO Device ID located at 0x20:
+
+	; ENTER CONFIGURATION MODE
+	MOV	DX,02EH
+	MOV	AX,055H
+	OUT	DX,AL
+	; GLOBAL CONFIGURATION  REGISTER
+	MOV	DX,02EH
+	MOV	AL,20H
+	OUT	DX,AL
+	; READ THE DATA
+	MOV	DX,02FH
+	IN	AL,DX
+	; EXIT CONFIGURATION MODE
+	MOV	DX,02EH
+	MOV	AX,0AAH
+	OUT	DX,AL
 
 The registers of interest for identifying the SIO on the dc7100 are Device ID
 (0x20) and Device Rev  (0x21).
@@ -135,29 +167,31 @@ The registers of interest for identifying the SIO on the dc7100 are Device ID
 The Device ID will read 0x6F (0x81 for SCH5307-NS, and 0x85 for SCH5317)
 The Device Rev currently reads 0x01
 
-Obtaining the HWM Base Address.
+Obtaining the HWM Base Address
+------------------------------
+
 The following is an example of how to read the HWM Base Address located in
-Logical Device 8.
+Logical Device 8::
 
-; ENTER CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,055H
-OUT	DX,AL
-; CONFIGURE REGISTER CRE0,
-; LOGICAL DEVICE 8
-MOV	DX,02EH
-MOV	AL,07H
-OUT	DX,AL ;Point to LD# Config Reg
-MOV	DX,02FH
-MOV	AL, 08H
-OUT	DX,AL;Point to Logical Device 8
-;
-MOV	DX,02EH
-MOV	AL,60H
-OUT	DX,AL	; Point to HWM Base Addr MSB
-MOV	DX,02FH
-IN	AL,DX	; Get MSB of HWM Base Addr
-; EXIT CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,0AAH
-OUT	DX,AL
+	; ENTER CONFIGURATION MODE
+	MOV	DX,02EH
+	MOV	AX,055H
+	OUT	DX,AL
+	; CONFIGURE REGISTER CRE0,
+	; LOGICAL DEVICE 8
+	MOV	DX,02EH
+	MOV	AL,07H
+	OUT	DX,AL ;Point to LD# Config Reg
+	MOV	DX,02FH
+	MOV	AL, 08H
+	OUT	DX,AL;Point to Logical Device 8
+	;
+	MOV	DX,02EH
+	MOV	AL,60H
+	OUT	DX,AL	; Point to HWM Base Addr MSB
+	MOV	DX,02FH
+	IN	AL,DX	; Get MSB of HWM Base Addr
+	; EXIT CONFIGURATION MODE
+	MOV	DX,02EH
+	MOV	AX,0AAH
+	OUT	DX,AL
diff --git a/Documentation/hwmon/smsc47m1 b/Documentation/hwmon/smsc47m1
index 10a24b420686..c54eabd5eb57 100644
--- a/Documentation/hwmon/smsc47m1
+++ b/Documentation/hwmon/smsc47m1
@@ -2,30 +2,53 @@ Kernel driver smsc47m1
 ======================
 
 Supported chips:
+
   * SMSC LPC47B27x, LPC47M112, LPC47M10x, LPC47M13x, LPC47M14x,
+
     LPC47M15x and LPC47M192
+
     Addresses scanned: none, address read from Super I/O config space
+
     Prefix: 'smsc47m1'
+
     Datasheets:
-        http://www.smsc.com/media/Downloads_Public/Data_Sheets/47b272.pdf
-        http://www.smsc.com/media/Downloads_Public/Data_Sheets/47m10x.pdf
-        http://www.smsc.com/media/Downloads_Public/Data_Sheets/47m112.pdf
-        http://www.smsc.com/
+
+	http://www.smsc.com/media/Downloads_Public/Data_Sheets/47b272.pdf
+
+	http://www.smsc.com/media/Downloads_Public/Data_Sheets/47m10x.pdf
+
+	http://www.smsc.com/media/Downloads_Public/Data_Sheets/47m112.pdf
+
+	http://www.smsc.com/
+
   * SMSC LPC47M292
+
     Addresses scanned: none, address read from Super I/O config space
+
     Prefix: 'smsc47m2'
+
     Datasheet: Not public
+
   * SMSC LPC47M997
+
     Addresses scanned: none, address read from Super I/O config space
+
     Prefix: 'smsc47m1'
+
     Datasheet: none
 
+
+
 Authors:
-        Mark D. Studebaker <mdsxyz123@yahoo.com>,
-        With assistance from Bruce Allen <ballen@uwm.edu>, and his
-        fan.c program: http://www.lsc-group.phys.uwm.edu/%7Eballen/driver/
-        Gabriele Gorla <gorlik@yahoo.com>,
-        Jean Delvare <jdelvare@suse.de>
+
+     - Mark D. Studebaker <mdsxyz123@yahoo.com>,
+     - With assistance from Bruce Allen <ballen@uwm.edu>, and his
+       fan.c program:
+
+       - http://www.lsc-group.phys.uwm.edu/%7Eballen/driver/
+
+     - Gabriele Gorla <gorlik@yahoo.com>,
+     - Jean Delvare <jdelvare@suse.de>
 
 Description
 -----------
@@ -57,7 +80,7 @@ hardware registers are read whenever any data is read (unless it is less
 than 1.5 seconds since the last update). This means that you can easily
 miss once-only alarms.
 
+------------------------------------------------------------------
 
-**********************
 The lm_sensors project gratefully acknowledges the support of
 Intel in the development of this driver.
diff --git a/Documentation/hwmon/smsc47m192 b/Documentation/hwmon/smsc47m192
index 6d54ecb7b3f8..a2e86ab67918 100644
--- a/Documentation/hwmon/smsc47m192
+++ b/Documentation/hwmon/smsc47m192
@@ -2,17 +2,28 @@ Kernel driver smsc47m192
 ========================
 
 Supported chips:
+
   * SMSC LPC47M192, LPC47M15x, LPC47M292 and LPC47M997
+
     Prefix: 'smsc47m192'
+
     Addresses scanned: I2C 0x2c - 0x2d
+
     Datasheet: The datasheet for LPC47M192 is publicly available from
-               http://www.smsc.com/
-               The LPC47M15x, LPC47M292 and LPC47M997 are compatible for
-               hardware monitoring.
 
-Author: Hartmut Rick <linux@rick.claranet.de>
-        Special thanks to Jean Delvare for careful checking
-        of the code and many helpful comments and suggestions.
+	       http://www.smsc.com/
+
+	       The LPC47M15x, LPC47M292 and LPC47M997 are compatible for
+
+	       hardware monitoring.
+
+
+
+Author:
+      - Hartmut Rick <linux@rick.claranet.de>
+
+      - Special thanks to Jean Delvare for careful checking
+	of the code and many helpful comments and suggestions.
 
 
 Description
@@ -52,52 +63,54 @@ Reading them more often repeats the same values.
 sysfs interface
 ---------------
 
-in0_input	- +2.5V voltage input
-in1_input	- CPU voltage input (nominal 2.25V)
-in2_input	- +3.3V voltage input
-in3_input	- +5V voltage input
-in4_input	- +12V voltage input (may be missing if used as VID4)
-in5_input	- Vcc voltage input (nominal 3.3V)
-		  This is the supply voltage of the sensor chip itself.
-in6_input	- +1.5V voltage input
-in7_input	- +1.8V voltage input
+===================== ==========================================================
+in0_input	      +2.5V voltage input
+in1_input	      CPU voltage input (nominal 2.25V)
+in2_input	      +3.3V voltage input
+in3_input	      +5V voltage input
+in4_input	      +12V voltage input (may be missing if used as VID4)
+in5_input	      Vcc voltage input (nominal 3.3V)
+		      This is the supply voltage of the sensor chip itself.
+in6_input	      +1.5V voltage input
+in7_input	      +1.8V voltage input
 
 in[0-7]_min,
-in[0-7]_max	- lower and upper alarm thresholds for in[0-7]_input reading
+in[0-7]_max	      lower and upper alarm thresholds for in[0-7]_input reading
 
-		  All voltages are read and written in mV.
+		      All voltages are read and written in mV.
 
-in[0-7]_alarm	- alarm flags for voltage inputs
-		  These files read '1' in case of alarm, '0' otherwise.
+in[0-7]_alarm	      alarm flags for voltage inputs
+		      These files read '1' in case of alarm, '0' otherwise.
 
-temp1_input	- chip temperature measured by on-chip diode
-temp[2-3]_input	- temperature measured by external diodes (one of these would
-		  typically be wired to the diode inside the CPU)
+temp1_input	      chip temperature measured by on-chip diode
+temp[2-3]_input	      temperature measured by external diodes (one of these
+		      would typically be wired to the diode inside the CPU)
 
 temp[1-3]_min,
-temp[1-3]_max	- lower and upper alarm thresholds for temperatures
+temp[1-3]_max	      lower and upper alarm thresholds for temperatures
 
-temp[1-3]_offset - temperature offset registers
-		  The chip adds the offsets stored in these registers to
-		  the corresponding temperature readings.
-		  Note that temp1 and temp2 offsets share the same register,
-		  they cannot both be different from zero at the same time.
-		  Writing a non-zero number to one of them will reset the other
-		  offset to zero.
+temp[1-3]_offset      temperature offset registers
+		      The chip adds the offsets stored in these registers to
+		      the corresponding temperature readings.
+		      Note that temp1 and temp2 offsets share the same register,
+		      they cannot both be different from zero at the same time.
+		      Writing a non-zero number to one of them will reset the other
+		      offset to zero.
 
-		  All temperatures and offsets are read and written in
-		  units of 0.001 degC.
+		      All temperatures and offsets are read and written in
+		      units of 0.001 degC.
 
-temp[1-3]_alarm - alarm flags for temperature inputs, '1' in case of alarm,
-		  '0' otherwise.
-temp[2-3]_input_fault - diode fault flags for temperature inputs 2 and 3.
-		  A fault is detected if the two pins for the corresponding
-		  sensor are open or shorted, or any of the two is shorted
-		  to ground or Vcc. '1' indicates a diode fault.
+temp[1-3]_alarm       alarm flags for temperature inputs, '1' in case of alarm,
+		      '0' otherwise.
+temp[2-3]_input_fault diode fault flags for temperature inputs 2 and 3.
+		      A fault is detected if the two pins for the corresponding
+		      sensor are open or shorted, or any of the two is shorted
+		      to ground or Vcc. '1' indicates a diode fault.
 
-cpu0_vid	- CPU voltage as received from the CPU
+cpu0_vid	      CPU voltage as received from the CPU
 
-vrm		- CPU VID standard used for decoding CPU voltage
+vrm		      CPU VID standard used for decoding CPU voltage
+===================== ==========================================================
 
-		  The *_min, *_max, *_offset and vrm files can be read and
-		  written, all others are read-only.
+The `*_min`, `*_max`, `*_offset` and `vrm` files can be read and written,
+all others are read-only.
diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/submitting-patches
index f88221b46153..12540b7d9b50 100644
--- a/Documentation/hwmon/submitting-patches
+++ b/Documentation/hwmon/submitting-patches
@@ -1,5 +1,5 @@
-	How to Get Your Patch Accepted Into the Hwmon Subsystem
-	-------------------------------------------------------
+How to Get Your Patch Accepted Into the Hwmon Subsystem
+=======================================================
 
 This text is a collection of suggestions for people writing patches or
 drivers for the hwmon subsystem. Following these suggestions will greatly
@@ -9,11 +9,12 @@ increase the chances of your change being accepted.
 1. General
 ----------
 
-* It should be unnecessary to mention, but please read and follow
-    Documentation/process/submit-checklist.rst
-    Documentation/process/submitting-drivers.rst
-    Documentation/process/submitting-patches.rst
-    Documentation/process/coding-style.rst
+* It should be unnecessary to mention, but please read and follow:
+
+    - Documentation/process/submit-checklist.rst
+    - Documentation/process/submitting-drivers.rst
+    - Documentation/process/submitting-patches.rst
+    - Documentation/process/coding-style.rst
 
 * Please run your patch through 'checkpatch --strict'. There should be no
   errors, no warnings, and few if any check messages. If there are any
diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 2b9e1005d88b..2aa9d9272966 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -1,5 +1,5 @@
 Naming and data format standards for sysfs files
-------------------------------------------------
+================================================
 
 The libsensors library offers an interface to the raw sensors data
 through the sysfs interface. Since lm-sensors 3.0.0, libsensors is
@@ -32,7 +32,7 @@ this reason, it is still not recommended to bypass the library.
 
 Each chip gets its own directory in the sysfs /sys/devices tree.  To
 find all sensor chips, it is easier to follow the device symlinks from
-/sys/class/hwmon/hwmon*.
+`/sys/class/hwmon/hwmon*`.
 
 Up to lm-sensors 3.0.0, libsensors looks for hardware monitoring attributes
 in the "physical" device directory. Since lm-sensors 3.0.1, attributes found
@@ -67,11 +67,13 @@ are interpreted as 0! For more on how written strings are interpreted see the
 
 -------------------------------------------------------------------------
 
-[0-*]	denotes any positive number starting from 0
-[1-*]	denotes any positive number starting from 1
+======= ===========================================
+`[0-*]`	denotes any positive number starting from 0
+`[1-*]`	denotes any positive number starting from 1
 RO	read only value
 WO	write only value
 RW	read/write value
+======= ===========================================
 
 Read/write values may be read-only for some chips, depending on the
 hardware implementation.
@@ -80,57 +82,82 @@ All entries (except name) are optional, and should only be created in a
 given driver if the chip has the feature.
 
 
-*********************
-* Global attributes *
-*********************
+*****************
+Global attributes
+*****************
 
-name		The chip name.
+`name`
+		The chip name.
 		This should be a short, lowercase string, not containing
 		whitespace, dashes, or the wildcard character '*'.
 		This attribute represents the chip name. It is the only
 		mandatory attribute.
 		I2C devices get this attribute created automatically.
+
 		RO
 
-update_interval	The interval at which the chip will update readings.
+`update_interval`
+		The interval at which the chip will update readings.
 		Unit: millisecond
+
 		RW
+
 		Some devices have a variable update rate or interval.
 		This attribute can be used to change it to the desired value.
 
 
-************
-* Voltages *
-************
+********
+Voltages
+********
+
+`in[0-*]_min`
+		Voltage min value.
 
-in[0-*]_min	Voltage min value.
 		Unit: millivolt
+
 		RW
-		
-in[0-*]_lcrit	Voltage critical min value.
+
+`in[0-*]_lcrit`
+		Voltage critical min value.
+
 		Unit: millivolt
+
 		RW
+
 		If voltage drops to or below this limit, the system may
 		take drastic action such as power down or reset. At the very
 		least, it should report a fault.
 
-in[0-*]_max	Voltage max value.
+`in[0-*]_max`
+		Voltage max value.
+
 		Unit: millivolt
+
 		RW
-		
-in[0-*]_crit	Voltage critical max value.
+
+`in[0-*]_crit`
+		Voltage critical max value.
+
 		Unit: millivolt
+
 		RW
+
 		If voltage reaches or exceeds this limit, the system may
 		take drastic action such as power down or reset. At the very
 		least, it should report a fault.
 
-in[0-*]_input	Voltage input value.
+`in[0-*]_input`
+		Voltage input value.
+
 		Unit: millivolt
+
 		RO
+
 		Voltage measured on the chip pin.
+
 		Actual voltage depends on the scaling resistors on the
 		motherboard, as recommended in the chip datasheet.
+
 		This varies by chip and by motherboard.
 		Because of this variation, values are generally NOT scaled
 		by the chip driver, and must be done by the application.
@@ -140,166 +167,232 @@ in[0-*]_input	Voltage input value.
 		thumb: drivers should report the voltage values at the
 		"pins" of the chip.
 
-in[0-*]_average
+`in[0-*]_average`
 		Average voltage
+
 		Unit: millivolt
+
 		RO
 
-in[0-*]_lowest
+`in[0-*]_lowest`
 		Historical minimum voltage
+
 		Unit: millivolt
+
 		RO
 
-in[0-*]_highest
+`in[0-*]_highest`
 		Historical maximum voltage
+
 		Unit: millivolt
+
 		RO
 
-in[0-*]_reset_history
+`in[0-*]_reset_history`
 		Reset inX_lowest and inX_highest
+
 		WO
 
-in_reset_history
+`in_reset_history`
 		Reset inX_lowest and inX_highest for all sensors
+
 		WO
 
-in[0-*]_label	Suggested voltage channel label.
+`in[0-*]_label`
+		Suggested voltage channel label.
+
 		Text string
+
 		Should only be created if the driver has hints about what
 		this voltage channel is being used for, and user-space
 		doesn't. In all other cases, the label is provided by
 		user-space.
+
 		RO
 
-in[0-*]_enable
+`in[0-*]_enable`
 		Enable or disable the sensors.
+
 		When disabled the sensor read will return -ENODATA.
-		1: Enable
-		0: Disable
+
+		- 1: Enable
+		- 0: Disable
+
 		RW
 
-cpu[0-*]_vid	CPU core reference voltage.
+`cpu[0-*]_vid`
+		CPU core reference voltage.
+
 		Unit: millivolt
+
 		RO
+
 		Not always correct.
 
-vrm		Voltage Regulator Module version number. 
+`vrm`
+		Voltage Regulator Module version number.
+
 		RW (but changing it should no more be necessary)
+
 		Originally the VRM standard version multiplied by 10, but now
 		an arbitrary number, as not all standards have a version
 		number.
+
 		Affects the way the driver calculates the CPU core reference
 		voltage from the vid pins.
 
 Also see the Alarms section for status flags associated with voltages.
 
 
-********
-* Fans *
-********
+****
+Fans
+****
+
+`fan[1-*]_min`
+		Fan minimum value
 
-fan[1-*]_min	Fan minimum value
 		Unit: revolution/min (RPM)
+
 		RW
 
-fan[1-*]_max	Fan maximum value
+`fan[1-*]_max`
+		Fan maximum value
+
 		Unit: revolution/min (RPM)
+
 		Only rarely supported by the hardware.
 		RW
 
-fan[1-*]_input	Fan input value.
+`fan[1-*]_input`
+		Fan input value.
+
 		Unit: revolution/min (RPM)
+
 		RO
 
-fan[1-*]_div	Fan divisor.
+`fan[1-*]_div`
+		Fan divisor.
+
 		Integer value in powers of two (1, 2, 4, 8, 16, 32, 64, 128).
+
 		RW
+
 		Some chips only support values 1, 2, 4 and 8.
 		Note that this is actually an internal clock divisor, which
 		affects the measurable speed range, not the read value.
 
-fan[1-*]_pulses	Number of tachometer pulses per fan revolution.
+`fan[1-*]_pulses`
+		Number of tachometer pulses per fan revolution.
+
 		Integer value, typically between 1 and 4.
+
 		RW
+
 		This value is a characteristic of the fan connected to the
 		device's input, so it has to be set in accordance with the fan
 		model.
+
 		Should only be created if the chip has a register to configure
 		the number of pulses. In the absence of such a register (and
 		thus attribute) the value assumed by all devices is 2 pulses
 		per fan revolution.
 
-fan[1-*]_target
+`fan[1-*]_target`
 		Desired fan speed
+
 		Unit: revolution/min (RPM)
+
 		RW
+
 		Only makes sense if the chip supports closed-loop fan speed
 		control based on the measured fan speed.
 
-fan[1-*]_label	Suggested fan channel label.
+`fan[1-*]_label`
+		Suggested fan channel label.
+
 		Text string
+
 		Should only be created if the driver has hints about what
 		this fan channel is being used for, and user-space doesn't.
 		In all other cases, the label is provided by user-space.
+
 		RO
 
-fan[1-*]_enable
+`fan[1-*]_enable`
 		Enable or disable the sensors.
+
 		When disabled the sensor read will return -ENODATA.
-		1: Enable
-		0: Disable
+
+		- 1: Enable
+		- 0: Disable
+
 		RW
 
 Also see the Alarms section for status flags associated with fans.
 
 
-*******
-* PWM *
-*******
+***
+PWM
+***
+
+`pwm[1-*]`
+		Pulse width modulation fan control.
 
-pwm[1-*]	Pulse width modulation fan control.
 		Integer value in the range 0 to 255
+
 		RW
+
 		255 is max or 100%.
 
-pwm[1-*]_enable
+`pwm[1-*]_enable`
 		Fan speed control method:
-		0: no fan speed control (i.e. fan at full speed)
-		1: manual fan speed control enabled (using pwm[1-*])
-		2+: automatic fan speed control enabled
+
+		- 0: no fan speed control (i.e. fan at full speed)
+		- 1: manual fan speed control enabled (using `pwm[1-*]`)
+		- 2+: automatic fan speed control enabled
+
 		Check individual chip documentation files for automatic mode
 		details.
+
 		RW
 
-pwm[1-*]_mode	0: DC mode (direct current)
-		1: PWM mode (pulse-width modulation)
+`pwm[1-*]_mode`
+		- 0: DC mode (direct current)
+		- 1: PWM mode (pulse-width modulation)
+
 		RW
 
-pwm[1-*]_freq	Base PWM frequency in Hz.
+`pwm[1-*]_freq`
+		Base PWM frequency in Hz.
+
 		Only possibly available when pwmN_mode is PWM, but not always
 		present even then.
+
 		RW
 
-pwm[1-*]_auto_channels_temp
+`pwm[1-*]_auto_channels_temp`
 		Select which temperature channels affect this PWM output in
-		auto mode. Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
+		auto mode.
+
+		Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
 		Which values are possible depend on the chip used.
+
 		RW
 
-pwm[1-*]_auto_point[1-*]_pwm
-pwm[1-*]_auto_point[1-*]_temp
-pwm[1-*]_auto_point[1-*]_temp_hyst
-		Define the PWM vs temperature curve. Number of trip points is
-		chip-dependent. Use this for chips which associate trip points
-		to PWM output channels.
+`pwm[1-*]_auto_point[1-*]_pwm` / `pwm[1-*]_auto_point[1-*]_temp` / `pwm[1-*]_auto_point[1-*]_temp_hyst`
+		Define the PWM vs temperature curve.
+
+		Number of trip points is chip-dependent. Use this for chips
+		which associate trip points to PWM output channels.
+
 		RW
 
-temp[1-*]_auto_point[1-*]_pwm
-temp[1-*]_auto_point[1-*]_temp
-temp[1-*]_auto_point[1-*]_temp_hyst
-		Define the PWM vs temperature curve. Number of trip points is
-		chip-dependent. Use this for chips which associate trip points
-		to temperature channels.
+`temp[1-*]_auto_point[1-*]_pwm` / `temp[1-*]_auto_point[1-*]_temp` / `temp[1-*]_auto_point[1-*]_temp_hyst`
+		Define the PWM vs temperature curve.
+
+		Number of trip points is chip-dependent. Use this for chips
+		which associate trip points to temperature channels.
+
 		RW
 
 There is a third case where trip points are associated to both PWM output
@@ -312,122 +405,173 @@ The actual result is up to the chip, but in general the highest candidate
 value (fastest fan speed) wins.
 
 
-****************
-* Temperatures *
-****************
+************
+Temperatures
+************
+
+`temp[1-*]_type`
+		Sensor type selection.
 
-temp[1-*]_type	Sensor type selection.
 		Integers 1 to 6
+
 		RW
-		1: CPU embedded diode
-		2: 3904 transistor
-		3: thermal diode
-		4: thermistor
-		5: AMD AMDSI
-		6: Intel PECI
+
+		- 1: CPU embedded diode
+		- 2: 3904 transistor
+		- 3: thermal diode
+		- 4: thermistor
+		- 5: AMD AMDSI
+		- 6: Intel PECI
+
 		Not all types are supported by all chips
 
-temp[1-*]_max	Temperature max value.
+`temp[1-*]_max`
+		Temperature max value.
+
 		Unit: millidegree Celsius (or millivolt, see below)
+
 		RW
 
-temp[1-*]_min	Temperature min value.
+`temp[1-*]_min`
+		Temperature min value.
+
 		Unit: millidegree Celsius
+
 		RW
 
-temp[1-*]_max_hyst
+`temp[1-*]_max_hyst`
 		Temperature hysteresis value for max limit.
+
 		Unit: millidegree Celsius
+
 		Must be reported as an absolute temperature, NOT a delta
 		from the max value.
+
 		RW
 
-temp[1-*]_min_hyst
+`temp[1-*]_min_hyst`
 		Temperature hysteresis value for min limit.
 		Unit: millidegree Celsius
+
 		Must be reported as an absolute temperature, NOT a delta
 		from the min value.
+
 		RW
 
-temp[1-*]_input Temperature input value.
+`temp[1-*]_input`
+	 Temperature input value.
+
 		Unit: millidegree Celsius
+
 		RO
 
-temp[1-*]_crit	Temperature critical max value, typically greater than
+`temp[1-*]_crit`
+		Temperature critical max value, typically greater than
 		corresponding temp_max values.
+
 		Unit: millidegree Celsius
+
 		RW
 
-temp[1-*]_crit_hyst
+`temp[1-*]_crit_hyst`
 		Temperature hysteresis value for critical limit.
+
 		Unit: millidegree Celsius
+
 		Must be reported as an absolute temperature, NOT a delta
 		from the critical value.
+
 		RW
 
-temp[1-*]_emergency
+`temp[1-*]_emergency`
 		Temperature emergency max value, for chips supporting more than
 		two upper temperature limits. Must be equal or greater than
 		corresponding temp_crit values.
+
 		Unit: millidegree Celsius
+
 		RW
 
-temp[1-*]_emergency_hyst
+`temp[1-*]_emergency_hyst`
 		Temperature hysteresis value for emergency limit.
+
 		Unit: millidegree Celsius
+
 		Must be reported as an absolute temperature, NOT a delta
 		from the emergency value.
+
 		RW
 
-temp[1-*]_lcrit	Temperature critical min value, typically lower than
+`temp[1-*]_lcrit`
+		Temperature critical min value, typically lower than
 		corresponding temp_min values.
+
 		Unit: millidegree Celsius
+
 		RW
 
-temp[1-*]_lcrit_hyst
+`temp[1-*]_lcrit_hyst`
 		Temperature hysteresis value for critical min limit.
+
 		Unit: millidegree Celsius
+
 		Must be reported as an absolute temperature, NOT a delta
 		from the critical min value.
+
 		RW
 
-temp[1-*]_offset
+`temp[1-*]_offset`
 		Temperature offset which is added to the temperature reading
 		by the chip.
+
 		Unit: millidegree Celsius
+
 		Read/Write value.
 
-temp[1-*]_label	Suggested temperature channel label.
+`temp[1-*]_label`
+		Suggested temperature channel label.
+
 		Text string
+
 		Should only be created if the driver has hints about what
 		this temperature channel is being used for, and user-space
 		doesn't. In all other cases, the label is provided by
 		user-space.
+
 		RO
 
-temp[1-*]_lowest
+`temp[1-*]_lowest`
 		Historical minimum temperature
+
 		Unit: millidegree Celsius
+
 		RO
 
-temp[1-*]_highest
+`temp[1-*]_highest`
 		Historical maximum temperature
+
 		Unit: millidegree Celsius
+
 		RO
 
-temp[1-*]_reset_history
+`temp[1-*]_reset_history`
 		Reset temp_lowest and temp_highest
+
 		WO
 
-temp_reset_history
+`temp_reset_history`
 		Reset temp_lowest and temp_highest for all sensors
+
 		WO
 
-temp[1-*]_enable
+`temp[1-*]_enable`
 		Enable or disable the sensors.
+
 		When disabled the sensor read will return -ENODATA.
-		1: Enable
-		0: Disable
+
+		- 1: Enable
+		- 0: Disable
+
 		RW
 
 Some chips measure temperature using external thermistors and an ADC, and
@@ -442,201 +586,300 @@ channels by the driver.
 Also see the Alarms section for status flags associated with temperatures.
 
 
-************
-* Currents *
-************
+********
+Currents
+********
+
+`curr[1-*]_max`
+		Current max value
 
-curr[1-*]_max	Current max value
 		Unit: milliampere
+
 		RW
 
-curr[1-*]_min	Current min value.
+`curr[1-*]_min`
+		Current min value.
+
 		Unit: milliampere
+
 		RW
 
-curr[1-*]_lcrit	Current critical low value
+`curr[1-*]_lcrit`
+		Current critical low value
+
 		Unit: milliampere
+
 		RW
 
-curr[1-*]_crit	Current critical high value.
+`curr[1-*]_crit`
+		Current critical high value.
+
 		Unit: milliampere
+
 		RW
 
-curr[1-*]_input	Current input value
+`curr[1-*]_input`
+		Current input value
+
 		Unit: milliampere
+
 		RO
 
-curr[1-*]_average
+`curr[1-*]_average`
 		Average current use
+
 		Unit: milliampere
+
 		RO
 
-curr[1-*]_lowest
+`curr[1-*]_lowest`
 		Historical minimum current
+
 		Unit: milliampere
+
 		RO
 
-curr[1-*]_highest
+`curr[1-*]_highest`
 		Historical maximum current
 		Unit: milliampere
 		RO
 
-curr[1-*]_reset_history
+`curr[1-*]_reset_history`
 		Reset currX_lowest and currX_highest
+
 		WO
 
-curr_reset_history
+`curr_reset_history`
 		Reset currX_lowest and currX_highest for all sensors
+
 		WO
 
-curr[1-*]_enable
+`curr[1-*]_enable`
 		Enable or disable the sensors.
+
 		When disabled the sensor read will return -ENODATA.
-		1: Enable
-		0: Disable
+
+		- 1: Enable
+		- 0: Disable
+
 		RW
 
 Also see the Alarms section for status flags associated with currents.
 
-*********
-* Power *
-*********
+*****
+Power
+*****
+
+`power[1-*]_average`
+				Average power use
 
-power[1-*]_average		Average power use
 				Unit: microWatt
+
 				RO
 
-power[1-*]_average_interval	Power use averaging interval.  A poll
+`power[1-*]_average_interval`
+				Power use averaging interval.  A poll
 				notification is sent to this file if the
 				hardware changes the averaging interval.
+
 				Unit: milliseconds
+
 				RW
 
-power[1-*]_average_interval_max	Maximum power use averaging interval
+`power[1-*]_average_interval_max`
+				Maximum power use averaging interval
+
 				Unit: milliseconds
+
 				RO
 
-power[1-*]_average_interval_min	Minimum power use averaging interval
+`power[1-*]_average_interval_min`
+				Minimum power use averaging interval
+
 				Unit: milliseconds
+
 				RO
 
-power[1-*]_average_highest	Historical average maximum power use
+`power[1-*]_average_highest`
+				Historical average maximum power use
+
 				Unit: microWatt
+
 				RO
 
-power[1-*]_average_lowest	Historical average minimum power use
+`power[1-*]_average_lowest`
+				Historical average minimum power use
+
 				Unit: microWatt
+
 				RO
 
-power[1-*]_average_max		A poll notification is sent to
-				power[1-*]_average when power use
+`power[1-*]_average_max`
+				A poll notification is sent to
+				`power[1-*]_average` when power use
 				rises above this value.
+
 				Unit: microWatt
+
 				RW
 
-power[1-*]_average_min		A poll notification is sent to
-				power[1-*]_average when power use
+`power[1-*]_average_min`
+				A poll notification is sent to
+				`power[1-*]_average` when power use
 				sinks below this value.
+
 				Unit: microWatt
+
 				RW
 
-power[1-*]_input		Instantaneous power use
+`power[1-*]_input`
+				Instantaneous power use
+
 				Unit: microWatt
+
 				RO
 
-power[1-*]_input_highest	Historical maximum power use
+`power[1-*]_input_highest`
+				Historical maximum power use
+
 				Unit: microWatt
+
 				RO
 
-power[1-*]_input_lowest		Historical minimum power use
+`power[1-*]_input_lowest`
+				Historical minimum power use
+
 				Unit: microWatt
+
 				RO
 
-power[1-*]_reset_history	Reset input_highest, input_lowest,
+`power[1-*]_reset_history`
+				Reset input_highest, input_lowest,
 				average_highest and average_lowest.
+
 				WO
 
-power[1-*]_accuracy		Accuracy of the power meter.
+`power[1-*]_accuracy`
+				Accuracy of the power meter.
+
 				Unit: Percent
+
 				RO
 
-power[1-*]_cap			If power use rises above this limit, the
+`power[1-*]_cap`
+				If power use rises above this limit, the
 				system should take action to reduce power use.
 				A poll notification is sent to this file if the
-				cap is changed by the hardware.  The *_cap
+				cap is changed by the hardware.  The `*_cap`
 				files only appear if the cap is known to be
 				enforced by hardware.
+
 				Unit: microWatt
+
 				RW
 
-power[1-*]_cap_hyst		Margin of hysteresis built around capping and
+`power[1-*]_cap_hyst`
+				Margin of hysteresis built around capping and
 				notification.
+
 				Unit: microWatt
+
 				RW
 
-power[1-*]_cap_max		Maximum cap that can be set.
+`power[1-*]_cap_max`
+				Maximum cap that can be set.
+
 				Unit: microWatt
+
 				RO
 
-power[1-*]_cap_min		Minimum cap that can be set.
+`power[1-*]_cap_min`
+				Minimum cap that can be set.
+
 				Unit: microWatt
+
 				RO
 
-power[1-*]_max			Maximum power.
+`power[1-*]_max`
+				Maximum power.
+
 				Unit: microWatt
+
 				RW
 
-power[1-*]_crit			Critical maximum power.
+`power[1-*]_crit`
+				Critical maximum power.
+
 				If power rises to or above this limit, the
 				system is expected take drastic action to reduce
 				power consumption, such as a system shutdown or
 				a forced powerdown of some devices.
+
 				Unit: microWatt
+
 				RW
 
-power[1-*]_enable		Enable or disable the sensors.
+`power[1-*]_enable`
+				Enable or disable the sensors.
+
 				When disabled the sensor read will return
 				-ENODATA.
-				1: Enable
-				0: Disable
+
+				- 1: Enable
+				- 0: Disable
+
 				RW
 
 Also see the Alarms section for status flags associated with power readings.
 
-**********
-* Energy *
-**********
+******
+Energy
+******
+
+`energy[1-*]_input`
+				Cumulative energy use
 
-energy[1-*]_input		Cumulative energy use
 				Unit: microJoule
+
 				RO
 
-energy[1-*]_enable		Enable or disable the sensors.
+`energy[1-*]_enable`
+				Enable or disable the sensors.
+
 				When disabled the sensor read will return
 				-ENODATA.
-				1: Enable
-				0: Disable
+
+				- 1: Enable
+				- 0: Disable
+
 				RW
 
-************
-* Humidity *
-************
+********
+Humidity
+********
+
+`humidity[1-*]_input`
+				Humidity
 
-humidity[1-*]_input		Humidity
 				Unit: milli-percent (per cent mille, pcm)
+
 				RO
 
 
-humidity[1-*]_enable		Enable or disable the sensors
+`humidity[1-*]_enable`
+				Enable or disable the sensors
+
 				When disabled the sensor read will return
 				-ENODATA.
-				1: Enable
-				0: Disable
+
+				- 1: Enable
+				- 0: Disable
+
 				RW
 
-**********
-* Alarms *
-**********
+******
+Alarms
+******
 
 Each channel or limit may have an associated alarm file, containing a
 boolean value. 1 means than an alarm condition exists, 0 means no alarm.
@@ -645,67 +888,67 @@ Usually a given chip will either use channel-related alarms, or
 limit-related alarms, not both. The driver should just reflect the hardware
 implementation.
 
-in[0-*]_alarm
-curr[1-*]_alarm
-power[1-*]_alarm
-fan[1-*]_alarm
-temp[1-*]_alarm
-		Channel alarm
-		0: no alarm
-		1: alarm
-		RO
++-------------------------------+-----------------------+
+| **`in[0-*]_alarm`,		| Channel alarm		|
+| `curr[1-*]_alarm`,		|			|
+| `power[1-*]_alarm`,		|   - 0: no alarm	|
+| `fan[1-*]_alarm`,		|   - 1: alarm		|
+| `temp[1-*]_alarm`**		|			|
+|				|   RO			|
++-------------------------------+-----------------------+
 
-OR
+**OR**
 
-in[0-*]_min_alarm
-in[0-*]_max_alarm
-in[0-*]_lcrit_alarm
-in[0-*]_crit_alarm
-curr[1-*]_min_alarm
-curr[1-*]_max_alarm
-curr[1-*]_lcrit_alarm
-curr[1-*]_crit_alarm
-power[1-*]_cap_alarm
-power[1-*]_max_alarm
-power[1-*]_crit_alarm
-fan[1-*]_min_alarm
-fan[1-*]_max_alarm
-temp[1-*]_min_alarm
-temp[1-*]_max_alarm
-temp[1-*]_lcrit_alarm
-temp[1-*]_crit_alarm
-temp[1-*]_emergency_alarm
-		Limit alarm
-		0: no alarm
-		1: alarm
-		RO
++-------------------------------+-----------------------+
+| **`in[0-*]_min_alarm`,	| Limit alarm		|
+| `in[0-*]_max_alarm`,		|			|
+| `in[0-*]_lcrit_alarm`,	|   - 0: no alarm	|
+| `in[0-*]_crit_alarm`,		|   - 1: alarm		|
+| `curr[1-*]_min_alarm`,	|			|
+| `curr[1-*]_max_alarm`,	| RO			|
+| `curr[1-*]_lcrit_alarm`,	|			|
+| `curr[1-*]_crit_alarm`,	|			|
+| `power[1-*]_cap_alarm`,	|			|
+| `power[1-*]_max_alarm`,	|			|
+| `power[1-*]_crit_alarm`,	|			|
+| `fan[1-*]_min_alarm`,		|			|
+| `fan[1-*]_max_alarm`,		|			|
+| `temp[1-*]_min_alarm`,	|			|
+| `temp[1-*]_max_alarm`,	|			|
+| `temp[1-*]_lcrit_alarm`,	|			|
+| `temp[1-*]_crit_alarm`,	|			|
+| `temp[1-*]_emergency_alarm`**	|			|
++-------------------------------+-----------------------+
 
 Each input channel may have an associated fault file. This can be used
 to notify open diodes, unconnected fans etc. where the hardware
 supports it. When this boolean has value 1, the measurement for that
 channel should not be trusted.
 
-fan[1-*]_fault
-temp[1-*]_fault
+`fan[1-*]_fault` / `temp[1-*]_fault`
 		Input fault condition
-		0: no fault occurred
-		1: fault condition
+
+		- 0: no fault occurred
+		- 1: fault condition
+
 		RO
 
 Some chips also offer the possibility to get beeped when an alarm occurs:
 
-beep_enable	Master beep enable
-		0: no beeps
-		1: beeps
+`beep_enable`
+		Master beep enable
+
+		- 0: no beeps
+		- 1: beeps
+
 		RW
 
-in[0-*]_beep
-curr[1-*]_beep
-fan[1-*]_beep
-temp[1-*]_beep
+`in[0-*]_beep`, `curr[1-*]_beep`, `fan[1-*]_beep`, `temp[1-*]_beep`,
 		Channel beep
-		0: disable
-		1: enable
+
+		- 0: disable
+		- 1: enable
+
 		RW
 
 In theory, a chip could provide per-limit beep masking, but no such chip
@@ -715,45 +958,57 @@ Old drivers provided a different, non-standard interface to alarms and
 beeps. These interface files are deprecated, but will be kept around
 for compatibility reasons:
 
-alarms		Alarm bitmask.
+`alarms`
+		Alarm bitmask.
+
 		RO
+
 		Integer representation of one to four bytes.
+
 		A '1' bit means an alarm.
+
 		Chips should be programmed for 'comparator' mode so that
 		the alarm will 'come back' after you read the register
 		if it is still valid.
+
 		Generally a direct representation of a chip's internal
 		alarm registers; there is no standard for the position
 		of individual bits. For this reason, the use of this
 		interface file for new drivers is discouraged. Use
-		individual *_alarm and *_fault files instead.
+		`individual *_alarm` and `*_fault` files instead.
 		Bits are defined in kernel/include/sensors.h.
 
-beep_mask	Bitmask for beep.
+`beep_mask`
+		Bitmask for beep.
 		Same format as 'alarms' with the same bit locations,
 		use discouraged for the same reason. Use individual
-		*_beep files instead.
+		`*_beep` files instead.
 		RW
 
 
-***********************
-* Intrusion detection *
-***********************
+*******************
+Intrusion detection
+*******************
 
-intrusion[0-*]_alarm
+`intrusion[0-*]_alarm`
 		Chassis intrusion detection
-		0: OK
-		1: intrusion detected
+
+		- 0: OK
+		- 1: intrusion detected
+
 		RW
+
 		Contrary to regular alarm flags which clear themselves
 		automatically when read, this one sticks until cleared by
 		the user. This is done by writing 0 to the file. Writing
 		other values is unsupported.
 
-intrusion[0-*]_beep
+`intrusion[0-*]_beep`
 		Chassis intrusion beep
+
 		0: disable
 		1: enable
+
 		RW
 
 
@@ -762,9 +1017,10 @@ sysfs attribute writes interpretation
 
 hwmon sysfs attributes always contain numbers, so the first thing to do is to
 convert the input to a number, there are 2 ways todo this depending whether
-the number can be negative or not:
-unsigned long u = simple_strtoul(buf, NULL, 10);
-long s = simple_strtol(buf, NULL, 10);
+the number can be negative or not::
+
+	unsigned long u = simple_strtoul(buf, NULL, 10);
+	long s = simple_strtol(buf, NULL, 10);
 
 With buf being the buffer with the user input being passed by the kernel.
 Notice that we do not use the second argument of strto[u]l, and thus cannot
@@ -789,13 +1045,13 @@ limits using clamp_val(value, min_limit, max_limit). If it is not continuous
 like for example a tempX_type, then when an invalid value is written,
 -EINVAL should be returned.
 
-Example1, temp1_max, register is a signed 8 bit value (-128 - 127 degrees):
+Example1, temp1_max, register is a signed 8 bit value (-128 - 127 degrees)::
 
 	long v = simple_strtol(buf, NULL, 10) / 1000;
 	v = clamp_val(v, -128, 127);
 	/* write v to register */
 
-Example2, fan divider setting, valid values 2, 4 and 8:
+Example2, fan divider setting, valid values 2, 4 and 8::
 
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 
diff --git a/Documentation/hwmon/tc654 b/Documentation/hwmon/tc654
index 47636a8077b4..ce546ee6dfed 100644
--- a/Documentation/hwmon/tc654
+++ b/Documentation/hwmon/tc654
@@ -2,13 +2,16 @@ Kernel driver tc654
 ===================
 
 Supported chips:
+
   * Microchip TC654 and TC655
+
     Prefix: 'tc654'
-    Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/20001734C.pdf
+    Datasheet: http://ww1.m
+    icrochip.com/downloads/en/DeviceDoc/20001734C.pdf
 
 Authors:
-        Chris Packham <chris.packham@alliedtelesis.co.nz>
-        Masahiko Iwamoto <iwamoto@allied-telesis.co.jp>
+      - Chris Packham <chris.packham@alliedtelesis.co.nz>
+      - Masahiko Iwamoto <iwamoto@allied-telesis.co.jp>
 
 Description
 -----------
diff --git a/Documentation/hwmon/tc74 b/Documentation/hwmon/tc74
index 43027aad5f8e..f1764211c129 100644
--- a/Documentation/hwmon/tc74
+++ b/Documentation/hwmon/tc74
@@ -2,8 +2,11 @@ Kernel driver tc74
 ====================
 
 Supported chips:
+
    * Microchip TC74
+
      Prefix: 'tc74'
+
      Datasheet: Publicly available at Microchip website.
 
 Description
diff --git a/Documentation/hwmon/thmc50 b/Documentation/hwmon/thmc50
index 8a7772ade8d0..6dba1b59b20c 100644
--- a/Documentation/hwmon/thmc50
+++ b/Documentation/hwmon/thmc50
@@ -2,30 +2,41 @@ Kernel driver thmc50
 =====================
 
 Supported chips:
+
   * Analog Devices ADM1022
+
     Prefix: 'adm1022'
+
     Addresses scanned: I2C 0x2c - 0x2e
+
     Datasheet: http://www.analog.com/en/prod/0,2877,ADM1022,00.html
+
   * Texas Instruments THMC50
+
     Prefix: 'thmc50'
+
     Addresses scanned: I2C 0x2c - 0x2e
-    Datasheet: http://www.ti.com/ 
+
+    Datasheet: http://www.ti.com/
+
 
 Author: Krzysztof Helt <krzysztof.h1@wp.pl>
 
 This driver was derived from the 2.4 kernel thmc50.c source file.
 
 Credits:
+
   thmc50.c (2.4 kernel):
-	Frodo Looijaard <frodol@dds.nl>
-	Philip Edelbrock <phil@netroedge.com>
+
+	- Frodo Looijaard <frodol@dds.nl>
+	- Philip Edelbrock <phil@netroedge.com>
 
 Module Parameters
 -----------------
 
 * adm1022_temp3: short array
-  List of adapter,address pairs to force chips into ADM1022 mode with
-  second remote temperature. This does not work for original THMC50 chips.
+    List of adapter,address pairs to force chips into ADM1022 mode with
+    second remote temperature. This does not work for original THMC50 chips.
 
 Description
 -----------
@@ -59,12 +70,17 @@ Driver Features
 
 The driver provides up to three temperatures:
 
-temp1		-- internal
-temp2		-- remote
-temp3		-- 2nd remote only for ADM1022
+temp1
+	- internal
+temp2
+	- remote
+temp3
+	- 2nd remote only for ADM1022
 
-pwm1		-- fan speed (0 = stop, 255 = full)
-pwm1_mode	-- always 0 (DC mode)
+pwm1
+	- fan speed (0 = stop, 255 = full)
+pwm1_mode
+	- always 0 (DC mode)
 
 The value of 0 for pwm1 also forces FAN_OFF signal from the chip,
 so it stops fans even if the value 0 into the ANALOG_OUT register does not.
diff --git a/Documentation/hwmon/tmp102 b/Documentation/hwmon/tmp102
index 8454a7763122..5e34821df4ab 100644
--- a/Documentation/hwmon/tmp102
+++ b/Documentation/hwmon/tmp102
@@ -2,12 +2,17 @@ Kernel driver tmp102
 ====================
 
 Supported chips:
+
   * Texas Instruments TMP102
+
     Prefix: 'tmp102'
+
     Addresses scanned: none
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp102.html
 
 Author:
+
 	Steven King <sfking@fdwdc.com>
 
 Description
diff --git a/Documentation/hwmon/tmp103 b/Documentation/hwmon/tmp103
index ec00a15645ba..7682a795e38c 100644
--- a/Documentation/hwmon/tmp103
+++ b/Documentation/hwmon/tmp103
@@ -2,12 +2,17 @@ Kernel driver tmp103
 ====================
 
 Supported chips:
+
   * Texas Instruments TMP103
+
     Prefix: 'tmp103'
+
     Addresses scanned: none
+
     Product info and datasheet: http://www.ti.com/product/tmp103
 
 Author:
+
 	Heiko Schocher <hs@denx.de>
 
 Description
diff --git a/Documentation/hwmon/tmp108 b/Documentation/hwmon/tmp108
index 25802df23010..7e08b7ef1e2f 100644
--- a/Documentation/hwmon/tmp108
+++ b/Documentation/hwmon/tmp108
@@ -2,12 +2,17 @@ Kernel driver tmp108
 ====================
 
 Supported chips:
+
   * Texas Instruments TMP108
+
     Prefix: 'tmp108'
+
     Addresses scanned: none
+
     Datasheet: http://www.ti.com/product/tmp108
 
 Author:
+
 	John Muir <john@jmuir.com>
 
 Description
diff --git a/Documentation/hwmon/tmp421 b/Documentation/hwmon/tmp421
index 9e6fe5549ca1..1ba926a3605c 100644
--- a/Documentation/hwmon/tmp421
+++ b/Documentation/hwmon/tmp421
@@ -2,28 +2,49 @@ Kernel driver tmp421
 ====================
 
 Supported chips:
+
   * Texas Instruments TMP421
+
     Prefix: 'tmp421'
+
     Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
+
   * Texas Instruments TMP422
+
     Prefix: 'tmp422'
+
     Addresses scanned: I2C 0x4c, 0x4d, 0x4e and 0x4f
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
+
   * Texas Instruments TMP423
+
     Prefix: 'tmp423'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
+
   * Texas Instruments TMP441
+
     Prefix: 'tmp441'
+
     Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+
     Datasheet: http://www.ti.com/product/tmp441
+
   * Texas Instruments TMP442
+
     Prefix: 'tmp442'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: http://www.ti.com/product/tmp442
 
 Authors:
+
 	Andre Prendel <andre.prendel@gmx.de>
 
 Description
@@ -40,5 +61,6 @@ for both the local and remote channels is 0.0625 degree C.
 The chips support only temperature measurement. The driver exports
 the temperature values via the following sysfs files:
 
-temp[1-4]_input
-temp[2-4]_fault
+**temp[1-4]_input**
+
+**temp[2-4]_fault**
diff --git a/Documentation/hwmon/twl4030-madc-hwmon b/Documentation/hwmon/twl4030-madc-hwmon
index c3a3a5be10ad..22c885383b11 100644
--- a/Documentation/hwmon/twl4030-madc-hwmon
+++ b/Documentation/hwmon/twl4030-madc-hwmon
@@ -1,8 +1,10 @@
 Kernel driver twl4030-madc
-=========================
+==========================
 
 Supported chips:
+
 	* Texas Instruments TWL4030
+
 	Prefix: 'twl4030-madc'
 
 
@@ -19,8 +21,9 @@ channels which can be used in different modes.
 
 See this table for the meaning of the different channels
 
+======= ==========================================================
 Channel Signal
-------------------------------------------
+======= ==========================================================
 0	Battery type(BTYPE)
 1	BCI: Battery temperature (BTEMP)
 2	GP analog input
@@ -37,6 +40,7 @@ Channel Signal
 13	Reserved
 14	Reserved
 15	VRUSB Supply/Speaker left/Speaker right polarization level
+======= ==========================================================
 
 
 The Sysfs nodes will represent the voltage in the units of mV,
diff --git a/Documentation/hwmon/userspace-tools b/Documentation/hwmon/userspace-tools
index 9865aeedc58f..bf3797c8e734 100644
--- a/Documentation/hwmon/userspace-tools
+++ b/Documentation/hwmon/userspace-tools
@@ -1,3 +1,6 @@
+Userspace tools
+===============
+
 Introduction
 ------------
 
diff --git a/Documentation/hwmon/via686a b/Documentation/hwmon/via686a
index e5f90ab5c48d..a343c35df740 100644
--- a/Documentation/hwmon/via686a
+++ b/Documentation/hwmon/via686a
@@ -2,29 +2,35 @@ Kernel driver via686a
 =====================
 
 Supported chips:
+
   * Via VT82C686A, VT82C686B  Southbridge Integrated Hardware Monitor
+
     Prefix: 'via686a'
+
     Addresses scanned: ISA in PCI-space encoded address
+
     Datasheet: On request through web form (http://www.via.com.tw/en/resources/download-center/)
 
 Authors:
-        Kyösti Mälkki <kmalkki@cc.hut.fi>,
-        Mark D. Studebaker <mdsxyz123@yahoo.com>
-        Bob Dougherty <bobd@stanford.edu>
-        (Some conversion-factor data were contributed by
-        Jonathan Teh Soon Yew <j.teh@iname.com>
-        and Alex van Kaam <darkside@chello.nl>.)
+	- Kyösti Mälkki <kmalkki@cc.hut.fi>,
+	- Mark D. Studebaker <mdsxyz123@yahoo.com>
+	- Bob Dougherty <bobd@stanford.edu>
+	- (Some conversion-factor data were contributed by
+	- Jonathan Teh Soon Yew <j.teh@iname.com>
+	- and Alex van Kaam <darkside@chello.nl>.)
 
 Module Parameters
 -----------------
 
+======================= =======================================================
 force_addr=0xaddr       Set the I/O base address. Useful for boards that
-                        don't set the address in the BIOS. Look for a BIOS
-                        upgrade before resorting to this. Does not do a
-                        PCI force; the via686a must still be present in lspci.
-                        Don't use this unless the driver complains that the
-                        base address is not set.
-                        Example: 'modprobe via686a force_addr=0x6000'
+			don't set the address in the BIOS. Look for a BIOS
+			upgrade before resorting to this. Does not do a
+			PCI force; the via686a must still be present in lspci.
+			Don't use this unless the driver complains that the
+			base address is not set.
+			Example: 'modprobe via686a force_addr=0x6000'
+======================= =======================================================
 
 Description
 -----------
diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627ehf
index 735c42a85ead..74d19ef11e1f 100644
--- a/Documentation/hwmon/w83627ehf
+++ b/Documentation/hwmon/w83627ehf
@@ -2,45 +2,79 @@ Kernel driver w83627ehf
 =======================
 
 Supported chips:
+
   * Winbond W83627EHF/EHG (ISA access ONLY)
+
     Prefix: 'w83627ehf'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: not available
+
   * Winbond W83627DHG
+
     Prefix: 'w83627dhg'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: not available
+
   * Winbond W83627DHG-P
+
     Prefix: 'w83627dhg'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: not available
+
   * Winbond W83627UHG
+
     Prefix: 'w83627uhg'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: available from www.nuvoton.com
+
   * Winbond W83667HG
+
     Prefix: 'w83667hg'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: not available
+
   * Winbond W83667HG-B
+
     Prefix: 'w83667hg'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT6775F/W83667HG-I
+
     Prefix: 'nct6775'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
+
   * Nuvoton NCT6776F
+
     Prefix: 'nct6776'
+
     Addresses scanned: ISA address retrieved from Super I/O registers
+
     Datasheet: Available from Nuvoton upon request
 
+
 Authors:
-        Jean Delvare <jdelvare@suse.de>
-        Yuan Mu (Winbond)
-        Rudolf Marek <r.marek@assembler.cz>
-        David Hubbard <david.c.hubbard@gmail.com>
-        Gong Jun <JGong@nuvoton.com>
+
+	- Jean Delvare <jdelvare@suse.de>
+	- Yuan Mu (Winbond)
+	- Rudolf Marek <r.marek@assembler.cz>
+	- David Hubbard <david.c.hubbard@gmail.com>
+	- Gong Jun <JGong@nuvoton.com>
 
 Description
 -----------
@@ -85,25 +119,30 @@ predefined temperature range. If the temperature goes out of range, fan
 is driven slower/faster to reach the predefined range again.
 
 The mode works for fan1-fan4. Mapping of temperatures to pwm outputs is as
-follows:
+follows::
 
-temp1 -> pwm1
-temp2 -> pwm2
-temp3 -> pwm3 (not on 627UHG)
-prog  -> pwm4 (not on 667HG and 667HG-B; the programmable setting is not
-	       supported by the driver)
+  temp1 -> pwm1
+  temp2 -> pwm2
+  temp3 -> pwm3 (not on 627UHG)
+  prog  -> pwm4 (not on 667HG and 667HG-B; the programmable setting is not
+		 supported by the driver)
 
 /sys files
 ----------
 
-name - this is a standard hwmon device entry, it contains the name of
-       the device (see the prefix in the list of supported devices at
-       the top of this file)
+name
+	this is a standard hwmon device entry, it contains the name of
+	the device (see the prefix in the list of supported devices at
+	the top of this file)
+
+pwm[1-4]
+	this file stores PWM duty cycle or DC value (fan speed) in range:
 
-pwm[1-4] - this file stores PWM duty cycle or DC value (fan speed) in range:
 	   0 (stop) to 255 (full)
 
-pwm[1-4]_enable - this file controls mode of fan/temperature control:
+pwm[1-4]_enable
+	this file controls mode of fan/temperature control:
+
 	* 1 Manual mode, write to pwm file any value 0-255 (full speed)
 	* 2 "Thermal Cruise" mode
 	* 3 "Fan Speed Cruise" mode
@@ -121,33 +160,43 @@ pwm[1-4]_enable - this file controls mode of fan/temperature control:
 	returned when reading pwm attributes is unrelated to SmartFan IV
 	operation.
 
-pwm[1-4]_mode - controls if output is PWM or DC level
-        * 0 DC output (0 - 12v)
-        * 1 PWM output
+pwm[1-4]_mode
+	controls if output is PWM or DC level
+
+	* 0 DC output (0 - 12v)
+	* 1 PWM output
 
 Thermal Cruise mode
 -------------------
 
 If the temperature is in the range defined by:
 
-pwm[1-4]_target    - set target temperature, unit millidegree Celsius
-		     (range 0 - 127000)
-pwm[1-4]_tolerance - tolerance, unit millidegree Celsius (range 0 - 15000)
+pwm[1-4]_target
+		   set target temperature, unit millidegree Celsius
+		   (range 0 - 127000)
+pwm[1-4]_tolerance
+		   tolerance, unit millidegree Celsius (range 0 - 15000)
 
 there are no changes to fan speed. Once the temperature leaves the interval,
 fan speed increases (temp is higher) or decreases if lower than desired.
 There are defined steps and times, but not exported by the driver yet.
 
-pwm[1-4]_min_output - minimum fan speed (range 1 - 255), when the temperature
-                      is below defined range.
-pwm[1-4]_stop_time  - how many milliseconds [ms] must elapse to switch
-                      corresponding fan off. (when the temperature was below
-                      defined range).
-pwm[1-4]_start_output-minimum fan speed (range 1 - 255) when spinning up
-pwm[1-4]_step_output- rate of fan speed change (1 - 255)
-pwm[1-4]_stop_output- minimum fan speed (range 1 - 255) when spinning down
-pwm[1-4]_max_output - maximum fan speed (range 1 - 255), when the temperature
-                      is above defined range.
+pwm[1-4]_min_output
+		   minimum fan speed (range 1 - 255), when the temperature
+		   is below defined range.
+pwm[1-4]_stop_time
+		   how many milliseconds [ms] must elapse to switch
+		   corresponding fan off. (when the temperature was below
+		   defined range).
+pwm[1-4]_start_output
+		   minimum fan speed (range 1 - 255) when spinning up
+pwm[1-4]_step_output
+		   rate of fan speed change (1 - 255)
+pwm[1-4]_stop_output
+		   minimum fan speed (range 1 - 255) when spinning down
+pwm[1-4]_max_output
+		   maximum fan speed (range 1 - 255), when the temperature
+		   is above defined range.
 
 Note: last six functions are influenced by other control bits, not yet exported
       by the driver, so a change might not have any effect.
@@ -161,26 +210,35 @@ different power-on default values, but BIOS should already be loading
 appropriate defaults. Note that bank selection must be performed as is currently
 done in the driver for all register addresses.
 
-0x49:  only on DHG, selects temperature source for AUX fan, CPU fan0
-0x4a:  not completely documented for the EHF and the DHG documentation assigns
-       different behavior to bits 7 and 6, including extending the temperature
-       input selection to SmartFan I, not just SmartFan III. Testing on the EHF
-       will reveal whether they are compatible or not.
+========================= =====================================================
+Register(s)		  Meaning
+========================= =====================================================
+0x49                      only on DHG, selects temperature source for AUX fan,
+			  CPU fan0
+0x4a                      not completely documented for the EHF and the DHG
+			  documentation assigns different behavior to bits 7
+			  and 6, including extending the temperature input
+			  selection to SmartFan I, not just SmartFan III.
+			  Testing on the EHF will reveal whether they are
+			  compatible or not.
+0x58                      Chip ID: 0xa1=EHF 0xc1=DHG
+0x5e                      only on DHG, has bits to enable "current mode"
+			  temperature detection and critical temperature
+			  protection
+0x45b                     only on EHF, bit 3, vin4 alarm (EHF supports 10
+			  inputs, only 9 on DHG)
+0x552                     only on EHF, vin4
+0x558                     only on EHF, vin4 high limit
+0x559                     only on EHF, vin4 low limit
+0x6b                      only on DHG, SYS fan critical temperature
+0x6c                      only on DHG, CPU fan0 critical temperature
+0x6d                      only on DHG, AUX fan critical temperature
+0x6e                      only on DHG, CPU fan1 critical temperature
+0x50-0x55 and 0x650-0x657 marked as:
 
-0x58:  Chip ID: 0xa1=EHF 0xc1=DHG
-0x5e:  only on DHG, has bits to enable "current mode" temperature detection and
-       critical temperature protection
-0x45b: only on EHF, bit 3, vin4 alarm (EHF supports 10 inputs, only 9 on DHG)
-0x552: only on EHF, vin4
-0x558: only on EHF, vin4 high limit
-0x559: only on EHF, vin4 low limit
-0x6b:  only on DHG, SYS fan critical temperature
-0x6c:  only on DHG, CPU fan0 critical temperature
-0x6d:  only on DHG, AUX fan critical temperature
-0x6e:  only on DHG, CPU fan1 critical temperature
-
-0x50-0x55 and 0x650-0x657 are marked "Test Register" for the EHF, but "Reserved
-       Register" for the DHG
+			    - "Test Register" for the EHF
+			    - "Reserved Register" for the DHG
+========================= =====================================================
 
 The DHG also supports PECI, where the DHG queries Intel CPU temperatures, and
 the ICH8 southbridge gets that data via PECI from the DHG, so that the
diff --git a/Documentation/hwmon/w83627hf b/Documentation/hwmon/w83627hf
index 8432e1118173..d1406c28dee7 100644
--- a/Documentation/hwmon/w83627hf
+++ b/Documentation/hwmon/w83627hf
@@ -20,10 +20,10 @@ Supported chips:
     Datasheet: Provided by Winbond on request(http://www.winbond.com/hq/enu)
 
 Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Mark Studebaker <mdsxyz123@yahoo.com>,
-        Bernhard C. Schrenk <clemy@clemy.org>
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+	Mark Studebaker <mdsxyz123@yahoo.com>,
+	Bernhard C. Schrenk <clemy@clemy.org>
 
 Module Parameters
 -----------------
@@ -52,8 +52,8 @@ If you really want i2c accesses for these Super I/O chips,
 use the w83781d driver. However this is not the preferred method
 now that this ISA driver has been developed.
 
-The w83627_HF_ uses pins 110-106 as VID0-VID4. The w83627_THF_ uses the
-same pins as GPIO[0:4]. Technically, the w83627_THF_ does not support a
+The `w83627_HF_` uses pins 110-106 as VID0-VID4. The `w83627_THF_` uses the
+same pins as GPIO[0:4]. Technically, the `w83627_THF_` does not support a
 VID reading. However the two chips have the identical 128 pin package. So,
 it is possible or even likely for a w83627thf to have the VID signals routed
 to these pins despite their not being labeled for that purpose. Therefore,
@@ -75,19 +75,23 @@ module parameter is gone for technical reasons. If you need this feature,
 you can obtain the same result by using the isaset tool (part of
 lm-sensors) before loading the driver:
 
-# Enter the Super I/O config space
-isaset -y -f 0x2e 0x87
-isaset -y -f 0x2e 0x87
+# Enter the Super I/O config space::
 
-# Select the hwmon logical device
-isaset -y 0x2e 0x2f 0x07 0x0b
+	isaset -y -f 0x2e 0x87
+	isaset -y -f 0x2e 0x87
 
-# Set the base I/O address (to 0x290 in this example)
-isaset -y 0x2e 0x2f 0x60 0x02
-isaset -y 0x2e 0x2f 0x61 0x90
+# Select the hwmon logical device::
 
-# Exit the Super-I/O config space
-isaset -y -f 0x2e 0xaa
+	isaset -y 0x2e 0x2f 0x07 0x0b
+
+# Set the base I/O address (to 0x290 in this example)::
+
+	isaset -y 0x2e 0x2f 0x60 0x02
+	isaset -y 0x2e 0x2f 0x61 0x90
+
+# Exit the Super-I/O config space::
+
+	isaset -y -f 0x2e 0xaa
 
 The above sequence assumes a Super-I/O config space at 0x2e/0x2f, but
 0x4e/0x4f is also possible.
@@ -97,18 +101,23 @@ Voltage pin mapping
 
 Here is a summary of the voltage pin mapping for the W83627THF. This
 can be useful to convert data provided by board manufacturers into
-working libsensors configuration statements.
-
-    W83627THF		|
-  Pin	| Name		| Register	| Sysfs attribute
------------------------------------------------------
-  100	| CPUVCORE	| 20h		| in0
-   99	| VIN0		| 21h		| in1
-   98	| VIN1		| 22h		| in2
-   97	| VIN2		| 24h		| in4
-  114	| AVCC		| 23h		| in3
-   61	| 5VSB		| 50h (bank 5)	| in7
-   74	| VBAT		| 51h (bank 5)	| in8
+working libsensors configuration statements:
+
+
+- W83627THF
+
+
+  ======== =============== =============== ===============
+  Pin	   Name		   Register	   Sysfs attribute
+  ======== =============== =============== ===============
+    100	   CPUVCORE	   20h		   in0
+     99	   VIN0		   21h		   in1
+     98	   VIN1		   22h		   in2
+     97	   VIN2		   24h		   in4
+    114	   AVCC		   23h		   in3
+     61	   5VSB		   50h (bank 5)	   in7
+     74	   VBAT		   51h (bank 5)	   in8
+  ======== =============== =============== ===============
 
 For other supported devices, you'll have to take the hard path and
 look up the information in the datasheet yourself (and then add it
diff --git a/Documentation/hwmon/w83773g b/Documentation/hwmon/w83773g
index 4cc6c0b8257f..cabaed391414 100644
--- a/Documentation/hwmon/w83773g
+++ b/Documentation/hwmon/w83773g
@@ -1,13 +1,18 @@
 Kernel driver w83773g
-====================
+=====================
 
 Supported chips:
+
   * Nuvoton W83773G
+
     Prefix: 'w83773g'
+
     Addresses scanned: I2C 0x4c and 0x4d
+
     Datasheet: https://www.nuvoton.com/resource-files/W83773G_SG_DatasheetV1_2.pdf
 
 Authors:
+
 	Lei YU <mine260309@gmail.com>
 
 Description
@@ -27,7 +32,4 @@ Resolution for both the local and remote channels is 0.125 degree C.
 The chip supports only temperature measurement. The driver exports
 the temperature values via the following sysfs files:
 
-temp[1-3]_input
-temp[2-3]_fault
-temp[2-3]_offset
-update_interval
+**temp[1-3]_input, temp[2-3]_fault, temp[2-3]_offset, update_interval**
diff --git a/Documentation/hwmon/w83781d b/Documentation/hwmon/w83781d
index 129b0a3b555b..f36d33dfb704 100644
--- a/Documentation/hwmon/w83781d
+++ b/Documentation/hwmon/w83781d
@@ -2,44 +2,64 @@ Kernel driver w83781d
 =====================
 
 Supported chips:
+
   * Winbond W83781D
+
     Prefix: 'w83781d'
+
     Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
+
     Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/w83781d.pdf
+
   * Winbond W83782D
+
     Prefix: 'w83782d'
+
     Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
+
     Datasheet: http://www.winbond.com
+
   * Winbond W83783S
+
     Prefix: 'w83783s'
+
     Addresses scanned: I2C 0x2d
+
     Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/w83783s.pdf
+
   * Asus AS99127F
+
     Prefix: 'as99127f'
+
     Addresses scanned: I2C 0x28 - 0x2f
+
     Datasheet: Unavailable from Asus
 
+
+
 Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Mark Studebaker <mdsxyz123@yahoo.com>
+
+      - Frodo Looijaard <frodol@dds.nl>,
+      - Philip Edelbrock <phil@netroedge.com>,
+      - Mark Studebaker <mdsxyz123@yahoo.com>
 
 Module parameters
 -----------------
 
 * init int
-  (default 1)
-  Use 'init=0' to bypass initializing the chip.
-  Try this if your computer crashes when you load the module.
+    (default 1)
+
+    Use 'init=0' to bypass initializing the chip.
+    Try this if your computer crashes when you load the module.
 
 * reset int
-  (default 0)
-  The driver used to reset the chip on load, but does no more. Use
-  'reset=1' to restore the old behavior. Report if you need to do this.
+    (default 0)
+    The driver used to reset the chip on load, but does no more. Use
+    'reset=1' to restore the old behavior. Report if you need to do this.
 
 force_subclients=bus,caddr,saddr,saddr
   This is used to force the i2c addresses for subclients of
-  a certain chip. Typical usage is `force_subclients=0,0x2d,0x4a,0x4b'
+  a certain chip. Typical usage is `force_subclients=0,0x2d,0x4a,0x4b`
   to force the subclients of chip 0x2d on bus 0 to i2c addresses
   0x4a and 0x4b. This parameter is useful for certain Tyan boards.
 
@@ -54,12 +74,19 @@ There is quite some difference between these chips, but they are similar
 enough that it was sensible to put them together in one driver.
 The Asus chips are similar to an I2C-only W83782D.
 
-Chip        #vin    #fanin  #pwm    #temp   wchipid vendid  i2c     ISA
-as99127f    7       3       0       3       0x31    0x12c3  yes     no
-as99127f rev.2 (type_name = as99127f)       0x31    0x5ca3  yes     no
-w83781d     7       3       0       3       0x10-1  0x5ca3  yes     yes
-w83782d     9       3       2-4     3       0x30    0x5ca3  yes     yes
-w83783s     5-6     3       2       1-2     0x40    0x5ca3  yes     no
++----------+---------+--------+-------+-------+---------+--------+------+-----+
+| Chip     | #vin    | #fanin | #pwm  | #temp | wchipid | vendid | i2c  | ISA |
++----------+---------+--------+-------+-------+---------+--------+------+-----+
+| as99127f | 7       | 3      | 0     | 3     | 0x31    | 0x12c3 | yes  |  no |
++----------+---------+--------+-------+-------+---------+--------+------+-----+
+| as99127f rev.2 (type_name = as99127f)       | 0x31    | 0x5ca3 | yes  |  no |
++----------+---------+--------+-------+-------+---------+--------+------+-----+
+| w83781d  | 7       | 3      | 0     | 3     | 0x10-1  | 0x5ca3 | yes  | yes |
++----------+---------+--------+-------+-------+---------+--------+------+-----+
+| w83782d  | 9       | 3      | 2-4   | 3     | 0x30    | 0x5ca3 | yes  | yes |
++----------+---------+--------+-------+-------+---------+--------+------+-----+
+| w83783s  | 5-6     | 3      | 2     |  1-2  | 0x40    | 0x5ca3 | yes  |  no |
++----------+---------+--------+-------+-------+---------+--------+------+-----+
 
 Detection of these chips can sometimes be foiled because they can be in
 an internal state that allows no clean access. If you know the address
@@ -124,22 +151,24 @@ or only the beeping for some alarms.
 
 Individual alarm and beep bits:
 
-0x000001: in0
-0x000002: in1
-0x000004: in2
-0x000008: in3
-0x000010: temp1
-0x000020: temp2 (+temp3 on W83781D)
-0x000040: fan1
-0x000080: fan2
-0x000100: in4
-0x000200: in5
-0x000400: in6
-0x000800: fan3
-0x001000: chassis
-0x002000: temp3 (W83782D only)
-0x010000: in7 (W83782D only)
-0x020000: in8 (W83782D only)
+======== ==========================
+0x000001 in0
+0x000002 in1
+0x000004 in2
+0x000008 in3
+0x000010 temp1
+0x000020 temp2 (+temp3 on W83781D)
+0x000040 fan1
+0x000080 fan2
+0x000100 in4
+0x000200 in5
+0x000400 in6
+0x000800 fan3
+0x001000 chassis
+0x002000 temp3 (W83782D only)
+0x010000 in7 (W83782D only)
+0x020000 in8 (W83782D only)
+======== ==========================
 
 If an alarm triggers, it will remain triggered until the hardware register
 is read at least once. This means that the cause for the alarm may
@@ -179,68 +208,74 @@ Please do not send mail to the author or the sensors group asking for
 a datasheet or ideas on how to convince Asus. We can't help.
 
 
-NOTES:
+NOTES
 -----
   783s has no in1 so that in[2-6] are compatible with the 781d/782d.
 
   783s pin is programmable for -5V or temp1; defaults to -5V,
-       no control in driver so temp1 doesn't work.
+  no control in driver so temp1 doesn't work.
 
   782d and 783s datasheets differ on which is pwm1 and which is pwm2.
-       We chose to follow 782d.
+  We chose to follow 782d.
 
   782d and 783s pin is programmable for fan3 input or pwm2 output;
-       defaults to fan3 input.
-       If pwm2 is enabled (with echo 255 1 > pwm2), then
-       fan3 will report 0.
+  defaults to fan3 input.
+  If pwm2 is enabled (with echo 255 1 > pwm2), then
+  fan3 will report 0.
 
   782d has pwm1-2 for ISA, pwm1-4 for i2c. (pwm3-4 share pins with
-       the ISA pins)
+  the ISA pins)
 
-Data sheet updates:
+Data sheet updates
 ------------------
 	- PWM clock registers:
-
-		000: master /  512
-		001: master / 1024
-		010: master / 2048
-		011: master / 4096
-		100: master / 8192
+		* 000: master /  512
+		* 001: master / 1024
+		* 010: master / 2048
+		* 011: master / 4096
+		* 100: master / 8192
 
 
 Answers from Winbond tech support
 ---------------------------------
->
-> 1) In the W83781D data sheet section 7.2 last paragraph, it talks about
->    reprogramming the R-T table if the Beta of the thermistor is not
->    3435K. The R-T table is described briefly in section 8.20.
->    What formulas do I use to program a new R-T table for a given Beta?
->
-	We are sorry that the calculation for R-T table value is
-confidential. If you have another Beta value of thermistor, we can help
-to calculate the R-T table for you. But you should give us real R-T
-Table which can be gotten by thermistor vendor. Therefore we will calculate
-them and obtain 32-byte data, and you can fill the 32-byte data to the
-register in Bank0.CR51 of W83781D.
 
+::
 
-> 2) In the W83782D data sheet, it mentions that pins 38, 39, and 40 are
->    programmable to be either thermistor or Pentium II diode inputs.
->    How do I program them for diode inputs? I can't find any register
->    to program these to be diode inputs.
- --> You may program Bank0 CR[5Dh] and CR[59h] registers.
+  >
+  > 1) In the W83781D data sheet section 7.2 last paragraph, it talks about
+  >    reprogramming the R-T table if the Beta of the thermistor is not
+  >    3435K. The R-T table is described briefly in section 8.20.
+  >    What formulas do I use to program a new R-T table for a given Beta?
+  >
 
- 	CR[5Dh]    		bit 1(VTIN1)    bit 2(VTIN2)   bit 3(VTIN3)
+  We are sorry that the calculation for R-T table value is
+  confidential. If you have another Beta value of thermistor, we can help
+  to calculate the R-T table for you. But you should give us real R-T
+  Table which can be gotten by thermistor vendor. Therefore we will calculate
+  them and obtain 32-byte data, and you can fill the 32-byte data to the
+  register in Bank0.CR51 of W83781D.
 
-      	thermistor                0		 0		0
- 	diode 		          1		 1		1
 
+  > 2) In the W83782D data sheet, it mentions that pins 38, 39, and 40 are
+  >    programmable to be either thermistor or Pentium II diode inputs.
+  >    How do I program them for diode inputs? I can't find any register
+  >    to program these to be diode inputs.
 
-(error) CR[59h] 		bit 4(VTIN1)	bit 2(VTIN2)   bit 3(VTIN3)
-(right) CR[59h] 		bit 4(VTIN1)	bit 5(VTIN2)   bit 6(VTIN3)
+  You may program Bank0 CR[5Dh] and CR[59h] registers.
 
- 	PII thermal diode         1		 1		1
- 	2N3904	diode	          0		 0		0
+  =============================== =============== ============== ============
+	CR[5Dh]    		bit 1(VTIN1)    bit 2(VTIN2)   bit 3(VTIN3)
+
+		thermistor                0		 0		0
+	diode 			  1		 1		1
+
+
+  (error) CR[59h] 		bit 4(VTIN1)	bit 2(VTIN2)   bit 3(VTIN3)
+  (right) CR[59h] 		bit 4(VTIN1)	bit 5(VTIN2)   bit 6(VTIN3)
+
+	PII thermal diode         1		 1		1
+	2N3904	diode		  0		 0		0
+  =============================== =============== ============== ============
 
 
 Asus Clones
@@ -251,18 +286,21 @@ Here are some very useful information that were given to us by Alex Van
 Kaam about how to detect these chips, and how to read their values. He
 also gives advice for another Asus chipset, the Mozart-2 (which we
 don't support yet). Thanks Alex!
+
 I reworded some parts and added personal comments.
 
-# Detection:
+Detection
+^^^^^^^^^
 
 AS99127F rev.1, AS99127F rev.2 and ASB100:
 - I2C address range: 0x29 - 0x2F
-- If register 0x58 holds 0x31 then we have an Asus (either ASB100 or
-  AS99127F)
+- If register 0x58 holds 0x31 then we have an Asus (either ASB100 or AS99127F)
 - Which one depends on register 0x4F (manufacturer ID):
-  0x06 or 0x94: ASB100
-  0x12 or 0xC3: AS99127F rev.1
-  0x5C or 0xA3: AS99127F rev.2
+
+  - 0x06 or 0x94: ASB100
+  - 0x12 or 0xC3: AS99127F rev.1
+  - 0x5C or 0xA3: AS99127F rev.2
+
   Note that 0x5CA3 is Winbond's ID (WEC), which let us think Asus get their
   AS99127F rev.2 direct from Winbond. The other codes mean ATT and DVC,
   respectively. ATT could stand for Asustek something (although it would be
@@ -273,88 +311,103 @@ Mozart-2:
 - I2C address: 0x77
 - If register 0x58 holds 0x56 or 0x10 then we have a Mozart-2
 - Of the Mozart there are 3 types:
-  0x58=0x56, 0x4E=0x94, 0x4F=0x36: Asus ASM58 Mozart-2
-  0x58=0x56, 0x4E=0x94, 0x4F=0x06: Asus AS2K129R Mozart-2
-  0x58=0x10, 0x4E=0x5C, 0x4F=0xA3: Asus ??? Mozart-2
+
+  - 0x58=0x56, 0x4E=0x94, 0x4F=0x36: Asus ASM58 Mozart-2
+  - 0x58=0x56, 0x4E=0x94, 0x4F=0x06: Asus AS2K129R Mozart-2
+  - 0x58=0x10, 0x4E=0x5C, 0x4F=0xA3: Asus ??? Mozart-2
+
   You can handle all 3 the exact same way :)
 
-# Temperature sensors:
+Temperature sensors
+^^^^^^^^^^^^^^^^^^^
 
 ASB100:
-- sensor 1: register 0x27
-- sensor 2 & 3 are the 2 LM75's on the SMBus
-- sensor 4: register 0x17
-Remark: I noticed that on Intel boards sensor 2 is used for the CPU
+  - sensor 1: register 0x27
+  - sensor 2 & 3 are the 2 LM75's on the SMBus
+  - sensor 4: register 0x17
+
+Remark:
+
+  I noticed that on Intel boards sensor 2 is used for the CPU
   and 4 is ignored/stuck, on AMD boards sensor 4 is the CPU and sensor 2 is
   either ignored or a socket temperature.
 
 AS99127F (rev.1 and 2 alike):
-- sensor 1: register 0x27
-- sensor 2 & 3 are the 2 LM75's on the SMBus
-Remark: Register 0x5b is suspected to be temperature type selector. Bit 1
+  - sensor 1: register 0x27
+  - sensor 2 & 3 are the 2 LM75's on the SMBus
+
+Remark:
+
+  Register 0x5b is suspected to be temperature type selector. Bit 1
   would control temp1, bit 3 temp2 and bit 5 temp3.
 
 Mozart-2:
-- sensor 1: register 0x27
-- sensor 2: register 0x13
+  - sensor 1: register 0x27
+  - sensor 2: register 0x13
 
-# Fan sensors:
+Fan sensors
+^^^^^^^^^^^
 
 ASB100, AS99127F (rev.1 and 2 alike):
-- 3 fans, identical to the W83781D
+  - 3 fans, identical to the W83781D
 
 Mozart-2:
-- 2 fans only, 1350000/RPM/div
-- fan 1: register 0x28,  divisor on register 0xA1 (bits 4-5)
-- fan 2: register 0x29,  divisor on register 0xA1 (bits 6-7)
+  - 2 fans only, 1350000/RPM/div
+  - fan 1: register 0x28,  divisor on register 0xA1 (bits 4-5)
+  - fan 2: register 0x29,  divisor on register 0xA1 (bits 6-7)
 
-# Voltages:
+Voltages
+^^^^^^^^
 
 This is where there is a difference between AS99127F rev.1 and 2.
-Remark: The difference is similar to the difference between
+
+Remark:
+
+  The difference is similar to the difference between
   W83781D and W83782D.
 
 ASB100:
-in0=r(0x20)*0.016
-in1=r(0x21)*0.016
-in2=r(0x22)*0.016
-in3=r(0x23)*0.016*1.68
-in4=r(0x24)*0.016*3.8
-in5=r(0x25)*(-0.016)*3.97
-in6=r(0x26)*(-0.016)*1.666
+  - in0=r(0x20)*0.016
+  - in1=r(0x21)*0.016
+  - in2=r(0x22)*0.016
+  - in3=r(0x23)*0.016*1.68
+  - in4=r(0x24)*0.016*3.8
+  - in5=r(0x25)*(-0.016)*3.97
+  - in6=r(0x26)*(-0.016)*1.666
 
 AS99127F rev.1:
-in0=r(0x20)*0.016
-in1=r(0x21)*0.016
-in2=r(0x22)*0.016
-in3=r(0x23)*0.016*1.68
-in4=r(0x24)*0.016*3.8
-in5=r(0x25)*(-0.016)*3.97
-in6=r(0x26)*(-0.016)*1.503
+  - in0=r(0x20)*0.016
+  - in1=r(0x21)*0.016
+  - in2=r(0x22)*0.016
+  - in3=r(0x23)*0.016*1.68
+  - in4=r(0x24)*0.016*3.8
+  - in5=r(0x25)*(-0.016)*3.97
+  - in6=r(0x26)*(-0.016)*1.503
 
 AS99127F rev.2:
-in0=r(0x20)*0.016
-in1=r(0x21)*0.016
-in2=r(0x22)*0.016
-in3=r(0x23)*0.016*1.68
-in4=r(0x24)*0.016*3.8
-in5=(r(0x25)*0.016-3.6)*5.14+3.6
-in6=(r(0x26)*0.016-3.6)*3.14+3.6
+  - in0=r(0x20)*0.016
+  - in1=r(0x21)*0.016
+  - in2=r(0x22)*0.016
+  - in3=r(0x23)*0.016*1.68
+  - in4=r(0x24)*0.016*3.8
+  - in5=(r(0x25)*0.016-3.6)*5.14+3.6
+  - in6=(r(0x26)*0.016-3.6)*3.14+3.6
 
 Mozart-2:
-in0=r(0x20)*0.016
-in1=255
-in2=r(0x22)*0.016
-in3=r(0x23)*0.016*1.68
-in4=r(0x24)*0.016*4
-in5=255
-in6=255
+  - in0=r(0x20)*0.016
+  - in1=255
+  - in2=r(0x22)*0.016
+  - in3=r(0x23)*0.016*1.68
+  - in4=r(0x24)*0.016*4
+  - in5=255
+  - in6=255
 
 
-# PWM
+PWM
+^^^
 
 * Additional info about PWM on the AS99127F (may apply to other Asus
-chips as well) by Jean Delvare as of 2004-04-09:
+  chips as well) by Jean Delvare as of 2004-04-09:
 
 AS99127F revision 2 seems to have two PWM registers at 0x59 and 0x5A,
 and a temperature sensor type selector at 0x5B (which basically means
@@ -401,15 +454,20 @@ AS99127F chips at all.
 I've been fiddling around with the (in)famous 0x59 register and
 found out the following values do work as a form of coarse pwm:
 
-0x80 - seems to turn fans off after some time(1-2 minutes)... might be
-some form of auto-fan-control based on temp? hmm (Qfan? this mobo is an
-old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attempt at Qfan
-that was dropped at the BIOS)
-0x81 - off
-0x82 - slightly "on-ner" than off, but my fans do not get to move. I can
-hear the high-pitched PWM sound that motors give off at too-low-pwm.
-0x83 - now they do move. Estimate about 70% speed or so.
-0x84-0x8f - full on
+0x80
+ - seems to turn fans off after some time(1-2 minutes)... might be
+   some form of auto-fan-control based on temp? hmm (Qfan? this mobo is an
+   old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attempt at Qfan
+   that was dropped at the BIOS)
+0x81
+ - off
+0x82
+ - slightly "on-ner" than off, but my fans do not get to move. I can
+   hear the high-pitched PWM sound that motors give off at too-low-pwm.
+0x83
+ - now they do move. Estimate about 70% speed or so.
+0x84-0x8f
+ - full on
 
 Changing the high nibble doesn't seem to do much except the high bit
 (0x80) must be set for PWM to work, else the current pwm doesn't seem to
@@ -435,6 +493,7 @@ looks like PWM is filtered on this motherboard.
 
 Here are some of measurements:
 
+==== =========
 0x80     20 mV
 0x81     20 mV
 0x82    232 mV
@@ -451,3 +510,4 @@ Here are some of measurements:
 0x8d  12.4  V
 0x8e  12.4  V
 0x8f  12.4  V
+==== =========
diff --git a/Documentation/hwmon/w83792d b/Documentation/hwmon/w83792d
index f2ffc402ea45..92c4bfe4968c 100644
--- a/Documentation/hwmon/w83792d
+++ b/Documentation/hwmon/w83792d
@@ -2,9 +2,13 @@ Kernel driver w83792d
 =====================
 
 Supported chips:
+
   * Winbond W83792D
+
     Prefix: 'w83792d'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: http://www.winbond.com.tw
 
 Author: Shane Huang (Winbond)
@@ -15,15 +19,16 @@ Module Parameters
 -----------------
 
 * init int
-  (default 1)
-  Use 'init=0' to bypass initializing the chip.
-  Try this if your computer crashes when you load the module.
+    (default 1)
+
+    Use 'init=0' to bypass initializing the chip.
+    Try this if your computer crashes when you load the module.
 
 * force_subclients=bus,caddr,saddr,saddr
-  This is used to force the i2c addresses for subclients of
-  a certain chip. Example usage is `force_subclients=0,0x2f,0x4a,0x4b'
-  to force the subclients of chip 0x2f on bus 0 to i2c addresses
-  0x4a and 0x4b.
+    This is used to force the i2c addresses for subclients of
+    a certain chip. Example usage is `force_subclients=0,0x2f,0x4a,0x4b`
+    to force the subclients of chip 0x2f on bus 0 to i2c addresses
+    0x4a and 0x4b.
 
 
 Description
@@ -67,31 +72,34 @@ or maximum limit.
 Alarms are provided as output from "realtime status register". Following bits
 are defined:
 
-bit - alarm on:
-0  - in0
-1  - in1
-2  - temp1
-3  - temp2
-4  - temp3
-5  - fan1
-6  - fan2
-7  - fan3
-8  - in2
-9  - in3
-10 - in4
-11 - in5
-12 - in6
-13 - VID change
-14 - chassis
-15 - fan7
-16 - tart1
-17 - tart2
-18 - tart3
-19 - in7
-20 - in8
-21 - fan4
-22 - fan5
-23 - fan6
+==== ==========
+bit   alarm on
+==== ==========
+0    in0
+1    in1
+2    temp1
+3    temp2
+4    temp3
+5    fan1
+6    fan2
+7    fan3
+8    in2
+9    in3
+10   in4
+11   in5
+12   in6
+13   VID change
+14   chassis
+15   fan7
+16   tart1
+17   tart2
+18   tart3
+19   in7
+20   in8
+21   fan4
+22   fan5
+23   fan6
+==== ==========
 
 Tart will be asserted while target temperature cannot be achieved after 3 minutes
 of full speed rotation of corresponding fan.
@@ -114,7 +122,7 @@ Known problems:
 	  by CR[0x49h].
 	- The function of vid and vrm has not been finished, because I'm NOT
 	  very familiar with them. Adding support is welcome.
- 	- The function of chassis open detection needs more tests.
+	- The function of chassis open detection needs more tests.
 	- If you have ASUS server board and chip was not found: Then you will
 	  need to upgrade to latest (or beta) BIOS. If it does not help please
 	  contact us.
@@ -165,17 +173,27 @@ for each fan.
 /sys files
 ----------
 
-pwm[1-7] - this file stores PWM duty cycle or DC value (fan speed) in range:
-	0 (stop) to 255 (full)
-pwm[1-3]_enable - this file controls mode of fan/temperature control:
-            * 0 Disabled
-            * 1 Manual mode
-            * 2 Smart Fan II
-            * 3 Thermal Cruise
-pwm[1-7]_mode - Select PWM or DC mode
-            * 0 DC
-            * 1 PWM
-thermal_cruise[1-3] - Selects the desired temperature for cruise (degC)
-tolerance[1-3] - Value in degrees of Celsius (degC) for +- T
-sf2_point[1-4]_fan[1-3] - four temperature points for each fan for Smart Fan II
-sf2_level[1-3]_fan[1-3] - three PWM/DC levels for each fan for Smart Fan II
+pwm[1-7]
+	- this file stores PWM duty cycle or DC value (fan speed) in range:
+
+	    0 (stop) to 255 (full)
+pwm[1-3]_enable
+	- this file controls mode of fan/temperature control:
+
+	    * 0 Disabled
+	    * 1 Manual mode
+	    * 2 Smart Fan II
+	    * 3 Thermal Cruise
+pwm[1-7]_mode
+	- Select PWM or DC mode
+
+	    * 0 DC
+	    * 1 PWM
+thermal_cruise[1-3]
+	- Selects the desired temperature for cruise (degC)
+tolerance[1-3]
+	- Value in degrees of Celsius (degC) for +- T
+sf2_point[1-4]_fan[1-3]
+	- four temperature points for each fan for Smart Fan II
+sf2_level[1-3]_fan[1-3]
+	- three PWM/DC levels for each fan for Smart Fan II
diff --git a/Documentation/hwmon/w83795 b/Documentation/hwmon/w83795
index d3e678216b9a..d0615e2fabb9 100644
--- a/Documentation/hwmon/w83795
+++ b/Documentation/hwmon/w83795
@@ -2,18 +2,26 @@ Kernel driver w83795
 ====================
 
 Supported chips:
+
   * Winbond/Nuvoton W83795G
+
     Prefix: 'w83795g'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: Available for download on nuvoton.com
+
   * Winbond/Nuvoton W83795ADG
+
     Prefix: 'w83795adg'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: Available for download on nuvoton.com
 
 Authors:
-    Wei Song (Nuvoton)
-    Jean Delvare <jdelvare@suse.de>
+    - Wei Song (Nuvoton)
+    - Jean Delvare <jdelvare@suse.de>
 
 
 Pin mapping
@@ -23,105 +31,112 @@ Here is a summary of the pin mapping for the W83795G and W83795ADG.
 This can be useful to convert data provided by board manufacturers
 into working libsensors configuration statements.
 
-    W83795G			|
-  Pin	| Name			| Register	| Sysfs attribute
-------------------------------------------------------------------
-   13	| VSEN1 (VCORE1)	| 10h		| in0
-   14	| VSEN2 (VCORE2)	| 11h		| in1
-   15	| VSEN3 (VCORE3)	| 12h		| in2
-   16	| VSEN4			| 13h		| in3
-   17	| VSEN5			| 14h		| in4
-   18	| VSEN6			| 15h		| in5
-   19	| VSEN7			| 16h		| in6
-   20	| VSEN8			| 17h		| in7
-   21	| VSEN9			| 18h		| in8
-   22	| VSEN10		| 19h		| in9
-   23	| VSEN11		| 1Ah		| in10
-   28	| VTT			| 1Bh		| in11
-   24	| 3VDD			| 1Ch		| in12
-   25	| 3VSB			| 1Dh		| in13
-   26	| VBAT			| 1Eh		| in14
-    3	| VSEN12/TR5		| 1Fh		| in15/temp5
-    4	| VSEN13/TR5		| 20h		| in16/temp6
-  5/  6	| VDSEN14/TR1/TD1	| 21h		| in17/temp1
-  7/  8	| VDSEN15/TR2/TD2	| 22h		| in18/temp2
-  9/ 10	| VDSEN16/TR3/TD3	| 23h		| in19/temp3
- 11/ 12	| VDSEN17/TR4/TD4	| 24h		| in20/temp4
-   40	| FANIN1		| 2Eh		| fan1
-   42	| FANIN2		| 2Fh		| fan2
-   44	| FANIN3		| 30h		| fan3
-   46	| FANIN4		| 31h		| fan4
-   48	| FANIN5		| 32h		| fan5
-   50	| FANIN6		| 33h		| fan6
-   52	| FANIN7		| 34h		| fan7
-   54	| FANIN8		| 35h		| fan8
-   57	| FANIN9		| 36h		| fan9
-   58	| FANIN10		| 37h		| fan10
-   59	| FANIN11		| 38h		| fan11
-   60	| FANIN12		| 39h		| fan12
-   31	| FANIN13		| 3Ah		| fan13
-   35	| FANIN14		| 3Bh		| fan14
-   41	| FANCTL1		| 10h (bank 2)	| pwm1
-   43	| FANCTL2		| 11h (bank 2)	| pwm2
-   45	| FANCTL3		| 12h (bank 2)	| pwm3
-   47	| FANCTL4		| 13h (bank 2)	| pwm4
-   49	| FANCTL5		| 14h (bank 2)	| pwm5
-   51	| FANCTL6		| 15h (bank 2)	| pwm6
-   53	| FANCTL7		| 16h (bank 2)	| pwm7
-   55	| FANCTL8		| 17h (bank 2)	| pwm8
- 29/ 30	| PECI/TSI (DTS1)	| 26h		| temp7
- 29/ 30	| PECI/TSI (DTS2)	| 27h		| temp8
- 29/ 30	| PECI/TSI (DTS3)	| 28h		| temp9
- 29/ 30	| PECI/TSI (DTS4)	| 29h		| temp10
- 29/ 30	| PECI/TSI (DTS5)	| 2Ah		| temp11
- 29/ 30	| PECI/TSI (DTS6)	| 2Bh		| temp12
- 29/ 30	| PECI/TSI (DTS7)	| 2Ch		| temp13
- 29/ 30	| PECI/TSI (DTS8)	| 2Dh		| temp14
-   27	| CASEOPEN#		| 46h		| intrusion0
 
-    W83795ADG			|
-  Pin	| Name			| Register	| Sysfs attribute
-------------------------------------------------------------------
-   10	| VSEN1 (VCORE1)	| 10h		| in0
-   11	| VSEN2 (VCORE2)	| 11h		| in1
-   12	| VSEN3 (VCORE3)	| 12h		| in2
-   13	| VSEN4			| 13h		| in3
-   14	| VSEN5			| 14h		| in4
-   15	| VSEN6			| 15h		| in5
-   16	| VSEN7			| 16h		| in6
-   17	| VSEN8			| 17h		| in7
-   22	| VTT			| 1Bh		| in11
-   18	| 3VDD			| 1Ch		| in12
-   19	| 3VSB			| 1Dh		| in13
-   20	| VBAT			| 1Eh		| in14
-   48	| VSEN12/TR5		| 1Fh		| in15/temp5
-    1	| VSEN13/TR5		| 20h		| in16/temp6
-  2/  3	| VDSEN14/TR1/TD1	| 21h		| in17/temp1
-  4/  5	| VDSEN15/TR2/TD2	| 22h		| in18/temp2
-  6/  7	| VDSEN16/TR3/TD3	| 23h		| in19/temp3
-  8/  9	| VDSEN17/TR4/TD4	| 24h		| in20/temp4
-   32	| FANIN1		| 2Eh		| fan1
-   34	| FANIN2		| 2Fh		| fan2
-   36	| FANIN3		| 30h		| fan3
-   37	| FANIN4		| 31h		| fan4
-   38	| FANIN5		| 32h		| fan5
-   39	| FANIN6		| 33h		| fan6
-   40	| FANIN7		| 34h		| fan7
-   41	| FANIN8		| 35h		| fan8
-   43	| FANIN9		| 36h		| fan9
-   44	| FANIN10		| 37h		| fan10
-   45	| FANIN11		| 38h		| fan11
-   46	| FANIN12		| 39h		| fan12
-   24	| FANIN13		| 3Ah		| fan13
-   28	| FANIN14		| 3Bh		| fan14
-   33	| FANCTL1		| 10h (bank 2)	| pwm1
-   35	| FANCTL2		| 11h (bank 2)	| pwm2
-   23	| PECI (DTS1)		| 26h		| temp7
-   23	| PECI (DTS2)		| 27h		| temp8
-   23	| PECI (DTS3)		| 28h		| temp9
-   23	| PECI (DTS4)		| 29h		| temp10
-   23	| PECI (DTS5)		| 2Ah		| temp11
-   23	| PECI (DTS6)		| 2Bh		| temp12
-   23	| PECI (DTS7)		| 2Ch		| temp13
-   23	| PECI (DTS8)		| 2Dh		| temp14
-   21	| CASEOPEN#		| 46h		| intrusion0
+- W83795G
+
+========= ======================= =============== ================
+Pin	  Name			  Register	  Sysfs attribute
+========= ======================= =============== ================
+   13	  VSEN1 (VCORE1)	  10h		  in0
+   14	  VSEN2 (VCORE2)	  11h		  in1
+   15	  VSEN3 (VCORE3)	  12h		  in2
+   16	  VSEN4			  13h		  in3
+   17	  VSEN5			  14h		  in4
+   18	  VSEN6			  15h		  in5
+   19	  VSEN7			  16h		  in6
+   20	  VSEN8			  17h		  in7
+   21	  VSEN9			  18h		  in8
+   22	  VSEN10		  19h		  in9
+   23	  VSEN11		  1Ah		  in10
+   28	  VTT			  1Bh		  in11
+   24	  3VDD			  1Ch		  in12
+   25	  3VSB			  1Dh		  in13
+   26	  VBAT			  1Eh		  in14
+    3	  VSEN12/TR5		  1Fh		  in15/temp5
+    4	  VSEN13/TR5		  20h		  in16/temp6
+  5/  6	  VDSEN14/TR1/TD1	  21h		  in17/temp1
+  7/  8	  VDSEN15/TR2/TD2	  22h		  in18/temp2
+  9/ 10	  VDSEN16/TR3/TD3	  23h		  in19/temp3
+ 11/ 12	  VDSEN17/TR4/TD4	  24h		  in20/temp4
+   40	  FANIN1		  2Eh		  fan1
+   42	  FANIN2		  2Fh		  fan2
+   44	  FANIN3		  30h		  fan3
+   46	  FANIN4		  31h		  fan4
+   48	  FANIN5		  32h		  fan5
+   50	  FANIN6		  33h		  fan6
+   52	  FANIN7		  34h		  fan7
+   54	  FANIN8		  35h		  fan8
+   57	  FANIN9		  36h		  fan9
+   58	  FANIN10		  37h		  fan10
+   59	  FANIN11		  38h		  fan11
+   60	  FANIN12		  39h		  fan12
+   31	  FANIN13		  3Ah		  fan13
+   35	  FANIN14		  3Bh		  fan14
+   41	  FANCTL1		  10h (bank 2)	  pwm1
+   43	  FANCTL2		  11h (bank 2)	  pwm2
+   45	  FANCTL3		  12h (bank 2)	  pwm3
+   47	  FANCTL4		  13h (bank 2)	  pwm4
+   49	  FANCTL5		  14h (bank 2)	  pwm5
+   51	  FANCTL6		  15h (bank 2)	  pwm6
+   53	  FANCTL7		  16h (bank 2)	  pwm7
+   55	  FANCTL8		  17h (bank 2)	  pwm8
+ 29/ 30	  PECI/TSI (DTS1)	  26h		  temp7
+ 29/ 30	  PECI/TSI (DTS2)	  27h		  temp8
+ 29/ 30	  PECI/TSI (DTS3)	  28h		  temp9
+ 29/ 30	  PECI/TSI (DTS4)	  29h		  temp10
+ 29/ 30	  PECI/TSI (DTS5)	  2Ah		  temp11
+ 29/ 30	  PECI/TSI (DTS6)	  2Bh		  temp12
+ 29/ 30	  PECI/TSI (DTS7)	  2Ch		  temp13
+ 29/ 30	  PECI/TSI (DTS8)	  2Dh		  temp14
+   27	  CASEOPEN#		  46h		  intrusion0
+========= ======================= =============== ================
+
+- W83795ADG
+
+========= ======================= =============== ================
+Pin	  Name			  Register	  Sysfs attribute
+========= ======================= =============== ================
+   10	  VSEN1 (VCORE1)	  10h		  in0
+   11	  VSEN2 (VCORE2)	  11h		  in1
+   12	  VSEN3 (VCORE3)	  12h		  in2
+   13	  VSEN4			  13h		  in3
+   14	  VSEN5			  14h		  in4
+   15	  VSEN6			  15h		  in5
+   16	  VSEN7			  16h		  in6
+   17	  VSEN8			  17h		  in7
+   22	  VTT			  1Bh		  in11
+   18	  3VDD			  1Ch		  in12
+   19	  3VSB			  1Dh		  in13
+   20	  VBAT			  1Eh		  in14
+   48	  VSEN12/TR5		  1Fh		  in15/temp5
+    1	  VSEN13/TR5		  20h		  in16/temp6
+  2/  3	  VDSEN14/TR1/TD1	  21h		  in17/temp1
+  4/  5	  VDSEN15/TR2/TD2	  22h		  in18/temp2
+  6/  7	  VDSEN16/TR3/TD3	  23h		  in19/temp3
+  8/  9	  VDSEN17/TR4/TD4	  24h		  in20/temp4
+   32	  FANIN1		  2Eh		  fan1
+   34	  FANIN2		  2Fh		  fan2
+   36	  FANIN3		  30h		  fan3
+   37	  FANIN4		  31h		  fan4
+   38	  FANIN5		  32h		  fan5
+   39	  FANIN6		  33h		  fan6
+   40	  FANIN7		  34h		  fan7
+   41	  FANIN8		  35h		  fan8
+   43	  FANIN9		  36h		  fan9
+   44	  FANIN10		  37h		  fan10
+   45	  FANIN11		  38h		  fan11
+   46	  FANIN12		  39h		  fan12
+   24	  FANIN13		  3Ah		  fan13
+   28	  FANIN14		  3Bh		  fan14
+   33	  FANCTL1		  10h (bank 2)	  pwm1
+   35	  FANCTL2		  11h (bank 2)	  pwm2
+   23	  PECI (DTS1)		  26h		  temp7
+   23	  PECI (DTS2)		  27h		  temp8
+   23	  PECI (DTS3)		  28h		  temp9
+   23	  PECI (DTS4)		  29h		  temp10
+   23	  PECI (DTS5)		  2Ah		  temp11
+   23	  PECI (DTS6)		  2Bh		  temp12
+   23	  PECI (DTS7)		  2Ch		  temp13
+   23	  PECI (DTS8)		  2Dh		  temp14
+   21	  CASEOPEN#		  46h		  intrusion0
+========= ======================= =============== ================
diff --git a/Documentation/hwmon/w83l785ts b/Documentation/hwmon/w83l785ts
index c8978478871f..7fa5418fed11 100644
--- a/Documentation/hwmon/w83l785ts
+++ b/Documentation/hwmon/w83l785ts
@@ -2,14 +2,19 @@ Kernel driver w83l785ts
 =======================
 
 Supported chips:
+
   * Winbond W83L785TS-S
+
     Prefix: 'w83l785ts'
+
     Addresses scanned: I2C 0x2e
+
     Datasheet: Publicly available at the Winbond USA website
-               http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83L785TS-S.pdf
+
+	       http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83L785TS-S.pdf
 
 Authors:
-        Jean Delvare <jdelvare@suse.de>
+	Jean Delvare <jdelvare@suse.de>
 
 Description
 -----------
diff --git a/Documentation/hwmon/w83l786ng b/Documentation/hwmon/w83l786ng
index d8f55d7fff10..2b7776190de3 100644
--- a/Documentation/hwmon/w83l786ng
+++ b/Documentation/hwmon/w83l786ng
@@ -1,10 +1,14 @@
 Kernel driver w83l786ng
-=====================
+=======================
 
 Supported chips:
+
   * Winbond W83L786NG/W83L786NR
+
     Prefix: 'w83l786ng'
+
     Addresses scanned: I2C 0x2e - 0x2f
+
     Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83L786NRNG09.pdf
 
 Author: Kevin Lo <kevlo@kevlo.org>
@@ -14,9 +18,10 @@ Module Parameters
 -----------------
 
 * reset boolean
-  (default 0)
-  Use 'reset=1' to reset the chip (via index 0x40, bit 7). The default
-  behavior is no chip reset to preserve BIOS settings
+    (default 0)
+
+    Use 'reset=1' to reset the chip (via index 0x40, bit 7). The default
+    behavior is no chip reset to preserve BIOS settings
 
 
 Description
@@ -41,14 +46,21 @@ or maximum limit.
 /sys files
 ----------
 
-pwm[1-2] - this file stores PWM duty cycle or DC value (fan speed) in range:
-	    0 (stop) to 255 (full)
-pwm[1-2]_enable - this file controls mode of fan/temperature control:
-            * 0 Manual Mode
-            * 1 Thermal Cruise
-            * 2 Smart Fan II
-            * 4 FAN_SET
-pwm[1-2]_mode - Select PWM of DC mode
-            * 0 DC
-            * 1 PWM
-tolerance[1-2] - Value in degrees of Celsius (degC) for +- T
+pwm[1-2]
+	    - this file stores PWM duty cycle or DC value (fan speed) in range:
+
+	      0 (stop) to 255 (full)
+pwm[1-2]_enable
+	    - this file controls mode of fan/temperature control:
+
+	    * 0 Manual Mode
+	    * 1 Thermal Cruise
+	    * 2 Smart Fan II
+	    * 4 FAN_SET
+pwm[1-2]_mode
+	    - Select PWM of DC mode
+
+	    * 0 DC
+	    * 1 PWM
+tolerance[1-2]
+	    - Value in degrees of Celsius (degC) for +- T
diff --git a/Documentation/hwmon/xgene-hwmon b/Documentation/hwmon/xgene-hwmon
index 6ec50ed7cc8f..439b30b881b6 100644
--- a/Documentation/hwmon/xgene-hwmon
+++ b/Documentation/hwmon/xgene-hwmon
@@ -1,7 +1,8 @@
 Kernel driver xgene-hwmon
-========================
+=========================
 
 Supported chips:
+
  * APM X-Gene SoC
 
 Description
@@ -15,16 +16,21 @@ For ACPI, it is the PCC mailbox.
 The following sensors are supported
 
   * Temperature
-    - SoC on-die temperature in milli-degree C
-    - Alarm when high/over temperature occurs
+      - SoC on-die temperature in milli-degree C
+      - Alarm when high/over temperature occurs
+
   * Power
-    - CPU power in uW
-    - IO power in uW
+      - CPU power in uW
+      - IO power in uW
 
 sysfs-Interface
 ---------------
 
-temp0_input - SoC on-die temperature (milli-degree C)
-temp0_critical_alarm - An 1 would indicates on-die temperature exceeded threshold
-power0_input - CPU power in (uW)
-power1_input - IO power in (uW)
+temp0_input
+	- SoC on-die temperature (milli-degree C)
+temp0_critical_alarm
+	- An 1 would indicates on-die temperature exceeded threshold
+power0_input
+	- CPU power in (uW)
+power1_input
+	- IO power in (uW)
-- 
2.20.1

