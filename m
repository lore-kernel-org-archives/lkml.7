Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911FFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B462084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1JWVK43f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbfIMOfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:35:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13192 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387600AbfIMOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:35:15 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DEV2ZR017903;
        Fri, 13 Sep 2019 16:35:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=hryKjyfCxTA2dnqKEkk14SmwqqJ3l+c8gAOzB7s0IVA=;
 b=1JWVK43fjD4/dHSvcvQQk318CIAnOUS9PlDb7E9UrkKWBPkvLOhUQAA+ttkePsMr9ScY
 v0wAZe02xXOOEs86nn3WDwIkFM5mtjWroOoGGMLDl2qwUOIH66HYB7cTTIg+IAYvALCh
 kZQnAlRPHnrr5Tl1ndalpo8MgsdoDf9Vvs4x1jbD8DHDTqb9eqUiN9gccv3tzRD7a5EE
 J7ySaocVq0CY8t3500m9LLJZw0LCl+BXRu5K6iXGlSKhSyF3nFfzhqJSZuAVclPByQ+O
 1CO7mK+J599J6GnWVml4gJfm+UleSNeDdyiazE6r5inJcWzejyHzDP79Tvg/Q5Lrt5oQ KQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uytdx5n8a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Sep 2019 16:35:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3639D50;
        Fri, 13 Sep 2019 14:35:01 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 917192C86AE;
        Fri, 13 Sep 2019 16:35:00 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep
 2019 16:35:00 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep 2019 16:35:00 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: enable ADC support on stm32mp157a-dk1
Date:   Fri, 13 Sep 2019 16:34:40 +0200
Message-ID: <1568385280-2633-4-git-send-email-fabrice.gasnier@st.com>
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

Configure ADC support on stm32mp157a-dk1. It can be used for various
purpose:
- AIN connector has several analog inputs: ANA0, ANA1, ADC2 in6 & in2,
  ADC1 in13 & in6
- USB Type-C CC1 & CC2 pins wired to in18 & in19
It's easier then to Configure them all. But keep them disabled by default,
so the pins are kept in their initial state to lower power consumption.
This way they can also be used as GPIO.
Add VDD and VDDA supplies to ADC on stm32mp157c-dk1 board. This allows to
get full ADC analog performances in case VDDA is below 2.7V (not the case
by default).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index ebd9f33..2f42fcd 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -97,6 +97,33 @@
 	};
 };
 
+&adc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc12_ain_pins_a>, <&adc12_usb_cc_pins_a>;
+	vdd-supply = <&vdd>;
+	vdda-supply = <&vdd>;
+	vref-supply = <&vrefbuf>;
+	status = "disabled";
+	adc1: adc@0 {
+		/*
+		 * Type-C USB_PWR_CC1 & USB_PWR_CC2 on in18 & in19.
+		 * Use at least 5 * RC time, e.g. 5 * (Rp + Rd) * C:
+		 * 5 * (56 + 47kOhms) * 5pF => 2.5us.
+		 * Use arbitrary margin here (e.g. 5us).
+		 */
+		st,min-sample-time-nsecs = <5000>;
+		/* AIN connector, USB Type-C CC1 & CC2 */
+		st,adc-channels = <0 1 6 13 18 19>;
+		status = "okay";
+	};
+	adc2: adc@100 {
+		/* AIN connector, USB Type-C CC1 & CC2 */
+		st,adc-channels = <0 1 2 6 18 19>;
+		st,min-sample-time-nsecs = <5000>;
+		status = "okay";
+	};
+};
+
 &cec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cec_pins_b>;
-- 
2.7.4

