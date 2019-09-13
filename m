Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC814C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C492721734
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="W/qZJCLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbfIMOfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:35:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42914 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389174AbfIMOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:35:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DEUoD2005823;
        Fri, 13 Sep 2019 16:35:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=r9bCUxv8k2rqzfX0+tEylu2OZfX7xZ0K9dYIQm5sZ6w=;
 b=W/qZJCLLcfrZugV9YgOxipRn7Z6z7LMe8JKXGRv42C6trfe2sEpuY4founWUEy9r4q7o
 u3cNAJo5A4HZT7Oae/86PZNaDJ1ru2/U6KLD4Y2eH1whS6FRASMIIywHsJE0ia8qbJgs
 RC6nNp4oQvOEjDhiJrSCZT+XW5rXrb6XoiythsTWsEix1HZCC1ElozBy2HzaivVGu+S1
 8J8+8zbUAEZyIzwxo852oju28gbsKMds+FU6wf2wZDY+mDqHQ2jLGWMsaW3URtMtHc6V
 FXpQsR+IgyLy7CI90gzwhCm2wDZhKLfX8zLBQJlJMZiMvLP92J78UgsdnazS9oZnYHb/ jg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uyte3wm11-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Sep 2019 16:35:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BF8F74E;
        Fri, 13 Sep 2019 14:34:59 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79A072C86AE;
        Fri, 13 Sep 2019 16:34:59 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep
 2019 16:34:59 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep 2019 16:34:59 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 2/3] ARM: dts: stm32: add ADC pins used on stm32mp157a-dk1
Date:   Fri, 13 Sep 2019 16:34:39 +0200
Message-ID: <1568385280-2633-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568385280-2633-1-git-send-email-fabrice.gasnier@st.com>
References: <1568385280-2633-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.232]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_07:2019-09-11,2019-09-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define pins that can be used for ADC on stm32mp157a-dk1 board:
- AIN connector has ADC input pins
- USB Type-C CC1 & CC2 pins (e.g. in18, in19)

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index e4a0d51..eeb60d0 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -137,6 +137,22 @@
 				status = "disabled";
 			};
 
+			adc12_ain_pins_a: adc12-ain-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* ADC1 in13 */
+						 <STM32_PINMUX('F', 12, ANALOG)>, /* ADC1 in6 */
+						 <STM32_PINMUX('F', 13, ANALOG)>, /* ADC2 in2 */
+						 <STM32_PINMUX('F', 14, ANALOG)>; /* ADC2 in6 */
+				};
+			};
+
+			adc12_usb_cc_pins_a: adc12-usb-cc-pins-0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 4, ANALOG)>, /* ADC12 in18 */
+						 <STM32_PINMUX('A', 5, ANALOG)>; /* ADC12 in19 */
+				};
+			};
+
 			cec_pins_a: cec-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 15, AF4)>;
-- 
2.7.4

