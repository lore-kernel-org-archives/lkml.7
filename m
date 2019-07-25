Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72091C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4795922BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TpIZ5+Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404101AbfGYLhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:37:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21478 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390934AbfGYLha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:37:30 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PBbH9s016249;
        Thu, 25 Jul 2019 13:37:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=6x9EMveWc/xIr2aUKeJ6ptlB+zbI8DrHbgR6eCuoRFs=;
 b=TpIZ5+HvlXGjjVjs37GpU8d5r+0/ZL8hKAtkHKpp67qwD/Xbh99pYsFUX93d+vgEJlBY
 vW3cL/qUSJGC6FxtwjpeDKbsjvxVslPp9lT/aUMYLUjiH3B/MW3hAwehijY6qIL+G1Ui
 MixDUawjkPbP8nA8QVRLPruKTPoI2fwjk9ugPGOEbKK1H9ndasYA7c0O00z5j0agNv1b
 CpxJnRqQWhCi/ihDz9RocV6vpOWpNddNgJtm79pLYuljkNnpnuIYNrIMBwOLIniZRPW9
 acJyp/jlbcXz/+3zORRWZVxtTbZiSJynQRO33oxu00EvghxX8Z1L93IWXyAGRiKGY9B1 Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tx604beg8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Jul 2019 13:37:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E9C638;
        Thu, 25 Jul 2019 11:37:16 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 832992B51;
        Thu, 25 Jul 2019 11:37:16 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 13:37:16 +0200
Received: from localhost (10.201.20.5) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul 2019 13:37:15 +0200
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
Date:   Thu, 25 Jul 2019 13:36:46 +0200
Message-ID: <1564054607-2028-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564054607-2028-1-git-send-email-amelie.delaunay@st.com>
References: <1564054607-2028-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Torgue <alexandre.torgue@st.com>

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
index 9ab25da..e4b04dd 100644
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
2.7.4

