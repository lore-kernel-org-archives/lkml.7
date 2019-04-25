Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034A4206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dNMdmiKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfDYOLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:11:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17586 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfDYOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:11:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PE8M6E005046;
        Thu, 25 Apr 2019 16:11:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=8FXCzOk28JP/mOmeugF2wTWl4QoTxGBnGveic2Qh+hA=;
 b=dNMdmiKN6O+4sPhbjGyTxSdt+z33l9e7Je1U5GPo5zAMXbk4HwXHbnm2scGllbz1XB9B
 XdlqrluaPtF6gjkmN7OYb7eBuMK+IEJttxJkCS6Q7McNSLo67svhxOvZYsOzVyI59uCR
 20VVoZx2X1dBo58eMgbWp3LY5cMY/XRnPewNJ9z0bUEIKla6ptg0EyZuhXljOyBi6AyA
 tswISO0j0IPV9zqUpTdRQJGmRUWEah0e/w8MTHiHKzQG2I68kmLpDrW88h6pJCayZoYY
 UZRqKdZRq3R4wzsKSpt+Rcz8GbMlYZnsa5BcuNQGtqOrVn9BXrGcMXvKAzoS+LNO/XI6 nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxm5ha-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 16:11:00 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFF8A5D;
        Thu, 25 Apr 2019 14:10:48 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BEEE527EA;
        Thu, 25 Apr 2019 14:10:48 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 25 Apr
 2019 16:10:48 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 16:10:48
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [Linux-stm32][PATCH 4/4] ARM: dts: stm32: add i2s pins muxing on stm32mp157
Date:   Thu, 25 Apr 2019 16:10:40 +0200
Message-ID: <1556201440-5540-5-git-send-email-olivier.moysan@st.com>
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

Add I2S pins muxing to stm32mp157.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6ea9b9ff45e7..e29bf7a2c18a 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -276,6 +276,25 @@
 				};
 			};
 
+			i2s2_pins_a: i2s2-0 {
+				pins {
+					pinmux = <STM32_PINMUX('I', 3, AF5)>, /* I2S2_SDO */
+						 <STM32_PINMUX('B', 9, AF5)>, /* I2S2_WS */
+						 <STM32_PINMUX('A', 9, AF5)>; /* I2S2_CK */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			i2s2_pins_sleep_a: i2s2-1 {
+				pins {
+					pinmux = <STM32_PINMUX('I', 3, ANALOG)>, /* I2S2_SDO */
+						 <STM32_PINMUX('B', 9, ANALOG)>, /* I2S2_WS */
+						 <STM32_PINMUX('A', 9, ANALOG)>; /* I2S2_CK */
+				};
+			};
+
 			ltdc_pins_a: ltdc-a-0 {
 				pins {
 					pinmux = <STM32_PINMUX('G',  7, AF14)>, /* LCD_CLK */
-- 
2.7.4

