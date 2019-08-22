Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AB3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0556B233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbfHVMfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:35:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20351 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbfHVMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:35:43 -0400
X-UUID: 592448d0be024390b0d39049756024ea-20190822
X-UUID: 592448d0be024390b0d39049756024ea-20190822
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 435136641; Thu, 22 Aug 2019 20:35:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 20:35:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 20:35:30 +0800
From:   <qii.wang@mediatek.com>
To:     <robh+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>
Subject: [PATCH] arm64: dts: mt8183: add I2C nodes
Date:   Thu, 22 Aug 2019 20:35:16 +0800
Message-ID: <1566477316-13245-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qii Wang <qii.wang@mediatek.com>

Add i2c nodes to mt8183 and mt8183-evb.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  96 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 189 ++++++++++++++++++++++++++++
 2 files changed, 285 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index d8e555c..1fb195c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -30,7 +30,103 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_0>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_1>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_2>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_3>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_4>;
+	status = "okay";
+	clock-frequency = <1000000>;
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_5>;
+	status = "okay";
+	clock-frequency = <1000000>;
+};
+
 &pio {
+	i2c_pins_0: i2c0{
+		pins_i2c{
+			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
+				 <PINMUX_GPIO83__FUNC_SCL0>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_1: i2c1{
+		pins_i2c{
+			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
+				 <PINMUX_GPIO84__FUNC_SCL1>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_2: i2c2{
+		pins_i2c{
+			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
+				 <PINMUX_GPIO104__FUNC_SDA2>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_3: i2c3{
+		pins_i2c{
+			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
+				 <PINMUX_GPIO51__FUNC_SDA3>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_4: i2c4{
+		pins_i2c{
+			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
+				 <PINMUX_GPIO106__FUNC_SDA4>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_5: i2c5{
+		pins_i2c{
+			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
+				 <PINMUX_GPIO49__FUNC_SDA5>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
 	spi_pins_0: spi0{
 		pins_spi{
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c2749c4..ab71291 100644
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
@@ -294,6 +309,64 @@
 			status = "disabled";
 		};
 
+		i2c6: i2c@11005000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11005000 0 0x1000>,
+			      <0 0x11000600 0 0x80>;
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
+			      <0 0x11000080 0 0x80>;
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
+			reg = <0 0x11008000 0 0x1000>,
+			      <0 0x11000100 0 0x80>;
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
+			      <0 0x11000280 0 0x80>;
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
 		spi0: spi@1100a000 {
 			compatible = "mediatek,mt8183-spi";
 			#address-cells = <1>;
@@ -307,6 +380,20 @@
 			status = "disabled";
 		};
 
+		i2c3: i2c@1100f000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x1100f000 0 0x1000>,
+			      <0 0x11000400 0 0x80>;
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
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8183-spi";
 			#address-cells = <1>;
@@ -320,6 +407,20 @@
 			status = "disabled";
 		};
 
+		i2c1: i2c@11011000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11011000 0 0x1000>,
+			      <0 0x11000480 0 0x80>;
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
@@ -346,6 +447,66 @@
 			status = "disabled";
 		};
 
+		i2c9: i2c@11014000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x11014000 0 0x1000>,
+			      <0 0x11000180 0 0x80>;
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
+			      <0 0x11000300 0 0x80>;
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
+			      <0 0x11000500 0 0x80>;
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
+			      <0 0x11000580 0 0x80>;
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
@@ -372,6 +533,34 @@
 			status = "disabled";
 		};
 
+		i2c7: i2c@1101a000 {
+			compatible = "mediatek,mt8183-i2c";
+			reg = <0 0x1101a000 0 0x1000>,
+			      <0 0x11000680 0 0x80>;
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
+			      <0 0x11000700 0 0x80>;
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
1.9.1

