Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E20C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816532177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494491;
	bh=1U2I5teJAEx9IZWzEH+9h/v5AiZokRYuZGEKxs3ho78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DA72mPJ4GLSPYQne53zfpVN7SbfkfrrskXuokaRR5qTS4NbbjIz5cGg8n2H3a4094
	 RiiZ0gkVSle4WfCPLm/D/8FkjMXNCbrtUBujY2NLF14XzMvRaKCdoYmyQ1/ayZo9G+
	 kfi81b74KgltiAZJW3Z/E+zA5wGbGePYFy6Z9oOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfDQJsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:48:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbfDQJqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ulutPdeq76TIAwFutCNSAnXWKpsBCVZyfKMBQDg50Ww=; b=LUHi1/3No//Nnj3kxiHaAmkoUI
        Zot0+K5/oDYj+LkGevhlydv8lqLIfVI4Tv/DOsbCO9JX62UdQbMwMP1nWK7vownFqGXDiQaBycGEj
        0usrR16Xx4ljliGCA3Y4nKEcAyohY/ctbNaAg4tzMDUibD2cGSjQ/RBybbn+niI3WONudnCD2bKqw
        xChbeZSsn4BWZaQPusCDaSpMbuZdL/gqnEw1su5hry0ejdFJ8YvXbZxBF7XVgPXifGwbSZv9tnvh3
        +2sBxN2pC3rp6LPk6XTpJVjo4uy+KL5STRy5ojW0c5JWiEuPzwbS3FDhl1B9rOM9d4Sg0BWZaRGUg
        DomcsnAA==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9K-0000aG-7a; Wed, 17 Apr 2019 09:46:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9D-0003vA-4J; Wed, 17 Apr 2019 06:46:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 14/21] docs: hwmon: dme1737, vt1211: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:22 -0300
Message-Id: <c9ee4a598a566e1618b0de31e9f779646bc6a9c3.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert dme1737 and vt1211 to ReST format, in order to allow
them to be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/dme1737 | 88 ++++++++++++++++++++++++++-----------
 Documentation/hwmon/vt1211  | 84 +++++++++++++++++++++--------------
 2 files changed, 114 insertions(+), 58 deletions(-)

diff --git a/Documentation/hwmon/dme1737 b/Documentation/hwmon/dme1737
index 4d2935145a1c..82fcbc6b2b43 100644
--- a/Documentation/hwmon/dme1737
+++ b/Documentation/hwmon/dme1737
@@ -2,21 +2,37 @@ Kernel driver dme1737
 =====================
 
 Supported chips:
+
   * SMSC DME1737 and compatibles (like Asus A8000)
+
     Prefix: 'dme1737'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: Provided by SMSC upon request and under NDA
+
   * SMSC SCH3112, SCH3114, SCH3116
+
     Prefix: 'sch311x'
+
     Addresses scanned: none, address read from Super-I/O config space
+
     Datasheet: Available on the Internet
+
   * SMSC SCH5027
+
     Prefix: 'sch5027'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: Provided by SMSC upon request and under NDA
+
   * SMSC SCH5127
+
     Prefix: 'sch5127'
+
     Addresses scanned: none, address read from Super-I/O config space
+
     Datasheet: Provided by SMSC upon request and under NDA
 
 Authors:
@@ -26,11 +42,14 @@ Authors:
 Module Parameters
 -----------------
 
-* force_start: bool	Enables the monitoring of voltage, fan and temp inputs
+* force_start: bool
+			Enables the monitoring of voltage, fan and temp inputs
 			and PWM output control functions. Using this parameter
 			shouldn't be required since the BIOS usually takes care
 			of this.
-* probe_all_addr: bool	Include non-standard LPC addresses 0x162e and 0x164e
+
+* probe_all_addr: bool
+			Include non-standard LPC addresses 0x162e and 0x164e
 			when probing for ISA devices. This is required for the
 			following boards:
 			- VIA EPIA SN18000
