Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C86C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317652173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494438;
	bh=sq96jJd2rU5/ZE8lQsc0tfcrqhUYYyPkZklYPOCxieI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ih2S3kiSrzRd187aW0EUsqwoy07nrg2jixh6JBr+bzD8VLzNmYUOG4Z/EWCJuCThE
	 yVyRzQcvezk8ZoQX/YobX6c/grL1DW6wNaeP2h2GOJQNLpfwBw3RCnf/RVdFKN2KEM
	 UjSrVEqfEUBFX7JT9PeXw7ED/1bTorMLbQgxkcfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfDQJrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:47:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbfDQJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2c2mrLgCbp7PZnwNzgZtrnDsXGK2/GMKpO8QwC4Y9Og=; b=mytZi4OKcCQ1/Q4KCNBJNkNyNA
        tGHtw/WCjxBrWDBfl3rs2PDdbvIZoLTQMdqrzrfcnw6pE/FHwkDHoNW/RajIRwYbWAajWNprWrq4m
        2dhgjBTvGScUB+BHqZZ9x2QoH+2M7RQeh2XoYZ5YgfCvNUAqhsnB81qyo+dnSVAU+567jZwyWR/0n
        iO1RiANwbCZ2VkNaXB51wSCgWxi7g85XU+eH6ISe5UK+UX/zCpX6/aaAM5LC/0LW4qwntcqicUhMX
        jOHsDx0SC0YrFmd0HWxUIxT1xrkxsONiDsr/FJbD4MaY1B8Ue1sUcTma5bdI3JwjSoi0Za1gL4Qv3
        zgeg5zJA==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9K-0000aM-C3; Wed, 17 Apr 2019 09:46:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9D-0003vU-83; Wed, 17 Apr 2019 06:46:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 18/21] docs: hwmon: pmbus files: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:26 -0300
Message-Id: <309c061320a1b2b6e2afa9a1f578827c98d76bbe.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pmbus files to ReST format, in order to allow them to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/adm1275    |  26 ++++
 Documentation/hwmon/ibm-cffps  |   3 +
 Documentation/hwmon/ir35221    |  11 +-
 Documentation/hwmon/lm25066    |  30 ++++
 Documentation/hwmon/ltc2978    | 267 +++++++++++++++++++++++++--------
 Documentation/hwmon/ltc3815    |  12 +-
 Documentation/hwmon/max16064   |  15 +-
 Documentation/hwmon/max20751   |   7 +
 Documentation/hwmon/max31785   |   6 +
 Documentation/hwmon/max34440   |  88 +++++++++--
 Documentation/hwmon/max8688    |  18 ++-
 Documentation/hwmon/pmbus      |  90 +++++++----
 Documentation/hwmon/pmbus-core | 173 ++++++++++++---------
 Documentation/hwmon/tps40422   |  23 ++-
 Documentation/hwmon/ucd9000    |  31 ++--
 Documentation/hwmon/ucd9200    |  42 ++++--
 Documentation/hwmon/zl6100     |  69 ++++++++-
 17 files changed, 684 insertions(+), 227 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index 5e277b0d91ce..5c5860011d6e 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -2,29 +2,53 @@ Kernel driver adm1275
 =====================
 
 Supported chips:
+
   * Analog Devices ADM1075
+
     Prefix: 'adm1075'
+
     Addresses scanned: -
+
     Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1075.pdf
+
   * Analog Devices ADM1272
+
     Prefix: 'adm1272'
+
     Addresses scanned: -
+
     Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1272.pdf
+
   * Analog Devices ADM1275
+
     Prefix: 'adm1275'
+
     Addresses scanned: -
+
     Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1275.pdf
+
   * Analog Devices ADM1276
+
     Prefix: 'adm1276'
+
     Addresses scanned: -
+
     Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1276.pdf
+
   * Analog Devices ADM1278
+
     Prefix: 'adm1278'
+
     Addresses scanned: -
+
     Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1278.pdf
+
   * Analog Devices ADM1293/ADM1294
+
     Prefix: 'adm1293', 'adm1294'
+
     Addresses scanned: -
+
     Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/ADM1293_1294.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
@@ -75,6 +99,7 @@ Sysfs entries
 The following attributes are supported. Limits are read-write, history reset
 attributes are write-only, all other attributes are read-only.
 
+======================= =======================================================
 inX_label		"vin1" or "vout1" depending on chip variant and
 			configuration. On ADM1075, ADM1293, and ADM1294,
 			vout1 reports the voltage on the VAUX pin.
@@ -120,3 +145,4 @@ temp1_reset_history	Write any value to reset history.
 
 			Temperature attributes are supported on ADM1272 and
 			ADM1278.
+======================= =======================================================
diff --git a/Documentation/hwmon/ibm-cffps b/Documentation/hwmon/ibm-cffps
index e05ecd8ecfcf..52e74e39463a 100644
--- a/Documentation/hwmon/ibm-cffps
+++ b/Documentation/hwmon/ibm-cffps
@@ -2,6 +2,7 @@ Kernel driver ibm-cffps
 =======================
 
 Supported chips:
+
   * IBM Common Form Factor power supply
 
 Author: Eddie James <eajames@us.ibm.com>
@@ -24,6 +25,7 @@ Sysfs entries
 
 The following attributes are supported:
 
+======================= ======================================================
 curr1_alarm		Output current over-current alarm.
 curr1_input		Measured output current in mA.
 curr1_label		"iout1"
@@ -52,3 +54,4 @@ temp2_alarm		Secondary rectifier temp over-temperature alarm.
 temp2_input		Measured secondary rectifier temp in millidegrees C.
 temp3_alarm		ORing FET temperature over-temperature alarm.
 temp3_input		Measured ORing FET temperature in millidegrees C.
+======================= ======================================================
diff --git a/Documentation/hwmon/ir35221 b/Documentation/hwmon/ir35221
index 3e82f3d93f44..a83922e5ccb5 100644
--- a/Documentation/hwmon/ir35221
+++ b/Documentation/hwmon/ir35221
@@ -3,8 +3,11 @@ Kernel driver ir35221
 
 Supported chips:
   * Infineon IR35221
+
     Prefix: 'ir35221'
+
     Addresses scanned: -
+
     Datasheet: Datasheet is not publicly available.
 
 Author: Samuel Mendoza-Jonas <sam@mendozajonas.com>
@@ -23,15 +26,16 @@ This driver does not probe for PMBus devices. You will have to instantiate
 devices explicitly.
 
 Example: the following commands will load the driver for an IR35221
-at address 0x70 on I2C bus #4:
+at address 0x70 on I2C bus #4::
 
-# modprobe ir35221
-# echo ir35221 0x70 > /sys/bus/i2c/devices/i2c-4/new_device
+	# modprobe ir35221
+	# echo ir35221 0x70 > /sys/bus/i2c/devices/i2c-4/new_device
 
 
 Sysfs attributes
 ----------------
 
+======================= =======================================================
 curr1_label		"iin"
 curr1_input		Measured input current
 curr1_max		Maximum current
@@ -85,3 +89,4 @@ temp[1-2]_highest	Highest temperature
 temp[1-2]_lowest	Lowest temperature
 temp[1-2]_max		Maximum temperature
 temp[1-2]_max_alarm	Chip temperature high alarm
+======================= =======================================================
diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066
index 51b32aa203a8..60b7f2722931 100644
--- a/Documentation/hwmon/lm25066
+++ b/Documentation/hwmon/lm25066
@@ -2,34 +2,62 @@ Kernel driver lm25066
 =====================
 
 Supported chips:
+
   * TI LM25056
