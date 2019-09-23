Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74999C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB2B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sobzG2RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390516AbfIWBLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 21:11:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbfIWBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cpjWwPHm4c7hDJF1ZArVr7FqrRX3Io65MwLKETdnkek=; b=sobzG2RR1vwvI5mJzXWm/yl8a
        Oe1l+IiBMAqg9WOMbb6PKWwHotSBWdZZsLp2c2Fad+OhE9NMO5PbkM6Oqar4/Q1cJEjZ4mcmWRh1T
        bl5tWpGx1k9dFhkxnZfxijKw++M66UU8khchsXQ7iqq7ZEQ/4swTefGurr3RAEaMsDMjh2x3ltZzT
        eMWFW0QQKoCF6S5j4lQFBIZq52VL9K+bzoQAJS55D+stosHeNcEVDrzO5Ohnj88S1HVrQQNyDsS+b
        DgpwiRozvNi7Ojx3PUcUf/iuHgesYNYj+C+D84TaIQ7MD0e4JNCkbm/W9eDWejL1Ze0Xpzcp0dBhk
        PV7lHpcWw==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCCso-0001um-Dc; Mon, 23 Sep 2019 01:11:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] soc: ti: move 2 driver config options into the TI SOC
 drivers menu
Message-ID: <66f8dce5-4aac-ad8f-d5de-65643b5aa459@infradead.org>
Date:   Sun, 22 Sep 2019 18:11:16 -0700
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

Move the AM654 and J721E SOC config options inside the "TI SOC drivers"
menu with the other TI SOC drivers.

Fixes: a869b7b30dac ("soc: ti: Add Support for AM654 SoC config option")
Fixes: cff377f7897a ("soc: ti: Add Support for J721E SoC config option")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Nishanth Menon <nm@ti.com>
#Cc: Benjamin Fair <b-fair@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
v2: add Santosh (maintainer) for merging
    drop Benjamin Fair (email address bounces)

 drivers/soc/ti/Kconfig |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- lnx-53.orig/drivers/soc/ti/Kconfig
+++ lnx-53/drivers/soc/ti/Kconfig
@@ -1,4 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# TI SOC drivers
+#
+menuconfig SOC_TI
+	bool "TI SOC drivers support"
+
+if SOC_TI
+
 # 64-bit ARM SoCs from TI
 if ARM64
 
@@ -14,17 +22,9 @@ config ARCH_K3_J721E_SOC
 	help
 	  Enable support for TI's J721E SoC Family.
 
-endif
+endif # ARCH_K3
 
-endif
-
-#
-# TI SOC drivers
-#
-menuconfig SOC_TI
-	bool "TI SOC drivers support"
-
-if SOC_TI
+endif # ARM64
 
 config KEYSTONE_NAVIGATOR_QMSS
 	tristate "Keystone Queue Manager Subsystem"
