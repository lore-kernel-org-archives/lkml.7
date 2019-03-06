Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6DEC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B2220661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfCFOwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:52:51 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:55693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfCFOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:52:50 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDhQt-1gqqn11fZH-00Akb5; Wed, 06 Mar 2019 15:52:24 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH] drivers: iio: Kconfig: pedantic cleanup
Date:   Wed,  6 Mar 2019 15:52:23 +0100
Message-Id: <1551883943-4930-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:c056N/AxyFNB4r6VkZ1lK/Zk6OdtKsQ998kUAum4rxnBZ6CJQLZ
 eLXmO7Zm1kg5/I24GnBg7cOl894fVlwlhehqfF7RPm68hs5TBGq8fbD52WILtASzkBrv8Ck
 Deul8cQr2tsSg3k2VFQ+nc7Z0AuXoX6b+LGn3+ZfcUSe2H+FcR7gSBWdKIF+Ppng5R4q3tw
 XxUj1jwYqhYsJ7qBEWCWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iyVQsPSZirk=:ObUIFGsGmN2gP1p6j/NRN1
 xQ+UEgYh5pBEomEVuRqp/4QPno9Td05Fkx1PzGexOHBWhv4e2+XpkM4s+2h3d0T/Z5sHUNu6S
 0el5n38v2UUYuMv9DlUvMBsG98mKb6h7JzWyZYoc+PTYn3MhKcZH486twQztJK2CZ0qeAdhuB
 Ux6FdLpNiU9lB4w7h82rJeA71D9+xKUB9tSHrAwvgFgtfiH+K9OQ9bwdzbUIBBkurvsC+wVoc
 izZBM7IPe4y/aZsUdSZvE5YSn6dh4MDFXD83NaOn0+9VklSKfwFTeIh15k/xnNA1bSm+Cet/o
 P2+iSk/wbUuWtnhW562y+D4QsC0zWof5GyUfwHTltBDzaAEH/Vs6v7k+ehecdLPgiu+oyLFmI
 9J8odH07DpH0lQtoT40Nca/JZBaK4ARhY7h/SJNLkylYz9kmGEfIo6LwxVB/0DoRemkcEpdrC
 KiCLx/9D77kLYi4K63FkmIjI6jkyQ5rOB/jBlL/eOfEM3z5CJ3IE1sgVOvuvVCjNis+rPwgjm
 LN1LD+iHfBGLEY8r6ZxM6Wwii44fAB5t0DgKxACbexChBakl7l6HkzHZ7Jvu9oSH+2sDmsfSN
 d0o8w4FGZjj3N0ubJAkrM3PwEA/1vfJCwVLalEX6Bjd9TcxotImDTCdthWoZ4hKCmHPMbKXV3
 56R5iGT7tD0qGWxZnenVVwbotP/sqMu9o8T7ifPENDTMWP3q/Fxl8OGBHeNdCzeUQOPz5f5zJ
 ulZx+jk1KahaSraIPOLF91rqop1Tq5PjZYlfTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/iio/Kconfig                   |  24 +--
 drivers/iio/accel/Kconfig             |  48 +++---
 drivers/iio/adc/Kconfig               |  20 +--
 drivers/iio/chemical/Kconfig          |  12 +-
 drivers/iio/common/ms_sensors/Kconfig |   2 +-
 drivers/iio/humidity/Kconfig          |  20 +--
 drivers/iio/light/Kconfig             | 274 +++++++++++++++++-----------------
 drivers/iio/potentiometer/Kconfig     |  34 ++---
 drivers/iio/temperature/Kconfig       |  16 +-
 9 files changed, 225 insertions(+), 225 deletions(-)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d08aeb4..014006d 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -39,28 +39,28 @@ config IIO_TRIGGER
 	  data now' interrupt.
 
 config IIO_CONSUMERS_PER_TRIGGER
-       int "Maximum number of consumers per trigger"
-       depends on IIO_TRIGGER
-       default "2"
-       help
-	This value controls the maximum number of consumers that a
-	given trigger may handle. Default is 2.
+	int "Maximum number of consumers per trigger"
+	depends on IIO_TRIGGER
+	default "2"
+	help
+	  This value controls the maximum number of consumers that a
+	  given trigger may handle. Default is 2.
 
 config IIO_SW_DEVICE
 	tristate "Enable software IIO device support"
 	select IIO_CONFIGFS
 	help
