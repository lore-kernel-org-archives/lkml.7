Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B7C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BFA20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306343;
	bh=9Ksqhhd1L7R8tO8N1qP062uhuD/S93g4xX+3n7nrjuk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=P6oxVjhkzuDL96OF+DunGxNTEdvXx+jSaRMQmKjRHftiHJzDc/mem1E1uJOafE82e
	 bevOuEPebLAhT4YAzfPYMJGj5KO9qyWFnDx4hAvu1Xou1TgTLzy0CDxudq58POMnRs
	 gzIcNFjkvcnI/54VXpllkE3GxSOzSKNn9wTA21Lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKUDTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUDTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:01 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A6820898;
        Thu, 21 Nov 2019 03:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306340;
        bh=9Ksqhhd1L7R8tO8N1qP062uhuD/S93g4xX+3n7nrjuk=;
        h=From:To:Cc:Subject:Date:From;
        b=dhjxDrCGeRc2byEQxgwNLsSWWxA7ebiuc5DOawNk7mBXmN8SBRIeMGPYM1L+rtUsk
         jw5AuZek5sXPBBufjND8mFIc8AMxc1Xv0+fQ4GjTQqcegDJyr8JlxRHhMzoDZbTaWx
         V8psmrv+ovo0Q7Mfd7RsK//vg6HkD+Uq/hzXOUYc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] clk: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:18:55 +0100
Message-Id: <1574306335-29026-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/clk/Kconfig           |  2 +-
 drivers/clk/mediatek/Kconfig  | 44 +++++++++++++++++++++----------------------
 drivers/clk/mvebu/Kconfig     |  2 +-
 drivers/clk/qcom/Kconfig      |  4 ++--
 drivers/clk/versatile/Kconfig |  2 +-
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0530bebfc25a..b8ebf7b93d63 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -27,7 +27,7 @@ config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
 	---help---
-          Supports the clocking subsystem of the WM831x/2x series of
+	  Supports the clocking subsystem of the WM831x/2x series of
 	  PMICs from Wolfson Microelectronics.
 
 source "drivers/clk/versatile/Kconfig"
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 7efc3617bbd5..e4c7cb518cda 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -174,36 +174,36 @@ config COMMON_CLK_MT6779_AUDSYS
 	  This driver supports Mediatek MT6779 audsys clocks.
 
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
+	 This driver supports MediaTek MT6797 basic clocks.
 
 config COMMON_CLK_MT6797_MMSYS
-       bool "Clock driver for MediaTek MT6797 mmsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 mmsys clocks.
+	bool "Clock driver for MediaTek MT6797 mmsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	 This driver supports MediaTek MT6797 mmsys clocks.
 
 config COMMON_CLK_MT6797_IMGSYS
-       bool "Clock driver for MediaTek MT6797 imgsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 imgsys clocks.
+	bool "Clock driver for MediaTek MT6797 imgsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	 This driver supports MediaTek MT6797 imgsys clocks.
 
 config COMMON_CLK_MT6797_VDECSYS
-       bool "Clock driver for MediaTek MT6797 vdecsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 vdecsys clocks.
+	bool "Clock driver for MediaTek MT6797 vdecsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	 This driver supports MediaTek MT6797 vdecsys clocks.
 
 config COMMON_CLK_MT6797_VENCSYS
-       bool "Clock driver for MediaTek MT6797 vencsys"
-       depends on COMMON_CLK_MT6797
-       ---help---
-         This driver supports MediaTek MT6797 vencsys clocks.
+	bool "Clock driver for MediaTek MT6797 vencsys"
+	depends on COMMON_CLK_MT6797
+	---help---
+	 This driver supports MediaTek MT6797 vencsys clocks.
 
 config COMMON_CLK_MT7622
 	bool "Clock driver for MediaTek MT7622"
diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index 415e6906a113..ded07b0bd0d5 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -29,7 +29,7 @@ config ARMADA_39X_CLK
 	select MVEBU_CLK_COMMON
 
 config ARMADA_37XX_CLK
-       bool
+	bool
 
 config ARMADA_XP_CLK
 	bool
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3b33ef129274..f37f3cd615f2 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config KRAIT_CLOCKS
-       bool
-       select KRAIT_L2_ACCESSORS
+	bool
+	select KRAIT_L2_ACCESSORS
 
 config QCOM_GDSC
 	bool
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index ac766855ba16..c2618f1477a2 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -9,7 +9,7 @@ config COMMON_CLK_VERSATILE
 		COMPILE_TEST
 	select REGMAP_MMIO
 	---help---
-          Supports clocking on ARM Reference designs:
+	  Supports clocking on ARM Reference designs:
 	  - Integrator/AP and Integrator/CP
 	  - RealView PB1176, EB, PB11MP and PBX
 	  - Versatile Express
-- 
2.7.4

