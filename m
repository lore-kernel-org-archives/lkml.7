Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF261C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7597E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894820;
	bh=WnSqaLrVJWhjaYFcF89JY8unBbP+oNDckI+KtqqL61E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LNLUWxuNrjlbBKCixeuDeODTpIvQLX2pqLD571cIvE6Kr+utPHdHn/eoxcephG3nC
	 cYIvIbonrbh1rZ3gpzFJMg5BiRMHsLhtrzUYWs2JesDQ6yVpeJs/QsZWe7CX3ZxoVc
	 dahX6X6PNt/gXdkgFRBj91cX9lZLUy58mfOMqlhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfDJLNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:13:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbfDJLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zyl0iXJRwzuvBEZs7BTvFpYBndYhMvCAD5/OttpaVwg=; b=TY6co1T9ocQjgai1d3yjtgrW/G
        59NVDpuPIg70hwXGGdt7jlNCpeR4aIe0B/wtuk7rj/BrHcf41hxQsu/LUh8HrFPPxzsQoSi85vvVY
        GHCh4gPoC9XEIdjgvKeC9W3vT4IXYctBM1hzSPejP+hiTU6l3q/WJ2uyHnCJZ2zy0PPqfswS6TDsC
        b6wUfP3olzUE4bbNn2sEh9qEfZKPjGMFzy3bbfKwdi66x34+GQmCYghoMkWUcQcRNvSYkvn+XChp5
        b3aO9vdTbByU2OGT6cgstjJKnp2ac+QEgBrNX4powPvE2IkNYa3rzMajh+0JakdH6cv6NF9vuEi9L
        kGp9xGWg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006n1-NH; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007T6-Gf; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 12/21] docs: hwmon: asc7621: convert to ReST format
Date:   Wed, 10 Apr 2019 08:12:02 -0300
Message-Id: <10612d65a1392e596cf60c981985d0af208c8a61.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert asc7621 to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/asc7621 | 146 ++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 58 deletions(-)

diff --git a/Documentation/hwmon/asc7621 b/Documentation/hwmon/asc7621
index 7287be7e1f21..b5a9fad0f172 100644
--- a/Documentation/hwmon/asc7621
+++ b/Documentation/hwmon/asc7621
@@ -1,10 +1,15 @@
+=====================
 Kernel driver asc7621
-==================
+=====================
 
 Supported chips:
+
     Andigilog aSC7621 and aSC7621a
+
     Prefix: 'asc7621'
+
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+
     Datasheet: http://www.fairview5.com/linux/asc7621/asc7621.pdf
 
 Author:
@@ -73,8 +78,10 @@ Finally, we have added a tach disable function that turns off the tach
 measurement system for individual tachs in order to save power. That is
 in register 75h.
 
---
+--------------------------------------------------------------------------
+
 aSC7621 Product Description
+===========================
 
 The aSC7621 has a two wire digital interface compatible with SMBus 2.0.
 Using a 10-bit ADC, the aSC7621 measures the temperature of two remote diode
@@ -102,6 +109,8 @@ System voltages of VCCP, 2.5V, 3.3V, 5.0V, and 12V motherboard power are
 monitored efficiently with internal scaling resistors.
 
 Features
+--------
+
 - Supports PECI interface and monitors internal and remote thermal diodes
 - 2-wire, SMBus 2.0 compliant, serial interface
 - 10-bit ADC
@@ -110,7 +119,7 @@ Features
 - Noise filtering of temperature reading for fan speed control
 - 0.25C digital temperature sensor resolution
 - 3 PWM fan speed control outputs for 2-, 3- or 4-wire fans and up to 4 fan
-	tachometer inputs
+  tachometer inputs
 - Enhanced measured temperature to Temperature Zone assignment.
 - Provides high and low PWM frequency ranges
 - 3 GPIO pins for custom use
@@ -123,17 +132,20 @@ Except where noted below, the sysfs entries created by this driver follow
 the standards defined in "sysfs-interface".
 
 temp1_source
+	=	===============================================
 	0 	(default) peci_legacy = 0, Remote 1 Temperature
-			peci_legacy = 1, PECI Processor Temperature 0
+		peci_legacy = 1, PECI Processor Temperature 0
 	1 	Remote 1 Temperature
 	2 	Remote 2 Temperature
 	3 	Internal Temperature
 	4 	PECI Processor Temperature 0
 	5 	PECI Processor Temperature 1
 	6 	PECI Processor Temperature 2
-	7  PECI Processor Temperature 3
+	7	PECI Processor Temperature 3
+	=	===============================================
 
 temp2_source
+	=	===============================================
 	0 	(default) Internal Temperature
 	1 	Remote 1 Temperature
 	2 	Remote 2 Temperature
@@ -142,8 +154,10 @@ temp2_source
 	5 	PECI Processor Temperature 1
 	6 	PECI Processor Temperature 2
 	7 	PECI Processor Temperature 3
+	=	===============================================
 
 temp3_source
+	=	===============================================
 	0 	(default) Remote 2 Temperature
 	1 	Remote 1 Temperature
 	2 	Remote 2 Temperature
@@ -152,10 +166,12 @@ temp3_source
 	5 	PECI Processor Temperature 1
 	6 	PECI Processor Temperature 2
 	7 	PECI Processor Temperature 3
+	=	===============================================
 
 temp4_source
+	=	===============================================
 	0 	(default) peci_legacy = 0, PECI Processor Temperature 0
