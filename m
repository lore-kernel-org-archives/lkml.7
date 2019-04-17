Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF03C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8662173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494467;
	bh=9c24dSyO9Q21DG4ptyac73kxHymTOwXbn68HtQlORTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYQyP2lSbWewSy56Eeq5jafRKkoKWvg7rPPy5f6kPop7P1rAvY0sIs1wSCloD6ysB
	 IF/t1K5gJTJikHIZlRcj0fJpOREVhjwWzqnalB/SUWXLH1jL7MJEYLtaAwlGoPETb/
	 QrGGVFfyr3DjQOrQ6xYiCgsIOSYoX30gFpdgmz4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfDQJrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:47:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbfDQJqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yr6flntSohMfDY8JmTkJqWByC2k/5EEKrm+kjxu+UOk=; b=CLyHBzlxpSpgBRQgDQMosY4cMT
        E6Qm6CWKhuVcLZspob1t2E6iYktAS0rw38vbZISLlnTvQeo63r2L2dCYvrHJT1zJuOVpE9ZzM3zwQ
        erc6QZCvGk+MQG308Cs6PfAp6Mxh0fDFxOHi7aj7bwcanKgdb6oQ1ttPyAMY0A+D8Ob06ylmd4Vwh
        AUAiIIGyHSfLhC63m05UOz5JRQuqK7bqIV47PE8ydUfy+DOOxv7EWrxJlKro3Zro5Q3cZVFAQRhvc
        FdediaVz36Sq3VAKco40bY6qNCiCrUOrRrOJENyNdIixNd+i0TsUcqS8DW2wR5zA1t7/EpfeCSMRf
        8IPF4EPg==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9K-0000aL-Au; Wed, 17 Apr 2019 09:46:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9D-0003vP-77; Wed, 17 Apr 2019 06:46:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 17/21] docs: hwmon: k8temp, w83793: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:25 -0300
Message-Id: <84e5c302b2254138de560781b47ab50d835f78bf.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert k8temp and w83793 to ReST format, in order to allow them
to be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/k8temp |  17 +++--
 Documentation/hwmon/w83793 | 123 ++++++++++++++++++++-----------------
 2 files changed, 77 insertions(+), 63 deletions(-)

diff --git a/Documentation/hwmon/k8temp b/Documentation/hwmon/k8temp
index 716dc24c7237..72da12aa17e5 100644
--- a/Documentation/hwmon/k8temp
+++ b/Documentation/hwmon/k8temp
@@ -2,12 +2,17 @@ Kernel driver k8temp
 ====================
 
 Supported chips:
+
   * AMD Athlon64/FX or Opteron CPUs
+
     Prefix: 'k8temp'
+
     Addresses scanned: PCI space
+
     Datasheet: http://support.amd.com/us/Processor_TechDocs/32559.pdf
 
 Author: Rudolf Marek
+
 Contact: Rudolf Marek <r.marek@assembler.cz>
 
 Description
@@ -27,10 +32,12 @@ implemented sensors.
 
 Mapping of /sys files is as follows:
 
-temp1_input - temperature of Core 0 and "place" 0
-temp2_input - temperature of Core 0 and "place" 1
-temp3_input - temperature of Core 1 and "place" 0
-temp4_input - temperature of Core 1 and "place" 1
+============= ===================================
+temp1_input   temperature of Core 0 and "place" 0
+temp2_input   temperature of Core 0 and "place" 1
+temp3_input   temperature of Core 1 and "place" 0
+temp4_input   temperature of Core 1 and "place" 1
+============= ===================================
 
 Temperatures are measured in degrees Celsius and measurement resolution is
 1 degree C. It is expected that future CPU will have better resolution. The
@@ -48,7 +55,7 @@ computed temperature called TControl, which must be lower than TControlMax.
 
 The relationship is following:
 
-temp1_input - TjOffset*2 < TControlMax,
+	temp1_input - TjOffset*2 < TControlMax,
 
 TjOffset is not yet exported by the driver, TControlMax is usually
 70 degrees C. The rule of the thumb -> CPU temperature should not cross