+
     Prefix: 'lm25056'
+
     Addresses scanned: -
+
     Datasheets:
+
 	http://www.ti.com/lit/gpn/lm25056
+
 	http://www.ti.com/lit/gpn/lm25056a
+
   * National Semiconductor LM25066
+
     Prefix: 'lm25066'
+
     Addresses scanned: -
+
     Datasheets:
+
 	http://www.national.com/pf/LM/LM25066.html
+
 	http://www.national.com/pf/LM/LM25066A.html
+
   * National Semiconductor LM5064
+
     Prefix: 'lm5064'
+
     Addresses scanned: -
+
     Datasheet:
+
 	http://www.national.com/pf/LM/LM5064.html
+
   * National Semiconductor LM5066
+
     Prefix: 'lm5066'
+
     Addresses scanned: -
+
     Datasheet:
+
 	http://www.national.com/pf/LM/LM5066.html
+
   * Texas Instruments LM5066I
+
     Prefix: 'lm5066i'
+
     Addresses scanned: -
+
 	Datasheet:
+
     http://www.ti.com/product/LM5066I
 
+
 Author: Guenter Roeck <linux@roeck-us.net>
 
 
@@ -64,6 +92,7 @@ Sysfs entries
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+======================= =======================================================
 in1_label		"vin"
 in1_input		Measured input voltage.
 in1_average		Average measured input voltage.
@@ -105,3 +134,4 @@ temp1_max		Maximum temperature.
 temp1_crit		Critical high temperature.
 temp1_max_alarm		Chip temperature high alarm.
 temp1_crit_alarm	Chip temperature critical high alarm.
+======================= =======================================================
diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index dfb2caa401d9..01a24fd6d5fe 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -2,85 +2,143 @@ Kernel driver ltc2978
 =====================
 
 Supported chips:
+
   * Linear Technology LTC2974
+
     Prefix: 'ltc2974'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc2974
+
   * Linear Technology LTC2975
+
     Prefix: 'ltc2975'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc2975
+
   * Linear Technology LTC2977
+
     Prefix: 'ltc2977'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc2977
+
   * Linear Technology LTC2978, LTC2978A
+
     Prefix: 'ltc2978'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc2978
-    	       http://www.linear.com/product/ltc2978a
+
+	       http://www.linear.com/product/ltc2978a
+
   * Linear Technology LTC2980
+
     Prefix: 'ltc2980'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc2980
+
   * Linear Technology LTC3880
+
     Prefix: 'ltc3880'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc3880
+
   * Linear Technology LTC3882
+
     Prefix: 'ltc3882'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc3882
+
   * Linear Technology LTC3883
+
     Prefix: 'ltc3883'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc3883
+
   * Linear Technology LTC3886
+
     Prefix: 'ltc3886'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc3886
+
   * Linear Technology LTC3887
+
     Prefix: 'ltc3887'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc3887
+
   * Linear Technology LTM2987
+
     Prefix: 'ltm2987'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltm2987
+
   * Linear Technology LTM4675
+
     Prefix: 'ltm4675'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltm4675
+
   * Linear Technology LTM4676
+
     Prefix: 'ltm4676'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltm4676
+
   * Analog Devices LTM4686
+
     Prefix: 'ltm4686'
+
     Addresses scanned: -
+
     Datasheet: http://www.analog.com/ltm4686
 
+
 Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
 -----------
 
-LTC2974 and LTC2975 are quad digital power supply managers.
-LTC2978 is an octal power supply monitor.
-LTC2977 is a pin compatible replacement for LTC2978.
-LTC2980 is a 16-channel Power System Manager, consisting of two LTC2977
-in a single die. The chip is instantiated and reported as two separate chips
-on two different I2C bus addresses.
-LTC3880, LTC3882, LTC3886, and LTC3887 are dual output poly-phase step-down
-DC/DC controllers.
-LTC3883 is a single phase step-down DC/DC controller.
-LTM2987 is a 16-channel Power System Manager with two LTC2977 plus
-additional components on a single die. The chip is instantiated and reported
-as two separate chips on two different I2C bus addresses.
-LTM4675 is a dual 9A or single 18A μModule regulator
-LTM4676 is a dual 13A or single 26A uModule regulator.
-LTM4686 is a dual 10A or single 20A uModule regulator.
+- LTC2974 and LTC2975 are quad digital power supply managers.
+- LTC2978 is an octal power supply monitor.
+- LTC2977 is a pin compatible replacement for LTC2978.
+- LTC2980 is a 16-channel Power System Manager, consisting of two LTC2977
+- in a single die. The chip is instantiated and reported as two separate chips
+- on two different I2C bus addresses.
+- LTC3880, LTC3882, LTC3886, and LTC3887 are dual output poly-phase step-down
+- DC/DC controllers.
+- LTC3883 is a single phase step-down DC/DC controller.
+- LTM2987 is a 16-channel Power System Manager with two LTC2977 plus
+- additional components on a single die. The chip is instantiated and reported
+- as two separate chips on two different I2C bus addresses.
+- LTM4675 is a dual 9A or single 18A μModule regulator
+- LTM4676 is a dual 13A or single 26A uModule regulator.
+- LTM4686 is a dual 10A or single 20A uModule regulator.
 
 
 Usage Notes
@@ -90,127 +148,208 @@ This driver does not probe for PMBus devices. You will have to instantiate
 devices explicitly.
 
 Example: the following commands will load the driver for an LTC2978 at address
-0x60 on I2C bus #1:
+0x60 on I2C bus #1::
 
-# modprobe ltc2978
-# echo ltc2978 0x60 > /sys/bus/i2c/devices/i2c-1/new_device
+	# modprobe ltc2978
+	# echo ltc2978 0x60 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs attributes
 ----------------
 
+======================= ========================================================
 in1_label		"vin"
+
 in1_input		Measured input voltage.
+
 in1_min			Minimum input voltage.
+
 in1_max			Maximum input voltage.
+
 			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
 			LTM2987 only.
+
 in1_lcrit		Critical minimum input voltage.
+
 			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
 			LTM2987 only.
+
 in1_crit		Critical maximum input voltage.
+
 in1_min_alarm		Input voltage low alarm.
+
 in1_max_alarm		Input voltage high alarm.
+
 			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
 			LTM2987 only.
 in1_lcrit_alarm		Input voltage critical low alarm.
+
 			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
 			LTM2987 only.
 in1_crit_alarm		Input voltage critical high alarm.
+
 in1_lowest		Lowest input voltage.
+
 			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
 			LTM2987 only.
 in1_highest		Highest input voltage.
+
 in1_reset_history	Reset input voltage history.
 
 in[N]_label		"vout[1-8]".
-			LTC2974, LTC2975: N=2-5
-			LTC2977, LTC2980, LTM2987: N=2-9
-			LTC2978: N=2-9
-			LTC3880, LTC3882, LTC23886 LTC3887, LTM4675, LTM4676:
-				N=2-3
-			LTC3883: N=2
+
+			- LTC2974, LTC2975: N=2-5
+			- LTC2977, LTC2980, LTM2987: N=2-9
+			- LTC2978: N=2-9
+			- LTC3880, LTC3882, LTC23886 LTC3887, LTM4675, LTM4676:
+			  N=2-3
+			- LTC3883: N=2
+
 in[N]_input		Measured output voltage.
+
 in[N]_min		Minimum output voltage.
+
 in[N]_max		Maximum output voltage.
+
 in[N]_lcrit		Critical minimum output voltage.
+
 in[N]_crit		Critical maximum output voltage.
