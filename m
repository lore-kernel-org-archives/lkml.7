Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6764EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D3E2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfC2KNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42594 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729137AbfC2KNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TAAeOo020867;
        Fri, 29 Mar 2019 11:12:56 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rhg9w0f6w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Mar 2019 11:12:56 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F6F831;
        Fri, 29 Mar 2019 10:12:56 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0081A2669;
        Fri, 29 Mar 2019 10:12:55 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 29 Mar
 2019 11:12:56 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 29 Mar 2019 11:12:55
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: add spdfirx pins to stm32mp157c
Date:   Fri, 29 Mar 2019 11:12:45 +0100
Message-ID: <1553854365-19866-3-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553854365-19866-1-git-send-email-olivier.moysan@st.com>
References: <1553854365-19866-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds spdifrx support on stm32mp157c eval board.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 9104896e6066..54c133094a8f 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -393,6 +393,19 @@
 				};
 			};
 
+			spdifrx_pins_a: spdifrx-0 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 12, AF8)>; /* SPDIF_IN1 */
+					bias-disable;
+				};
+			};
+
+			spdifrx_sleep_pins_a: spdifrx-1 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 12, ANALOG)>; /* SPDIF_IN1 */
+				};
+			};
+
 			uart4_pins_a: uart4-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
-- 
2.7.4

