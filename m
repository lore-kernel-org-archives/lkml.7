Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC96C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0B420856
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfCaQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:48:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbfCaQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:48:24 -0400
Received: from localhost ([46.183.103.17]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1My2pz-1h1MKf3SZD-00zVQB; Sun, 31 Mar 2019 18:47:59 +0200
Date:   Sun, 31 Mar 2019 18:47:56 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        masneyb@onstation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bmp085.yaml: transform DT documentation of iio sensor into
 YAML
Message-ID: <20190331164753.xifw6kkiwdg4xpzo@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:o5hHlLfo4Vhe5StMsrjxDDrbkijgYfhiSS5BdSANv6Nehq72DTo
 pM0SOxCeDRAIAbDipMHo2oIhHgPeDKsIhdj8vbHJob2oS0B/IwHAjNMJUjjMV7UD3JWudEr
 wxQiYYgBbpDgWq+UsXsBQvYfipRbiW2oUZuMu+xEw6Mtnvd3/uWxHZfBjYmM1bu5WRpuXRO
 i+vUMdbVyoWMfEgtt4Y4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hxXyqtuNJ3E=:xCegxalvBYAtEB6NrDeq5I
 WTl+2wljvqYUE08zBqFiY1mKMaQWIbrBzDH+88KQzyhl1OZX6uPhwuwEekoy+woCEvfLujyJd
 5dyvEBk8A3DwEVQzoXvkV6diCbvxT77biycbT1wcsu5ohgrvc1pdGL0PkuGq3jZSc1KRH7Lhb
 xT1QgK0yxbpiFfm13x70hFqAl3ZtU+fXZyPPoLZ48YyObMP+ZXmqx696CkTTtIOfRVWaw7225
 IA91uOLOS0z534ZKbAyaiL0pYmc79BJk3xK5kU4rDwDyzL5eBlcKd2ztm2JNOCQpjN617hxur
 Dfc9AaK+GY00pGpS1y4Tp79g0JuIsdgFTI/s7TU6pcHu7Oznz33BLhkZGl4sKYvURIBh7C/6/
 /RlWgHhfkskPX1k340zJKi08Xd7hh7hdOAe2CarbC6MAJvjkCzsdfTJWZJZYfZHfnesaXv5JV
 EqwQjNgCwfLu5jpqPFwycJ3Mpsq3o3lDwQ9xKaYjW5KY3+0hDvGa0Dxu2VljQ072z91PXHARw
 DgvwVL5fuO7uBOJTQSGbEeqpeQd3PcBMknomtQNpFGHi/5VY+0HTPEDk5CXaCLBcZKg9HG2Kd
 QKBkB1NtL7UcoKMVM5ate447hzZxwDqZYFpA194H9Vvtaxuhhq1vBlpbU3DHc+vusoDxYosnr
 DAyvKNiq92wwyW7zZLvEwbWUMRpwLPjgOzME2WYr7WKppafShkRakFB8wNs9F7X7CpON9orOk
 BLCNpp5q1DGTIM1Pz4W0veomuJcPa21U3guimTjEukp1ElwKiJd1QHJ5ElE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use bmp085.txt and change it into yaml format

fix links to datasheets in replaced documentation

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../devicetree/bindings/iio/pressure/bmp085.txt    | 27 --------
 .../devicetree/bindings/iio/pressure/bmp085.yaml   | 71 ++++++++++++++++++++++
 2 files changed, 71 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
deleted file mode 100644
index 61c72e63c584..000000000000
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-BMP085/BMP18x/BMP28x digital pressure sensors
-
-Required properties:
-- compatible: must be one of:
-  "bosch,bmp085"
-  "bosch,bmp180"
-  "bosch,bmp280"
-  "bosch,bme280"
-
-Optional properties:
-- interrupts: interrupt mapping for IRQ
-- reset-gpios: a GPIO line handling reset of the sensor: as the line is
-  active low, it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)
-- vddd-supply: digital voltage regulator (see regulator/regulator.txt)
-- vdda-supply: analog voltage regulator (see regulator/regulator.txt)
-
-Example:
-
-pressure@77 {
-	compatible = "bosch,bmp085";
-	reg = <0x77>;
-	interrupt-parent = <&gpio0>;
-	interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-	reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
-	vddd-supply = <&foo>;
-	vdda-supply = <&bar>;
-};
diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
new file mode 100644
index 000000000000..884f889c1ca5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/bmp085.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BMP085/BMP180/BMP280/BME280 pressure iio sensors
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  Pressure, temperature and humidity iio sensors with i2c and spi interfaces
+
+  Specifications about the sensor can be found at:
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp180
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp280
+    https://www.bosch-sensortec.com/bst/products/all_products/bme280
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - bosch,bmp085
+          - bosch,bmp180
+          - bosch,bmp280
+          - bosch,bme280
+
+  vddd-supply:
+    description:
+      digital voltage regulator (see regulator/regulator.txt)
+    maxItems: 1
+
+  vdda-supply:
+    description:
+      analog voltage regulator (see regulator/regulator.txt)
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      A GPIO line handling reset of the sensor. As the line is active low,
+      it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt mapping for IRQ (BMP085 only)
+
+required:
+  - compatible
+  - vddd-supply
+  - vdda-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pressure@77 {
+          compatible = "bosch,bmp085";
+          reg = <0x77>;
+          interrupt-parent = <&gpio0>;
+          interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+          reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+          vddd-supply = <&foo>;
+          vdda-supply = <&bar>;
+      };
+    };
-- 
2.11.0