@@ -70,7 +89,8 @@ scaling resistors. The values returned by the driver therefore reflect true
 millivolts and don't need scaling. The voltage inputs are mapped as follows
 (the last column indicates the input ranges):
 
-DME1737, A8000:
+DME1737, A8000::
+
 	in0: +5VTR	(+5V standby)		0V - 6.64V
 	in1: Vccp	(processor core)	0V - 3V
 	in2: VCC	(internal +3.3V)	0V - 4.38V
@@ -79,7 +99,8 @@ DME1737, A8000:
 	in5: VTR	(+3.3V standby)		0V - 4.38V
 	in6: Vbat	(+3.0V)			0V - 4.38V
 
-SCH311x:
+SCH311x::
+
 	in0: +2.5V				0V - 3.32V
 	in1: Vccp	(processor core)	0V - 2V
 	in2: VCC	(internal +3.3V)	0V - 4.38V
@@ -88,7 +109,8 @@ SCH311x:
 	in5: VTR	(+3.3V standby)		0V - 4.38V
 	in6: Vbat	(+3.0V)			0V - 4.38V
 
-SCH5027:
+SCH5027::
+
 	in0: +5VTR	(+5V standby)		0V - 6.64V
 	in1: Vccp	(processor core)	0V - 3V
 	in2: VCC	(internal +3.3V)	0V - 4.38V
@@ -97,7 +119,8 @@ SCH5027:
 	in5: VTR	(+3.3V standby)		0V - 4.38V
 	in6: Vbat	(+3.0V)			0V - 4.38V
 
-SCH5127:
+SCH5127::
+
 	in0: +2.5				0V - 3.32V
 	in1: Vccp	(processor core)	0V - 3V
 	in2: VCC	(internal +3.3V)	0V - 4.38V
@@ -119,7 +142,7 @@ Celsius. The chip also features offsets for all 3 temperature inputs which -
 when programmed - get added to the input readings. The chip does all the
 scaling by itself and the driver therefore reports true temperatures that don't
 need any user-space adjustments. The temperature inputs are mapped as follows
-(the last column indicates the input ranges):
+(the last column indicates the input ranges)::
 
 	temp1: Remote diode 1 (3904 type) temperature	-127C - +127C
 	temp2: DME1737 internal temperature		-127C - +127C
@@ -171,6 +194,7 @@ pwm[1-3]_auto_pwm_min, respectively. The thermal thresholds of the zones are
 programmed via zone[1-3]_auto_point[1-3]_temp and
 zone[1-3]_auto_point1_temp_hyst:
 
+	=============================== =======================================
 	pwm[1-3]_auto_point2_pwm	full-speed duty-cycle (255, i.e., 100%)
 	pwm[1-3]_auto_point1_pwm	low-speed duty-cycle
 	pwm[1-3]_auto_pwm_min		min-speed duty-cycle
@@ -179,6 +203,7 @@ zone[1-3]_auto_point1_temp_hyst:
 	zone[1-3]_auto_point2_temp	full-speed temp
 	zone[1-3]_auto_point1_temp	low-speed temp
 	zone[1-3]_auto_point1_temp_hyst	min-speed temp
+	=============================== =======================================
 
 The chip adjusts the output duty-cycle linearly in the range of auto_point1_pwm
 to auto_point2_pwm if the temperature of the associated zone is between
@@ -192,17 +217,21 @@ all PWM outputs are set to 100% duty-cycle.
 Following is another representation of how the chip sets the output duty-cycle
 based on the temperature of the associated thermal zone:
 
-			Duty-Cycle	Duty-Cycle
-	Temperature	Rising Temp	Falling Temp
-	-----------	-----------	------------
+	=============== =============== =================
+	Temperature	Duty-Cycle	Duty-Cycle
+			Rising Temp	Falling Temp
+	=============== =============== =================
 	full-speed	full-speed	full-speed
 
-			< linearly adjusted duty-cycle >
+	-		< linearly	-
+			adjusted
+			duty-cycle >
 
 	low-speed	low-speed	low-speed
