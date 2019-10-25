Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546EFCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDC92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408390AbfJYIml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:42:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46712 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407876AbfJYImk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:42:40 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C757820043F;
        Fri, 25 Oct 2019 10:42:38 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E27720006D;
        Fri, 25 Oct 2019 10:42:31 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7D3DB402BC;
        Fri, 25 Oct 2019 16:42:22 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, ping.bai@nxp.com,
        jun.li@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        daniel.lezcano@linaro.org, shengjiu.wang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: imx8mm: Change compatible string for sdma
Date:   Fri, 25 Oct 2019 16:39:23 +0800
Message-Id: <1571992763-31339-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDMA in i.MX8MM should use same configuration as i.MX8MQ
So need to change compatible string to be "fsl,imx8mq-sdma".

Fixes: a05ea40eb384 ("arm64: dts: imx: Add i.mx8mm dtsi support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 2139c0a9c495..6a54d2a3b19b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -394,7 +394,7 @@
 			};
 
 			sdma2: dma-controller@302c0000 {
-				compatible = "fsl,imx8mm-sdma", "fsl,imx7d-sdma";
+				compatible = "fsl,imx8mm-sdma", "fsl,imx8mq-sdma";
 				reg = <0x302c0000 0x10000>;
 				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_SDMA2_ROOT>,
@@ -405,7 +405,7 @@
 			};
 
 			sdma3: dma-controller@302b0000 {
-				compatible = "fsl,imx8mm-sdma", "fsl,imx7d-sdma";
+				compatible = "fsl,imx8mm-sdma", "fsl,imx8mq-sdma";
 				reg = <0x302b0000 0x10000>;
 				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_SDMA3_ROOT>,
@@ -741,7 +741,7 @@
 			};
 
 			sdma1: dma-controller@30bd0000 {
-				compatible = "fsl,imx8mm-sdma", "fsl,imx7d-sdma";
+				compatible = "fsl,imx8mm-sdma", "fsl,imx8mq-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_SDMA1_ROOT>,
-- 
2.21.0

