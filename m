Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7536D20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924195;
	bh=Izt/5LqM2wzPDvqkGCJHu0S4ZZhIFDLEp9Bp5Fwmx+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0p3NEAmyJ/JDssM2/9mZCYsSbLvWILDbCQ4gSxW/RZLlHUWbg19f1uk1oeZYWc78
	 nansTwo/QVG7ZcprpvjG+kKaG2S+5cPmZhy8VrGY9Tt3e0rBaAYs1uhZrfw1NVQMm5
	 TzVACnnOAKvW49YFShPHFUabG8LBnlU8KB0VS/vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDJTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:23:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfDJTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HBtp3BEM97J+VvxjcyTQ0Rh8cs8lWpfrxcjNLnrN9tA=; b=hn0QhnV4q3qU2hs3/8L/YvYfIp
        BQqgmX1TrfZTcZ5HkclrR1Z3iPK7C2ebVb1We4iUVQ3lamLfY1QFOs2eCV3n22NmUKhtfIKng3c2Z
        YnLHX+85KnjeW2f6RvAv+u5vRBrvnpY5I1vQY3iIcWqw8/mrRf7Bgu/U8lUEDCGcJKjE3anEy6ctB
        fcl9MChhUsUcU+GTxzapWQGmHKOkhGtC0S3sYOMRWkUx4gQhD3sKKZJ7Ozp2Gij0x9m3yRzzJgZbd
        GEWZIbEpRFc04iip1TXjGeEZIDJrl9cQN2LQnoXpUBETdp48nAPGCUKfFN9irlxLEpqy7cxMi7AUZ
        CwfY6aMw==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoM-0003R3-Jz; Wed, 10 Apr 2019 19:23:06 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoJ-0000zG-20; Wed, 10 Apr 2019 16:23:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 13/21] docs: hwmon: ads1015: convert to ReST format
Date:   Wed, 10 Apr 2019 16:22:50 -0300
Message-Id: <a4c22d2c42ae9efa2ec456fcce01b56ab915b84c.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ads1015 to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/ads1015 | 72 ++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
index 02d2a459385f..e0951c4e57bb 100644
--- a/Documentation/hwmon/ads1015
+++ b/Documentation/hwmon/ads1015
@@ -2,17 +2,25 @@ Kernel driver ads1015
 =====================
 
 Supported chips:
+
   * Texas Instruments ADS1015
+
     Prefix: 'ads1015'
-    Datasheet: Publicly available at the Texas Instruments website :
-               http://focus.ti.com/lit/ds/symlink/ads1015.pdf
+
+    Datasheet: Publicly available at the Texas Instruments website:
+
+	       http://focus.ti.com/lit/ds/symlink/ads1015.pdf
+
   * Texas Instruments ADS1115
+
     Prefix: 'ads1115'
-    Datasheet: Publicly available at the Texas Instruments website :
-               http://focus.ti.com/lit/ds/symlink/ads1115.pdf
+
+    Datasheet: Publicly available at the Texas Instruments website:
+
+	       http://focus.ti.com/lit/ds/symlink/ads1115.pdf
 
 Authors:
-        Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
+	Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
 
 Description
 -----------
@@ -24,14 +32,15 @@ This device is a 12/16-bit A-D converter with 4 inputs.
 The inputs can be used single ended or in certain differential combinations.
 
 The inputs can be made available by 8 sysfs input files in0_input - in7_input:
-in0: Voltage over AIN0 and AIN1.
-in1: Voltage over AIN0 and AIN3.
-in2: Voltage over AIN1 and AIN3.
-in3: Voltage over AIN2 and AIN3.
-in4: Voltage over AIN0 and GND.
-in5: Voltage over AIN1 and GND.
-in6: Voltage over AIN2 and GND.
-in7: Voltage over AIN3 and GND.
+
+  - in0: Voltage over AIN0 and AIN1.
+  - in1: Voltage over AIN0 and AIN3.
+  - in2: Voltage over AIN1 and AIN3.
+  - in3: Voltage over AIN2 and AIN3.
+  - in4: Voltage over AIN0 and GND.
+  - in5: Voltage over AIN1 and GND.
+  - in6: Voltage over AIN2 and GND.
+  - in7: Voltage over AIN3 and GND.
 
 Which inputs are available can be configured using platform data or devicetree.
 
@@ -42,29 +51,34 @@ Platform Data
 
 In linux/platform_data/ads1015.h platform data is defined, channel_data contains
 configuration data for the used input combinations:
+
 - pga is the programmable gain amplifier (values are full scale)
-  0: +/- 6.144 V
-  1: +/- 4.096 V
-  2: +/- 2.048 V
-  3: +/- 1.024 V
-  4: +/- 0.512 V
-  5: +/- 0.256 V
+
+    - 0: +/- 6.144 V
+    - 1: +/- 4.096 V
+    - 2: +/- 2.048 V
+    - 3: +/- 1.024 V
+    - 4: +/- 0.512 V
+    - 5: +/- 0.256 V
+
 - data_rate in samples per second
-  0: 128
-  1: 250
-  2: 490
-  3: 920
-  4: 1600
-  5: 2400
-  6: 3300
 
-Example:
-struct ads1015_platform_data data = {
+    - 0: 128
+    - 1: 250
+    - 2: 490
+    - 3: 920
+    - 4: 1600
+    - 5: 2400
+    - 6: 3300
+
+Example::
+
+  struct ads1015_platform_data data = {
 	.channel_data = {
 		[2] = { .enabled = true, .pga = 1, .data_rate = 0 },
 		[4] = { .enabled = true, .pga = 4, .data_rate = 5 },
 	}
-};
+  };
 
 In this case only in2_input (FS +/- 4.096 V, 128 SPS) and in4_input
 (FS +/- 0.512 V, 2400 SPS) would be created.
-- 
2.20.1