-			min-speed	low-speed
+	-		min-speed	low-speed
 	min-speed	min-speed	min-speed
-			min-speed	min-speed
+	-		min-speed	min-speed
+	=============== =============== =================
 
 
 Sysfs Attributes
@@ -211,8 +240,9 @@ Sysfs Attributes
 Following is a list of all sysfs attributes that the driver provides, their
 permissions and a short description:
 
+=============================== ======= =======================================
 Name				Perm	Description
-----				----	-----------
+=============================== ======= =======================================
 cpu0_vid			RO	CPU core reference voltage in
 					millivolts.
 vrm				RW	Voltage regulator module version
@@ -242,9 +272,10 @@ temp[1-3]_fault			RO	Temp input fault. Returns 1 if the chip
 zone[1-3]_auto_channels_temp	RO	Temperature zone to temperature input
 					mapping. This attribute is a bitfield
 					and supports the following values:
-						1: temp1
-						2: temp2
-						4: temp3
+
+						- 1: temp1
+						- 2: temp2
+						- 4: temp3
 zone[1-3]_auto_point1_temp_hyst	RW	Auto PWM temp point1 hysteresis. The
 					output of the corresponding PWM is set
 					to the pwm_auto_min value if the temp
@@ -275,9 +306,10 @@ pmw[1-3,5-6]			RO/RW	Duty-cycle of PWM output. Supported
 					manual mode.
 pwm[1-3]_enable			RW	Enable of PWM outputs 1-3. Supported
 					values are:
-						 0: turned off (output @ 100%)
-						 1: manual mode
-						 2: automatic mode
+
+						- 0: turned off (output @ 100%)
+						- 1: manual mode
+						- 2: automatic mode
 pwm[5-6]_enable			RO	Enable of PWM outputs 5-6. Always
 					returns 1 since these 2 outputs are
 					hard-wired to manual mode.
@@ -294,11 +326,12 @@ pmw[1-3]_ramp_rate		RW	Ramp rate of PWM output. Determines how
 pwm[1-3]_auto_channels_zone	RW	PWM output to temperature zone mapping.
 					This attribute is a bitfield and
 					supports the following values:
-						1: zone1
-						2: zone2
-						4: zone3
-						6: highest of zone[2-3]
-						7: highest of zone[1-3]
+
+						- 1: zone1
+						- 2: zone2
+						- 4: zone3
+						- 6: highest of zone[2-3]
+						- 7: highest of zone[1-3]
 pwm[1-3]_auto_pwm_min		RW	Auto PWM min pwm. Minimum PWM duty-
 					cycle. Supported values are 0 or
 					auto_point1_pwm.
@@ -307,12 +340,14 @@ pwm[1-3]_auto_point1_pwm	RW	Auto PWM pwm point. Auto_point1 is the
 pwm[1-3]_auto_point2_pwm	RO	Auto PWM pwm point. Auto_point2 is the
 					full-speed duty-cycle which is hard-
 					wired to 255 (100% duty-cycle).
+=============================== ======= =======================================
 
 Chip Differences
 ----------------
 
+======================= ======= ======= ======= =======
 Feature			dme1737	sch311x	sch5027	sch5127
--------------------------------------------------------
+======================= ======= ======= ======= =======
 temp[1-3]_offset	yes	yes
 vid			yes
 zone3			yes	yes	yes
@@ -326,3 +361,4 @@ pwm5			opt		opt
 fan6			opt		opt
 pwm6			opt		opt
 in7						yes
+======================= ======= ======= ======= =======
diff --git a/Documentation/hwmon/vt1211 b/Documentation/hwmon/vt1211
index 77fa633b97a8..ddbcde7dd642 100644
--- a/Documentation/hwmon/vt1211
+++ b/Documentation/hwmon/vt1211
@@ -2,9 +2,13 @@ Kernel driver vt1211
 ====================
 
 Supported chips:
+
   * VIA VT1211
