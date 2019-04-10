Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93502C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A39520854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xcA+1SUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfDJNir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:38:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60268 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfDJNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:38:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3ADcZLQ093686;
        Wed, 10 Apr 2019 08:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554903515;
        bh=E4k9VqGqVYxNBJV0ymWKgYTisp4lzVsiqLq/Z2C96n8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xcA+1SUsRAdmoF+pPPvEHMTJbjaQ5BDyO7tB33TWHnVUq96KlEQSM0435qOPDKmOD
         OQlTkcqApN/qEKDf69FqHN2ey3QGgAAK7F/HAT5FwYrBMCQODhCMFqmhTLKvCmNSRA
         U5m6xu9rSn1IkOB2DMmdUv4hXr6ZATM2m8DivGXk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3ADcZ9M009214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Apr 2019 08:38:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 10
 Apr 2019 08:38:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 10 Apr 2019 08:38:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3ADcYnM071505;
        Wed, 10 Apr 2019 08:38:34 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/6] dt-bindings: mfd: Add lm36274 bindings to ti-lmu
Date:   Wed, 10 Apr 2019 08:38:29 -0500
Message-ID: <20190410133833.28859-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.21.0.5.gaeb582a983
In-Reply-To: <20190410133833.28859-1-dmurphy@ti.com>
References: <20190410133833.28859-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v2 - No changes - https://lore.kernel.org/patchwork/patch/1058776/

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
2.21.0.5.gaeb582a983

