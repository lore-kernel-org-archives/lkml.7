Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86405C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AC421670
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfE2IbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:31:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60842 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfE2IbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:31:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77FB92011CA;
        Wed, 29 May 2019 10:31:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E10D200272;
        Wed, 29 May 2019 10:31:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 418BA402FA;
        Wed, 29 May 2019 16:31:00 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 3/3] arm64: dts: ls1088a: Revise gpio registers to little-endian
Date:   Wed, 29 May 2019 16:32:54 +0800
Message-Id: <20190529083254.39581-3-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529083254.39581-1-chuanhua.han@nxp.com>
References: <20190529083254.39581-1-chuanhua.han@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fsl-ls1088a Soc GPIO registers are used as little endian,
the patch adds the little-endian attribute to each gpio node.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 661137ffa319..3e6d20d065bd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -272,6 +272,7 @@
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
+			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -282,6 +283,7 @@
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
+			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -292,6 +294,7 @@
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
 			interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>;
+			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -302,6 +305,7 @@
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
 			interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>;
+			little-endian;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-- 
2.17.1

