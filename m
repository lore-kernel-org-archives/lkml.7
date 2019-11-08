Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE34FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E0721D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="x2eGZ2fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfKHQiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:38:02 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17004 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727233AbfKHQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:38:00 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8GMEND032766;
        Fri, 8 Nov 2019 17:37:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=yLObshd9hzUy4IWMSCmF/oQKkuoRU3dJhdKjXSa8dCs=;
 b=x2eGZ2fBJ4xnI/zqAq4URJLuQMfMCttuVjYzzNxK/JfOqT3xol5soiW//M4Y1dZdiko2
 JxIhkxJGOCzOxfSezvc7vHvtPM9R24N02ptS12C9o+78Yq5ryFO4n5wqpEletTEeOvG7
 MWGBctp8zWQNTo5QgfTSKO5s3BSiLLBVZ17E07dobHSScctgfKHx09qPe+sTBwi0RKEy
 wAgCObqQVfJAqrAbowokBg2HPME7IcRx/Ghr2BA4fz2fYljcOQM7EVCEfML147j9SZsJ
 nbbhFRlVSZCU1rj/55sfa3Ro1Duy4/M/hxeTs00B392/esR43YMiY7hfPIZ8pICpwjRl PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w41vmvpvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 17:37:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC658100034;
        Fri,  8 Nov 2019 17:37:48 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C10492C38AC;
        Fri,  8 Nov 2019 17:37:48 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019
 17:37:48 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019 17:37:48 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: add ADC pins used for stm32mp157c-ed1
Date:   Fri, 8 Nov 2019 17:37:38 +0100
Message-ID: <1573231059-395-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573231059-395-1-git-send-email-fabrice.gasnier@st.com>
References: <1573231059-395-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_05:2019-11-08,2019-11-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define adc1_in6 pin used on stm32mp157c eval board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 1e45b75..41cb211 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -137,6 +137,12 @@
 				status = "disabled";
 			};
 
+			adc1_in6_pins_a: adc1-in6 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 12, ANALOG)>;
+				};
+			};
+
 			adc12_ain_pins_a: adc12-ain-0 {
 				pins {
 					pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* ADC1 in13 */
-- 
2.7.4

