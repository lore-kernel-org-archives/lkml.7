Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33801C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1DF2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfCHPKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:10:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21759 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbfCHPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:10:45 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x28F7KXI016159;
        Fri, 8 Mar 2019 16:10:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgbea9v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 08 Mar 2019 16:10:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B09D638;
        Fri,  8 Mar 2019 15:10:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 822815936;
        Fri,  8 Mar 2019 15:10:27 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Mar 2019
 16:10:27 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Mar 2019
 16:10:27 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH  1/2] ARM: dts: stm32: add pinctrl sleep config for qspi on stm32mp157c-ev1
Date:   Fri, 8 Mar 2019 16:10:22 +0100
Message-ID: <1552057823-10876-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552057823-10876-1-git-send-email-ludovic.Barre@st.com>
References: <1552057823-10876-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds pinctrl sleep config for qspi on stm32mp157c-ev1

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     |  3 ++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 9ec4694..5520f65 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -289,6 +289,12 @@
 				};
 			};
 
+			qspi_clk_sleep_pins_a: qspi-clk-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 10, ANALOG)>; /* QSPI_CLK */
+				};
+			};
+
 			qspi_bk1_pins_a: qspi-bk1-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
@@ -307,6 +313,16 @@
 				};
 			};
 
+			qspi_bk1_sleep_pins_a: qspi-bk1-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 8, ANALOG)>, /* QSPI_BK1_IO0 */
+						 <STM32_PINMUX('F', 9, ANALOG)>, /* QSPI_BK1_IO1 */
+						 <STM32_PINMUX('F', 7, ANALOG)>, /* QSPI_BK1_IO2 */
+						 <STM32_PINMUX('F', 6, ANALOG)>, /* QSPI_BK1_IO3 */
+						 <STM32_PINMUX('B', 6, ANALOG)>; /* QSPI_BK1_NCS */
+				};
+			};
+
 			qspi_bk2_pins_a: qspi-bk2-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('H', 2, AF9)>, /* QSPI_BK2_IO0 */
@@ -325,6 +341,16 @@
 				};
 			};
 
+			qspi_bk2_sleep_pins_a: qspi-bk2-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* QSPI_BK2_IO0 */
+						 <STM32_PINMUX('H', 3, ANALOG)>, /* QSPI_BK2_IO1 */
+						 <STM32_PINMUX('G', 10, ANALOG)>, /* QSPI_BK2_IO2 */
+						 <STM32_PINMUX('G', 7, ANALOG)>, /* QSPI_BK2_IO3 */
+						 <STM32_PINMUX('C', 0, ANALOG)>; /* QSPI_BK2_NCS */
+				};
+			};
+
 			uart4_pins_a: uart4-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index b6aca40..7fef155 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -131,8 +131,9 @@
 };
 
 &qspi {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a &qspi_bk2_pins_a>;
+	pinctrl-1 = <&qspi_clk_sleep_pins_a &qspi_bk1_sleep_pins_a &qspi_bk2_sleep_pins_a>;
 	reg = <0x58003000 0x1000>, <0x70000000 0x4000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.7.4

