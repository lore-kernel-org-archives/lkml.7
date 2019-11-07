Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8B3C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D7217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfKGDcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:32:17 -0500
Received: from inva020.nxp.com ([92.121.34.13]:38126 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbfKGDcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:32:17 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E41A1A0697;
        Thu,  7 Nov 2019 04:32:14 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 26CD11A0511;
        Thu,  7 Nov 2019 04:32:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26DB0402B1;
        Thu,  7 Nov 2019 11:32:00 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, daniel.baluta@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8qxp: Remove unnecessary "interrupt-parent" property
Date:   Thu,  7 Nov 2019 11:30:35 +0800
Message-Id: <1573097435-19814-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gic is appointed as default interrupt parent for devices, so no need
to specify it again in device nodes which use it as interrupt parent.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 9646a41..fb5f752 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -250,7 +250,6 @@
 			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 			reg = <0x5a060000 0x1000>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_IPG_CLK>,
 				 <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
 			clock-names = "ipg", "baud";
@@ -262,7 +261,6 @@
 			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 			reg = <0x5a070000 0x1000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART1_IPG_CLK>,
 				 <&adma_lpcg IMX_ADMA_LPCG_UART1_BAUD_CLK>;
 			clock-names = "ipg", "baud";
@@ -274,7 +272,6 @@
 			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 			reg = <0x5a080000 0x1000>;
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART2_IPG_CLK>,
 				 <&adma_lpcg IMX_ADMA_LPCG_UART2_BAUD_CLK>;
 			clock-names = "ipg", "baud";
@@ -286,7 +283,6 @@
 			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 			reg = <0x5a090000 0x1000>;
 			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART3_IPG_CLK>,
 				 <&adma_lpcg IMX_ADMA_LPCG_UART3_BAUD_CLK>;
 			clock-names = "ipg", "baud";
@@ -298,7 +294,6 @@
 			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 			reg = <0x5a800000 0x4000>;
 			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
 			clock-names = "per";
 			assigned-clocks = <&clk IMX_ADMA_I2C0_CLK>;
@@ -311,7 +306,6 @@
 			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 			reg = <0x5a810000 0x4000>;
 			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
 			clock-names = "per";
 			assigned-clocks = <&clk IMX_ADMA_I2C1_CLK>;
@@ -324,7 +318,6 @@
 			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 			reg = <0x5a820000 0x4000>;
 			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
 			clock-names = "per";
 			assigned-clocks = <&clk IMX_ADMA_I2C2_CLK>;
@@ -337,7 +330,6 @@
 			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 			reg = <0x5a830000 0x4000>;
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
 			clock-names = "per";
 			assigned-clocks = <&clk IMX_ADMA_I2C3_CLK>;
@@ -361,7 +353,6 @@
 
 		usdhc1: mmc@5b010000 {
 			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b010000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
@@ -374,7 +365,6 @@
 
 		usdhc2: mmc@5b020000 {
 			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b020000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
@@ -389,7 +379,6 @@
 
 		usdhc3: mmc@5b030000 {
 			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b030000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
@@ -446,7 +435,6 @@
 		ddr-pmu@5c020000 {
 			compatible = "fsl,imx8-ddr-pmu";
 			reg = <0x5c020000 0x10000>;
-			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
-- 
2.7.4

