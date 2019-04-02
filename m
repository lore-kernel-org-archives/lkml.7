Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D8FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81647214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfDBMgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:36:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22055 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730468AbfDBMgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:36:20 -0400
X-UUID: 5fd74bbeac1540daaa052d8d5ebafbe5-20190402
X-UUID: 5fd74bbeac1540daaa052d8d5ebafbe5-20190402
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1402223861; Tue, 02 Apr 2019 20:36:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 20:36:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 20:36:11 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH RESEND v6 6/6] dts: arm64: mt8183: Add I2C nodes
Date:   Tue, 2 Apr 2019 20:36:00 +0800
Message-ID: <1554208560-14817-7-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i2c nodes for I2C controllers

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi |  192 ++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 75c4881..3dde2be 100644
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
@@ -299,6 +314,183 @@
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
+
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
+
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

