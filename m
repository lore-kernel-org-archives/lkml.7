Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABCEC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2030B2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494522;
	bh=AEwvaBiPOfuIQaCIw89Fi5DrGWTyEddmDPGqxe9GTxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6U3x1Tx+wZYcOfZc8RHrlOUBwWvpE3z1wd9UJlYYjfcLXV8UaXrshPxCIXAnaEjN
	 dvw/oTNxEWtR10lqPRq015Cocue58u5YXAVp5S1yxuidRJAC1SM+xHf1FJcEemWaVC
	 rJa9MBJ1uyioXPCnXLdpypRwevfdNk2P5Z0kBreo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbfDQJsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:48:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbfDQJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6Qp3OTiveUtdQiehEFVG/K5c8ofOuDom/ezWCNRJrzE=; b=FKlTM234SxlApmsHdiTYUxL55U
        lzl7V6iD6kAoj0ZzXzAuNIpH8IUMvWrLcBAZpr+CBZ+4XnL0pfmmiYxBVMAQuIqqsfMboCdPqjTAN
        YD4/6d+grCLfkLomapTpdog6D/cF41mJdYql0OyEX+OCxacgBjbYHMdjPOqnEF1V5pyT42lLmBAwS
        ASxbIznLvyCRq/EUTgrf0uBYT34mnmsdeLrmcv0IR7iMgYIEYWyNA+cAYF8kl1UgAvMmrlga0lVWW
        rEYbnTk4qTC4B43AAUCD9mkcYsl2wa/u3WoMiwzJhXQNfIMqg2FLXgRyiM1Hn0j0ofsHtLioUp5JX
        3aMPrjjw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9G-0000a8-KF; Wed, 17 Apr 2019 09:46:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9C-0003uS-Tj; Wed, 17 Apr 2019 06:46:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 06/21] docs: hwmon: pc87360: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:14 -0300
Message-Id: <a45618c63e12dc75c2c72ac8c18accb661c4ecb1.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pc87360 to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/pc87360 | 38 +++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/pc87360 b/Documentation/hwmon/pc87360
index d5f5cf16ce59..4bad07bce54b 100644
--- a/Documentation/hwmon/pc87360
+++ b/Documentation/hwmon/pc87360
@@ -2,14 +2,19 @@ Kernel driver pc87360
 =====================
 
 Supported chips:
+
   * National Semiconductor PC87360, PC87363, PC87364, PC87365 and PC87366
+
     Prefixes: 'pc87360', 'pc87363', 'pc87364', 'pc87365', 'pc87366'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheets: No longer available
 
 Authors: Jean Delvare <jdelvare@suse.de>
 
 Thanks to Sandeep Mehta, Tonko de Rooy and Daniel Ceregatti for testing.
+
 Thanks to Rudolf Marek for helping me investigate conversion issues.
 
 
@@ -17,11 +22,13 @@ Module Parameters
 -----------------
 
 * init int
-  Chip initialization level:
-   0: None
-  *1: Forcibly enable internal voltage and temperature channels, except in9
-   2: Forcibly enable all voltage and temperature channels, except in9
-   3: Forcibly enable all voltage and temperature channels, including in9
+    Chip initialization level:
+
+    - 0: None
+    - **1**: Forcibly enable internal voltage and temperature channels,
+      except in9
+    - 2: Forcibly enable all voltage and temperature channels, except in9
+    - 3: Forcibly enable all voltage and temperature channels, including in9
 
 Note that this parameter has no effect for the PC87360, PC87363 and PC87364
 chips.
@@ -43,13 +50,15 @@ hardware monitoring chipsets, not only controlling and monitoring three fans,
 but also monitoring eleven voltage inputs and two (PC87365) or up to four
 (PC87366) temperatures.
 
+  =========== ======= ======= ======= ======= =====
   Chip        #vin    #fan    #pwm    #temp   devid
-
+  =========== ======= ======= ======= ======= =====
   PC87360     -       2       2       -       0xE1
   PC87363     -       2       2       -       0xE8
   PC87364     -       3       3       -       0xE4
   PC87365     11      3       3       2       0xE5
   PC87366     11      3       3       3-4     0xE9
+  =========== ======= ======= ======= ======= =====
 
 The driver assumes that no more than one chip is present, and one of the
 standard Super I/O addresses is used (0x2E/0x2F or 0x4E/0x4F)
@@ -68,18 +77,23 @@ have to care no more.
 
 For reference, here are a few values about clock dividers:
 
-                slowest         accuracy        highest
-                measurable      around 3000     accurate
+    =========== =============== =============== ===========
+		slowest         accuracy        highest
+		measurable      around 3000     accurate
     divider     speed (RPM)     RPM (RPM)       speed (RPM)
-         1        1882              18           6928
-         2         941              37           4898
-         4         470              74           3464
-         8         235             150           2449
+    =========== =============== =============== ===========
+	 1        1882              18           6928
+	 2         941              37           4898
+	 4         470              74           3464
+	 8         235             150           2449
+    =========== =============== =============== ===========
 
 For the curious, here is how the values above were computed:
+
  * slowest measurable speed: clock/(255*divider)
  * accuracy around 3000 RPM: 3000^2/clock
  * highest accurate speed: sqrt(clock*100)
+
 The clock speed for the PC87360 family is 480 kHz. I arbitrarily chose 100
 RPM as the lowest acceptable accuracy.
 
-- 
2.20.1

