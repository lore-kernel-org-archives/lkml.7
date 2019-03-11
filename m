Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A17F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfCKN06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfCKNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:37 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsYzF-1gnk440Jxr-00u5Ee for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 057/114] drivers: power: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:09 +0100
Message-Id: <1552310346-7629-58-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Vp5mMWrzkTob7NWgoKgC8cQ6Ms0L+FzLPBMvGCv7OcEcJqh2yiv
 HF5Q8Diyu7O/odpNE57G3SFKpaJdPHb4XHPUDuWZ8VSYBm57vQ9GG5Rx0gbFphlCvNqSiC2
 pUVtjw2wQsPbVZGNXOv+0Rr5zaK7a1v5UyH6W2AT1tnwC2kaigoZ8xj18ZvhTHJEswobovL
 G+DIhLPZhldB3rUB6BRrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9tnk5u3vBM=:YuOEtRqVMEyW3Jeb6iwqC1
 SxDQjAAPyPnxU5k2dhWSKqqCY2caXKNxgoXfcQn2qKRPDGa7lPCBnGSyWDxBoGRZBkVB7dzx5
 FNMYFge8kHg+fm5ibOdXDaY2Bqb0Cpy+rkUnKTAzHRkvRHXzDIV/zZyFv29rJbnTP0vGKr6UT
 CSdYCL0ICp/bz/1Auq2FNiPrS5qd+VZbvOIVtnvI4W16bFIVTdAR4EeoT1yIfKWcO9T8uz3hM
 2mi9MLiPTIMRYo94OC5w+3XRUULuINpVL118s7pMSy9lvuMx3lereXxkybiloHzNAj6o7uhGz
 08YhW1zVF1+PSoowLsADhJqOM58V16wBnyvo5MmFui2it8LYzp0+1YReHiPaD6dCAt2AcodXO
 93FZmQhwzvFAbe4B2CvzRpe1TVE6Ldjmi86jMUIk8d2tXkH6/tcAhWWymfbDOsbuouMghXrnZ
 /6DC/sKWiUnmgakc3ccr8gj3tLyczgwrKsa0OQ+lG9YH0rfygtFEDahuXR3yoGXDSfQUcLLxw
 YhFhrLUszC7mdLNvz5wSW4TNhJvFHEHPHtW+swuL0IJC8yt/OcgVHwFGzRlTypAmbbMYt7Yab
 IfNSPSCkssoUIFJiF9aC4ioEV0wlElAGxRbM7+0ALqPslCvQ7YyuOlCaFnSVJ/K+b/rPEIufN
 Mg40jzfRpRmx4B1j5+eI3JsyyeO68FzMGPMDcIa3gIeNpfyPAF3f1Hyzj/lmdIy3zxJcMEenE
 rcGrDzEgs+b9+oLlPB0nce9ixuvqX7rkikYZ2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/power/avs/Kconfig    | 12 +++++------
 drivers/power/supply/Kconfig | 48 ++++++++++++++++++++++----------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index a67eeac..4c25d1c 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -12,9 +12,9 @@ menuconfig POWER_AVS
 	  Say Y here to enable Adaptive Voltage Scaling class support.
 
 config ROCKCHIP_IODOMAIN
-        tristate "Rockchip IO domain support"
-        depends on POWER_AVS && ARCH_ROCKCHIP && OF
-        help
-          Say y here to enable support io domains on Rockchip SoCs. It is
-          necessary for the io domain setting of the SoC to match the
-          voltage supplied by the regulators.
+	tristate "Rockchip IO domain support"
+	depends on POWER_AVS && ARCH_ROCKCHIP && OF
+	help
+	  Say y here to enable support io domains on Rockchip SoCs. It is
+	  necessary for the io domain setting of the SoC to match the
+	  voltage supplied by the regulators.
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879..51f496c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -58,10 +58,10 @@ config WM831X_POWER
 	  provided by Wolfson Microelectronics WM831x PMICs.
 
 config WM8350_POWER