-	 Provides IIO core support for software devices. A software
-	 device can be created via configfs or directly by a driver
-	 using the API provided.
+	  Provides IIO core support for software devices. A software
+	  device can be created via configfs or directly by a driver
+	  using the API provided.
 
 config IIO_SW_TRIGGER
 	tristate "Enable software triggers support"
 	select IIO_CONFIGFS
 	help
-	 Provides IIO core support for software triggers. A software
-	 trigger can be created via configfs or directly by a driver
-	 using the API provided.
+	  Provides IIO core support for software triggers. A software
+	  trigger can be created via configfs or directly by a driver
+	  using the API provided.
 
 config IIO_TRIGGERED_EVENT
 	tristate
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 898839c..4a1f133 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -6,28 +6,28 @@
 menu "Accelerometers"
 
 config ADIS16201
-        tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
-        depends on SPI
-        select IIO_ADIS_LIB
-        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-        help
-          Say Y here to build support for Analog Devices adis16201 dual-axis
-          digital inclinometer and accelerometer.
+	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say Y here to build support for Analog Devices adis16201 dual-axis
+	  digital inclinometer and accelerometer.
 
-          To compile this driver as a module, say M here: the module will
-          be called adis16201.
+	  To compile this driver as a module, say M here: the module will
+	  be called adis16201.
 
 config ADIS16209
-        tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
-        depends on SPI
-        select IIO_ADIS_LIB
-        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-        help
-          Say Y here to build support for Analog Devices adis16209 dual-axis digital inclinometer
-          and accelerometer.
+	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say Y here to build support for Analog Devices adis16209 dual-axis digital inclinometer
+	  and accelerometer.
 
-          To compile this driver as a module, say M here: the module will be
-          called adis16209.
+	  To compile this driver as a module, say M here: the module will be
+	  called adis16209.
 
 config ADXL345
 	tristate
@@ -100,16 +100,16 @@ config BMA180
 	  module will be called bma180.
 
 config BMA220
-    tristate "Bosch BMA220 3-Axis Accelerometer Driver"
+	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-    help
-      Say yes here to add support for the Bosch BMA220 triaxial
-      acceleration sensor.
+	help
+	  Say yes here to add support for the Bosch BMA220 triaxial
+	  acceleration sensor.
 
-      To compile this driver as a module, choose M here: the
-      module will be called bma220_spi.
+	  To compile this driver as a module, choose M here: the
+	  module will be called bma220_spi.
 
 config BMC150_ACCEL
 	tristate "Bosch BMC150 Accelerometer Driver"
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7a3ca4e..16b8b7e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -347,7 +347,7 @@ config HX711
 
 	  This driver uses two GPIOs, one acts as the clock and controls the
 	  channel selection and gain, the other one is used for the measurement
-          data
+	  data
 
 	  Currently the raw value is read from the chip and delivered.
 	  To get an actual weight one needs to subtract the
@@ -533,17 +533,17 @@ config MCP3911
 	  called mcp3911.
 
 config MEDIATEK_MT6577_AUXADC
-        tristate "MediaTek AUXADC driver"
-        depends on ARCH_MEDIATEK || COMPILE_TEST
-        depends on HAS_IOMEM
-        help
-          Say yes here to enable support for MediaTek mt65xx AUXADC.
+	tristate "MediaTek AUXADC driver"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to enable support for MediaTek mt65xx AUXADC.
 
-          The driver supports immediate mode operation to read from one of sixteen
-          channels (external or internal).
+	  The driver supports immediate mode operation to read from one of sixteen
+	  channels (external or internal).
 
-          This driver can also be built as a module. If so, the module will be
-          called mt6577_auxadc.
+	  This driver can also be built as a module. If so, the module will be
+	  called mt6577_auxadc.
 
 config MEN_Z188_ADC
 	tristate "MEN 16z188 ADC IP Core support"
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index b8e005b..e6ad533 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -12,14 +12,14 @@ config ATLAS_PH_SENSOR
 	select IIO_TRIGGERED_BUFFER
 	select IRQ_WORK
 	help