+
 in[N]_min_alarm		Output voltage low alarm.
+
 in[N]_max_alarm		Output voltage high alarm.
+
 in[N]_lcrit_alarm	Output voltage critical low alarm.
+
 in[N]_crit_alarm	Output voltage critical high alarm.
-in[N]_lowest		Lowest output voltage. LTC2974, LTC2975,
-			and LTC2978 only.
+
+in[N]_lowest		Lowest output voltage.
+
+
+			LTC2974, LTC2975,and LTC2978 only.
+
 in[N]_highest		Highest output voltage.
+
 in[N]_reset_history	Reset output voltage history.
 
 temp[N]_input		Measured temperature.
-			On LTC2974 and LTC2975, temp[1-4] report external
-			temperatures, and temp5 reports the chip temperature.
-			On LTC2977, LTC2980, LTC2978, and LTM2987, only one
-			temperature measurement is supported and reports
-			the chip temperature.
-			On LTC3880, LTC3882, LTC3887, LTM4675, and LTM4676,
-			temp1 and temp2 report external temperatures, and temp3
-			reports the chip temperature.
-			On LTC3883, temp1 reports an external temperature,
-			and temp2 reports the chip temperature.
-temp[N]_min		Mimimum temperature. LTC2974, LCT2977, LTM2980, LTC2978,
-			and LTM2987 only.
+
+			- On LTC2974 and LTC2975, temp[1-4] report external
+			  temperatures, and temp5 reports the chip temperature.
+			- On LTC2977, LTC2980, LTC2978, and LTM2987, only one
+			  temperature measurement is supported and reports
+			  the chip temperature.
+			- On LTC3880, LTC3882, LTC3887, LTM4675, and LTM4676,
+			  temp1 and temp2 report external temperatures, and
+			  temp3 reports the chip temperature.
+			- On LTC3883, temp1 reports an external temperature,
+			  and temp2 reports the chip temperature.
+
+temp[N]_min		Mimimum temperature.
+
+			LTC2974, LCT2977, LTM2980, LTC2978, and LTM2987 only.
+
 temp[N]_max		Maximum temperature.
+
 temp[N]_lcrit		Critical low temperature.
+
 temp[N]_crit		Critical high temperature.
+
 temp[N]_min_alarm	Temperature low alarm.
+
 			LTC2974, LTC2975, LTC2977, LTM2980, LTC2978, and
 			LTM2987 only.
+
 temp[N]_max_alarm	Temperature high alarm.
+
+
 temp[N]_lcrit_alarm	Temperature critical low alarm.
+
 temp[N]_crit_alarm	Temperature critical high alarm.
+
 temp[N]_lowest		Lowest measured temperature.
-			LTC2974, LTC2975, LTC2977, LTM2980, LTC2978, and
-			LTM2987 only.
-			Not supported for chip temperature sensor on LTC2974 and
-			LTC2975.
-temp[N]_highest		Highest measured temperature. Not supported for chip
-			temperature sensor on LTC2974 and LTC2975.
-temp[N]_reset_history	Reset temperature history. Not supported for chip
-			temperature sensor on LTC2974 and LTC2975.
+
+			- LTC2974, LTC2975, LTC2977, LTM2980, LTC2978, and
+			  LTM2987 only.
+			- Not supported for chip temperature sensor on LTC2974
+			  and LTC2975.
+
+temp[N]_highest		Highest measured temperature.
+
+			Not supported for chip temperature sensor on
+			LTC2974 and LTC2975.
+
+temp[N]_reset_history	Reset temperature history.
+
+			Not supported for chip temperature sensor on
+			LTC2974 and LTC2975.
 
 power1_label		"pin". LTC3883 and LTC3886 only.
+
 power1_input		Measured input power.
 
 power[N]_label		"pout[1-4]".
-			LTC2974, LTC2975: N=1-4
-			LTC2977, LTC2980, LTM2987: Not supported
-			LTC2978: Not supported
-			LTC3880, LTC3882, LTC3886, LTC3887, LTM4675, LTM4676:
-				N=1-2
-			LTC3883: N=2
+
+			- LTC2974, LTC2975: N=1-4
+			- LTC2977, LTC2980, LTM2987: Not supported
+			- LTC2978: Not supported
+			- LTC3880, LTC3882, LTC3886, LTC3887, LTM4675, LTM4676:
+			  N=1-2
+			- LTC3883: N=2
+
 power[N]_input		Measured output power.
 
-curr1_label		"iin". LTC3880, LTC3883, LTC3886, LTC3887, LTM4675,
+curr1_label		"iin".
+
+			LTC3880, LTC3883, LTC3886, LTC3887, LTM4675,
 			and LTM4676 only.
+
 curr1_input		Measured input current.
+
 curr1_max		Maximum input current.
+
 curr1_max_alarm		Input current high alarm.
-curr1_highest		Highest input current. LTC3883 and LTC3886 only.
-curr1_reset_history	Reset input current history. LTC3883 and LTC3886 only.
+
+curr1_highest		Highest input current.
+
+			LTC3883 and LTC3886 only.
+
+curr1_reset_history	Reset input current history.
+
+			LTC3883 and LTC3886 only.
 
 curr[N]_label		"iout[1-4]".
-			LTC2974, LTC2975: N=1-4
-			LTC2977, LTC2980, LTM2987: not supported
-			LTC2978: not supported
-			LTC3880, LTC3882, LTC3886, LTC3887, LTM4675, LTM4676:
-				N=2-3
-			LTC3883: N=2
+
+			- LTC2974, LTC2975: N=1-4
+			- LTC2977, LTC2980, LTM2987: not supported
+			- LTC2978: not supported
+			- LTC3880, LTC3882, LTC3886, LTC3887, LTM4675, LTM4676:
+			  N=2-3
+			- LTC3883: N=2
+
 curr[N]_input		Measured output current.
+
 curr[N]_max		Maximum output current.
+
 curr[N]_crit		Critical high output current.
-curr[N]_lcrit		Critical low output current. LTC2974 and LTC2975 only.
+
+curr[N]_lcrit		Critical low output current.
+
+			LTC2974 and LTC2975 only.
+
 curr[N]_max_alarm	Output current high alarm.
+
 curr[N]_crit_alarm	Output current critical high alarm.
+
 curr[N]_lcrit_alarm	Output current critical low alarm.
+
 			LTC2974 and LTC2975 only.
-curr[N]_lowest		Lowest output current. LTC2974 and LTC2975 only.
+
+curr[N]_lowest		Lowest output current.
+
+			LTC2974 and LTC2975 only.
+
 curr[N]_highest		Highest output current.
+
 curr[N]_reset_history	Reset output current history.
+======================= ========================================================
diff --git a/Documentation/hwmon/ltc3815 b/Documentation/hwmon/ltc3815
index eb7db2d13587..fb0135fc1925 100644
--- a/Documentation/hwmon/ltc3815
+++ b/Documentation/hwmon/ltc3815
@@ -2,9 +2,13 @@ Kernel driver ltc3815
 =====================
 
 Supported chips:
+
   * Linear Technology LTC3815
+
     Prefix: 'ltc3815'
+
     Addresses scanned: -
+
     Datasheet: http://www.linear.com/product/ltc3815
 
 Author: Guenter Roeck <linux@roeck-us.net>
@@ -23,15 +27,16 @@ This driver does not probe for PMBus devices. You will have to instantiate
 devices explicitly.
 
 Example: the following commands will load the driver for an LTC3815
-at address 0x20 on I2C bus #1:
+at address 0x20 on I2C bus #1::
 
