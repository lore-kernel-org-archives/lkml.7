Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF672084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfCKNZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2OEq-1h3trz1pHi-003txN for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 075/114] drivers: soc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:27 +0100
Message-Id: <1552310346-7629-76-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:WNe5ajDCvAztfws4BppVvCQjFI/iGhfL3Wau5SgcQUwrLQOw3wS
 o9Qs3UDjBfvn6MDFPm8piEwCfAIJQjV9xs4i7THmOhxbLXMFIT4iAFYSqxoOfPWoLt+qbAu
 jx5U8ijZxKH14NY4FP1+XqthQWcrV2HHvnrQfREJZE08MMJ4cEmjndP0PxwpGk+jPsdFAm/
 I1pIkWq31EG0V7NfPclvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0://Ae+MnW+h0=:9xT2SJA9exnqPMYUmmtLlN
 zJCOFY1qrBBvwj+slWWPLLI8EB+VK4xH2Okxlo5pdDpNiwojUQDu17u4Uo/6ytMpyvPKWpb7C
 QxAFNV2LNFzUBBf2P1QL+FlrIwCKqNhHZTwB6yLkQvGiMCQy89FB7gwk9VtBdrycuRKcC281t
 Z0JLdO4c1JD8HWPyyBfusKOglmq7Ru+lnyBdPTe4J+/A1QfjlIkZIJR34kHwdZXqdcGIUS3D6
 TMhn/JZIVfZqOARJzbjHFGypt97kLz0vmUUS1WPUtH1l/CAQ+fwUCd2JPtYucpzapB58RVQrc
 M5KK6vOeDa//eSRNv+i8BGh+GcBjePJK3Af4yLmM5z0vc0frMEU1jaRDmxsc2jTkEU6C6fY6e
 fHMpZCjCWiwsfTsX8ff6RDU/DigeVrrLBeAjOpSs8lWTSkMPI+xvpuWzzt2AWcpqhlhinHKBO
 ovDaf19NaKogOFfFyQuBe5LblPjsLTiXhQIwJuAklpqXyaL0fq4CMyPUymtZasvyzFF7n1w/d
 W0xLMihU28Dr72JQy1DqVw9a5dt3YRgsXoArmkNDGs+Bzyl+uRoxbwo+no/hmkx7a0CQhdWI5
 11G05blpNcw5dDtu4Js2F/NDH2B7PVXAxtWCOmm61vn40TG/zpDY2ii9PIYwCVkyT7MF93nCp
 41peHRNY6o8FZhPktZzygQT41h0SQpGwp4P/ADpfhE4JUe7Y4LKpJ/+HA25P+wj2IKpsyA9Ig
 mTGHgb8UlKC3rqWQUCxRtYHgqQcMO1EJV6zIKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/soc/fsl/Kconfig      |  9 +++++----
 drivers/soc/qcom/Kconfig     | 23 ++++++++++++-----------
 drivers/soc/rockchip/Kconfig | 18 +++++++++---------
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 61f8e14..0db980a 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -20,13 +20,14 @@ config FSL_GUTS
 	  into this driver as well.
 
 config FSL_MC_DPIO
-        tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
-        select SOC_BUS
-        help
+	tristate "QorIQ DPAA2 DPIO driver"
+	depends on FSL_MC_BUS
+	select SOC_BUS
+	help
 	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
 	  buffer management facilities for software to interact with
 	  other DPAA2 objects. This driver does not expose the DPIO
 	  objects individually, but groups them under a service layer
 	  API.
+
 endmenu
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 1ee298f..e885233 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -32,13 +32,13 @@ config QCOM_GLINK_SSR
 	  neighboring subsystems going up or down.
 
 config QCOM_GSBI
-        tristate "QCOM General Serial Bus Interface"
-        depends on ARCH_QCOM || COMPILE_TEST
-        select MFD_SYSCON
-        help
-          Say y here to enable GSBI support.  The GSBI provides control
-          functions for connecting the underlying serial UART, SPI, and I2C
-          devices to the output pins.
+	tristate "QCOM General Serial Bus Interface"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  Say y here to enable GSBI support.  The GSBI provides control
+	  functions for connecting the underlying serial UART, SPI, and I2C
+	  devices to the output pins.
 
 config QCOM_LLCC
 	tristate "Qualcomm Technologies, Inc. LLCC driver"
@@ -175,8 +175,9 @@ config QCOM_APR
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
 	help
-          Enable APR IPC protocol support between
-          application processor and QDSP6. APR is
-          used by audio driver to configure QDSP6
-          ASM, ADM and AFE modules.
+	  Enable APR IPC protocol support between
+	  application processor and QDSP6. APR is
+	  used by audio driver to configure QDSP6
+	  ASM, ADM and AFE modules.
+
 endmenu
diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 20da55d..f468b79 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -14,15 +14,15 @@ config ROCKCHIP_GRF
 	  to make some of them conform to expectations of the kernel.
 
 config ROCKCHIP_PM_DOMAINS
-        bool "Rockchip generic power domain"
-        depends on PM
-        select PM_GENERIC_DOMAINS
-        help
-          Say y here to enable power domain support.
-          In order to meet high performance and low power requirements, a power
-          management unit is designed or saving power when RK3288 in low power
-          mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
+	bool "Rockchip generic power domain"
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, a power
+	  management unit is designed or saving power when RK3288 in low power
+	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
 
-          If unsure, say N.
+	  If unsure, say N.
 
 endif
-- 
1.9.1

