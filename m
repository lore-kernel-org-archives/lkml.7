Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2890C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D952084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCKFla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:41:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24782 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfCKFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:41:24 -0400
X-UUID: 0555059632784148b29c0036d881975c-20190311
X-UUID: 0555059632784148b29c0036d881975c-20190311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 384663094; Mon, 11 Mar 2019 13:41:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 13:41:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 13:41:11 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH v6 6/6] dts: arm64: mt8183: Add I2C nodes
Date:   Mon, 11 Mar 2019 13:40:40 +0800
Message-ID: <1552282840-12778-7-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
References: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6FA1A84FA54BA1BFB58D8ACA5EE16B6CAB24BF3899834D82AB2DA3069DA4525F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds nodes for I2C controller.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi |  190 ++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 165b859..f20f1af 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -16,6 +16,21 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -268,6 +283,79 @@
 			status = "disabled";
 		};
 
+		i2c6: i2c@11005000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11005000 0 0x1000>,
+				<0 0x11000600 0 0x80>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C6>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@11007000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11007000 0 0x1000>,
+				<0 0x11000080 0 0x80>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C0>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@11008000 {
+			compatible = "mediatek,mt8183-i2c";
+			id = <4>;
+			reg = <0 0x11008000 0 0x1000>,
+				<0 0x11000100 0 0x80>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C1>,
+				 <&infracfg CLK_INFRA_AP_DMA>,
+				 <&infracfg CLK_INFRA_I2C1_ARBITER>;
+			clock-names = "main", "dma","arb";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@11009000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11009000 0 0x1000>,
+				<0 0x11000280 0 0x80>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C2>,
+				 <&infracfg CLK_INFRA_AP_DMA>,
+				 <&infracfg CLK_INFRA_I2C2_ARBITER>;
+			clock-names = "main", "dma", "arb";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@1100f000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x1100f000 0 0x1000>,
+				<0 0x11000400 0 0x80>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C3>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi0: spi@1100a000 {
 			compatible = "mediatek,mt8183-spi";
 			#address-cells = <1>;
@@ -294,6 +382,20 @@
 			status = "disabled";
 		};
 
+		i2c1: i2c@11011000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11011000 0 0x1000>,
+				<0 0x11000480 0 0x80>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C4>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi2: spi@11012000 {
 			compatible = "mediatek,mt8183-spi";
 			#address-cells = <1>;
@@ -320,6 +422,66 @@
 			status = "disabled";
 		};
 
+		i2c9: i2c@11014000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11014000 0 0x1000>,
+				<0 0x11000180 0 0x80>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C1_IMM>,
+				 <&infracfg CLK_INFRA_AP_DMA>,
+				 <&infracfg CLK_INFRA_I2C1_ARBITER>;
+			clock-names = "main", "dma", "arb";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c10: i2c@11015000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11015000 0 0x1000>,
+				<0 0x11000300 0 0x80>;
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C2_IMM>,
+				 <&infracfg CLK_INFRA_AP_DMA>,
+				 <&infracfg CLK_INFRA_I2C2_ARBITER>;
+			clock-names = "main", "dma", "arb";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@11016000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11016000 0 0x1000>,
+				<0 0x11000500 0 0x80>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C5>,
+				 <&infracfg CLK_INFRA_AP_DMA>,
+				 <&infracfg CLK_INFRA_I2C5_ARBITER>;
+			clock-names = "main", "dma", "arb";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c11: i2c@11017000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11017000 0 0x1000>,
+				<0 0x11000580 0 0x80>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C5_IMM>,
+				 <&infracfg CLK_INFRA_AP_DMA>,
+				 <&infracfg CLK_INFRA_I2C5_ARBITER>;
+			clock-names = "main", "dma", "arb";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi4: spi@11018000 {
 			compatible = "mediatek,mt8183-spi";
 			#address-cells = <1>;
@@ -346,6 +508,34 @@
 			status = "disabled";
 		};
 
+		i2c7: i2c@1101a000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x1101a000 0 0x1000>,
+				<0 0x11000680 0 0x80>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C7>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@1101b000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x1101b000 0 0x1000>,
+				<0 0x11000700 0 0x80>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_I2C8>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		audiosys: syscon@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
-- 
1.7.9.5