-# modprobe ltc3815
-# echo ltc3815 0x20 > /sys/bus/i2c/devices/i2c-1/new_device
+	# modprobe ltc3815
+	# echo ltc3815 0x20 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs attributes
 ----------------
 
+======================= =======================================================
 in1_label		"vin"
 in1_input		Measured input voltage.
 in1_alarm		Input voltage alarm.
@@ -59,3 +64,4 @@ curr2_input		Measured output current.
 curr2_alarm		Output current alarm.
 curr2_highest		Highest output current.
 curr2_reset_history	Reset output current history.
+======================= =======================================================
diff --git a/Documentation/hwmon/max16064 b/Documentation/hwmon/max16064
index 265370f5cb82..61ec679dc477 100644
--- a/Documentation/hwmon/max16064
+++ b/Documentation/hwmon/max16064
@@ -2,9 +2,13 @@ Kernel driver max16064
 ======================
 
 Supported chips:
+
   * Maxim MAX16064
+
     Prefix: 'max16064'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX16064.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
@@ -40,16 +44,20 @@ Sysfs entries
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+======================= ========================================================
 in[1-4]_label		"vout[1-4]"
 in[1-4]_input		Measured voltage. From READ_VOUT register.
 in[1-4]_min		Minimum Voltage. From VOUT_UV_WARN_LIMIT register.
 in[1-4]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
 in[1-4]_lcrit		Critical minimum Voltage. VOUT_UV_FAULT_LIMIT register.
-in[1-4]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[1-4]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT
+			register.
 in[1-4]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in[1-4]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
-in[1-4]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
-in[1-4]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+in[1-4]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT
+			status.
+in[1-4]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT
+			status.
 in[1-4]_highest		Historical maximum voltage.
 in[1-4]_reset_history	Write any value to reset history.
 
@@ -64,3 +72,4 @@ temp1_crit_alarm	Chip temperature critical high alarm. Set by comparing
 			status is set.
 temp1_highest		Historical maximum temperature.
 temp1_reset_history	Write any value to reset history.
+======================= ========================================================
diff --git a/Documentation/hwmon/max20751 b/Documentation/hwmon/max20751
index f9fa25ebb521..d546695900ef 100644
--- a/Documentation/hwmon/max20751
+++ b/Documentation/hwmon/max20751
@@ -2,10 +2,15 @@ Kernel driver max20751
 ======================
 
 Supported chips:
+
   * maxim MAX20751
+
     Prefix: 'max20751'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX20751.pdf
+
     Application note: http://pdfserv.maximintegrated.com/en/an/AN5941.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
@@ -40,6 +45,7 @@ Sysfs entries
 
 The following attributes are supported.
 
+======================= =======================================================
 in1_label		"vin1"
 in1_input		Measured voltage.
 in1_min			Minimum input voltage.
@@ -75,3 +81,4 @@ temp1_crit_alarm	Chip temperature critical high alarm.
 
 power1_input		Output power.
 power1_label		"pout1"
+======================= =======================================================
diff --git a/Documentation/hwmon/max31785 b/Documentation/hwmon/max31785
index 270c5f865261..c8c6756d0ee1 100644
--- a/Documentation/hwmon/max31785
+++ b/Documentation/hwmon/max31785
@@ -2,9 +2,13 @@ Kernel driver max31785
 ======================
 
 Supported chips:
+
   * Maxim MAX31785, MAX31785A
+
     Prefix: 'max31785' or 'max31785a'
+
     Addresses scanned: -
+
     Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
 
 Author: Andrew Jeffery <andrew@aj.id.au>
@@ -30,6 +34,7 @@ devices explicitly.
 Sysfs attributes
 ----------------
 
+======================= =======================================================
 fan[1-4]_alarm		Fan alarm.
 fan[1-4]_fault		Fan fault.
 fan[1-8]_input		Fan RPM. On the MAX31785A, inputs 5-8 correspond to the
@@ -58,3 +63,4 @@ temp[1-11]_crit_alarm	Chip temperature critical high alarm
 temp[1-11]_input	Measured temperature
 temp[1-11]_max		Maximum temperature
 temp[1-11]_max_alarm	Chip temperature high alarm
+======================= =======================================================
diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max34440
index b2de8fa49273..639838ef29fd 100644
--- a/Documentation/hwmon/max34440
+++ b/Documentation/hwmon/max34440
@@ -2,34 +2,63 @@ Kernel driver max34440
 ======================
 
 Supported chips:
+
   * Maxim MAX34440
+
     Prefixes: 'max34440'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34440.pdf
+
   * Maxim MAX34441
+
     PMBus 5-Channel Power-Supply Manager and Intelligent Fan Controller
+
     Prefixes: 'max34441'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34441.pdf
+
   * Maxim MAX34446
+
     PMBus Power-Supply Data Logger
+
     Prefixes: 'max34446'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34446.pdf
+
   * Maxim MAX34451
+
     PMBus 16-Channel V/I Monitor and 12-Channel Sequencer/Marginer
+
     Prefixes: 'max34451'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34451.pdf
+
   * Maxim MAX34460
+
     PMBus 12-Channel Voltage Monitor & Sequencer
+
     Prefix: 'max34460'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34460.pdf
+
   * Maxim MAX34461
+
     PMBus 16-Channel Voltage Monitor & Sequencer
+
     Prefix: 'max34461'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34461.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
@@ -77,42 +106,67 @@ Sysfs entries
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+In
+~~
+
+======================= =======================================================
 in[1-6]_label		"vout[1-6]".
 in[1-6]_input		Measured voltage. From READ_VOUT register.
 in[1-6]_min		Minimum Voltage. From VOUT_UV_WARN_LIMIT register.
 in[1-6]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
 in[1-6]_lcrit		Critical minimum Voltage. VOUT_UV_FAULT_LIMIT register.
-in[1-6]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[1-6]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT
+			register.
 in[1-6]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in[1-6]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
-in[1-6]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
-in[1-6]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+in[1-6]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT
+			status.
+in[1-6]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT
+			status.
 in[1-6]_lowest		Historical minimum voltage.
 in[1-6]_highest		Historical maximum voltage.
 in[1-6]_reset_history	Write any value to reset history.
+======================= =======================================================
 
-			MAX34446 only supports in[1-4].
+.. note:: MAX34446 only supports in[1-4].
 
+Curr
+~~~~
+
+======================= ========================================================
 curr[1-6]_label		"iout[1-6]".
 curr[1-6]_input		Measured current. From READ_IOUT register.
 curr[1-6]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
-curr[1-6]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr[1-6]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT
+			register.
 curr[1-6]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
 curr[1-6]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
 curr[1-4]_average	Historical average current (MAX34446/34451 only).
 curr[1-6]_highest	Historical maximum current.
 curr[1-6]_reset_history	Write any value to reset history.
+======================= ========================================================
 
-			in6 and curr6 attributes only exist for MAX34440.
-			MAX34446 only supports curr[1-4].
+.. note::
 
+    - in6 and curr6 attributes only exist for MAX34440.
+    - MAX34446 only supports curr[1-4].
+
+Power
+~~~~~
+
+======================= ========================================================
 power[1,3]_label	"pout[1,3]"
 power[1,3]_input	Measured power.
 power[1,3]_average	Historical average power.
 power[1,3]_highest	Historical maximum power.
+======================= ========================================================
 
-			Power attributes only exist for MAX34446.
+.. note:: Power attributes only exist for MAX34446.
 
+Temp
+~~~~
+
+======================= ========================================================
 temp[1-8]_input		Measured temperatures. From READ_TEMPERATURE_1 register.
 			temp1 is the chip's internal temperature. temp2..temp5
 			are remote I2C temperature sensors. For MAX34441, temp6
