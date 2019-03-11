Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CEB222B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfCKNaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:30:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MlfCm-1gcUb216he-00iiPh for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:30 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 020/114] drivers: thermal: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:32 +0100
Message-Id: <1552310346-7629-21-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:bKE8JEO8jyEatvL8QMwpMR54rm18KRlYedy4kUOd8Lf4KVpZdCo
 fwWJUd2a44FVMvD3hBfYJbP6kLbOAWiLmiYg4Pe23sF9SqYmHNwz/rXDMgfSQd8BdwNj9wj
 m4+mVVjddtga69lQJFukPgrx7eaxM7NLetioF+MZtWI8qdUTZAIY6l+yzVDj71HfU0gheSW
 ukoz32JmgqX17EfrnOzuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J+n3RWAPgx0=:65cyDip2hk285pnu/aBGc1
 qFHFLK/TiwCuVmgfYypCiuy+9+CYZkitJMl2b/2+bSLjYL2mEGZu3LPt00+zx0JBezpvjkXVm
 aml2yoJF5q5Zk2xB7tuII6zXUC+35SVqCbyzIeqMyWnZGuYGSL6EgzUtRe3Z1/MxYGUdS7wFW
 Vn5lUemjZPkbFao5hy6uB5XJXGh9mQW434PXv7S2BPuwmo6w9rj9wA2jea1MPkWePjv6kv3U9
 pcDKunkaaMeznUlB3TFxQqFLuIJ/mkNklmQ/mDREpwBZNDM/mqeJInnG7bS18s7AUWrAfUrHC
 pKQ/Ft8FI6RJ+MHjZuSq5wm/faofxiZxdvT2btpLFO9ggjQ3ZA1K9mTCEdkuG3o8WgzguiBU5
 prnGNecSMFLUn68kPXogGsKWnFsC4fTHzZ2KtIZU1Cn/ouupfZHrb7jAB6ZNQKnIpfkzou5/F
 yHtoxFuGfC8c/BCCk8whRlKImYCrVy30mRhHl7C7X5HWKFpQxpWJDVGerE5A7FbW6Q10H3KAR
 antTIdpX3lm/zPYNtTWWrzDQdh88ZVsmWGozmKvQLPh2qUPJ9TuafkkQixlJmjhENzn5aBJm3
 qmQEdLAegrr6zCZoslrQfUBbBVyjSkzh3aNH5TYW5UDouhIWiKGQWl8Oo097Bcp+iUPnwl4JB
 3rIT137scxBq0rNuhfmvPQGbuNLp6Aw+ZQkOI6snEGJ3ynS5/NNXRxYWxo0XmD0nh7J4uRGES
 zyypQ11D4yPbQUY+qbw6mT21+cfzHYGHFGwd8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/thermal/st/Kconfig    | 22 +++++++++++-----------
 drivers/thermal/tegra/Kconfig |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
index b80f9a9..d8b1a45 100644
--- a/drivers/thermal/st/Kconfig
+++ b/drivers/thermal/st/Kconfig
@@ -3,9 +3,9 @@
 #
 
 config ST_THERMAL
-       tristate "Thermal sensors on STMicroelectronics STi series of SoCs"
-       help
-         Support for thermal sensors on STMicroelectronics STi series of SoCs.
+	tristate "Thermal sensors on STMicroelectronics STi series of SoCs"
+	help
+	  Support for thermal sensors on STMicroelectronics STi series of SoCs.
 
 config ST_THERMAL_SYSCFG
 	select ST_THERMAL
@@ -16,11 +16,11 @@ config ST_THERMAL_MEMMAP
 	tristate "STi series memory mapped access based thermal sensors"
 
 config STM32_THERMAL
-       tristate "Thermal framework support on STMicroelectronics STM32 series of SoCs"
-       depends on MACH_STM32MP157
-       default y
-       help
-	Support for thermal framework on STMicroelectronics STM32 series of
-	SoCs. This thermal driver allows to access to general thermal framework
-	functionalities and to acces to SoC sensor functionalities. This
-	configuration is fully dependent of MACH_STM32MP157.
+	tristate "Thermal framework support on STMicroelectronics STM32 series of SoCs"
+	depends on MACH_STM32MP157
+	default y
+	help
+	  Support for thermal framework on STMicroelectronics STM32 series of
+	  SoCs. This thermal driver allows to access to general thermal framework
+	  functionalities and to acces to SoC sensor functionalities. This
+	  configuration is fully dependent of MACH_STM32MP157.
diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
index f8740f7..fc0b33b 100644
--- a/drivers/thermal/tegra/Kconfig
+++ b/drivers/thermal/tegra/Kconfig
@@ -14,7 +14,7 @@ config TEGRA_BPMP_THERMAL
 	tristate "Tegra BPMP thermal sensing"
 	depends on TEGRA_BPMP || COMPILE_TEST
 	help
-	 Enable this option for support for sensing system temperature of NVIDIA
-	 Tegra systems-on-chip with the BPMP coprocessor (Tegra186).
+	  Enable this option for support for sensing system temperature of NVIDIA
+	  Tegra systems-on-chip with the BPMP coprocessor (Tegra186).
 
 endmenu
-- 
1.9.1

