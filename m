Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A1C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF8520644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hsNnN6K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfDYOLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:11:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41994 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfDYOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:10:58 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PE8KYp019888;
        Thu, 25 Apr 2019 16:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=a4jjkUN4GINRF9az9bnmYoWz8JKbI5OalSqu1R1JJGY=;
 b=hsNnN6K7wqbe0312PL8lAKPnGx44ObAOJm2v0G/H7ezOMMIY0urZ23QeJNKm+Fx+Ut+/
 f2wPT7YxaSPvimElMGVg8+HdPnOtMjV8k/JEYBCBiTlxItmISJLmFUIHKYTNslA4jrCS
 I5QZwZ7PEM5quWT5ZUlrauD6NhI/evmN41DCOWTi37BNBejSJE0t3eFCYL4NYXpquQZa
 ToTMTF4nneru57bonyvlDGou4XaMp5Y9jjPnKO+9nTjZp9U5kQ22R9D4TVl2fEqiYL9T
 QLw8fFypKgBcFxSEwCVi9XFftVG9LfvGhPNOHaF9IiI8DVOSUf1dih9K2r3tod7sC+la Sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytaddg6f-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 16:10:47 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A6C575D;
        Thu, 25 Apr 2019 14:10:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7459127EC;
        Thu, 25 Apr 2019 14:10:46 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 25 Apr
 2019 16:10:46 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 16:10:46
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [Linux-stm32][PATCH 2/4] ARM: dts: stm32: add sai pins muxing on stm32mp157
Date:   Thu, 25 Apr 2019 16:10:38 +0200
Message-ID: <1556201440-5540-3-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556201440-5540-1-git-send-email-olivier.moysan@st.com>
References: <1556201440-5540-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAI pins muxing to stm32mp157.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 85c417d9983b..6ea9b9ff45e7 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -506,6 +506,79 @@
 				};
 			};
 
+			sai2a_pins_a: sai2a-0 {
+				pins {
+					pinmux = <STM32_PINMUX('I', 5, AF10)>, /* SAI2_SCK_A */
+						 <STM32_PINMUX('I', 6, AF10)>, /* SAI2_SD_A */
+						 <STM32_PINMUX('I', 7, AF10)>, /* SAI2_FS_A */
+						 <STM32_PINMUX('E', 0, AF10)>; /* SAI2_MCLK_A */
+					slew-rate = <0>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			sai2a_sleep_pins_a: sai2a-1 {
+				pins {
+					pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* SAI2_SCK_A */
+						 <STM32_PINMUX('I', 6, ANALOG)>, /* SAI2_SD_A */
+						 <STM32_PINMUX('I', 7, ANALOG)>, /* SAI2_FS_A */
+						 <STM32_PINMUX('E', 0, ANALOG)>; /* SAI2_MCLK_A */
+				};
+			};
+
+			sai2b_pins_a: sai2b-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('E', 12, AF10)>, /* SAI2_SCK_B */
+						 <STM32_PINMUX('E', 13, AF10)>, /* SAI2_FS_B */
+						 <STM32_PINMUX('E', 14, AF10)>; /* SAI2_MCLK_B */
+					slew-rate = <0>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
+					bias-disable;
+				};
+			};
+
+			sai2b_sleep_pins_a: sai2b-1 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* SAI2_SD_B */
+						 <STM32_PINMUX('E', 12, ANALOG)>, /* SAI2_SCK_B */
+						 <STM32_PINMUX('E', 13, ANALOG)>, /* SAI2_FS_B */
+						 <STM32_PINMUX('E', 14, ANALOG)>; /* SAI2_MCLK_B */
+				};
+			};
+
+			sai2b_pins_b: sai2b-2 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
+					bias-disable;
+				};
+			};
+
+			sai2b_sleep_pins_b: sai2b-3 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
+				};
+			};
+
+			sai4a_pins_a: sai4a-0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 5, AF10)>; /* SAI4_SD_A */
+					slew-rate = <0>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			sai4a_sleep_pins_a: sai4a-1 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 5, ANALOG)>; /* SAI4_SD_A */
+				};
+			};
+
 			sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 				pins {
 					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-- 
2.7.4