@@ -125,11 +179,17 @@ temp[1-8]_crit_alarm	Temperature critical high alarm.
 temp[1-8]_average	Historical average temperature (MAX34446 only).
 temp[1-8]_highest	Historical maximum temperature.
 temp[1-8]_reset_history	Write any value to reset history.
+======================= ========================================================
 
-			temp7 and temp8 attributes only exist for MAX34440.
-			MAX34446 only supports temp[1-3].
 
-MAX34451 supports attribute groups in[1-16] (or curr[1-16] based on input pins)
-and temp[1-5].
-MAX34460 supports attribute groups in[1-12] and temp[1-5].
-MAX34461 supports attribute groups in[1-16] and temp[1-5].
+.. note::
+   - temp7 and temp8 attributes only exist for MAX34440.
+   - MAX34446 only supports temp[1-3].
+
+
+.. note::
+
+   - MAX34451 supports attribute groups in[1-16] (or curr[1-16] based on
+     input pins) and temp[1-5].
+   - MAX34460 supports attribute groups in[1-12] and temp[1-5].
+   - MAX34461 supports attribute groups in[1-16] and temp[1-5].
diff --git a/Documentation/hwmon/max8688 b/Documentation/hwmon/max8688
index ca233bec7a8a..43da139234c1 100644
--- a/Documentation/hwmon/max8688
+++ b/Documentation/hwmon/max8688
@@ -2,9 +2,13 @@ Kernel driver max8688
 =====================
 
 Supported chips:
+
   * Maxim MAX8688
+
     Prefix: 'max8688'
+
     Addresses scanned: -
+
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX8688.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
@@ -40,23 +44,28 @@ Sysfs entries
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+======================= ========================================================
 in1_label		"vout1"
 in1_input		Measured voltage. From READ_VOUT register.
 in1_min			Minimum Voltage. From VOUT_UV_WARN_LIMIT register.
 in1_max			Maximum voltage. From VOUT_OV_WARN_LIMIT register.
 in1_lcrit		Critical minimum Voltage. VOUT_UV_FAULT_LIMIT register.
-in1_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in1_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT
+			register.
 in1_min_alarm		Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in1_max_alarm		Voltage high alarm. From VOLTAGE_OV_WARNING status.
-in1_lcrit_alarm		Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
-in1_crit_alarm		Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+in1_lcrit_alarm		Voltage critical low alarm. From VOLTAGE_UV_FAULT
+			status.
+in1_crit_alarm		Voltage critical high alarm. From VOLTAGE_OV_FAULT
+			status.
 in1_highest		Historical maximum voltage.
 in1_reset_history	Write any value to reset history.
 
 curr1_label		"iout1"
 curr1_input		Measured current. From READ_IOUT register.
 curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
-curr1_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr1_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT
+			register.
 curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT register.
 curr1_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
 curr1_highest		Historical maximum current.
@@ -73,3 +82,4 @@ temp1_crit_alarm	Chip temperature critical high alarm. Set by comparing
 			status is set.
 temp1_highest		Historical maximum temperature.
 temp1_reset_history	Write any value to reset history.
+======================= ========================================================
diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index dfd9c65996c0..abfb9dd4857d 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -1,42 +1,77 @@
 Kernel driver pmbus
-====================
+===================
 
 Supported chips:
+
   * Ericsson BMR453, BMR454
+
     Prefixes: 'bmr453', 'bmr454'
+
     Addresses scanned: -
+
     Datasheet:
+
  http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146395
+
   * ON Semiconductor ADP4000, NCP4200, NCP4208
+
     Prefixes: 'adp4000', 'ncp4200', 'ncp4208'
+
     Addresses scanned: -
+
     Datasheets:
+
 	http://www.onsemi.com/pub_link/Collateral/ADP4000-D.PDF
+
 	http://www.onsemi.com/pub_link/Collateral/NCP4200-D.PDF
+
 	http://www.onsemi.com/pub_link/Collateral/JUNE%202009-%20REV.%200.PDF
+
   * Lineage Power
+
     Prefixes: 'mdt040', 'pdt003', 'pdt006', 'pdt012', 'udt020'
+
     Addresses scanned: -
+
     Datasheets:
+
 	http://www.lineagepower.com/oem/pdf/PDT003A0X.pdf
+
 	http://www.lineagepower.com/oem/pdf/PDT006A0X.pdf
+
 	http://www.lineagepower.com/oem/pdf/PDT012A0X.pdf
+
 	http://www.lineagepower.com/oem/pdf/UDT020A0X.pdf
+
 	http://www.lineagepower.com/oem/pdf/MDT040A0X.pdf
+
   * Texas Instruments TPS40400, TPS544B20, TPS544B25, TPS544C20, TPS544C25
+
     Prefixes: 'tps40400', 'tps544b20', 'tps544b25', 'tps544c20', 'tps544c25'
+
     Addresses scanned: -
+
     Datasheets:
+
 	http://www.ti.com/lit/gpn/tps40400
+
 	http://www.ti.com/lit/gpn/tps544b20
+
 	http://www.ti.com/lit/gpn/tps544b25
+
 	http://www.ti.com/lit/gpn/tps544c20
+
 	http://www.ti.com/lit/gpn/tps544c25
+
   * Generic PMBus devices
+
     Prefix: 'pmbus'
+
     Addresses scanned: -
+
     Datasheet: n.a.
 
+
 Author: Guenter Roeck <linux@roeck-us.net>
 
 
@@ -62,9 +97,10 @@ supported by all chips), and since there is no well defined address range for
 PMBus devices. You will have to instantiate the devices explicitly.
 
 Example: the following will load the driver for an LTC2978 at address 0x60
-on I2C bus #1:
-$ modprobe pmbus
-$ echo ltc2978 0x60 > /sys/bus/i2c/devices/i2c-1/new_device
+on I2C bus #1::
+
+	$ modprobe pmbus
+	$ echo ltc2978 0x60 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Platform data support
@@ -72,9 +108,9 @@ Platform data support
 
 Support for additional PMBus chips can be added by defining chip parameters in
 a new chip specific driver file. For example, (untested) code to add support for
-Emerson DS1200 power modules might look as follows.
+Emerson DS1200 power modules might look as follows::
 