-	 Say Y here to build I2C interface support for the following
-	 Atlas Scientific OEM SM sensors:
+	  Say Y here to build I2C interface support for the following
+	  Atlas Scientific OEM SM sensors:
 	    * pH SM sensor
 	    * EC SM sensor
 	    * ORP SM sensor
 
-	 To compile this driver as module, choose M here: the
-	 module will be called atlas-ph-sensor.
+	  To compile this driver as module, choose M here: the
+	  module will be called atlas-ph-sensor.
 
 config BME680
 	tristate "Bosch Sensortec BME680 sensor driver"
@@ -47,8 +47,8 @@ config BME680_SPI
 config CCS811
 	tristate "AMS CCS811 VOC sensor"
 	depends on I2C
-    select IIO_BUFFER
-    select IIO_TRIGGERED_BUFFER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to build I2C interface support for the AMS
 	  CCS811 VOC (Volatile Organic Compounds) sensor
diff --git a/drivers/iio/common/ms_sensors/Kconfig b/drivers/iio/common/ms_sensors/Kconfig
index b28a92b..89398d0 100644
--- a/drivers/iio/common/ms_sensors/Kconfig
+++ b/drivers/iio/common/ms_sensors/Kconfig
@@ -3,4 +3,4 @@
 #
 
 config IIO_MS_SENSORS_I2C
-        tristate
+	tristate
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 1a0d458..f1a8ec9 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -4,16 +4,16 @@
 menu "Humidity sensors"
 
 config AM2315
-    tristate "Aosong AM2315 relative humidity and temperature sensor"
-    depends on I2C
-    select IIO_BUFFER
-    select IIO_TRIGGERED_BUFFER
-    help
-      If you say yes here you get support for the Aosong AM2315
-      relative humidity and ambient temperature sensor.
+	tristate "Aosong AM2315 relative humidity and temperature sensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for the Aosong AM2315
+	  relative humidity and ambient temperature sensor.
 
-      This driver can also be built as a module. If so, the module will
-      be called am2315.
+	  This driver can also be built as a module. If so, the module will
+	  be called am2315.
 
 config DHT11
 	tristate "DHT11 (and compatible sensors) driver"
@@ -78,7 +78,7 @@ config HTS221_SPI
 config HTU21
 	tristate "Measurement Specialties HTU21 humidity & temperature sensor"
 	depends on I2C
-        select IIO_MS_SENSORS_I2C
+	select IIO_MS_SENSORS_I2C
 	help
 	  If you say yes here you get support for the Measurement Specialties
 	  HTU21 humidity and temperature sensor.
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 36f4584..a378ec7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -13,11 +13,11 @@ config ACPI_ALS
 	select IIO_TRIGGERED_BUFFER
 	select IIO_KFIFO_BUF
 	help
-	 Say Y here if you want to build a driver for the ACPI0008
-	 Ambient Light Sensor.
+	  Say Y here if you want to build a driver for the ACPI0008
+	  Ambient Light Sensor.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called acpi-als.
+	  To compile this driver as a module, choose M here: the module will
+	  be called acpi-als.
 
 config ADJD_S311
 	tristate "ADJD-S311-CR999 digital color sensor"
@@ -25,31 +25,31 @@ config ADJD_S311
 	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
-	 If you say yes here you get support for the Avago ADJD-S311-CR999
-	 digital color light sensor.
+	  If you say yes here you get support for the Avago ADJD-S311-CR999
+	  digital color light sensor.
 
-	 This driver can also be built as a module.  If so, the module
-	 will be called adjd_s311.
+	  This driver can also be built as a module.  If so, the module
+	  will be called adjd_s311.
 
 config AL3320A
 	tristate "AL3320A ambient light sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the Dyna Image AL3320A
-	 ambient light sensor.
+	  Say Y here if you want to build a driver for the Dyna Image AL3320A
+	  ambient light sensor.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called al3320a.
+	  To compile this driver as a module, choose M here: the
+	  module will be called al3320a.
 
 config APDS9300
 	tristate "APDS9300 ambient light sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the Avago APDS9300
