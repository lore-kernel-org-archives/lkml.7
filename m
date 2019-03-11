Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C45206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfCKN01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:27 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ml6i2-1ge9Ya2zJk-00lSEh for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 069/114] drivers: perf: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:21 +0100
Message-Id: <1552310346-7629-70-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5e2pTlhpal6ZXW15i002/jqRn+UXmjUwFf1K9ULXA2gt/qj8SEa
 nJW3cxMf+QEuqtHeAP9mO6fyRK3yXGQfy47msTCA8jp1vRbsSgljgkFaXsVOynKRaNVCLGT
 qH/HOAivUM5sI3juyS2jERMOc4XPZX2Gmsmn0kyEmwyRIajIOB0NasBPXXzBHcL3VUjqJhQ
 0h4AYrGEdXOhVr5ZIu5ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fm8a3xJIN6k=:3nSamFLM8Rt379m2CTGsh5
 qyAkQ5G6I7lFSQTMn673dy1DPAM6NvLkbaS/EAvpL6CIEyojFXAReKVbzUIJFDD3AYKDv4r2J
 KGOH71uhnvm39UN/XQdFndd/yxe2PO8oo0NOpLkIIcgr9PIReiPzUlWgkl9we7gZdVP1jguVG
 472UjF8fiovgcpnPgA6PAsOnr4nHSVAKmjQCtnIB/sj0MU7puLo//zDZP5LIshGjEBWzp+QXz
 2BdQ/wfyxjZfJ5q/ZsMrxEY0u5IKcdZFQrosCpUfpS5buDSyYjp3AEzBVhHnlLVtmwhn2aOpc
 EGw8/rbc0RYbL3LWn6YwBD+xOic+ULXGjILQzNKIWrqzWiXh0DY08HD5JYYl55d/FZUmFBMvi
 7Jmu4IYEZTRQvLrnM96m6T7TC5GmzhRI/WuUbLgYaobLiaa1QqVq+KP940DaGZ7Sm+xM5ndX6
 /UoGfGfEyv2Yx/orQULSV2fA8YOP9NoQDegmrNpRVmPEbqpHqpjdSg3XTYz3bV3uMetuIACxc
 HdZjTETHtz/JXY0+TLkUxQUsnxStbjm3nK5AA3MZ2hatTj8zp7Clbd04m7A2C+LSMLYcJ5OZc
 U/hEMBTZGS1BL5IwavJocGC1F0y0kKuzhUWjhqCZME0JVAZCg7M0848BYBsSGB4MTEkWc7pqv
 Xq47z/jif3S0nhKy/F7v9Al8l8OsiTOypy6wy6WwISI3iJL2zH+G1dNmIoxupk1fPSDDUu526
 +eF+EAaPwteVlpV7idJvFILDwDKiPTSk1SIjIg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/perf/Kconfig | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index af9bc17..468d759f 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -62,11 +62,11 @@ config ARM_DSU_PMU
 	  to DSU.
 
 config HISI_PMU
-       bool "HiSilicon SoC PMU"
-       depends on ARM64 && ACPI
-       help
-         Support for HiSilicon SoC uncore performance monitoring
-         unit (PMU), such as: L3C, HHA and DDRC.
+	bool "HiSilicon SoC PMU"
+	depends on ARM64 && ACPI
+	help
+	  Support for HiSilicon SoC uncore performance monitoring
+	  unit (PMU), such as: L3C, HHA and DDRC.
 
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
@@ -82,26 +82,26 @@ config QCOM_L3_PMU
 	depends on ARCH_QCOM && ARM64 && ACPI
 	select QCOM_IRQ_COMBINER
 	help
-	   Provides support for the L3 cache performance monitor unit (PMU)
-	   in Qualcomm Technologies processors.
-	   Adds the L3 cache PMU into the perf events subsystem for
-	   monitoring L3 cache events.
+	  Provides support for the L3 cache performance monitor unit (PMU)
+	  in Qualcomm Technologies processors.
+	  Adds the L3 cache PMU into the perf events subsystem for
+	  monitoring L3 cache events.
 
 config THUNDERX2_PMU
 	tristate "Cavium ThunderX2 SoC PMU UNCORE"
 	depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
 	default m
 	help
-	   Provides support for ThunderX2 UNCORE events.
-	   The SoC has PMU support in its L3 cache controller (L3C) and
-	   in the DDR4 Memory Controller (DMC).
+	  Provides support for ThunderX2 UNCORE events.
+	  The SoC has PMU support in its L3 cache controller (L3C) and
+	  in the DDR4 Memory Controller (DMC).
 
 config XGENE_PMU
-        depends on ARCH_XGENE
-        bool "APM X-Gene SoC PMU"
-        default n
-        help
-          Say y if you want to use APM X-Gene SoC performance monitors.
+	depends on ARCH_XGENE
+	bool "APM X-Gene SoC PMU"
+	default n
+	help
+	  Say y if you want to use APM X-Gene SoC performance monitors.
 
 config ARM_SPE_PMU
 	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
-- 
1.9.1