-static struct pmbus_driver_info ds1200_info = {
+  static struct pmbus_driver_info ds1200_info = {
 	.pages = 1,
 	/* Note: All other sensors are in linear mode */
 	.direct[PSC_VOLTAGE_OUT] = true,
@@ -95,45 +131,45 @@ static struct pmbus_driver_info ds1200_info = {
 		   | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
 		   | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
 		   | PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12,
-};
+  };
 
-static int ds1200_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
-{
+  static int ds1200_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+  {
 	return pmbus_do_probe(client, id, &ds1200_info);
-}
+  }
 
-static int ds1200_remove(struct i2c_client *client)
-{
+  static int ds1200_remove(struct i2c_client *client)
+  {
 	return pmbus_do_remove(client);
-}
+  }
 
-static const struct i2c_device_id ds1200_id[] = {
+  static const struct i2c_device_id ds1200_id[] = {
 	{"ds1200", 0},
 	{}
-};
+  };
 
-MODULE_DEVICE_TABLE(i2c, ds1200_id);
+  MODULE_DEVICE_TABLE(i2c, ds1200_id);
 
-/* This is the driver that will be inserted */
-static struct i2c_driver ds1200_driver = {
+  /* This is the driver that will be inserted */
+  static struct i2c_driver ds1200_driver = {
 	.driver = {
 		   .name = "ds1200",
 		   },
 	.probe = ds1200_probe,
 	.remove = ds1200_remove,
 	.id_table = ds1200_id,
-};
+  };
 
-static int __init ds1200_init(void)
-{
+  static int __init ds1200_init(void)
+  {
 	return i2c_add_driver(&ds1200_driver);
-}
+  }
 
-static void __exit ds1200_exit(void)
-{
+  static void __exit ds1200_exit(void)
+  {
 	i2c_del_driver(&ds1200_driver);
-}
+  }
 
 
 Sysfs entries
@@ -148,6 +184,7 @@ a given sysfs entry.
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+======================= ========================================================
 inX_input		Measured voltage. From READ_VIN or READ_VOUT register.
 inX_min			Minimum Voltage.
 			From VIN_UV_WARN_LIMIT or VOUT_UV_WARN_LIMIT register.
@@ -214,3 +251,4 @@ tempX_lcrit_alarm	Chip temperature critical low alarm. Set by comparing
 tempX_crit_alarm	Chip temperature critical high alarm. Set by comparing
 			READ_TEMPERATURE_X with OT_FAULT_LIMIT if
 			TEMP_OT_FAULT status is set.
+======================= ========================================================
diff --git a/Documentation/hwmon/pmbus-core b/Documentation/hwmon/pmbus-core
index 8ed10e9ddfb5..92515c446fe3 100644
--- a/Documentation/hwmon/pmbus-core
+++ b/Documentation/hwmon/pmbus-core
@@ -1,3 +1,4 @@
+==================================
 PMBus core driver and internal API
 ==================================
 
@@ -120,24 +121,24 @@ Specifically, it provides the following information.
   non-standard PMBus commands to standard commands, or to augment standard
   command return values with device specific information.
 
-  API functions
-  -------------
+API functions
+=============
 
-  Functions provided by chip driver
-  ---------------------------------
+Functions provided by chip driver
+---------------------------------
 
-  All functions return the command return value (read) or zero (write) if
-  successful. A return value of -ENODATA indicates that there is no manufacturer
-  specific command, but that a standard PMBus command may exist. Any other
-  negative return value indicates that the commands does not exist for this
-  chip, and that no attempt should be made to read or write the standard
-  command.
+All functions return the command return value (read) or zero (write) if
+successful. A return value of -ENODATA indicates that there is no manufacturer
+specific command, but that a standard PMBus command may exist. Any other
+negative return value indicates that the commands does not exist for this
+chip, and that no attempt should be made to read or write the standard
+command.
 
-  As mentioned above, an exception to this rule applies to virtual commands,
-  which  _must_ be handled in driver specific code. See "Virtual PMBus Commands"
-  above for more details.
+As mentioned above, an exception to this rule applies to virtual commands,
+which *must* be handled in driver specific code. See "Virtual PMBus Commands"
+above for more details.
 
-  Command execution in the core PMBus driver code is as follows.
+Command execution in the core PMBus driver code is as follows::
 
 	if (chip_access_function) {
 		status = chip_access_function();
@@ -148,128 +149,160 @@ Specifically, it provides the following information.
 		return -EINVAL;
 	return generic_access();
 
-  Chip drivers may provide pointers to the following functions in struct
-  pmbus_driver_info. All functions are optional.
+Chip drivers may provide pointers to the following functions in struct
+pmbus_driver_info. All functions are optional.
+
+::
 
   int (*read_byte_data)(struct i2c_client *client, int page, int reg);
 
-  Read byte from page <page>, register <reg>.
-  <page> may be -1, which means "current page".
+Read byte from page <page>, register <reg>.
+<page> may be -1, which means "current page".
+
+
+::
 
   int (*read_word_data)(struct i2c_client *client, int page, int reg);
 
-  Read word from page <page>, register <reg>.
+Read word from page <page>, register <reg>.
+
+::
 
   int (*write_word_data)(struct i2c_client *client, int page, int reg,
-		         u16 word);
+			 u16 word);
 
-  Write word to page <page>, register <reg>.
+Write word to page <page>, register <reg>.
+
+::
 
   int (*write_byte)(struct i2c_client *client, int page, u8 value);
 
-  Write byte to page <page>, register <reg>.
-  <page> may be -1, which means "current page".
+Write byte to page <page>, register <reg>.
+<page> may be -1, which means "current page".
+
+::
 
   int (*identify)(struct i2c_client *client, struct pmbus_driver_info *info);
 
-  Determine supported PMBus functionality. This function is only necessary
-  if a chip driver supports multiple chips, and the chip functionality is not
-  pre-determined. It is currently only used by the generic pmbus driver
-  (pmbus.c).
+Determine supported PMBus functionality. This function is only necessary
+if a chip driver supports multiple chips, and the chip functionality is not
+pre-determined. It is currently only used by the generic pmbus driver
+(pmbus.c).
 
-  Functions exported by core driver
-  ---------------------------------
+Functions exported by core driver
+---------------------------------
 
-  Chip drivers are expected to use the following functions to read or write
-  PMBus registers. Chip drivers may also use direct I2C commands. If direct I2C
-  commands are used, the chip driver code must not directly modify the current
-  page, since the selected page is cached in the core driver and the core driver
-  will assume that it is selected. Using pmbus_set_page() to select a new page
-  is mandatory.
+Chip drivers are expected to use the following functions to read or write
+PMBus registers. Chip drivers may also use direct I2C commands. If direct I2C
+commands are used, the chip driver code must not directly modify the current
+page, since the selected page is cached in the core driver and the core driver
+will assume that it is selected. Using pmbus_set_page() to select a new page
+is mandatory.
+
+::
 
   int pmbus_set_page(struct i2c_client *client, u8 page);
 
-  Set PMBus page register to <page> for subsequent commands.
+Set PMBus page register to <page> for subsequent commands.
+
+::
 
   int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
 
-  Read word data from <page>, <reg>. Similar to i2c_smbus_read_word_data(), but
-  selects page first.
+Read word data from <page>, <reg>. Similar to i2c_smbus_read_word_data(), but
+selects page first.
+
+::
 
   int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg,
 			    u16 word);
 
-  Write word data to <page>, <reg>. Similar to i2c_smbus_write_word_data(), but
-  selects page first.
+Write word data to <page>, <reg>. Similar to i2c_smbus_write_word_data(), but
+selects page first.
+
+::
 
   int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg);
 
-  Read byte data from <page>, <reg>. Similar to i2c_smbus_read_byte_data(), but
-  selects page first. <page> may be -1, which means "current page".
+Read byte data from <page>, <reg>. Similar to i2c_smbus_read_byte_data(), but
+selects page first. <page> may be -1, which means "current page".
+
+::
 
   int pmbus_write_byte(struct i2c_client *client, int page, u8 value);
 
-  Write byte data to <page>, <reg>. Similar to i2c_smbus_write_byte(), but
-  selects page first. <page> may be -1, which means "current page".
+Write byte data to <page>, <reg>. Similar to i2c_smbus_write_byte(), but
+selects page first. <page> may be -1, which means "current page".
+
+::
 
   void pmbus_clear_faults(struct i2c_client *client);
 
-  Execute PMBus "Clear Fault" command on all chip pages.
-  This function calls the device specific write_byte function if defined.
-  Therefore, it must _not_ be called from that function.
+Execute PMBus "Clear Fault" command on all chip pages.
+This function calls the device specific write_byte function if defined.
+Therefore, it must _not_ be called from that function.
+
+::
 
   bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 