-	 ambient light sensor.
+	  Say Y here if you want to build a driver for the Avago APDS9300
+	  ambient light sensor.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called apds9300.
+	  To compile this driver as a module, choose M here: the
+	  module will be called apds9300.
 
 config APDS9960
 	tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
@@ -68,74 +68,74 @@ config BH1750
 	tristate "ROHM BH1750 ambient light sensor"
 	depends on I2C
 	help
-	 Say Y here to build support for the ROHM BH1710, BH1715, BH1721,
-	 BH1750, BH1751 ambient light sensors.
+	  Say Y here to build support for the ROHM BH1710, BH1715, BH1721,
+	  BH1750, BH1751 ambient light sensors.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called bh1750.
+	  To compile this driver as a module, choose M here: the module will
+	  be called bh1750.
 
 config BH1780
 	tristate "ROHM BH1780 ambient light sensor"
 	depends on I2C
 	help
-	 Say Y here to build support for the ROHM BH1780GLI ambient
-	 light sensor.
+	  Say Y here to build support for the ROHM BH1780GLI ambient
+	  light sensor.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called bh1780.
+	  To compile this driver as a module, choose M here: the module will
+	  be called bh1780.
 
 config CM32181
 	depends on I2C
 	tristate "CM32181 driver"
 	help
-	 Say Y here if you use cm32181.
-	 This option enables ambient light sensor using
-	 Capella cm32181 device driver.
+	  Say Y here if you use cm32181.
+	  This option enables ambient light sensor using
+	  Capella cm32181 device driver.
 
-	 To compile this driver as a module, choose M here:
-	 the module will be called cm32181.
+	  To compile this driver as a module, choose M here:
+	  the module will be called cm32181.
 
 config CM3232
 	depends on I2C
 	tristate "CM3232 ambient light sensor"
 	help
-	 Say Y here if you use cm3232.
-	 This option enables ambient light sensor using
-	 Capella Microsystems cm3232 device driver.
+	  Say Y here if you use cm3232.
+	  This option enables ambient light sensor using
+	  Capella Microsystems cm3232 device driver.
 
-	 To compile this driver as a module, choose M here:
-	 the module will be called cm3232.
+	  To compile this driver as a module, choose M here:
+	  the module will be called cm3232.
 
 config CM3323
 	depends on I2C
 	tristate "Capella CM3323 color light sensor"
 	help
-	 Say Y here if you want to build a driver for Capella CM3323
-	 color sensor.
+	  Say Y here if you want to build a driver for Capella CM3323
+	  color sensor.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called cm3323.
+	  To compile this driver as a module, choose M here: the module will
+	  be called cm3323.
 
 config CM3605
 	tristate "Capella CM3605 ambient light and proximity sensor"
 	depends on OF
 	help
-	 Say Y here if you want to build a driver for Capella CM3605
-	 ambient light and short range proximity sensor.
+	  Say Y here if you want to build a driver for Capella CM3605
+	  ambient light and short range proximity sensor.
 
-	 To compile this driver as a module, choose M here: the module will
-	 be called cm3605.
+	  To compile this driver as a module, choose M here: the module will
+	  be called cm3605.
 
 config CM36651
 	depends on I2C
 	tristate "CM36651 driver"
 	help
-	 Say Y here if you use cm36651.
-	 This option enables proximity & RGB sensor using
-	 Capella cm36651 device driver.
+	  Say Y here if you use cm36651.
+	  This option enables proximity & RGB sensor using
+	  Capella cm36651 device driver.
 
-	 To compile this driver as a module, choose M here:
-	 the module will be called cm36651.
+	  To compile this driver as a module, choose M here:
+	  the module will be called cm36651.
 
 config IIO_CROS_EC_LIGHT_PROX
 	tristate "ChromeOS EC Light and Proximity Sensors"
@@ -167,21 +167,21 @@ config SENSORS_ISL29018
 	select REGMAP_I2C
 	default n
 	help
-	 If you say yes here you get support for ambient light sensing and
-	 proximity infrared sensing from Intersil ISL29018.
-	 This driver will provide the measurements of ambient light intensity
-	 in lux, proximity infrared sensing and normal infrared sensing.
-	 Data from sensor is accessible via sysfs.
+	  If you say yes here you get support for ambient light sensing and
+	  proximity infrared sensing from Intersil ISL29018.
+	  This driver will provide the measurements of ambient light intensity
+	  in lux, proximity infrared sensing and normal infrared sensing.
+	  Data from sensor is accessible via sysfs.
 
 config SENSORS_ISL29028
 	tristate "Intersil ISL29028 Concurrent Light and Proximity Sensor"
 	depends on I2C
 	select REGMAP_I2C
 	help