-			peci_legacy = 1, Remote 1 Temperature
+		peci_legacy = 1, Remote 1 Temperature
 	1 	Remote 1 Temperature
 	2 	Remote 2 Temperature
 	3 	Internal Temperature
@@ -163,58 +179,65 @@ temp4_source
 	5 	PECI Processor Temperature 1
 	6 	PECI Processor Temperature 2
 	7 	PECI Processor Temperature 3
+	=	===============================================
 
-temp[1-4]_smoothing_enable
-temp[1-4]_smoothing_time
+temp[1-4]_smoothing_enable / temp[1-4]_smoothing_time
 	Smooths spikes in temp readings caused by noise.
 	Valid values in milliseconds are:
-	35000
-	17600
-	11800
-	 7000
-	 4400
-	 3000
-	 1600
-	  800
+
+	* 35000
+	* 17600
+	* 11800
+	*  7000
+	*  4400
+	*  3000
+	*  1600
+	*   800
 
 temp[1-4]_crit
 	When the corresponding zone temperature reaches this value,
 	ALL pwm outputs will got to 100%.
 
-temp[5-8]_input
-temp[5-8]_enable
+temp[5-8]_input / temp[5-8]_enable
 	The aSC7621 can also read temperatures provided by the processor
 	via the PECI bus.  Usually these are "core" temps and are relative
 	to the point where the automatic thermal control circuit starts
 	throttling.  This means that these are usually negative numbers.
 
 pwm[1-3]_enable
+	=============== ========================================================
 	0		Fan off.
 	1		Fan on manual control.
 	2		Fan on automatic control and will run at the minimum pwm
-				if the temperature for the zone is below the minimum.
-	3		Fan on automatic control but will be off if the temperature
-				for the zone is below the minimum.
-	4-254	Ignored.
+			if the temperature for the zone is below the minimum.
+	3		Fan on automatic control but will be off if the
+			temperature for the zone is below the minimum.
+	4-254		Ignored.
 	255		Fan on full.
+	=============== ========================================================
 
 pwm[1-3]_auto_channels
 	Bitmap as described in sysctl-interface with the following
 	exceptions...
+
 	Only the following combination of zones (and their corresponding masks)
 	are valid:
-	1
-	2
-	3
-	2,3
-	1,2,3
-	4
-	1,2,3,4
 
-	Special values:
-	0			Disabled.
-	16		Fan on manual control.
-	31		Fan on full.
+	* 1
+	* 2
+	* 3
+	* 2,3
+	* 1,2,3
+	* 4
+	* 1,2,3,4
+
+	* Special values:
+
+	  ==		======================
+	  0		Disabled.
+	  16		Fan on manual control.
+	  31		Fan on full.
+	  ==		======================
 
 
 pwm[1-3]_invert
@@ -226,22 +249,22 @@ pwm[1-3]_freq
 	PWM frequency in Hz
 	Valid values in Hz are:
 
-	10
-	15
-	23
-	30  (default)
-	38
-	47
-	62
-	94
-	23000
-	24000
-	25000
-	26000
-	27000
-	28000
-	29000
-	30000
+	* 10
+	* 15
+	* 23
+	* 30  (default)
+	* 38
+	* 47
+	* 62
+	* 94
+	* 23000
+	* 24000
+	* 25000
+	* 26000
+	* 27000
+	* 28000
+	* 29000
+	* 30000
 
 	Setting any other value will be ignored.
 
@@ -251,17 +274,17 @@ peci_enable
 peci_avg
 	Input filter average time.
 
-	0 	0 Sec. (no Smoothing) (default)
-	1 	0.25 Sec.
-	2 	0.5 Sec.
-	3 	1.0 Sec.
-	4 	2.0 Sec.
-	5 	4.0 Sec.
-	6 	8.0 Sec.
-	7 	0.0 Sec.
+	* 0 	0 Sec. (no Smoothing) (default)
+	* 1 	0.25 Sec.
+	* 2 	0.5 Sec.
+	* 3 	1.0 Sec.
+	* 4 	2.0 Sec.
+	* 5 	4.0 Sec.
+	* 6 	8.0 Sec.
+	* 7 	0.0 Sec.
 
 peci_legacy
-
+	=	============================================
 	0	Standard Mode (default)
 		Remote Diode 1 reading is associated with
 		Temperature Zone 1, PECI is associated with
@@ -270,10 +293,12 @@ peci_legacy
 	1	Legacy Mode
 		PECI is associated with Temperature Zone 1,
 		Remote Diode 1 is associated with Zone 4
+	=	============================================
 
 peci_diode
 	Diode filter
 
+	=	====================
 	0	0.25 Sec.
 	1 	1.1 Sec.
 	2 	2.4 Sec.  (default)
@@ -282,15 +307,20 @@ peci_diode
 	5 	6.8 Sec.
 	6 	10.2 Sec.
 	7 	16.4 Sec.
+	=	====================
 
 peci_4domain
 	Four domain enable
 
+	=	===============================================
 	0 	1 or 2 Domains for enabled processors (default)
 	1 	3 or 4 Domains for enabled processors
+	=	===============================================
 
 peci_domain
 	Domain
 
+	=	==================================================
 	0 	Processor contains a single domain (0) 	 (default)
 	1 	Processor contains two domains (0,1)
+	=	==================================================
-- 
2.20.1