-        tristate "WM8350 PMU support"
-        depends on MFD_WM8350
-        help
-          Say Y here to enable support for the power management unit
+	tristate "WM8350 PMU support"
+	depends on MFD_WM8350
+	help
+	  Say Y here to enable support for the power management unit
 	  provided by the Wolfson Microelectronics WM8350 PMIC.
 
 config TEST_POWER
@@ -183,16 +183,16 @@ config BATTERY_WM97XX
 	  Say Y to enable support for battery measured by WM97xx aux port.
 
 config BATTERY_SBS
-        tristate "SBS Compliant gas gauge"
-        depends on I2C
-        help
+	tristate "SBS Compliant gas gauge"
+	depends on I2C
+	help
 	  Say Y to include support for SBS battery driver for SBS-compliant
 	  gas gauges.
 
 config CHARGER_SBS
-        tristate "SBS Compliant charger"
-        depends on I2C
-        help
+	tristate "SBS Compliant charger"
+	depends on I2C
+	help
 	  Say Y to include support for SBS compliant battery chargers.
 
 config MANAGER_SBS
@@ -389,7 +389,7 @@ config CHARGER_PCF50633
 	tristate "NXP PCF50633 MBC"
 	depends on MFD_PCF50633
 	help
-	 Say Y to include support for NXP PCF50633 Main Battery Charger.
+	  Say Y to include support for NXP PCF50633 Main Battery Charger.
 
 config BATTERY_JZ4740
 	tristate "Ingenic JZ4740 battery"
@@ -469,11 +469,11 @@ config CHARGER_MANAGER
 	depends on REGULATOR
 	select EXTCON
 	help
-          Say Y to enable charger-manager support, which allows multiple
-          chargers attached to a battery and multiple batteries attached to a
-          system. The charger-manager also can monitor charging status in
-          runtime and in suspend-to-RAM by waking up the system periodically
-          with help of suspend_again support.
+	  Say Y to enable charger-manager support, which allows multiple
+	  chargers attached to a battery and multiple batteries attached to a
+	  system. The charger-manager also can monitor charging status in
+	  runtime and in suspend-to-RAM by waking up the system periodically
+	  with help of suspend_again support.
 
 config CHARGER_LTC3651
 	tristate "LTC3651 charger"
@@ -587,15 +587,15 @@ config CHARGER_TPS65090
 	tristate "TPS65090 battery charger driver"
 	depends on MFD_TPS65090
 	help
-	 Say Y here to enable support for battery charging with TPS65090
-	 PMIC chips.
+	  Say Y here to enable support for battery charging with TPS65090
+	  PMIC chips.
 
 config CHARGER_TPS65217
 	tristate "TPS65217 battery charger driver"
 	depends on MFD_TPS65217
 	help
-	 Say Y here to enable support for battery charging with TPS65217
-	 PMIC chips.
+	  Say Y here to enable support for battery charging with TPS65217
+	  PMIC chips.
 
 config BATTERY_GAUGE_LTC2941
 	tristate "LTC2941/LTC2943 Battery Gauge Driver"
@@ -649,15 +649,15 @@ config CHARGER_SC2731
 	tristate "Spreadtrum SC2731 charger driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
 	help
-	 Say Y here to enable support for battery charging with SC2731
-	 PMIC chips.
+	  Say Y here to enable support for battery charging with SC2731
+	  PMIC chips.
 
 config FUEL_GAUGE_SC27XX
 	tristate "Spreadtrum SC27XX fuel gauge driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
 	depends on IIO
 	help
-	 Say Y here to enable support for fuel gauge with SC27XX
-	 PMIC chips.
+	  Say Y here to enable support for fuel gauge with SC27XX
+	  PMIC chips.
 
 endif # POWER_SUPPLY
-- 
1.9.1