-	 Provides driver for the Intersil's ISL29028 device.
-	 This driver supports the sysfs interface to get the ALS, IR intensity,
-	 Proximity value via iio. The ISL29028 provides the concurrent sensing
-	 of ambient light and proximity.
+	  Provides driver for the Intersil's ISL29028 device.
+	  This driver supports the sysfs interface to get the ALS, IR intensity,
+	  Proximity value via iio. The ISL29028 provides the concurrent sensing
+	  of ambient light and proximity.
 
 config ISL29125
 	tristate "Intersil ISL29125 digital color light sensor"
@@ -228,22 +228,22 @@ config JSA1212
 	depends on I2C
 	select REGMAP_I2C
 	help
-	 Say Y here if you want to build a IIO driver for JSA1212
-	 proximity & ALS sensor device.
+	  Say Y here if you want to build a IIO driver for JSA1212
+	  proximity & ALS sensor device.
 
-	 To compile this driver as a module, choose M here:
-	 the module will be called jsa1212.
+	  To compile this driver as a module, choose M here:
+	  the module will be called jsa1212.
 
 config RPR0521
 	tristate "ROHM RPR0521 ALS and proximity sensor driver"
 	depends on I2C
 	select REGMAP_I2C
 	help
-	 Say Y here if you want to build support for ROHM's RPR0521
-	 ambient light and proximity sensor device.
+	  Say Y here if you want to build support for ROHM's RPR0521
+	  ambient light and proximity sensor device.
 
-	 To compile this driver as a module, choose M here:
-	 the module will be called rpr0521.
+	  To compile this driver as a module, choose M here:
+	  the module will be called rpr0521.
 
 config SENSORS_LM3533
 	tristate "LM3533 ambient light sensor"
@@ -269,22 +269,22 @@ config LTR501
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	 If you say yes here you get support for the Lite-On LTR-501ALS-01
-	 ambient light and proximity sensor. This driver also supports LTR-559
-	 ALS/PS or LTR-301 ALS sensors.
+	  If you say yes here you get support for the Lite-On LTR-501ALS-01
+	  ambient light and proximity sensor. This driver also supports LTR-559
+	  ALS/PS or LTR-301 ALS sensors.
 
-	 This driver can also be built as a module.  If so, the module
-         will be called ltr501.
+	  This driver can also be built as a module.  If so, the module
+	  will be called ltr501.
 
 config LV0104CS
 	tristate "LV0104CS Ambient Light Sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build support for the On Semiconductor
-	 LV0104CS ambient light sensor.
+	  Say Y here if you want to build support for the On Semiconductor
+	  LV0104CS ambient light sensor.
 
-	 To compile this driver as a module, choose M here:
-	 the module will be called lv0104cs.
+	  To compile this driver as a module, choose M here:
+	  the module will be called lv0104cs.
 
 config MAX44000
 	tristate "MAX44000 Ambient and Infrared Proximity Sensor"
@@ -293,11 +293,11 @@ config MAX44000
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	 Say Y here if you want to build support for Maxim Integrated's
-	 MAX44000 ambient and infrared proximity sensor device.
+	  Say Y here if you want to build support for Maxim Integrated's
+	  MAX44000 ambient and infrared proximity sensor device.
 
-	 To compile this driver as a module, choose M here:
-	 the module will be called max44000.
+	  To compile this driver as a module, choose M here:
+	  the module will be called max44000.
 
 config OPT3001
 	tristate "Texas Instruments OPT3001 Light Sensor"
@@ -310,15 +310,15 @@ config OPT3001
 	  opt3001.
 
 config PA12203001
-        tristate "TXC PA12203001 light and proximity sensor"
-        depends on I2C
-        select REGMAP_I2C
-        help
-         If you say yes here you get support for the TXC PA12203001
-         ambient light and proximity sensor.
+	tristate "TXC PA12203001 light and proximity sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the TXC PA12203001
+	  ambient light and proximity sensor.
 
