Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAAFECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F8220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbfJPCRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:17:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57654 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbfJPCRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:17:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A22381A04D8;
        Wed, 16 Oct 2019 04:17:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 298DD1A02E0;
        Wed, 16 Oct 2019 04:17:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 88C7F40305;
        Wed, 16 Oct 2019 10:17:01 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        jun.li@nxp.com, ping.bai@nxp.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, daniel.lezcano@linaro.org,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, jon@solid-run.com, baruch@tkos.co.il,
        angus@akkea.ca, pavel@ucw.cz, agx@sigxcpu.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        dafna.hirschfeld@collabora.com, richard.hu@technexion.com,
        andradanciu1997@gmail.com, manivannan.sadhasivam@linaro.org,
        aisheng.dong@nxp.com, peng.fan@nxp.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/5] arm64: dts: imx8mq: Move usdhc clocks assignment to board DT
Date:   Wed, 16 Oct 2019 10:14:24 +0800
Message-Id: <1571192067-19600-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usdhc's clock rate is different according to different devices
connected, so clock rate assignment should be placed in board
DT according to different devices connected on each usdhc port.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts                | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts     | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts           | 2 ++
 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts            | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi            | 2 ++
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi         | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                   | 2 --
 8 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 4e0a281..40fa390 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -278,6 +278,8 @@
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
@@ -291,6 +293,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts b/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts
index f52e872..b8cb20c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts
@@ -110,6 +110,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 683a110..2a759df 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -780,6 +780,8 @@
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
@@ -790,6 +792,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index c832bf0..81d2692 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -191,6 +191,8 @@
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
+	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts b/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
index 8a4aee2..59da96b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
@@ -207,6 +207,8 @@
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
@@ -217,6 +219,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
index d7f03c6..3dc44114 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
@@ -170,6 +170,8 @@
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 087b5b6..333c4e2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -486,6 +486,8 @@
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
@@ -499,6 +501,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a6d57fb..7f93194 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -868,8 +868,6 @@
 				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
 				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
-				assigned-clock-rates = <400000000>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
-- 
2.7.4