diff --git a/Documentation/hwmon/w83793 b/Documentation/hwmon/w83793
index 6cc5f639b721..83bb40c48645 100644
--- a/Documentation/hwmon/w83793
+++ b/Documentation/hwmon/w83793
@@ -2,29 +2,34 @@ Kernel driver w83793
 ====================
 
 Supported chips:
+
   * Winbond W83793G/W83793R
+
     Prefix: 'w83793'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: Still not published
 
 Authors:
-    Yuan Mu (Winbond Electronics)
-    Rudolf Marek <r.marek@assembler.cz>
+    - Yuan Mu (Winbond Electronics)
+    - Rudolf Marek <r.marek@assembler.cz>
 
 
 Module parameters
 -----------------
 
 * reset int
-  (default 0)
-  This parameter is not recommended, it will lose motherboard specific
-  settings. Use 'reset=1' to reset the chip when loading this module.
+    (default 0)
+
+    This parameter is not recommended, it will lose motherboard specific
+    settings. Use 'reset=1' to reset the chip when loading this module.
 
 * force_subclients=bus,caddr,saddr1,saddr2
-  This is used to force the i2c addresses for subclients of
-  a certain chip. Typical usage is `force_subclients=0,0x2f,0x4a,0x4b'
-  to force the subclients of chip 0x2f on bus 0 to i2c addresses
-  0x4a and 0x4b.
+    This is used to force the i2c addresses for subclients of
+    a certain chip. Typical usage is `force_subclients=0,0x2f,0x4a,0x4b`
+    to force the subclients of chip 0x2f on bus 0 to i2c addresses
+    0x4a and 0x4b.
 
 
 Description
@@ -33,70 +38,72 @@ Description
 This driver implements support for Winbond W83793G/W83793R chips.
 
 * Exported features
-  This driver exports 10 voltage sensors, up to 12 fan tachometer inputs,
-  6 remote temperatures, up to 8 sets of PWM fan controls, SmartFan
-  (automatic fan speed control) on all temperature/PWM combinations, 2
-  sets of 6-pin CPU VID input.
+    This driver exports 10 voltage sensors, up to 12 fan tachometer inputs,
+    6 remote temperatures, up to 8 sets of PWM fan controls, SmartFan
+    (automatic fan speed control) on all temperature/PWM combinations, 2
+    sets of 6-pin CPU VID input.
 
 * Sensor resolutions
-  If your motherboard maker used the reference design, the resolution of
-  voltage0-2 is 2mV, resolution of voltage3/4/5 is 16mV, 8mV for voltage6,
-  24mV for voltage7/8. Temp1-4 have a 0.25 degree Celsius resolution,
-  temp5-6 have a 1 degree Celsiis resolution.
+    If your motherboard maker used the reference design, the resolution of
+    voltage0-2 is 2mV, resolution of voltage3/4/5 is 16mV, 8mV for voltage6,
+    24mV for voltage7/8. Temp1-4 have a 0.25 degree Celsius resolution,
+    temp5-6 have a 1 degree Celsiis resolution.
 
 * Temperature sensor types
-  Temp1-4 have 2 possible types. It can be read from (and written to)
-  temp[1-4]_type.
-  - If the value is 3, it starts monitoring using a remote termal diode
-    (default).
-  - If the value is 6, it starts monitoring using the temperature sensor
-    in Intel CPU and get result by PECI.
-  Temp5-6 can be connected to external thermistors (value of
-  temp[5-6]_type is 4).
+    Temp1-4 have 2 possible types. It can be read from (and written to)
+    temp[1-4]_type.
+
+    - If the value is 3, it starts monitoring using a remote termal diode
+      (default).
+    - If the value is 6, it starts monitoring using the temperature sensor
+      in Intel CPU and get result by PECI.
+
+    Temp5-6 can be connected to external thermistors (value of
+    temp[5-6]_type is 4).
 
 * Alarm mechanism
-  For voltage sensors, an alarm triggers if the measured value is below
-  the low voltage limit or over the high voltage limit.
-  For temperature sensors, an alarm triggers if the measured value goes
-  above the high temperature limit, and wears off only after the measured
-  value drops below the hysteresis value.
-  For fan sensors, an alarm triggers if the measured value is below the
-  low speed limit.
+    For voltage sensors, an alarm triggers if the measured value is below
+    the low voltage limit or over the high voltage limit.
+    For temperature sensors, an alarm triggers if the measured value goes
+    above the high temperature limit, and wears off only after the measured
+    value drops below the hysteresis value.
+    For fan sensors, an alarm triggers if the measured value is below the
+    low speed limit.
 
 * SmartFan/PWM control
-  If you want to set a pwm fan to manual mode, you just need to make sure it
-  is not controlled by any temp channel, for example, you want to set fan1
-  to manual mode, you need to check the value of temp[1-6]_fan_map, make
-  sure bit 0 is cleared in the 6 values. And then set the pwm1 value to
-  control the fan.
+    If you want to set a pwm fan to manual mode, you just need to make sure it
+    is not controlled by any temp channel, for example, you want to set fan1
+    to manual mode, you need to check the value of temp[1-6]_fan_map, make
+    sure bit 0 is cleared in the 6 values. And then set the pwm1 value to
+    control the fan.
 
-  Each temperature channel can control all the 8 PWM outputs (by setting the
-  corresponding bit in tempX_fan_map), you can set the temperature channel
-  mode using temp[1-6]_pwm_enable, 2 is Thermal Cruise mode and 3
-  is the SmartFanII mode. Temperature channels will try to speed up or
-  slow down all controlled fans, this means one fan can receive different
-  PWM value requests from different temperature channels, but the chip
-  will always pick the safest (max) PWM value for each fan.
+    Each temperature channel can control all the 8 PWM outputs (by setting the
+    corresponding bit in tempX_fan_map), you can set the temperature channel
+    mode using temp[1-6]_pwm_enable, 2 is Thermal Cruise mode and 3
+    is the SmartFanII mode. Temperature channels will try to speed up or
+    slow down all controlled fans, this means one fan can receive different
+    PWM value requests from different temperature channels, but the chip
+    will always pick the safest (max) PWM value for each fan.
 
-  In Thermal Cruise mode, the chip attempts to keep the temperature at a
-  predefined value, within a tolerance margin. So if tempX_input >
-  thermal_cruiseX + toleranceX, the chip will increase the PWM value,
-  if tempX_input < thermal_cruiseX - toleranceX, the chip will decrease
-  the PWM value. If the temperature is within the tolerance range, the PWM
-  value is left unchanged.
+    In Thermal Cruise mode, the chip attempts to keep the temperature at a
+    predefined value, within a tolerance margin. So if tempX_input >
+    thermal_cruiseX + toleranceX, the chip will increase the PWM value,
+    if tempX_input < thermal_cruiseX - toleranceX, the chip will decrease
+    the PWM value. If the temperature is within the tolerance range, the PWM
+    value is left unchanged.
 
-  SmartFanII works differently, you have to define up to 7 PWM, temperature
-  trip points, defining a PWM/temperature curve which the chip will follow.
-  While not fundamentally different from the Thermal Cruise mode, the
-  implementation is quite different, giving you a finer-grained control.
+    SmartFanII works differently, you have to define up to 7 PWM, temperature
+    trip points, defining a PWM/temperature curve which the chip will follow.
+    While not fundamentally different from the Thermal Cruise mode, the
+    implementation is quite different, giving you a finer-grained control.
 
 * Chassis
-  If the case open alarm triggers, it will stay in this state unless cleared
-  by writing 0 to the sysfs file "intrusion0_alarm".
+    If the case open alarm triggers, it will stay in this state unless cleared
+    by writing 0 to the sysfs file "intrusion0_alarm".
 
 * VID and VRM
-  The VRM version is detected automatically, don't modify the it unless you
-  *do* know the cpu VRM version and it's not properly detected.
+    The VRM version is detected automatically, don't modify the it unless you
+    *do* know the cpu VRM version and it's not properly detected.
 
 
 Notes
-- 
2.20.1