-         This driver can also be built as a module.  If so, the module
-         will be called pa12203001.
+	  This driver can also be built as a module.  If so, the module
+	  will be called pa12203001.
 
 config SI1133
 	tristate "SI1133 UV Index Sensor and Ambient Light Sensor"
@@ -349,12 +349,12 @@ config STK3310
 	depends on I2C
 	select REGMAP_I2C
 	help
-	 Say yes here to get support for the Sensortek STK3310 ambient light
-	 and proximity sensor. The STK3311 model is also supported by this
-	 driver.
+	  Say yes here to get support for the Sensortek STK3310 ambient light
+	  and proximity sensor. The STK3311 model is also supported by this
+	  driver.
 
-	 Choosing M will build the driver as a module. If so, the module
-	 will be called stk3310.
+	  Choosing M will build the driver as a module. If so, the module
+	  will be called stk3310.
 
 config ST_UVIS25
 	tristate "STMicroelectronics UVIS25 sensor driver"
@@ -386,11 +386,11 @@ config TCS3414
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	 If you say yes here you get support for the TAOS TCS3414
-	 family of digital color sensors.
+	  If you say yes here you get support for the TAOS TCS3414
+	  family of digital color sensors.
 
-	 This driver can also be built as a module.  If so, the module
-	 will be called tcs3414.
+	  This driver can also be built as a module.  If so, the module
+	  will be called tcs3414.
 
 config TCS3472
 	tristate "TAOS TCS3472 color light-to-digital converter"
@@ -398,67 +398,67 @@ config TCS3472
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	 If you say yes here you get support for the TAOS TCS3472
-	 family of color light-to-digital converters with IR filter.
+	  If you say yes here you get support for the TAOS TCS3472
+	  family of color light-to-digital converters with IR filter.
 
-	 This driver can also be built as a module.  If so, the module
-	 will be called tcs3472.
+	  This driver can also be built as a module.  If so, the module
+	  will be called tcs3472.
 
 config SENSORS_TSL2563
 	tristate "TAOS TSL2560, TSL2561, TSL2562 and TSL2563 ambient light sensors"
 	depends on I2C
 	help
-	 If you say yes here you get support for the Taos TSL2560,
-	 TSL2561, TSL2562 and TSL2563 ambient light sensors.
+	  If you say yes here you get support for the Taos TSL2560,
+	  TSL2561, TSL2562 and TSL2563 ambient light sensors.
 
-	 This driver can also be built as a module.  If so, the module
-	 will be called tsl2563.
+	  This driver can also be built as a module.  If so, the module
+	  will be called tsl2563.
 
 config TSL2583
 	tristate "TAOS TSL2580, TSL2581 and TSL2583 light-to-digital converters"
 	depends on I2C
 	help
-	 Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
-	 Access ALS data via iio, sysfs.
+	  Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
+	  Access ALS data via iio, sysfs.
 
 config TSL2772
 	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
 	depends on I2C
 	help
-	 Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
-	 tmd2672, tsl2772, tmd2772 devices.
-	 Provides iio_events and direct access via sysfs.
+	  Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
+	  tmd2672, tsl2772, tmd2772 devices.
+	  Provides iio_events and direct access via sysfs.
 
 config TSL4531
 	tristate "TAOS TSL4531 ambient light sensors"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the TAOS TSL4531 family
-	 of ambient light sensors with direct lux output.
+	  Say Y here if you want to build a driver for the TAOS TSL4531 family
+	  of ambient light sensors with direct lux output.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called tsl4531.
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsl4531.
 
 config US5182D
 	tristate "UPISEMI light and proximity sensor"
 	depends on I2C
 	help
-	 If you say yes here you get support for the UPISEMI US5182D
-	 ambient light and proximity sensor.
+	  If you say yes here you get support for the UPISEMI US5182D
+	  ambient light and proximity sensor.
 
-	 This driver can also be built as a module.  If so, the module
-	 will be called us5182d.
+	  This driver can also be built as a module.  If so, the module
+	  will be called us5182d.
 
 config VCNL4000
 	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the Vishay VCNL4000,
