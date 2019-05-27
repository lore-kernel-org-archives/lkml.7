Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AEBC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7AC2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfE0JFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:05:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31019 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726492AbfE0JFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:05:41 -0400
X-UUID: 1984a0d3cca947e29193c02e3280f2b4-20190527
X-UUID: 1984a0d3cca947e29193c02e3280f2b4-20190527
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 999682; Mon, 27 May 2019 17:05:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 27 May 2019 17:05:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 27 May 2019 17:05:19 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        Mengqi Zhang <Mengqi.Zhang@mediatek.com>
Subject: [PATCH v11 5/6] arm64: dts: mt8183: add spi node
Date:   Mon, 27 May 2019 17:04:46 +0800
Message-ID: <1558947887-31084-6-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
References: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spi DTS node to the mt8183 and mt8183-evb.

Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 105 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    |  78 +++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 49909ac..d8e555c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -30,6 +30,111 @@
 	status = "okay";
 };
 
+&pio {
+	spi_pins_0: spi0{
+		pins_spi{
+			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
+				 <PINMUX_GPIO86__FUNC_SPI0_CSB>,
+				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
+				 <PINMUX_GPIO88__FUNC_SPI0_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_1: spi1{
+		pins_spi{
+			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
+				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
+				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
+				 <PINMUX_GPIO164__FUNC_SPI1_A_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_2: spi2{
+		pins_spi{
+			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
+				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
+				 <PINMUX_GPIO2__FUNC_SPI2_CLK>,
+				 <PINMUX_GPIO94__FUNC_SPI2_MI>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_3: spi3{
+		pins_spi{
+			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
+				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
+				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
+				 <PINMUX_GPIO24__FUNC_SPI3_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_4: spi4{
+		pins_spi{
+			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
+				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
+				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
+				 <PINMUX_GPIO20__FUNC_SPI4_CLK>;
+			bias-disable;
+		};
+	};
+
+	spi_pins_5: spi5{
+		pins_spi{
+			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
+				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
+				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
+				 <PINMUX_GPIO16__FUNC_SPI5_CLK>;
+			bias-disable;
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_0>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_1>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_2>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_3>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_4>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&spi5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins_5>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5672c18..2e3063f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -285,6 +285,84 @@
 			status = "disabled";
 		};
 
+		spi0: spi@1100a000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI0>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi1: spi@11010000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11010000 0 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI1>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi2: spi@11012000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11012000 0 0x1000>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI2>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi3: spi@11013000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11013000 0 0x1000>;
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI3>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi4: spi@11018000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11018000 0 0x1000>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI4>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi5: spi@11019000 {
+			compatible = "mediatek,mt8183-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11019000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
+				 <&topckgen CLK_TOP_MUX_SPI>,
+				 <&infracfg CLK_INFRA_SPI5>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
 		audiosys: syscon@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
-- 
1.8.1.1.dirty

