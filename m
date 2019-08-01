Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8767C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2DA2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="M8BdWzYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfHAHrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:47:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23516 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728582AbfHAHrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:47:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x717kCJb019571;
        Thu, 1 Aug 2019 09:46:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=zzC3uAed5A7dYU4IrlXdMoYN39GbIOLsffQotC5fMd8=;
 b=M8BdWzYZnMQYkSfcoFZtJrebjGiRAYOh2MHKEsmXkyVFsjVuq9lBSG2yzBklvajlkV2a
 ZFLLZqIHDVjrXApEi2gMZMWtB9/zBV7qjghyg+hvp38JGV++V62oy2pDUEmduJY+Uqo0
 4bkxk/JofI2kv2tnnvdHF2QCEZSADSuJuQlIkkldN4YzhY5rrh1Uctkek3gxVNOn4xko
 BHTMEdIwXU7fGJ0i64ogZEc4eogpmFqF3530IyGYbEVIdXKgIrZdRpLeqa4Isx3NjF9P
 iR0pClbF0o6DcZLtg0w8qK5yzcIsvNYN7J1RMKDjlT+fcbu4tmi30D2QE1FWPgLE7ArT Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2yn1m2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 01 Aug 2019 09:46:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CCE1238;
        Thu,  1 Aug 2019 07:46:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 939C5CEA35;
        Thu,  1 Aug 2019 09:46:38 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 09:46:38 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019 09:46:38
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH] ARM: dts: stm32: add DFSDM pins to stm32mp157c
Date:   Thu, 1 Aug 2019 09:46:07 +0200
Message-ID: <1564645567-13156-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DFSDM pins to stm32mp157c.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 9eaec9bf8cb8..f96a928cbc49 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -230,6 +230,45 @@
 				};
 			};
 
+			dfsdm_clkout_pins_a: dfsdm-clkout-pins-0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 13, AF3)>; /* DFSDM_CKOUT */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			dfsdm_clkout_sleep_pins_a: dfsdm-clkout-sleep-pins-0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 13, ANALOG)>; /* DFSDM_CKOUT */
+				};
+			};
+
+			dfsdm_data1_pins_a: dfsdm-data1-pins-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 3, AF3)>; /* DFSDM_DATA1 */
+				};
+			};
+
+			dfsdm_data1_sleep_pins_a: dfsdm-data1-sleep-pins-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 3, ANALOG)>; /* DFSDM_DATA1 */
+				};
+			};
+
+			dfsdm_data3_pins_a: dfsdm-data3-pins-0 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 13, AF6)>; /* DFSDM_DATA3 */
+				};
+			};
+
+			dfsdm_data3_sleep_pins_a: dfsdm-data3-sleep-pins-0 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 13, ANALOG)>; /* DFSDM_DATA3 */
+				};
+			};
+
 			ethernet0_rgmii_pins_a: rgmii-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
-- 
2.7.4