+
     Prefix: 'vt1211'
+
     Addresses scanned: none, address read from Super-I/O config space
+
     Datasheet: Provided by VIA upon request and under NDA
 
 Authors: Juerg Haefliger <juergh@gmail.com>
@@ -19,14 +23,17 @@ technical support.
 Module Parameters
 -----------------
 
-* uch_config: int	Override the BIOS default universal channel (UCH)
+
+* uch_config: int
+			Override the BIOS default universal channel (UCH)
 			configuration for channels 1-5.
 			Legal values are in the range of 0-31. Bit 0 maps to
 			UCH1, bit 1 maps to UCH2 and so on. Setting a bit to 1
 			enables the thermal input of that particular UCH and
 			setting a bit to 0 enables the voltage input.
 
-* int_mode: int		Override the BIOS default temperature interrupt mode.
+* int_mode: int
+			Override the BIOS default temperature interrupt mode.
 			The only possible value is 0 which forces interrupt
 			mode 0. In this mode, any pending interrupt is cleared
 			when the status register is read but is regenerated as
@@ -55,8 +62,9 @@ connected to the PWM outputs of the VT1211 :-().
 The following table shows the relationship between the vt1211 inputs and the
 sysfs nodes.
 
+=============== ============== =========== ================================
 Sensor          Voltage Mode   Temp Mode   Default Use (from the datasheet)
-------          ------------   ---------   --------------------------------
+=============== ============== =========== ================================
 Reading 1                      temp1       Intel thermal diode
 Reading 3                      temp2       Internal thermal diode
 UCH1/Reading2   in0            temp3       NTC type thermistor
@@ -65,6 +73,7 @@ UCH3            in2            temp5       VccP (processor core)
 UCH4            in3            temp6       +5V
 UCH5            in4            temp7       +12V
 +3.3V           in5                        Internal VCC (+3.3V)
+=============== ============== =========== ================================
 
 
 Voltage Monitoring
@@ -82,19 +91,22 @@ follows. And this is of course totally dependent on the actual board
 implementation :-) You will have to find documentation for your own
 motherboard and edit sensors.conf accordingly.
 
-                                      Expected
+============= ====== ====== ========= ============
+				      Expected
 Voltage       R1     R2     Divider   Raw Value
------------------------------------------------
+============= ====== ====== ========= ============
 +2.5V         2K     10K    1.2       2083 mV
-VccP          ---    ---    1.0       1400 mV (1)
+VccP          ---    ---    1.0       1400 mV [1]_
 +5V           14K    10K    2.4       2083 mV
 +12V          47K    10K    5.7       2105 mV
-+3.3V (int)   2K     3.4K   1.588     3300 mV (2)
++3.3V (int)   2K     3.4K   1.588     3300 mV [2]_
 +3.3V (ext)   6.8K   10K    1.68      1964 mV
+============= ====== ====== ========= ============
 
-(1) Depending on the CPU (1.4V is for a VIA C3 Nehemiah).
-(2) R1 and R2 for 3.3V (int) are internal to the VT1211 chip and the driver
-    performs the scaling and returns the properly scaled voltage value.
+.. [1] Depending on the CPU (1.4V is for a VIA C3 Nehemiah).
+
+.. [2] R1 and R2 for 3.3V (int) are internal to the VT1211 chip and the driver
+       performs the scaling and returns the properly scaled voltage value.
 
 Each measured voltage has an associated low and high limit which triggers an
 alarm when crossed.
@@ -124,35 +136,37 @@ compute temp1 (@-Offset)/Gain, (@*Gain)+Offset
 According to the VIA VT1211 BIOS porting guide, the following gain and offset
 values should be used:
 
+=============== ======== ===========
 Diode Type      Offset   Gain
-----------      ------   ----
+=============== ======== ===========
 Intel CPU       88.638   0.9528
-                65.000   0.9686   *)
+		65.000   0.9686 [3]_
 VIA C3 Ezra     83.869   0.9528
 VIA C3 Ezra-T   73.869   0.9528
