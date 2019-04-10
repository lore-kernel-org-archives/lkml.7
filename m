Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36508C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFC420820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924199;
	bh=HaVAQHmoGTN7IZRrzcKHEau+vBPCCBYTAoUnQ+DGe/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v11ev0OxaqE0dvSftqTOSgJbxhMyrl1ysv0qivyYF+8nG0oviPhal97yh9Lc+9VVW
	 6vdrvLUVCiCe10oKeHcfUlzzQM8kpj+L/BapHn0qOd/G8EBhqM4izZW4O3p34HoSzc
	 bZSAEeDA9rfYLSJbDwPvK42uM2aSG9I238/5K+yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDJTXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:23:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDJTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9xKJ/YbyKW5rRxZsZt0x225FxAk2hW2sKjXaGp6q0hU=; b=DOslt9+EeJ3Dyet+47ZnO5KK4r
        GzH3LRDQuxlXvhF1TY1OKJyZb0PQDpUm7AlMeAFjjmJTDeprjqFU5sq+ohJes1iEUkWGPBtz6gQPV
        r6kyNM6Sec3oKfz/Ks0Z2uTi+4DDU+qiPHpXlMzGTwG2JtebfQ6xINezcU5JT6Ny1NZXFvxd5eWJK
        CA3qUayMdwOyIHiuxHFl4VyZaUdO744EseSGRPVg1kaqrDsCkeEBMEl4rG4r7gVKHupeRsFYcFLSY
        QY0GwQbfZKZ0l2SusyYcw7iwFPQ6y5fHVl6hm8WvxFts0zmh9Y22pbc0nvFl4P5oAk+kl1RSo3ond
        OKn5qDSw==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoM-0003Qx-Ht; Wed, 10 Apr 2019 19:23:06 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoJ-0000zS-4U; Wed, 10 Apr 2019 16:23:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 16/21] docs: hwmon: da9052, da9055: convert to ReST format
Date:   Wed, 10 Apr 2019 16:22:53 -0300
Message-Id: <53f1f767bdef56b1d9d042b4dc2506625eb5ed05.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert da9052 and da9055 to ReST format, in order to allow
them to be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/da9052 | 40 ++++++++++++++++++++++++++------------
 Documentation/hwmon/da9055 | 20 ++++++++++++++-----
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/Documentation/hwmon/da9052 b/Documentation/hwmon/da9052
index 5bc51346b689..556e2778b9e5 100644
--- a/Documentation/hwmon/da9052
+++ b/Documentation/hwmon/da9052
@@ -1,6 +1,12 @@
+Kernel driver da9052
+====================
+
 Supported chips:
+
   * Dialog Semiconductors DA9052-BC and DA9053-AA/Bx PMICs
+
     Prefix: 'da9052'
+
     Datasheet: Datasheet is not publicly available.
 
 Authors: David Dajun Chen <dchen@diasemi.com>
@@ -15,17 +21,20 @@ different inputs. The track and hold circuit ensures stable input voltages at
 the input of the ADC during the conversion.
 
 The ADC is used to measure the following inputs:
-Channel 0: VDDOUT - measurement of the system voltage
-Channel 1: ICH - internal battery charger current measurement
-Channel 2: TBAT - output from the battery NTC
-Channel 3: VBAT - measurement of the battery voltage
-Channel 4: ADC_IN4 - high impedance input (0 - 2.5V)
-Channel 5: ADC_IN5 - high impedance input (0 - 2.5V)
-Channel 6: ADC_IN6 - high impedance input (0 - 2.5V)
-Channel 7: XY - TSI interface to measure the X and Y voltage of the touch
-	   screen resistive potentiometers
-Channel 8: Internal Tjunc. - sense (internal temp. sensor)
-Channel 9: VBBAT - measurement of the backup battery voltage
+
+========= ===================================================================
+Channel 0 VDDOUT - measurement of the system voltage
+Channel 1 ICH - internal battery charger current measurement
+Channel 2 TBAT - output from the battery NTC
+Channel 3 VBAT - measurement of the battery voltage
+Channel 4 ADC_IN4 - high impedance input (0 - 2.5V)
+Channel 5 ADC_IN5 - high impedance input (0 - 2.5V)
+Channel 6 ADC_IN6 - high impedance input (0 - 2.5V)
+Channel 7 XY - TSI interface to measure the X and Y voltage of the touch
+	  screen resistive potentiometers
+Channel 8 Internal Tjunc. - sense (internal temp. sensor)
+Channel 9 VBBAT - measurement of the backup battery voltage
+========= ===================================================================
 
 By using sysfs attributes we can measure the system voltage VDDOUT, the battery
 charging current ICH, battery temperature TBAT, battery junction temperature
