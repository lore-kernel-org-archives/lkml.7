Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9BB218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YBgR6512"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfCUO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:29:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55428 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfCUO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:29:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LET5mg005405;
        Thu, 21 Mar 2019 09:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553178545;
        bh=DGmYK0qNA6EMnV0LOh22qiWek2uuO8gQ4HNuRRy1iDU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YBgR6512g7ClbzJVwPnqUvvBg3WuyQfi802b8U8HuEomVk/SlrRRPHYrMWgTXi1jH
         TVY9oXTh1EJ2vspjSmcu9cuLLImc0CfmuzR5DR5G71BwITC2pr1Ko8v9irGiJ06wFT
         H0cZlBu8AwJSZfqCX7Lmd++wwBibEgatZb3/wT2o=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LET4lU032692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 09:29:05 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 09:29:04 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 09:29:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LET4Kx028900;
        Thu, 21 Mar 2019 09:29:04 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <tony@atomide.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt properties
Date:   Thu, 21 Mar 2019 09:28:36 -0500
Message-ID: <20190321142838.22985-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190321142838.22985-1-dmurphy@ti.com>
References: <20190321142838.22985-1-dmurphy@ti.com>
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

v5 - No change - https://lore.kernel.org/patchwork/patch/1050409/

v4 - No change - https://lore.kernel.org/patchwork/patch/1050125/
v3 - updated keypad label on v1 comment - https://lore.kernel.org/patchwork/patch/1049023/
v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
I did not change the label as it is undecided what it could be - https://lore.kernel.org/patchwork/patch/1048806/

 arch/arm/boot/dts/omap4-droid4-xt894.dts | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index e21ec929f096..aea206f04f76 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -383,20 +383,30 @@
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
+		ramp-up-us = <1024>;
+		ramp-down-us = <8193>;
 
-			lcd {
-				led-sources = <0 1 2>;
-				ramp-up-msec = <1>;
-				ramp-down-msec = <0>;
-			};
+		lcd_backlight: led@0 {
+			reg = <0>;
+			led-sources = <2>;
+			ti,led-mode = <0>;
+			label = "backlight";
+			linux,default-trigger = "backlight";
+		};
+
+		led@1 {
+			reg = <1>;
+			led-sources = <1>;
+			ti,led-mode = <0>;
+			label = "platform::kbd_backlight";
 		};
 	};
 };
-- 
2.21.0.5.gaeb582a983

