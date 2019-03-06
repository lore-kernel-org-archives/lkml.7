Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F142206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfCFWF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:05:29 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:33401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:05:29 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3UlW-1h2Ctb3uXy-000bN0; Wed, 06 Mar 2019 23:05:26 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2] drivers: thermal: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 23:05:24 +0100
Message-Id: <1551909924-25233-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551898342-19308-1-git-send-email-info@metux.net>
References: <1551898342-19308-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Rs/xNDBXti5dzAkyWzVD/5C0CwToSOExcugjaJV5TChGap7N44J
 y90WPfcnAJ62Pbmyf54ITUigbdxZXiFpnDommLKjUAz7IoLdher5qf7izruKbR+rJtFjvFk
 Ln4tPtF7s/nR3VcQen1Q+HaE5lIOL18rGqQVrM6Q1XBXlCiG3iPYvj4AiTzWuWvNvDkj8QQ
 seMO5TAb47BJj7t7bdstg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:myr7Zy8Gg2Y=:NYd2OdgUguZpPUkTV7Gken
 czdrXBFJ6capAbnSVJFU6uD2SyBEAugO4kVfEHSSnXABxneQeq40mharWHcHYnH0EovZ8oo3Z
 IXQUzZN/yBzYbHiX3+UXniq5ueopQa7NjXEaH/uF7l40ZQvi9D+AixFmcYjAqe5v2QV+KIMQb
 XdHA4AdG4xh3v2CxpBdHiltCdO1EyOG9tQ82BKvDfTI4akIhkdO35/w7nBLbfYPjp0qUPDENR
 FxkCj259pra/j4moifM4dnwNPq4u4Bq32vcpWXt4rGS4hiwM7T+kFDkkRkzKd15XLI0XdzNja
 IWqxjJF7mS7Tx6Toro9YotmGyGHJ/XViP0xmV4C2VQuLKaofHN3dq1OoyH88U6NF2i79OT+Js
 jbyU4Nqj0xYyTLAhyDXtXfgAXU1uPnDiz+9YtTOrNUywOmHRbzqMBYVZiE4N9hWskVGzhtgzJ
 ty54UVE+i1XatoVVVZB/luzeMvct1hrRzrQHITWmstcyZB2RDb7RWUDBVqFSjFBcMjkqrwgYV
 mQg5v1Tlbp9KiEFuX+MoeaViTU0GIXtJqJQhNHv5ZdtuISyyXgkgFAHp1AV+vXWDLC2VJLYXv
 E+a9M/J0sI8BmaEfV30/YNWNtI832sDk0DA84QXfCHKbMijzBMemYi3tq7xIgSlz3PYf1VUv/
 yXd/9+UyItWDz2TOxeDfn+B2ytAi38UyE9gxAzCQfzlE1OdMksURvjVxoccIwKC17msAQUjxl
 OKmLuAoz3YfA7WKOTFEB/frg6p4fHAO3bSUIMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

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