@@ -37,12 +46,15 @@ Voltage Monitoring
 Voltages are sampled by a 10 bit ADC.
 
 The battery voltage is calculated as:
+
 	Milli volt = ((ADC value * 1000) / 512) + 2500
 
 The backup battery voltage is calculated as:
+
 	Milli volt = (ADC value * 2500) / 512;
 
 The voltages on ADC channels 4, 5 and 6 are calculated as:
+
 	Milli volt = (ADC value * 2500) / 1023
 
 Temperature Monitoring
@@ -52,10 +64,14 @@ Temperatures are sampled by a 10 bit ADC.  Junction and battery temperatures
 are monitored by the ADC channels.
 
 The junction temperature is calculated:
+
 	Degrees celsius = 1.708 * (TJUNC_RES - T_OFFSET) - 108.8
+
 The junction temperature attribute is supported by the driver.
 
 The battery temperature is calculated:
-	Degree Celsius = 1 / (t1 + 1/298)- 273
+
+	Degree Celsius = 1 / (t1 + 1/298) - 273
+
 where t1 = (1/B)* ln(( ADCval * 2.5)/(R25*ITBAT*255))
 Default values of R25, B, ITBAT are 10e3, 3380 and 50e-6 respectively.
diff --git a/Documentation/hwmon/da9055 b/Documentation/hwmon/da9055
index 855c3f536e00..beae271a3312 100644
--- a/Documentation/hwmon/da9055
+++ b/Documentation/hwmon/da9055
@@ -1,6 +1,11 @@
+Kernel driver da9055
+====================
+
 Supported chips:
   * Dialog Semiconductors DA9055 PMIC
+
     Prefix: 'da9055'
+
     Datasheet: Datasheet is not publicly available.
 
 Authors: David Dajun Chen <dchen@diasemi.com>
@@ -15,11 +20,12 @@ different inputs. The track and hold circuit ensures stable input voltages at
 the input of the ADC during the conversion.
 
 The ADC is used to measure the following inputs:
-Channel 0: VDDOUT - measurement of the system voltage
-Channel 1: ADC_IN1 - high impedance input (0 - 2.5V)
-Channel 2: ADC_IN2 - high impedance input (0 - 2.5V)
-Channel 3: ADC_IN3 - high impedance input (0 - 2.5V)
-Channel 4: Internal Tjunc. - sense (internal temp. sensor)
+
+- Channel 0: VDDOUT - measurement of the system voltage
+- Channel 1: ADC_IN1 - high impedance input (0 - 2.5V)
+- Channel 2: ADC_IN2 - high impedance input (0 - 2.5V)
+- Channel 3: ADC_IN3 - high impedance input (0 - 2.5V)
+- Channel 4: Internal Tjunc. - sense (internal temp. sensor)
 
 By using sysfs attributes we can measure the system voltage VDDOUT,
 chip junction temperature and auxiliary channels voltages.
@@ -31,9 +37,11 @@ Voltages are sampled in a AUTO mode it can be manually sampled too and results
 are stored in a 10 bit ADC.
 
 The system voltage is calculated as:
+
 	Milli volt = ((ADC value * 1000) / 85) + 2500
 
 The voltages on ADC channels 1, 2 and 3 are calculated as:
+
 	Milli volt = (ADC value * 1000) / 102
 
 Temperature Monitoring
@@ -43,5 +51,7 @@ Temperatures are sampled by a 10 bit ADC.  Junction temperatures
 are monitored by the ADC channels.
 
 The junction temperature is calculated:
+
 	Degrees celsius = -0.4084 * (ADC_RES - T_OFFSET) + 307.6332
+
 The junction temperature attribute is supported by the driver.
-- 
2.20.1