+=============== ======== ===========
 
-*) This is the formula from the lm_sensors 2.10.0 sensors.conf file. I don't
-know where it comes from or how it was derived, it's just listed here for
-completeness.
+.. [3] This is the formula from the lm_sensors 2.10.0 sensors.conf file. I don't
+       know where it comes from or how it was derived, it's just listed here for
+       completeness.
 
 Temp3-temp7 support NTC thermistors. For these channels, the driver returns
 the voltages as seen at the individual pins of UCH1-UCH5. The voltage at the
 pin (Vpin) is formed by a voltage divider made of the thermistor (Rth) and a
-scaling resistor (Rs):
+scaling resistor (Rs)::
 
-Vpin = 2200 * Rth / (Rs + Rth)   (2200 is the ADC max limit of 2200 mV)
+  Vpin = 2200 * Rth / (Rs + Rth)   (2200 is the ADC max limit of 2200 mV)
 
 The equation for the thermistor is as follows (google it if you want to know
-more about it):
+more about it)::
 
-Rth = Ro * exp(B * (1 / T - 1 / To))   (To is 298.15K (25C) and Ro is the
-                                        nominal resistance at 25C)
+  Rth = Ro * exp(B * (1 / T - 1 / To))   (To is 298.15K (25C) and Ro is the
+					  nominal resistance at 25C)
 
 Mingling the above two equations and assuming Rs = Ro and B = 3435 yields the
-following formula for sensors.conf:
+following formula for sensors.conf::
 
-compute tempx 1 / (1 / 298.15 - (` (2200 / @ - 1)) / 3435) - 273.15,
-              2200 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
+  compute tempx 1 / (1 / 298.15 - (` (2200 / @ - 1)) / 3435) - 273.15,
+		2200 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
 
 
 Fan Speed Control
@@ -176,31 +190,37 @@ registers in the VT1211 and programming one set is sufficient (actually only
 the first set pwm1_auto_point[1-4]_temp is writable, the second set is
 read-only).
 
+========================== =========================================
 PWM Auto Point             PWM Output Duty-Cycle
-------------------------------------------------
+========================== =========================================
 pwm[1-2]_auto_point4_pwm   full speed duty-cycle (hard-wired to 255)
 pwm[1-2]_auto_point3_pwm   high speed duty-cycle
 pwm[1-2]_auto_point2_pwm   low speed duty-cycle
 pwm[1-2]_auto_point1_pwm   off duty-cycle (hard-wired to 0)
+========================== =========================================
 
+==========================  =================
 Temp Auto Point             Thermal Threshold
----------------------------------------------
+==========================  =================
 pwm[1-2]_auto_point4_temp   full speed temp
 pwm[1-2]_auto_point3_temp   high speed temp
 pwm[1-2]_auto_point2_temp   low speed temp
 pwm[1-2]_auto_point1_temp   off temp
+==========================  =================
 
 Long story short, the controller implements the following algorithm to set the
 PWM output duty-cycle based on the input temperature:
 
-Thermal Threshold             Output Duty-Cycle
-                    (Rising Temp)           (Falling Temp)
-----------------------------------------------------------
-                    full speed duty-cycle   full speed duty-cycle
+=================== ======================= ========================
+Thermal Threshold   Output Duty-Cycle       Output Duty-Cycle
+		    (Rising Temp)           (Falling Temp)
+=================== ======================= ========================
+-                   full speed duty-cycle   full speed duty-cycle
 full speed temp
-                    high speed duty-cycle   full speed duty-cycle
+-		    high speed duty-cycle   full speed duty-cycle
 high speed temp
-                    low speed duty-cycle    high speed duty-cycle
+-		    low speed duty-cycle    high speed duty-cycle
 low speed temp
-                    off duty-cycle          low speed duty-cycle
+-		    off duty-cycle          low speed duty-cycle
 off temp
+=================== ======================= ========================
-- 
2.20.1

