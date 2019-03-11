Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9348BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC2D2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCKNY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:58 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0G5h-1gor4230at-00xN1w for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 077/114] drivers: clk: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:29 +0100
Message-Id: <1552310346-7629-78-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:UHmyBvTZkLdgQf7dXArNGMN5u70VIh6hvYEgxD7ajFU7wAus2Kw
 aBDBz4aJhjO23w8Y8jYC6s6wsm5tYQf2yd6V11/4Kr3ZUFJGCkYFTActYvcxBGVykSJmuFU
 kJ07TaeXYFhcsTqxGHKDAD586GHwLxkVuabeMzK4WTvO5jwHCohF7YNVuRXF9f3WpNKRgTG
 1eZ8XhYIYdaoJyWD4UGDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m82uEzuEZvs=:D72EnS/zjeV3q1w+6UCZjD
 hL2psc+Hq3Qv9xo003FOMSzZ07dNm8mRaxrDia/npZI13xwCRKZjcaNeBEdwHnsF3Iqn24QOF
 w2D5vFNp1AynXZSHPURFudcEFQojSyeGG/aQc6i3KIQ0Iv9OoVzRZNcD++oKPEX1/r3SpA1ls
 seHuIEKkc7ecEzrrGC4sAOWstpBjxzcOyEH6iHpgNQj/qoy3frQW7cZI+MMasCHO+zwxVdaVt
 qoZLqcklTez17ek+d2zHPp9Lg/Xnl6uwSh+v0wa5PDfmdQyYsXNwga8pZ7tttURfU7I2bSvFK
 S2XwAnLiJxFEI2jM8ju8DSzgSdv2/vGa4huJk//oP/MAojZw/k6hVpShINUEgefEnYP70dGSl
 FLyLiG0Q9fd9RgUHKoDN/mSXXneFyjus+lHYA49iMoxD7OQu/0164teKCXTPJ+9e8hPy0bT98
 5WiydFI/uVXeJ71jX6FHTDAKYoDfRWDJt9ui9dluOQbWDO/sViaERw5bfc++PvRR5qzihQDnc
 ju2OCDJ+OYEZ9m6j5SL43oUrzAD8Dvp0gG+X6//V9JVtvjGbBJdKJ+fgFsy6bMTCm5T6C3UH+
 kZDNI3NPAq/nitGzX2H3lN2GIpXDZdqzsl0Jf8sIIFIvWy7fA9VE/zpJZKNd6PGZPuxY3auZ/
 76l13LPosSXqc1dL/feQ/mL021fHlCmtoRIw0wYhKVbihkyVscqd1VCamLSuX4vExZpaeXfMy
 XPbCXkOcuAG90Lvkafg85jdn38y3r0GRQp3CQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/Kconfig           |  2 +-
 drivers/clk/imx/Kconfig       |  2 +-
 drivers/clk/mediatek/Kconfig  | 44 +++++++++++++++++++++----------------------
 drivers/clk/mvebu/Kconfig     |  2 +-
 drivers/clk/qcom/Kconfig      | 12 ++++++------
 drivers/clk/versatile/Kconfig |  2 +-
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d2f0bb5..c988a1d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -26,7 +26,7 @@ config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
 	---help---
-          Supports the clocking subsystem of the WM831x/2x series of
+	  Supports the clocking subsystem of the WM831x/2x series of
 	  PMICs from Wolfson Microelectronics.
 
 source "drivers/clk/versatile/Kconfig"
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 4aae31a..48bc676 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -12,7 +12,7 @@ config CLK_IMX8MQ
 	bool "IMX8MQ CCM Clock Driver"
 	depends on ARCH_MXC && ARM64
 	help
-	    Build the driver for i.MX8MQ CCM Clock Driver
+	  Build the driver for i.MX8MQ CCM Clock Driver
 
 config CLK_IMX8QXP
 	bool "IMX8QXP SCU Clock"
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 53edade..308772fa 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -117,36 +117,36 @@ config COMMON_CLK_MT2712_VENCSYS
 	  This driver supports MediaTek MT2712 vencsys clocks.
 
 config COMMON_CLK_MT6797
-       bool "Clock driver for MediaTek MT6797"
-       depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
-       select COMMON_CLK_MEDIATEK
-       default ARCH_MEDIATEK && ARM64
-       ---help---
-         This driver supports MediaTek MT6797 basic clocks.
+	bool "Clock driver for MediaTek MT6797"
+	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK && ARM64
+	---help---
+	  This driver supports MediaTek MT6797 basic clocks.
 
 config COMMON_CLK_MT6797_MMSYS
-       bool "Clock driver for MediaTek MT6797 mmsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 mmsys clocks.
+	bool "Clock driver for MediaTek MT6797 mmsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	  This driver supports MediaTek MT6797 mmsys clocks.
 
 config COMMON_CLK_MT6797_IMGSYS
-       bool "Clock driver for MediaTek MT6797 imgsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 imgsys clocks.
+	bool "Clock driver for MediaTek MT6797 imgsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	  This driver supports MediaTek MT6797 imgsys clocks.
 
 config COMMON_CLK_MT6797_VDECSYS
-       bool "Clock driver for MediaTek MT6797 vdecsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 vdecsys clocks.
+	bool "Clock driver for MediaTek MT6797 vdecsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	  This driver supports MediaTek MT6797 vdecsys clocks.
 
 config COMMON_CLK_MT6797_VENCSYS
-       bool "Clock driver for MediaTek MT6797 vencsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 vencsys clocks.
+	bool "Clock driver for MediaTek MT6797 vencsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	  This driver supports MediaTek MT6797 vencsys clocks.
 
 config COMMON_CLK_MT7622
 	bool "Clock driver for MediaTek MT7622"
diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index fddc8ac..a765b0b 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -25,7 +25,7 @@ config ARMADA_39X_CLK
 	select MVEBU_CLK_COMMON
 
 config ARMADA_37XX_CLK
-       bool
+	bool
 
 config ARMADA_XP_CLK
 	bool
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1c04575c..c866cab 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1,6 +1,6 @@
 config KRAIT_CLOCKS
-       bool
-       select KRAIT_L2_ACCESSORS
+	bool
+	select KRAIT_L2_ACCESSORS
 
 config QCOM_GDSC
 	bool
@@ -67,10 +67,10 @@ config QCOM_CLK_RPMH
 	tristate "RPMh Clock Driver"
 	depends on QCOM_RPMH
 	help
-	 RPMh manages shared resources on some Qualcomm Technologies, Inc.
-	 SoCs. It accepts requests from other hardware subsystems via RSC.
-	 Say Y if you want to support the clocks exposed by RPMh on
-	 platforms such as SDM845.
+	  RPMh manages shared resources on some Qualcomm Technologies, Inc.
+	  SoCs. It accepts requests from other hardware subsystems via RSC.
+	  Say Y if you want to support the clocks exposed by RPMh on
+	  platforms such as SDM845.
 
 config APQ_GCC_8084
 	tristate "APQ8084 Global Clock Controller"
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 8aa875f..5607683 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -8,7 +8,7 @@ config COMMON_CLK_VERSATILE
 		COMPILE_TEST
 	select REGMAP_MMIO
 	---help---
-          Supports clocking on ARM Reference designs:
+	  Supports clocking on ARM Reference designs:
 	  - Integrator/AP and Integrator/CP
 	  - RealView PB1176, EB, PB11MP and PBX
 	  - Versatile Express
-- 
1.9.1

