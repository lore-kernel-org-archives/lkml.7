Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4421D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="k0yB8MTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfJ2MrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:47:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18778 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387918AbfJ2MrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:47:16 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TCfsns022083;
        Tue, 29 Oct 2019 13:47:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jNnEqN1hFt8/AY3yeOnojB7iTitMfqt8Vkof3+I9CM0=;
 b=k0yB8MTBiS5GhfB1oCetSvS9Pwmls7m8rGZ31EQfCShN0wtKetCx2qvyB2Mi/FmFieMm
 attvb4hBtJcuSQHf+MRe7ceRhHhb2IKTmnwS6qc3kkDmCN+igVCbjr8snn+5Wy2XZJfn
 czOh2x12x7gnhBi4sdrQMFSOZyJEEuXyA5RsU82U0EhTUv5QdPg7T+ToLaXSdyBZ/g0H
 BekDS1mWvQt7ilB4MtGsC4NVg6T9Uim6P1Za+yBYYOeZdZNJZKcstfigPEpbKYuQMepL
 eO8R6HvkMSsus+YjwatBmLCRdFNdIIe4EQo8mVgTAko0W5GEpaobrW3U5/i2bTqXH59b wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbm0frm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 13:47:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3CE37100034;
        Tue, 29 Oct 2019 13:47:00 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EAB22BE234;
        Tue, 29 Oct 2019 13:47:00 +0100 (CET)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 29 Oct
 2019 13:47:00 +0100
Received: from localhost (10.201.22.141) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 29 Oct 2019 13:46:59
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: remove OV5640 pinctrl definition on stm32mp157c-ev1
Date:   Tue, 29 Oct 2019 13:46:50 +0100
Message-ID: <20191029124651.12625-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029124651.12625-1-amelie.delaunay@st.com>
References: <20191029124651.12625-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.22.141]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"push-pull" configuration is now fully handled by the gpiolib and the
STMFX pinctrl driver. There is no longer need to declare a pinctrl group
to only configure "push-pull" setting for the line. It is done directly by
the gpiolib.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 2baae5f25e2c..3f7fcba3a516 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -182,14 +182,12 @@
 
 	ov5640: camera@3c {
 		compatible = "ovti,ov5640";
-		pinctrl-names = "default";
-		pinctrl-0 = <&ov5640_pins>;
 		reg = <0x3c>;
 		clocks = <&clk_ext_camera>;
 		clock-names = "xclk";
 		DOVDD-supply = <&v2v8>;
-		powerdown-gpios = <&stmfx_pinctrl 18 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&stmfx_pinctrl 19 GPIO_ACTIVE_LOW>;
+		powerdown-gpios = <&stmfx_pinctrl 18 (GPIO_ACTIVE_HIGH | GPIO_PUSH_PULL)>;
+		reset-gpios = <&stmfx_pinctrl 19 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
 		rotation = <180>;
 		status = "okay";
 
@@ -225,12 +223,6 @@
 				drive-push-pull;
 				bias-pull-down;
 			};
-
-			ov5640_pins: camera {
-				pins = "agpio2", "agpio3"; /* stmfx pins 18 & 19 */
-				drive-push-pull;
-				output-low;
-			};
 		};
 	};
 };
-- 
2.17.1