-	 VCNL4010, VCNL4020, VCNL4200 combined ambient light and proximity
-	 sensor.
+	  Say Y here if you want to build a driver for the Vishay VCNL4000,
+	  VCNL4010, VCNL4020, VCNL4200 combined ambient light and proximity
+	  sensor.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called vcnl4000.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vcnl4000.
 
 config VCNL4035
 	tristate "VCNL4035 combined ALS and proximity sensor"
@@ -466,41 +466,41 @@ config VCNL4035
 	select REGMAP_I2C
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the Vishay VCNL4035,
-	 combined ambient light (ALS) and proximity sensor. Currently only ALS
-	 function is available.
+	  Say Y here if you want to build a driver for the Vishay VCNL4035,
+	  combined ambient light (ALS) and proximity sensor. Currently only ALS
+	  function is available.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called vcnl4035.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vcnl4035.
 
 config VEML6070
 	tristate "VEML6070 UV A light sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the Vishay VEML6070 UV A
-	 light sensor.
+	  Say Y here if you want to build a driver for the Vishay VEML6070 UV A
+	  light sensor.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called veml6070.
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml6070.
 
 config VL6180
 	tristate "VL6180 ALS, range and proximity sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the STMicroelectronics
-	 VL6180 combined ambient light, range and proximity sensor.
+	  Say Y here if you want to build a driver for the STMicroelectronics
+	  VL6180 combined ambient light, range and proximity sensor.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called vl6180.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vl6180.
 
 config ZOPT2201
 	tristate "ZOPT2201 ALS and UV B sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the IDT
-	 ZOPT2201 ambient light and UV B sensor.
+	  Say Y here if you want to build a driver for the IDT
+	  ZOPT2201 ambient light and UV B sensor.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called zopt2201.
+	  To compile this driver as a module, choose M here: the
+	  module will be called zopt2201.
 
 endmenu
diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 6303cbe..a81a3a1 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -26,26 +26,26 @@ config DS1803
 	  module will be called ds1803.
 
 config MAX5481
-        tristate "Maxim MAX5481-MAX5484 Digital Potentiometer driver"
-        depends on SPI
-        help
-          Say yes here to build support for the Maxim
-          MAX5481, MAX5482, MAX5483, MAX5484 digital potentiometer
-          chips.
+	tristate "Maxim MAX5481-MAX5484 Digital Potentiometer driver"
+	depends on SPI
+	help
+	  Say yes here to build support for the Maxim
+	  MAX5481, MAX5482, MAX5483, MAX5484 digital potentiometer
+	  chips.
 
-          To compile this driver as a module, choose M here: the
-          module will be called max5481.
+	  To compile this driver as a module, choose M here: the
+	  module will be called max5481.
 
 config MAX5487
-        tristate "Maxim MAX5487/MAX5488/MAX5489 Digital Potentiometer driver"
-        depends on SPI
-        help
-          Say yes here to build support for the Maxim
-          MAX5487, MAX5488, MAX5489 digital potentiometer
-          chips.
-
-          To compile this driver as a module, choose M here: the
-          module will be called max5487.
+	tristate "Maxim MAX5487/MAX5488/MAX5489 Digital Potentiometer driver"
+	depends on SPI
+	help
+	  Say yes here to build support for the Maxim
+	  MAX5487, MAX5488, MAX5489 digital potentiometer
+	  chips.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called max5487.
 
 config MCP4018
 	tristate "Microchip MCP4017/18/19 Digital Potentiometer driver"
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 82e4a62..7f0b826 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -66,14 +66,14 @@ config TMP006
 	  be called tmp006.
 
 config TMP007
-        tristate "TMP007 infrared thermopile sensor with Integrated Math Engine"
-        depends on I2C
-        help
-          If you say yes here you get support for the Texas Instruments
-          TMP007 infrared thermopile sensor with Integrated Math Engine.
-
-          This driver can also be built as a module. If so, the module will
-          be called tmp007.
+	tristate "TMP007 infrared thermopile sensor with Integrated Math Engine"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Texas Instruments
+	  TMP007 infrared thermopile sensor with Integrated Math Engine.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called tmp007.
 
 config TSYS01
 	tristate "Measurement Specialties TSYS01 temperature sensor using I2C bus connection"
-- 
1.9.1