-  Check if byte register exists. Return true if the register exists, false
-  otherwise.
-  This function calls the device specific write_byte function if defined to
-  obtain the chip status. Therefore, it must _not_ be called from that function.
+Check if byte register exists. Return true if the register exists, false
+otherwise.
+This function calls the device specific write_byte function if defined to
+obtain the chip status. Therefore, it must _not_ be called from that function.
+
+::
 
   bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
 
-  Check if word register exists. Return true if the register exists, false
-  otherwise.
-  This function calls the device specific write_byte function if defined to
-  obtain the chip status. Therefore, it must _not_ be called from that function.
+Check if word register exists. Return true if the register exists, false
+otherwise.
+This function calls the device specific write_byte function if defined to
+obtain the chip status. Therefore, it must _not_ be called from that function.
+
+::
 
   int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
-                     struct pmbus_driver_info *info);
+		     struct pmbus_driver_info *info);
 
-  Execute probe function. Similar to standard probe function for other drivers,
-  with the pointer to struct pmbus_driver_info as additional argument. Calls
-  identify function if supported. Must only be called from device probe
-  function.
+Execute probe function. Similar to standard probe function for other drivers,
+with the pointer to struct pmbus_driver_info as additional argument. Calls
+identify function if supported. Must only be called from device probe
+function.
+
+::
 
   void pmbus_do_remove(struct i2c_client *client);
 
-  Execute driver remove function. Similar to standard driver remove function.
+Execute driver remove function. Similar to standard driver remove function.
+
+::
 
   const struct pmbus_driver_info
 	*pmbus_get_driver_info(struct i2c_client *client);
 
-  Return pointer to struct pmbus_driver_info as passed to pmbus_do_probe().
+Return pointer to struct pmbus_driver_info as passed to pmbus_do_probe().
 
 
 PMBus driver platform data
 ==========================
 
 PMBus platform data is defined in include/linux/pmbus.h. Platform data
-currently only provides a flag field with a single bit used.
+currently only provides a flag field with a single bit used::
 
-#define PMBUS_SKIP_STATUS_CHECK (1 << 0)
+	#define PMBUS_SKIP_STATUS_CHECK (1 << 0)
 
-struct pmbus_platform_data {
-        u32 flags;              /* Device specific flags */
-};
+	struct pmbus_platform_data {
+		u32 flags;              /* Device specific flags */
+	};
 
 
 Flags
 -----
 
 PMBUS_SKIP_STATUS_CHECK
-
-During register detection, skip checking the status register for
-communication or command errors.
+	During register detection, skip checking the status register for
+	communication or command errors.
 
 Some PMBus chips respond with valid data when trying to read an unsupported
 register. For such chips, checking the status register is mandatory when
diff --git a/Documentation/hwmon/tps40422 b/Documentation/hwmon/tps40422
index 24bb0688d515..359751eb5ed4 100644
--- a/Documentation/hwmon/tps40422
+++ b/Documentation/hwmon/tps40422
@@ -2,9 +2,13 @@ Kernel driver tps40422
 ======================
 
 Supported chips:
+
   * TI TPS40422
+
     Prefix: 'tps40422'
+
     Addresses scanned: -
+
     Datasheet: http://www.ti.com/lit/gpn/tps40422
 
 Author: Zhu Laiwen <richard.zhu@nsn.com>
@@ -39,6 +43,7 @@ Sysfs entries
 
 The following attributes are supported.
 
+======================= =======================================================
 in[1-2]_label		"vout[1-2]"
 in[1-2]_input		Measured voltage. From READ_VOUT register.
 in[1-2]_alarm		voltage alarm.
@@ -46,19 +51,23 @@ in[1-2]_alarm		voltage alarm.
 curr[1-2]_input		Measured current. From READ_IOUT register.
 curr[1-2]_label		"iout[1-2]"
 curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
-curr1_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr1_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT
+			register.
 curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT status.
 curr1_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
 curr2_alarm		Current high alarm. From IOUT_OC_WARNING status.
 
-temp1_input		Measured temperature. From READ_TEMPERATURE_2 register on page 0.
+temp1_input		Measured temperature. From READ_TEMPERATURE_2 register
+			on page 0.
 temp1_max		Maximum temperature. From OT_WARN_LIMIT register.
 temp1_crit		Critical high temperature. From OT_FAULT_LIMIT register.
 temp1_max_alarm		Chip temperature high alarm. Set by comparing
-			READ_TEMPERATURE_2 on page 0 with OT_WARN_LIMIT if TEMP_OT_WARNING
-			status is set.
+			READ_TEMPERATURE_2 on page 0 with OT_WARN_LIMIT if
+			TEMP_OT_WARNING status is set.
 temp1_crit_alarm	Chip temperature critical high alarm. Set by comparing
-			READ_TEMPERATURE_2 on page 0 with OT_FAULT_LIMIT if TEMP_OT_FAULT
-			status is set.
-temp2_input		Measured temperature. From READ_TEMPERATURE_2 register on page 1.
+			READ_TEMPERATURE_2 on page 0 with OT_FAULT_LIMIT if
+			TEMP_OT_FAULT status is set.
+temp2_input		Measured temperature. From READ_TEMPERATURE_2 register
+			on page 1.
 temp2_alarm		Chip temperature alarm on page 1.
+======================= =======================================================
diff --git a/Documentation/hwmon/ucd9000 b/Documentation/hwmon/ucd9000
index 262e713e60ff..d69061b7312c 100644
--- a/Documentation/hwmon/ucd9000
+++ b/Documentation/hwmon/ucd9000
@@ -2,15 +2,20 @@ Kernel driver ucd9000
 =====================
 
 Supported chips:
+
   * TI UCD90120, UCD90124, UCD90160, UCD9090, and UCD90910
+
     Prefixes: 'ucd90120', 'ucd90124', 'ucd90160', 'ucd9090', 'ucd90910'
+
     Addresses scanned: -
+
     Datasheets:
-	http://focus.ti.com/lit/ds/symlink/ucd90120.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd90124.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd90160.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd9090.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd90910.pdf
+
+	- http://focus.ti.com/lit/ds/symlink/ucd90120.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd90124.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd90160.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd9090.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd90910.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -76,23 +81,28 @@ Sysfs entries
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+======================= ========================================================
 in[1-12]_label		"vout[1-12]".
 in[1-12]_input		Measured voltage. From READ_VOUT register.
 in[1-12]_min		Minimum Voltage. From VOUT_UV_WARN_LIMIT register.
 in[1-12]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
 in[1-12]_lcrit		Critical minimum Voltage. VOUT_UV_FAULT_LIMIT register.
-in[1-12]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[1-12]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT
+			register.
 in[1-12]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in[1-12]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
-in[1-12]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
-in[1-12]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+in[1-12]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT
+			status.
+in[1-12]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT
+			status.
 
 curr[1-12]_label	"iout[1-12]".
 curr[1-12]_input	Measured current. From READ_IOUT register.
 curr[1-12]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
-curr[1-12]_lcrit	Critical minimum output current. From IOUT_UC_FAULT_LIMIT
+curr[1-12]_lcrit	Critical minimum output current. From
+			IOUT_UC_FAULT_LIMIT register.
+curr[1-12]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT
 			register.
-curr[1-12]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
 curr[1-12]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
 curr[1-12]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
 
@@ -116,3 +126,4 @@ fan[1-4]_fault		Fan fault.
 			created only for enabled fans.
 			Note that even though UCD90910 supports up to 10 fans,
 			only up to four fans are currently supported.
