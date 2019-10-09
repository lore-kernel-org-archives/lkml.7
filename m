Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4AFECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B1121848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jjpy1ZRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfJIONN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:13:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51384 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729644AbfJIONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:13:09 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x99EB8k1002204;
        Wed, 9 Oct 2019 16:12:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=W0FeZpUSt+/rnOmNlmsayVnYWoa4oyrKoH7/onjOr/s=;
 b=jjpy1ZRuUJ6bzczj22wl6sK6lCIC9wYbFzlXt3k/s/80ShBlDIjeAJ5Gez9I+7zDMzFa
 39XQGxSvaJvauS7HwwOkEIY2/zSoPAracx8R0Ei3iilAbu9nbA0pH+0vBSQmUHBQOIaK
 Bz7X3rCC0HpemqZCJkQlRW37y1LdJeCHMxDjylCvNQiLHjnji9P89lQ48KwqZ8+uupDL
 2mNIuwOrfTd2Tlyea2RSIPCuJqioQhHQadGIamNrKT3LbZcnL36WCj04ujTgsOgnWgG3
 IAVI3vQIlBrYQV5kJKZcgjSlw6IDqyZjqO6mqQuK5B01JxXC54uFGCqTPQwpM8wdOQy8 DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn0xeud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 16:12:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86455100034;
        Wed,  9 Oct 2019 16:12:58 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C0F921E6AF;
        Wed,  9 Oct 2019 16:12:58 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 16:12:58 +0200
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019 16:12:58 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: Add DAC support to stm32mp157c-ed1
Date:   Wed, 9 Oct 2019 16:12:52 +0200
Message-ID: <1570630372-24579-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570630372-24579-1-git-send-email-fabrice.gasnier@st.com>
References: <1570630372-24579-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_06:2019-10-08,2019-10-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stm32mp157c-ed1 board has digital-to-analog converter signals routed
to JP11 and JP10 jumpers (e.g. PA4/PA5).
It's easier then to configure them both. But keep them disabled by default,
so the pins are kept in their initial state to lower power consumption.
This way they can also be used as GPIO.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 1d426ea..2b40ad9 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -104,6 +104,19 @@
 	};
 };
 
+&dac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dac_ch1_pins_a &dac_ch2_pins_a>;
+	vref-supply = <&vdda>;
+	status = "disabled";
+	dac1: dac@1 {
+		status = "okay";
+	};
+	dac2: dac@2 {
+		status = "okay";
+	};
+};
+
 &dts {
 	status = "okay";
 };
-- 
2.7.4

