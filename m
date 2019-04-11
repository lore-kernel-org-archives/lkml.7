Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A7B2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xwcSybCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDKTjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:39:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52022 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:39:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BJcoFv116875;
        Thu, 11 Apr 2019 14:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555011530;
        bh=t3YrqG0Nm7PYbsiOLOPSZsjrnOS/RgZqdo+csKzF08c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xwcSybCl8YX+gJqWNAyO6Oaz7Dzkb0/lh+uRDt4AeIKJfe3eq6telw532AqWTsm/0
         7bDwVDU+wrV8Ws2WdgwfvxzzeG0M4MO5x6/Emm2Hr2hCVBNlg8hnudRwELZEFCB5wh
         DqsdtatAzMxrO1AALTQWoRPfLaJlB/yzfkOonfcs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BJcoDU095215
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 14:38:50 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 14:38:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 14:38:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BJco1T073804;
        Thu, 11 Apr 2019 14:38:50 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <marek.behun@nic.cz>, <rdunlap@infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings documention
Date:   Thu, 11 Apr 2019 14:38:43 -0500
Message-ID: <20190411193848.23140-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.21.0.5.gaeb582a983
In-Reply-To: <20190411193848.23140-1-dmurphy@ti.com>
References: <20190411193848.23140-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the LEDs multicolor class framework.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/common.txt       |   2 +
 .../bindings/leds/leds-class-multicolor.txt   | 142 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 7497a3c221fe..bc424a9ba547 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -23,6 +23,8 @@ Optional properties for child nodes:
 - color : Color of the LED. Use one of the LED_COLOR_ID_* prefixed definitions
 	  from the header include/dt-bindings/leds/common.h.
 	  If there is no matching LED_COLOR_ID available, add a new one.
+	  For multi color LED support see leds-multicolor.txt within this
+	  directory.
 
 - led-enumerator: Integer to be used for LED differentiation when neither
 		  function nor color can be used for that purpose.
diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
new file mode 100644
index 000000000000..9cbc4aece53d
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
@@ -0,0 +1,142 @@
+* Multicolor LED properties
+
+Multicolor LEDs can consist of a RGB, RGBW or a RGBA LED clusters.  These devices
+can be grouped together and also provide a modeling mechanism so that the
+cluster LEDs can vary in hue and intensity to produce a wide range of colors.
+
+The nodes and properties defined in this document are unique to the multicolor 
+LED class.  Common LED nodes and properties are inherited from the common.txt
+within this documentation directory.
+
+Required LED Child properties:
+	- color : For multicolor LED support this property should be defined as
+		  LED_COLOR_ID_MULTI and further definition can be found in
+		  include/linux/leds/common.h.
+
+Optional LED Child properties:
+	- available-brightness-models : This is the phandle to the brightness-model
+					node(s) that this LED cluster can support.
+
+Required Brightness model properties
+	- led-brightness-model : This flag alerts the device driver and class
+				 code that this node is a brightness model node
+				 and to process the properties differently.
+
+Required Brightness model child properties
+	- model_name : This is the name of the model presented to the user.  This
+		       should be a color that the LED cluster can produce for
+		       the device it is attached to.
+	- layout : This is the LED layout for the levels.  This layout will
+		   determine the color order of the levels.  The layout and
+		   level-x properties array should be the same size.
+	- level-x : These are the values for the LEDs to produce the color that
+		    is defined.  These values are placed in the array according
+		    to the layout property.
+
+led-controller@30 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "ti,lp5024";
+	reg = <0x29>;
+
+	lp5024_model_yellow: brightness-models {
+		led-brightness-model;
+		model@0 {
+			model_name = "yellow";
+			layout = <LED_COLOR_ID_RED
+				  LED_COLOR_ID_GREEN
+				  LED_COLOR_ID_BLUE>;
+			level-1 = <255 227 40>;
+			level-2 = <255 240 136>;
+			level-3 = <255 247 196>;
+		};
+	};
+
+	lp5024_model_orange: brightness-models {
+		led-brightness-model;
+		model@1 {
+			model_name = "orange";
+			layout = <LED_COLOR_ID_RED
+				  LED_COLOR_ID_GREEN
+				  LED_COLOR_ID_BLUE>;
+			level-1 = <236 140 16>;
+			level-2 = <236 157 55>;
+			level-3 = <236 183 115>;
+		};
+	}; 
+
+	multi-led@4 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <4>;
+		color = <LED_COLOR_ID_MULTI>;
+		function = LED_FUNCTION_ACTIVITY;
+		available-brightness-models = <&lp5024_model_yellow>;
+		
+		led@12 {
+			reg = <12>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@13 {
+			reg = <13>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@14 {
+			reg = <14>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+
+	/* Only support RGB no model defined */
+	multi-led@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+		label = "rgb:led_mod1";
+		
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@4 {
+			reg = <4>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@5 {
+			reg = <5>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+
+	multi-led@2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		label = "rgb:banks";
+		reg = <2>;
+		ti,led-bank = <2 3 5>;
+		available-brightness-models = <&lp5024_model_orange>;
+
+		led@6 {
+			reg = <0x6>;
+			color = <LED_COLOR_ID_RED>;
+			led-sources = <6 9 15>;
+		};
+
+		led@7 {
+			reg = <0x7>;
+			color = <LED_COLOR_ID_GREEN>;
+			led-sources = <7 10 16>;
+		};
+
+		led@8 {
+			reg = <0x8>;
+			color = <LED_COLOR_ID_BLUE>;
+			led-sources = <8 11 17>;
+		};
+	};
+
+};
-- 
2.21.0.5.gaeb582a983

