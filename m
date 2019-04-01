Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF56C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7AB20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfDARe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:34:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbfDAReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:21 -0400
Received: from localhost ([88.128.82.80]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKuGD-1hW70Y3ITN-00LIAd; Mon, 01 Apr 2019 19:33:55 +0200
Date:   Mon, 1 Apr 2019 19:33:54 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] avia-hx711.yaml: transform DT binding to YAML
Message-ID: <20190401173353.g4k5vb6flsfgtaaj@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:odTq/USEkEGP+Q1Tk6oBoKZrDHxcjAUBqDGKmMtL/ZZmclkQb7Q
 UA2F9DKUvL9hV4Hw6xhw1uXRDOQpAeFFieuvyHOS/LkNkbc28eSZBoBnSlj86xuth6VLJcg
 rmCt87awnZxfTY65+10kePM0Gg5wQ5/hmmCvyp6gOzcbGKTjjGumo4+kMDSQGHTnOMFauJO
 QTqln3vwtfAY0GfHQe6XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ASsM5JBLSA=:ukXYP21DobAT5m2PkBv1ev
 TtOF7BXYcslJ5IscOfiHohWp5km2N7NcAdSZXcECXebDGBvoZ6/qULKvIk1J/qMTLhwGJzn31
 iKfGtTFq5xb2Nrnxzb9GW9YYQJJ/3SLNeojDkfyDSkp/k4BgnHdIQIOO3f4yErB6w8LFyFOzw
 sV8dnJJxALAsXj76E8Lp7N1Pz5HU4pjFkJTn4PIjGKkzWX3JO3pke20Ovnqa/IzEI5I2c+QhT
 hvmvVC5rt7Vs0qIX9w3y/NLOzc9KsYtKL1yfIbbmG8BKpcsdW6MJuB7a95Ky2PkhTKi1SOUeG
 YF4V+VFCbQn/2YkaGeRiT6MpVOl8f688WZeGQ1LJZh8xAMYGHIHDqzmIYIicFAXFdZxQi2Gj5
 8V/hxhBgu5TJaNett00yZK1qebC26OtkIYIcGJ4pt9+zQqKSvJ99wsNcgB5JIOU/mJAo5K3jH
 t6Jyoyt8dnRne3Uzeo5jEnjanaGkCngiYwtRJs13nid+u4jXjxVYJuPLxoqKWj+L24G/TGaot
 rM3mEX4duxhxvSH7nfziwWS7OjrTqf8IgtfDpBl0D8Tnj2YJEy1IWvLNykcihSHzCdagESqiA
 4DAb4zVJhYqAUSqzbEkmhc6/itdUsj8G3yo8UIJIJcVO26ddy8Gqt3TwhvxnLwr6OxbEstndM
 82MP61/UNwFmAp0/OKM0daYjYF/P2hb8INb9MlIdcABKGft2X6JU+byCB/0InSfkwqVXvWvLv
 SqXTszW082Nf8x75ExyE9Nxb+qgZn0It/ZXWQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace avia-hx711.txt by avia-hx711.yaml as yaml devicetree
documentation for avia hx711 iio adc sensor

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../devicetree/bindings/iio/adc/avia-hx711.txt     | 24 --------
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    | 66 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
deleted file mode 100644
index 7222328a3d0d..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* AVIA HX711 ADC chip for weight cells
-  Bit-banging driver
-
-Required properties:
- - compatible:	Should be "avia,hx711"
- - sck-gpios:	Definition of the GPIO for the clock
- - dout-gpios:	Definition of the GPIO for data-out
-		See Documentation/devicetree/bindings/gpio/gpio.txt
- - avdd-supply:	Definition of the regulator used as analog supply
-
-Optional properties:
- - clock-frequency:	Frequency of PD_SCK in Hz
-			Minimum value allowed is 10 kHz because of maximum
-			high time of 50 microseconds.
-
-Example:
-weight {
-	compatible = "avia,hx711";
-	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
-	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
-	avdd-suppy = <&avdd>;
-	clock-frequency = <100000>;
-};
-
diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
new file mode 100644
index 000000000000..8a4100ceeaf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AVIA HX711 ADC chip for weight cells
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  Bit-banging driver using two GPIOs:
+  - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
+    and up to 3 cycles for selection of the input channel and gain for the
+    next measurement
+  - dout-gpio is the sensor data the sensor responds to the clock
+
+  Specifications about the driver can be found at:
+  http://www.aviaic.com/ENProducts.aspx
+
+properties:
+  compatible:
+    enum:
+      - avia,hx711
+
+  sck-gpios:
+    description:
+      Definition of the GPIO for the clock (output). In the datasheet it is
+      named PD_SCK
+    maxItems: 1
+
+  dout-gpios:
+    description:
+      Definition of the GPIO for the data-out sent by the sensor in
+      response to the clock (input).
+      See Documentation/devicetree/bindings/gpio/gpio.txt for information
+      on how to specify a consumer gpio.
+    maxItems: 1
+
+  avdd-supply:
+    description:
+      Definition of the regulator used as analog supply
+    maxItems: 1
+
+  clock-frequency:
+    minimum: 20000
+    maximum: 2500000
+    default: 400000
+
+required:
+  - compatible
+  - sck-gpios
+  - dout-gpios
+  - avdd-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    weight {
+        compatible = "avia,hx711";
+        sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+        dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        avdd-suppy = <&avdd>;
+        clock-frequency = <100000>;
+    };
-- 
2.11.0
