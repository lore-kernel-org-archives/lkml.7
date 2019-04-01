Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B77C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1437820830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wt+Viejc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbfDAReW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:34:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34210 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbfDAReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31HY41r129011;
        Mon, 1 Apr 2019 12:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554140044;
        bh=xDYlTH5XXfThFNxXnCwRk3hxMj0oZHMo/0kqlGCr+P8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wt+Viejc7IW4vTS6ae4Gh7bCMhr6r5NosiXz6r21flpDIcWMLabMkvBdQWgR4DAab
         aIrHeu6Gw3xV3pJVSg/l1BUb2p31JmC07TuTrIZPIhbMhBRKzyyAalK8I+pD4Sg9TZ
         cX7chlNuYPR194wYCjVcpIbi4aS17+kRIlwzR9tw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31HY46b110627
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 12:34:04 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 12:34:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 12:34:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31HY33c036390;
        Mon, 1 Apr 2019 12:34:03 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <marek.behun@nic.cz>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 2/5] dt: bindings: Add multicolor class dt bindings documention
Date:   Mon, 1 Apr 2019 12:33:57 -0500
Message-ID: <20190401173400.14238-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190401173400.14238-1-dmurphy@ti.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the LEDs multicolor class framework.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/leds/leds-class-multicolor.txt   | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
new file mode 100644
index 000000000000..4b1a26104c79
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
@@ -0,0 +1,140 @@
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
+	- color : This is the color ID of the LED.  Definitions can be found
+		  in include/linux/leds/common.txt
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
+		label = "rgb:led_mod4";
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
2.19.0

