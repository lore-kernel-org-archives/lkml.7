Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB985C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919B221939
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257048;
	bh=5ctZbnZNrSnZgv1IWKJ5Sx/tVIqjKHrJKdyG0qSaZPM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1SpXq7MDlwnh6FnP7RzSokxzlkKD6d3H1mR7Sq/xOxU4DhcMT4plrgJ1OVRE+Oir0
	 hfatUD4eKX+Ut7GksxBK3Q4CIQave5QO5UrIYOiC97NquRoEdT5dBHqivUbxlw5E0z
	 vwSGsnTl6AgSWI4a+LC8Q1lnGX24em58cXlMxoGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfKTNh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfKTNhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:25 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE7921939;
        Wed, 20 Nov 2019 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257044;
        bh=5ctZbnZNrSnZgv1IWKJ5Sx/tVIqjKHrJKdyG0qSaZPM=;
        h=From:To:Cc:Subject:Date:From;
        b=Fhq9RmcrWonFtRRJ/pxpZRmlxHDuAosA25qdpTrk7EEvDB6l0DT1UzcPhq40dtJkv
         NmIya/wH6xZkWXvSSoqaL1M/97yVNl2j/r/Ijdf2xWl7phlTUwyRtZtqLGL8j14ykL
         gMGQM5eVoKfBZ4dzXb16SIZdgOSYYAe/INJOxGzI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH] m68k: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:21 +0800
Message-Id: <20191120133721.12178-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig.bus     |  2 +-
 arch/m68k/Kconfig.debug   | 16 ++++++++--------
 arch/m68k/Kconfig.machine |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/m68k/Kconfig.bus b/arch/m68k/Kconfig.bus
index 9d0a3a23d50e..f1be832e2b74 100644
--- a/arch/m68k/Kconfig.bus
+++ b/arch/m68k/Kconfig.bus
@@ -66,6 +66,6 @@ endif
 if !MMU
 
 config ISA_DMA_API
-        def_bool !M5272
+	def_bool !M5272
 
 endif
diff --git a/arch/m68k/Kconfig.debug b/arch/m68k/Kconfig.debug
index f43643111eaf..11b306bdd788 100644
--- a/arch/m68k/Kconfig.debug
+++ b/arch/m68k/Kconfig.debug
@@ -12,16 +12,16 @@ config EARLY_PRINTK
 	bool "Early printk"
 	depends on !(SUN3 || M68000 || COLDFIRE)
 	help
-          Write kernel log output directly to a serial port.
-          Where implemented, output goes to the framebuffer as well.
-          PROM console functionality on Sun 3x is not affected by this option.
+	  Write kernel log output directly to a serial port.
+	  Where implemented, output goes to the framebuffer as well.
+	  PROM console functionality on Sun 3x is not affected by this option.
 
-          Pass "earlyprintk" on the kernel command line to get a
-          boot console.
+	  Pass "earlyprintk" on the kernel command line to get a
+	  boot console.
 
-          This is useful for kernel debugging when your machine crashes very
-          early, i.e. before the normal console driver is loaded.
-          You should normally say N here, unless you want to debug such a crash.
+	  This is useful for kernel debugging when your machine crashes very
+	  early, i.e. before the normal console driver is loaded.
+	  You should normally say N here, unless you want to debug such a crash.
 
 if !MMU
 
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index c01e103492fd..b23a66bac77f 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -269,10 +269,10 @@ config AMCORE
 	  Support for the Sysam AMCORE open-hardware generic board.
 
 config STMARK2
-        bool "Sysam stmark2 board support"
-        depends on M5441x
-        help
-          Support for the Sysam stmark2 open-hardware generic board.
+	bool "Sysam stmark2 board support"
+	depends on M5441x
+	help
+	  Support for the Sysam stmark2 open-hardware generic board.
 
 config FIREBEE
 	bool "FireBee board support"
-- 
2.17.1

