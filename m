Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615252063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfCFSw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:52:26 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfCFSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:52:26 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mg6mG-1gamQD3wBa-00hgdi; Wed, 06 Mar 2019 19:52:24 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] drivers: thermal: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:52:22 +0100
Message-Id: <1551898342-19308-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:f8X5uOOlThPBguGoyP7xnhVdhvJTmeY0c2dzecpQ9qPGksmvnAw
 qCF9PX0GYRYnwVR6fAznr/PHdO5+tRdbaOCO4jMhLZ9UcYEa9YdatxBQYNJVmXKM5ghh8nu
 v+nj1ggzg9K0vqNY8zMfYUmddqC2urSYJQcyXnuVLHO4dtKU/O3V9F+m0bTIfiEOeF2f46P
 ZXW9z9oHYIn9RpbXdZAow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yta/PsAQHFU=:6NfTbnvqMur/xcW1orqt6b
 iSehflfKbMcvP30mn57WAFoRPerU1dLbwtNQDHbmBH3mLM4YydcOCtGiapkEc9U9/heDetXnH
 tiy7NBh/Ady7egD7NpOKI7PUwPE76p6str/Jnj2YobmTxUeNYcFjJPxQrc+apZ/0ct93GGEUr
 G37pEjEGSvfyQxiN0ygYxvJHaPf6o4QBAiWzN/mCS2JNg+Dv0FgMtNvI4KsAPuXTG80WlK7B5
 C4fh18N1UfJaQJrjM+W0X5iqoEIPmeTFEOLLiuU8PI/2d2pgTFoQhOVft7EmDdh+0jSZh/4t4
 VCnn6RyOqNCE9D4XQMxWzHhPO1hnFwn1tYJLTgPHEdwdyMvGkwxbXxzuwS41XIguNGnNM8Dmu
 hcwS25dRFIjpXZxfydlROrgVoTu5fnhMNp9OiDTkmdkqBZ/mlsF0eq/XfpRrPBoQbaF/iGZXx
 +8brh7UlpMm/p2sejCXIZfdweCBOFUHkFXVEPhkew4Ey1py4tD0SGETuElTv2UDxxDuJ2d+23
 Jkgen/OxbkQFT/MahCbb/nMRl6mFVt9Yfo9IYseRGjFHvmNUrbN3uouOn2m0dZAOo7mTbNhCF
 sI+1zqNpI8m9F2DOWpXfS6H6V+UjUxt8LGGI/C0a5q94wpG1DbYOPNyhbpb+WkW1ZiMSGs+iz
 Z3gPIJKlDurBdWKUp7GcaNpACQXhaXLIGEQxXbrcq5JhItPkwT+LkazTydpZCE75Fb3p19g8d
 se8UIY0J1EoVxEc1ByKqeREA0O1RjeDPEoNyLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

