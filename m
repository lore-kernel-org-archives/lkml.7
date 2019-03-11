Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A45C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF11B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfCKNWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfCKNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:43 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MIxBc-1hMWeK0L3y-00KTR3 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 109/114] drivers: clocksource: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:19:01 +0100
Message-Id: <1552310346-7629-110-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:u5ocUO4e+lnEg8IXrwNyZbjXMAxU14qnj/DcllXvVX+YbJW1a3R
 nq0baLtHRhC/SeY8xSENBYo2DBtwllq5l0rpIfMgua4QrBX9KdPRMGPMoi6iskAnOnp9/0n
 2JfpXs4lwJxtRuKyS630DTr+cM0IYqzyCOu4DfLui2iq1IRnjnoD/NXAghKPUhAnU7aQjJ0
 vA5voUEkmHp7UfNlwpH5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3GzBpYdaTFE=:ED7piXWIg7omQuBnQBIZaG
 O11YjT3mSHQ2wXPPIyWLNl2j1OiPzMl//SqEQAvNhjqolGwZ/k8egWivVlsVxNf/V1WL49UBs
 DfOveoVAs7dAynGGru++zYnRtXCOdu6YHr7DCm2JgbClfPLj1DU8TLyoaacdCC9NJKSyhKikJ
 e0ZSmduj5e1Okvwd6+wAE7TV/dXEThdKuxy7N085UY8MMd/MjxDlSCGJE7qMmmOwqAf32dW7d
 sLYCXXQn0vmngda0hR/CwKYlGXJ3vN3DWWHuarKAlVCu373Yi1vyq1Dj+iBReDKJpNbDMsdgp
 e0b6cd0KynGad3opwkvFt8J/DfSThCcsHruhJRXDUWeU3mj5+5/TbZSfJTMdV++UIFHHX0Rr2
 30Rqbqq00sxE05IKCuQdDuCaMpEhNNiR+jGb6XS3O8GxndHh4SzwOmio0XSiQY1Pi9QDu6/ce
 yzIqGaIpldlP1EThirsJZY53gLZQejntsVrK3b7UPdwc9v/+Uec8Tqt0dEMHHx5UZi26VDs8O
 3ndfvapBSORxap5tehyqQClOzKjMP6nT6Z3SAko359pf/kD9zUhYyBjNfbF9mLc4CiFqH9NW3
 5w3NwdZhYBpLT1LBavx4s0tlWPPOMnLHayAmN0GJzYUYd1zy5KkaaJsNrp5XJ5duOqyA3M+2c
 dgtWeVRW0qhkW2RQTLxDelYV3YpIhvuIO148ZEP3/PLik996bgHoxaA6+OHh1MivX2621Uu5W
 OV9VX3qhRelvBhBWGzSjoQdkfgtsY2gEjUH2KA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clocksource/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a..4e5b091 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -389,7 +389,7 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	depends on ARM_GLOBAL_TIMER
 	default y
 	help
-	 Use ARM global timer clock source as sched_clock
+	  Use ARM global timer clock source as sched_clock
 
 config ARMV7M_SYSTICK
 	bool "Support for the ARMv7M system time" if COMPILE_TEST
@@ -446,7 +446,7 @@ config OXNAS_RPS_TIMER
 	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
 
 config SYS_SUPPORTS_SH_CMT
-        bool
+	bool
 
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
@@ -466,13 +466,13 @@ config SPRD_TIMER
 	  Enables support for the Spreadtrum timer driver.
 
 config SYS_SUPPORTS_SH_MTU2
-        bool
+	bool
 
 config SYS_SUPPORTS_SH_TMU
-        bool
+	bool
 
 config SYS_SUPPORTS_EM_STI
-        bool
+	bool
 
 config CLKSRC_JCORE_PIT
 	bool "J-Core PIT timer driver" if COMPILE_TEST
@@ -566,21 +566,21 @@ config CLKSRC_PXA
 	  platforms.
 
 config H8300_TMR8
-        bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 8 bits timer for the H8300 platform.
 
 config H8300_TMR16
-        bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 16 bits timer for the H8300 platform with the
 	  H83069 cpu.
 
 config H8300_TPU
-        bool "Clocksource for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clocksource for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the clocksource for the H8300 platform with the
 	  H8S2678 cpu.
-- 
1.9.1

