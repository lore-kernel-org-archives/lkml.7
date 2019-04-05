Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D9FC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91E21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WNp38kRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfDEO4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:56:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43294 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfDEOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:55:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35EtqWP043227;
        Fri, 5 Apr 2019 09:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554476152;
        bh=WsV8jHQsSWe30n80GjU+q1luZECi25VWLF52xZShihU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WNp38kRetp3PIFQeBR7/DhTe95SFYLzcKPYhB8UI5Kiarmukw6kc0DPABAHEHJ5tv
         +qtbBs4R8nZkpMA+045Nv2vsPhixjfbCAj5omRJ+OWyhTlbvbBbOZvryGTXjLrs+aI
         uX5kbkfg6QTrF1HaUgGruHZ0hyIrVyOpSHUWcsOc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35EtqTS120165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:55:52 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:55:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:55:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35EtqPr033333;
        Fri, 5 Apr 2019 09:55:52 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/6] dt-bindings: mfd: Add lm36274 bindings to ti-lmu
Date:   Fri, 5 Apr 2019 09:55:36 -0500
Message-ID: <20190405145540.27703-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190405145540.27703-1-dmurphy@ti.com>
References: <20190405145540.27703-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the LM36274 backlight driver with regulator support.
This is a multi-function device for backlight applications.

Backlight properties will be documented in it's a supplemental
bindings document.

Regulator support is documented in the regulator/lm363x-regulator.txt

http://www.ti.com/lit/ds/symlink/lm36274.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/mfd/ti-lmu.txt        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index a948a8f41b2c..6ada671c1038 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -8,6 +8,7 @@ TI LMU driver supports lighting devices below.
   LM3632       Backlight and regulator
   LM3633       Backlight, LED and fault monitor
   LM3695       Backlight
+  LM36274      Backlight and regulator
 
 Required properties:
   - compatible: Should be one of:
@@ -15,11 +16,13 @@ Required properties:
                 "ti,lm3632"
                 "ti,lm3633"
                 "ti,lm3695"
+		"ti,lm36274"
   - reg: I2C slave address.
          0x11 for LM3632
          0x29 for LM3631
          0x36 for LM3633
          0x63 for LM3695
+         0x11 for LM36274
 
 Optional property:
   - enable-gpios: A GPIO specifier for hardware enable pin.
@@ -50,12 +53,14 @@ Optional nodes:
       - compatible: Should be one of:
                     "ti,lm3633-fault-monitor"
   - leds: LED properties for LM3633. Please refer to [2].
+	  LED properties for LM36274. Please refer to [4].
   - regulators: Regulator properties for LM3631 and LM3632.
                 Please refer to [3].
 
 [1] ../leds/backlight/ti-lmu-backlight.txt
 [2] ../leds/leds-lm3633.txt
 [3] ../regulator/lm363x-regulator.txt
+[4] ../leds/leds-lm36274.txt
 
 lm3631@29 {
 	compatible = "ti,lm3631";
@@ -213,3 +218,52 @@ lm3695@63 {
 		};
 	};
 };
+
+lm36274@11 {
+	compatible = "ti,lm36274";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x11>;
+
+	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,lm363x-regulator";
+
+		enable-gpios = <&pioC 0 GPIO_ACTIVE_HIGH>,
+			       <&pioC 1 GPIO_ACTIVE_HIGH>;
+
+		vboost {
+			regulator-name = "lcd_boost";
+			regulator-min-microvolt = <4000000>;
+			regulator-max-microvolt = <7150000>;
+			regulator-always-on;
+		};
+
+		vpos {
+			regulator-name = "lcd_vpos";
+			regulator-min-microvolt = <4000000>;
+			regulator-max-microvolt = <6500000>;
+		};
+
+		vneg {
+			regulator-name = "lcd_vneg";
+			regulator-min-microvolt = <4000000>;
+			regulator-max-microvolt = <6500000>;
+		};
+	};
+
+	backlight {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,lm36274-backlight";
+
+		led@0 {
+			reg = <0>;
+			led-sources = <0 2>;
+			label = "white:backlight_cluster";
+			linux,default-trigger = "backlight";
+		};
+	};
+};
-- 
2.19.0

