Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC1C20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xKEo1Y26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCGWKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:10:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40260 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:10:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x27MA9Bf123618;
        Thu, 7 Mar 2019 16:10:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551996609;
        bh=dg2jvREIrdBG9k5vObXIkn6EvUSqoQ5KCD3Zgtr+Btk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xKEo1Y26dCA8howfJ66UYTAtPBvKVGQnTWdtKQLymsPZvxlZxabxqA8XrSfesQTNm
         STpPQMbMkz9lY8SpYWO3Jv4r4O92R4gA7Df3WjO30RFcYfASTmYzNyUjf3m/kyYqLa
         sU2XSog1eM3/RvKYIwPlpt/61QWviBD/UmvH4h8I=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x27MA9Wf007840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 16:10:09 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Mar 2019 16:10:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Mar 2019 16:10:09 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x27MA8dJ004822;
        Thu, 7 Mar 2019 16:10:09 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.83.167])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x27MA7U21623;
        Thu, 7 Mar 2019 16:10:07 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <tony@atomide.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt properties
Date:   Thu, 7 Mar 2019 16:09:45 -0600
Message-ID: <20190307220947.20057-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190307220947.20057-1-dmurphy@ti.com>
References: <20190307220947.20057-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the properties for the lm3532 device node for droid4.
With this change the backlight LED string and the keypad
LED strings will be controlled separately.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 27 +++++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index e21ec929f096..94e3d53dbcf3 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/leds-lm3532.h>
 #include "omap443x.dtsi"
 #include "motorola-cpcap-mapphone.dtsi"
 
@@ -383,20 +384,30 @@
 };
 
 &i2c1 {
-	lm3532@38 {
+	led-controller@38 {
 		compatible = "ti,lm3532";
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x38>;
 
 		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
 
-		lcd_backlight: backlight {
-			compatible = "ti,lm3532-backlight";
+		ramp-up-ms = <LM3532_RAMP_1024us>;
+		ramp-down-ms = <LM3532_RAMP_65536us>;
 
-			lcd {
-				led-sources = <0 1 2>;
-				ramp-up-msec = <1>;
-				ramp-down-msec = <0>;
-			};
+		lcd_backlight: led@0 {
+			reg = <0>;
+			led-sources = <2>;
+			ti,led-mode = <LM3532_BL_MODE_MANUAL>;
+			label = "backlight";
+			linux,default-trigger = "backlight";
+		};
+
+		led@1 {
+			reg = <1>;
+			led-sources = <1>;
+			ti,led-mode = <LM3532_BL_MODE_MANUAL>;
+			label = "keypad";
 		};
 	};
 };
-- 
2.20.1.390.gb5101f9297

