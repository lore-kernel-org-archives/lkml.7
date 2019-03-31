Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38530C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133CD20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfCaP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:27:47 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbfCaP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:27:47 -0400
Received: from localhost ([46.183.103.17]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MirX2-1gglG117Ia-00eqHR; Sun, 31 Mar 2019 17:27:21 +0200
Date:   Sun, 31 Mar 2019 17:27:19 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] avia-hx711.yaml: transform DT binding to YAML
Message-ID: <20190331152717.j3b3aggx674zrcko@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:8srxJQR4NFdCcwtXmptXtnJUqw19e2iSVy9vdLa0F6Yf079FxCy
 ZSD83zdvZfYyOnZoSercbRWQEq5a2AALok2Wxm0kl66v8vXiOTVN3CYDsvmjiN06WpHbrIr
 6rTiLIilZV2haM9lv/gMwVJxAT1Qf9d0AdbI8UjhX5R15ms6XJdEEIfErHQ7khEAO3jWUM1
 DMVzJjJuhIgmapatGV1Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WC6t/Mzhk1I=:ISGn84++fZC5E33ESrNRDX
 +kyPDfztqGOz/foMyxKO2CRnuYJcHnYDf/niIeWwH0g/f/mC41iczm1nTQ/edXYdncX66QOcJ
 wPgnSDUAxfhNzU7o6fLUqQ37672AR4CCtimW4rRonAGn8DGlvsXv4+l+SdqrxMZ/DuR8MCrI4
 AFllMrY5KDcEXuDk93eKr0BFHQx1oKCAGrN5VQjXaB9GGKqYZRxyqUcRgtnb9fT2oJw6QmQt6
 V1UnOs38aT9Dln5D0Y9wUyd09Pi+Pp9iTdD04JxulYTJcmqQRtM1bLkJ29CPxJLW5gJNOxx87
 t2r3b6vdxcCyCE7reReMkmAK+EUAtQd0JXFcDhbw3lvXdd/1OqWjGAf8IxaFu24cnOobua3fs
 ntbIQmqQvbPq3VWZNoM17Tilql9QnPkrkGYfXr2euq3tjk/oEs4LO6lm5IizKXd1Ot0EgVCgn
 eq1nigXFh5PiNbRaihu2ncey66sAFiVlwbvloEIlMD8BBTUnnLcaVL3A+SOfLG69F1JrYPVTF
 NQJTKgchapXnveH3fLfzn9zTT/KM0P/rCArtnqgoByWQSIItK20Plo54ED9puXuNFJrMwKNDT
 etLS0GlWLKUyz6lVRwJjNeJ8UEsjM4oZtAkMa3X8jBz5EeBGsviR6dt8PpA5vF1s8je0YTmMe
 R1N095OVQryDpl+OXMvUzUywPCBjMACy+ePCfgMgFCQ6P6/ZDyAB1UvnEwlsCw/gONJMNg/+H
 KXxtrqSegCxEVku32NJGLWBzAaK8izv37WvGMWUehweIIFRv5xyV0M3KY40=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace avia-hx711.txt by avia-hx711.yaml as yaml devicetree documentation
for avia hx711 iio adc sensor

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../devicetree/bindings/iio/adc/avia-hx711.txt     | 24 --------
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    | 67 ++++++++++++++++++++++
 2 files changed, 67 insertions(+), 24 deletions(-)
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
index 000000000000..e4fee0f877ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -0,0 +1,67 @@
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
+    oneOf:
+      - items:
+        - const: avia,hx711
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
