Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B308AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FBC2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbfB1O0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:26:46 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51024 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731073AbfB1O0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:26:15 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SEGHPc022515;
        Thu, 28 Feb 2019 15:26:02 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvh3we8j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 15:26:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E43C938;
        Thu, 28 Feb 2019 14:26:01 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CDDBE5993;
        Thu, 28 Feb 2019 14:26:01 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb
 2019 15:26:01 +0100
Received: from localhost (10.201.23.19) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb 2019 15:26:01
 +0100
From:   Hugues Fruchet <hugues.fruchet@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/4] ARM: dts: stm32: add DCMI pins to stm32mp157c
Date:   Thu, 28 Feb 2019 15:25:44 +0100
Message-ID: <1551363945-19497-4-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551363945-19497-1-git-send-email-hugues.fruchet@st.com>
References: <1551363945-19497-1-git-send-email-hugues.fruchet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.19]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DCMI pins to stm32mp157c.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6b3a9c6..b299afc 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -414,6 +414,47 @@
 					bias-disable;
 				};
 			};
+
+			dcmi_pins_a: dcmi-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 8,  AF13)>,/* DCMI_HSYNC */
+						 <STM32_PINMUX('B', 7,  AF13)>,/* DCMI_VSYNC */
+						 <STM32_PINMUX('A', 6,  AF13)>,/* DCMI_PIXCLK */
+						 <STM32_PINMUX('H', 9,  AF13)>,/* DCMI_D0 */
+						 <STM32_PINMUX('H', 10, AF13)>,/* DCMI_D1 */
+						 <STM32_PINMUX('H', 11, AF13)>,/* DCMI_D2 */
+						 <STM32_PINMUX('H', 12, AF13)>,/* DCMI_D3 */
+						 <STM32_PINMUX('H', 14, AF13)>,/* DCMI_D4 */
+						 <STM32_PINMUX('I', 4,  AF13)>,/* DCMI_D5 */
+						 <STM32_PINMUX('B', 8,  AF13)>,/* DCMI_D6 */
+						 <STM32_PINMUX('E', 6,  AF13)>,/* DCMI_D7 */
+						 <STM32_PINMUX('I', 1,  AF13)>,/* DCMI_D8 */
+						 <STM32_PINMUX('H', 7,  AF13)>,/* DCMI_D9 */
+						 <STM32_PINMUX('I', 3,  AF13)>,/* DCMI_D10 */
+						 <STM32_PINMUX('H', 15, AF13)>;/* DCMI_D11 */
+					bias-disable;
+				};
+			};
+
+			dcmi_sleep_pins_a: dcmi-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 8,  ANALOG)>,/* DCMI_HSYNC */
+						 <STM32_PINMUX('B', 7,  ANALOG)>,/* DCMI_VSYNC */
+						 <STM32_PINMUX('A', 6,  ANALOG)>,/* DCMI_PIXCLK */
+						 <STM32_PINMUX('H', 9,  ANALOG)>,/* DCMI_D0 */
+						 <STM32_PINMUX('H', 10, ANALOG)>,/* DCMI_D1 */
+						 <STM32_PINMUX('H', 11, ANALOG)>,/* DCMI_D2 */
+						 <STM32_PINMUX('H', 12, ANALOG)>,/* DCMI_D3 */
+						 <STM32_PINMUX('H', 14, ANALOG)>,/* DCMI_D4 */
+						 <STM32_PINMUX('I', 4,  ANALOG)>,/* DCMI_D5 */
+						 <STM32_PINMUX('B', 8,  ANALOG)>,/* DCMI_D6 */
+						 <STM32_PINMUX('E', 6,  ANALOG)>,/* DCMI_D7 */
+						 <STM32_PINMUX('I', 1,  ANALOG)>,/* DCMI_D8 */
+						 <STM32_PINMUX('H', 7,  ANALOG)>,/* DCMI_D9 */
+						 <STM32_PINMUX('I', 3,  ANALOG)>,/* DCMI_D10 */
+						 <STM32_PINMUX('H', 15, ANALOG)>;/* DCMI_D11 */
+				};
+			};
 		};
 
 		pinctrl_z: pin-controller-z@54004000 {
-- 
2.7.4