+======================= ========================================================
diff --git a/Documentation/hwmon/ucd9200 b/Documentation/hwmon/ucd9200
index 1e8060e631bd..44eda4a579b6 100644
--- a/Documentation/hwmon/ucd9200
+++ b/Documentation/hwmon/ucd9200
@@ -2,18 +2,23 @@ Kernel driver ucd9200
 =====================
 
 Supported chips:
+
   * TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248
+
     Prefixes: 'ucd9220', 'ucd9222', 'ucd9224', 'ucd9240', 'ucd9244', 'ucd9246',
-	'ucd9248'
+    'ucd9248'
+
     Addresses scanned: -
+
     Datasheets:
-	http://focus.ti.com/lit/ds/symlink/ucd9220.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd9222.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd9224.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd9240.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd9244.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd9246.pdf
-	http://focus.ti.com/lit/ds/symlink/ucd9248.pdf
+
+	- http://focus.ti.com/lit/ds/symlink/ucd9220.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd9222.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd9224.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd9240.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd9244.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd9246.pdf
+	- http://focus.ti.com/lit/ds/symlink/ucd9248.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -52,12 +57,14 @@ Sysfs entries
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+======================= ========================================================
 in1_label		"vin".
 in1_input		Measured voltage. From READ_VIN register.
 in1_min			Minimum Voltage. From VIN_UV_WARN_LIMIT register.
 in1_max			Maximum voltage. From VIN_OV_WARN_LIMIT register.
 in1_lcrit		Critical minimum Voltage. VIN_UV_FAULT_LIMIT register.
-in1_crit		Critical maximum voltage. From VIN_OV_FAULT_LIMIT register.
+in1_crit		Critical maximum voltage. From VIN_OV_FAULT_LIMIT
+			register.
 in1_min_alarm		Voltage low alarm. From VIN_UV_WARNING status.
 in1_max_alarm		Voltage high alarm. From VIN_OV_WARNING status.
 in1_lcrit_alarm		Voltage critical low alarm. From VIN_UV_FAULT status.
@@ -68,11 +75,14 @@ in[2-5]_input		Measured voltage. From READ_VOUT register.
 in[2-5]_min		Minimum Voltage. From VOUT_UV_WARN_LIMIT register.
 in[2-5]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
 in[2-5]_lcrit		Critical minimum Voltage. VOUT_UV_FAULT_LIMIT register.
-in[2-5]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[2-5]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT
+			register.
 in[2-5]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in[2-5]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
-in[2-5]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
-in[2-5]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+in[2-5]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT
+			status.
+in[2-5]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT
+			status.
 
 curr1_label		"iin".
 curr1_input		Measured current. From READ_IIN register.
@@ -80,9 +90,10 @@ curr1_input		Measured current. From READ_IIN register.
 curr[2-5]_label		"iout[1-4]".
 curr[2-5]_input		Measured current. From READ_IOUT register.
 curr[2-5]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
-curr[2-5]_lcrit		Critical minimum output current. From IOUT_UC_FAULT_LIMIT
+curr[2-5]_lcrit		Critical minimum output current. From
+			IOUT_UC_FAULT_LIMIT register.
+curr[2-5]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT
 			register.
-curr[2-5]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
 curr[2-5]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
 curr[2-5]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
 
@@ -97,7 +108,7 @@ power[2-5]_label	"pout[1-4]"
 			rails. See chip datasheets for details.
 
 temp[1-5]_input		Measured temperatures. From READ_TEMPERATURE_1 and
-		        READ_TEMPERATURE_2 registers.
+			READ_TEMPERATURE_2 registers.
 			temp1 is the chip internal temperature. temp[2-5] are
 			rail temperatures.  temp[2-5] attributes are only
 			created for enabled rails. See chip datasheets for
@@ -110,3 +121,4 @@ temp[1-5]_crit_alarm	Temperature critical high alarm.
 fan1_input		Fan RPM. ucd9240 only.
 fan1_alarm		Fan alarm. ucd9240 only.
 fan1_fault		Fan fault. ucd9240 only.
+======================= ========================================================
diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
index 477a94b131ae..4029970bace4 100644
--- a/Documentation/hwmon/zl6100
+++ b/Documentation/hwmon/zl6100
@@ -2,57 +2,106 @@ Kernel driver zl6100
 ====================
 
 Supported chips:
+
   * Intersil / Zilker Labs ZL2004
+
     Prefix: 'zl2004'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6847.pdf
+
   * Intersil / Zilker Labs ZL2005
+
     Prefix: 'zl2005'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6848.pdf
+
   * Intersil / Zilker Labs ZL2006
+
     Prefix: 'zl2006'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6850.pdf
+
   * Intersil / Zilker Labs ZL2008
+
     Prefix: 'zl2008'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6859.pdf
+
   * Intersil / Zilker Labs ZL2105
+
     Prefix: 'zl2105'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6851.pdf
+
   * Intersil / Zilker Labs ZL2106
+
     Prefix: 'zl2106'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6852.pdf
+
   * Intersil / Zilker Labs ZL6100
+
     Prefix: 'zl6100'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6876.pdf
+
   * Intersil / Zilker Labs ZL6105
+
     Prefix: 'zl6105'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn6906.pdf
+
   * Intersil / Zilker Labs ZL9101M
+
     Prefix: 'zl9101'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn7669.pdf
+
   * Intersil / Zilker Labs ZL9117M
+
     Prefix: 'zl9117'
+
     Addresses scanned: -
+
     Datasheet: http://www.intersil.com/data/fn/fn7914.pdf
+
   * Ericsson BMR450, BMR451
+
     Prefix: 'bmr450', 'bmr451'
+
     Addresses scanned: -
+
     Datasheet:
+
 http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146401
+
   * Ericsson BMR462, BMR463, BMR464
+
     Prefixes: 'bmr462', 'bmr463', 'bmr464'
+
     Addresses scanned: -
+
     Datasheet:
-http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146256
 
+	http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146256
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -75,13 +124,15 @@ This driver does not auto-detect devices. You will have to instantiate the
 devices explicitly. Please see Documentation/i2c/instantiating-devices for
 details.
 
-WARNING: Do not access chip registers using the i2cdump command, and do not use
-any of the i2ctools commands on a command register used to save and restore
-configuration data (0x11, 0x12, 0x15, 0x16, and 0xf4). The chips supported by
-this driver interpret any access to those command registers (including read
-commands) as request to execute the command in question. Unless write accesses
-to those registers are protected, this may result in power loss, board resets,
-and/or Flash corruption. Worst case, your board may turn into a brick.
+.. warning::
+
+  Do not access chip registers using the i2cdump command, and do not use
+  any of the i2ctools commands on a command register used to save and restore
+  configuration data (0x11, 0x12, 0x15, 0x16, and 0xf4). The chips supported by
+  this driver interpret any access to those command registers (including read
+  commands) as request to execute the command in question. Unless write accesses
+  to those registers are protected, this may result in power loss, board resets,
+  and/or Flash corruption. Worst case, your board may turn into a brick.
 
 
 Platform data support
@@ -110,6 +161,7 @@ Sysfs entries
 The following attributes are supported. Limits are read-write; all other
 attributes are read-only.
 
+======================= ========================================================
 in1_label		"vin"
 in1_input		Measured input voltage.
 in1_min			Minimum input voltage.
@@ -158,3 +210,4 @@ temp[12]_min_alarm	Chip temperature low alarm.
 temp[12]_max_alarm	Chip temperature high alarm.
 temp[12]_lcrit_alarm	Chip temperature critical low alarm.
 temp[12]_crit_alarm	Chip temperature critical high alarm.
+======================= ========================================================
-- 
2.20.1

