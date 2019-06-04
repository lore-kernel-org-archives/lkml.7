Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0DD207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vt+ZGbLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFDRn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:43:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37492 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFDRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:43:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54Hhnli027627;
        Tue, 4 Jun 2019 12:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559670229;
        bh=p/w7U8M9/CoJS0HUsPEqCyOoFhRjhTcOtuoAb+KaDFE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vt+ZGbLlmc2lBA6y2lSHwQp12JEmFp+6SduEQ9MRCo3Gsbha2UKdemBmPSdh5buVL
         xPjPXmSdfWxCDWIHG5C51dBYDfGNDI58iAPsGXHyHSE0HhSBLeQHz95RRyDz5Qq8Ig
         UKfQv0fDqGIq4qab++m6RSXHa98UJbVc0wb8M9JI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54Hhn3j057687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 12:43:49 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 12:43:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 12:43:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54Hhn1G123676;
        Tue, 4 Jun 2019 12:43:49 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <lee.jones@linaro.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 5/6] dt-bindings: leds: Add LED bindings for the LM36274
Date:   Tue, 4 Jun 2019 12:43:44 -0500
Message-ID: <20190604174345.14841-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.21.0.5.gaeb582a983
In-Reply-To: <20190604174345.14841-1-dmurphy@ti.com>
References: <20190604174345.14841-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the LM36274 LED specific bindings.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---

v5 - No changes

 .../devicetree/bindings/leds/leds-lm36274.txt | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm36274.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm36274.txt b/Documentation/devicetree/bindings/leds/leds-lm36274.txt
new file mode 100644
index 000000000000..329393700191
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm36274.txt
@@ -0,0 +1,82 @@
+* Texas Instruments LM36274 4-Channel LCD Backlight Driver w/Integrated Bias
+
+The LM36274 is an integrated four-channel WLED driver and LCD bias supply.
+The backlight boost provides the power to bias four parallel LED strings with
+up to 29V total output voltage. The 11-bit LED current is programmable via
+the I2C bus and/or controlled via a logic level PWM input from 60 μA to 30 mA.
+
+Parent device properties are documented in ../mfd/ti_lmu.txt
+Regulator properties are documented in ../regulator/lm363x-regulator.txt
+
+Required backlight properties:
+	- compatible:
+		"ti,lm36274-backlight"
+	- reg : 0
+	- #address-cells : 1
+	- #size-cells : 0
+	- led-sources : Indicates which LED strings will be enabled.
+			Values from 0-3, sources is 0 based so strings will be
+			source value + 1.
+
+Optional backlight properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+HVLED string 1 and 3 are controlled by control bank A and HVLED 2 string is
+controlled by control bank B.
+
+lm36274@11 {
+	compatible = "ti,lm36274";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x11>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+
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
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm36274.pdf
-- 
2.21.0.5.gaeb582a983

