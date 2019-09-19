Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A540AC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFFB208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZY0Rkt0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407150AbfISWdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:33:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405879AbfISWd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=caeA/02qRI4RebALR6RnJseaugOqJ+jt25dGBDaeAaI=; b=ZY0Rkt0UIeEu336HG0FLfhTIL
        /DSR9LO+YNj1ZUEDas7ubnvcLhtiOFkWBL+Z8QjbEBI3S7rowrNjgi53qeN0MpEF7C6ivYZUfFekG
        8ifA6XG8I8qtkgnPI/8oR4B7kFR8qr+NEBqpASU0koI9Kdt4cCimBl1zwwx1pbHdFIWcM4JyAggjx
        kjU4MH+G5sB2ambF/XAIw3tx7MOL71LYXXVNHPrQDHVYkqWmLFHawa5ukdM0bOpcoD1yVZnrCzYQf
        RJtWfqQ/IUUHn9PdcfFS6bVXPIFgNkb5sypB7xeGsuGnEUbH7qBksC0dIwgbBDiO1lfwnpxQUyhhW
        11gBPxjEQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iB4zM-0006Wl-EL; Thu, 19 Sep 2019 22:33:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] soc: ti: big cleanup of Kconfig file
To:     LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sandeep Nair <sandeep_n@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>
Message-ID: <8437a1f9-18f2-dd03-4fea-de5ba71f25c9@infradead.org>
Date:   Thu, 19 Sep 2019 15:33:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Cleanup drivers/soc/ti/Kconfig:
- delete duplicate words
- end sentences with '.'
- fix typos/spellos
- Subsystem is one word
- capitalize acronyms
- reflow lines to be <= 80 columns

Fixes: 41f93af900a2 ("soc: ti: add Keystone Navigator QMSS driver")
Fixes: 88139ed03058 ("soc: ti: add Keystone Navigator DMA support")
Fixes: afe761f8d3e9 ("soc: ti: Add pm33xx driver for basic suspend support")
Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")
Fixes: a869b7b30dac ("soc: ti: Add Support for AM654 SoC config option")
Fixes: cff377f7897a ("soc: ti: Add Support for J721E SoC config option")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Sandeep Nair <sandeep_n@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
@Santosh: MAINTAINERS says that you maintain drivers/soc/ti/*,
but there is more that Keystone-related code in that subdirectory
now... just in case you want to update that info.

 drivers/soc/ti/Kconfig |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- lnx-53.orig/drivers/soc/ti/Kconfig
+++ lnx-53/drivers/soc/ti/Kconfig
@@ -7,12 +7,12 @@ if ARCH_K3
 config ARCH_K3_AM6_SOC
 	bool "K3 AM6 SoC"
 	help
-	  Enable support for TI's AM6 SoC Family support
+	  Enable support for TI's AM6 SoC Family.
 
 config ARCH_K3_J721E_SOC
 	bool "K3 J721E SoC"
 	help
-	  Enable support for TI's J721E SoC Family support
+	  Enable support for TI's J721E SoC Family.
 
 endif
 
@@ -27,7 +27,7 @@ menuconfig SOC_TI
 if SOC_TI
 
 config KEYSTONE_NAVIGATOR_QMSS
-	tristate "Keystone Queue Manager Sub System"
+	tristate "Keystone Queue Manager Subsystem"
 	depends on ARCH_KEYSTONE
 	help
 	  Say y here to support the Keystone multicore Navigator Queue
@@ -42,9 +42,9 @@ config KEYSTONE_NAVIGATOR_DMA
 	tristate "TI Keystone Navigator Packet DMA support"
 	depends on ARCH_KEYSTONE
 	help
-	  Say y tp enable support for the Keystone Navigator Packet DMA on
-	  on Keystone family of devices. It sets up the dma channels for the
-	  Queue Manager Sub System.
+	  Say y to enable support for the Keystone Navigator Packet DMA on
+	  on Keystone family of devices. It sets up the DMA channels for the
+	  Queue Manager Subsystem.
 
 	  If unsure, say N.
 
@@ -53,10 +53,10 @@ config AMX3_PM
 	depends on SOC_AM33XX || SOC_AM43XX
 	depends on WKUP_M3_IPC && TI_EMIF_SRAM && SRAM && RTC_DRV_OMAP
 	help
-	  Enable power management on AM335x and AM437x. Required for suspend to mem
-	  and standby states on both AM335x and AM437x platforms and for deeper cpuidle
-	  c-states on AM335x. Also required for rtc and ddr in self-refresh low
-	  power mode on AM437x platforms.
+	  Enable power management on AM335x and AM437x. Required for suspend
+	  to mem and standby states on both AM335x and AM437x platforms and
+	  for deeper cpuidle c-states on AM335x. Also required for RTC and
+	  DDR in self-refresh low power mode on AM437x platforms.
 
 config WKUP_M3_IPC
 	tristate "TI AMx3 Wkup-M3 IPC Driver"

