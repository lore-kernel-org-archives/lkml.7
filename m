Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886C520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfDARcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:13 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733164AbfDARcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:11 -0400
Received: from localhost ([88.128.82.80]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFsdD-1h9gHm1VFf-00HPJQ; Mon, 01 Apr 2019 19:31:45 +0200
Date:   Mon, 1 Apr 2019 19:31:44 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        masneyb@onstation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bmp085.yaml: transform DT documentation of iio sensor
 into YAML
Message-ID: <20190401173142.cunj5iwz2ox454qx@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:pvuH7a1rABTg+UcpM29SaGBhBzWTUniAVX3J0NWk4KDHOji2emU
 zuPaCxl6tvndrwGP8tQh0Z50rqLzMEMQdzlY9C1j9y+ykVq+UtqB/7AGuC/GzbNOD+UH96v
 EKerkKl+3VxDSwEVBg5+Oq2NChoiMgL8p9YMOczR+2NPmxKKhkQ/9nTBbgmaAYGUzyYy0h0
 kV1dZN28cXFFXjElvtAww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sWwWGXihVE8=:LLm4vyhY7o0ihTONyD48v6
 anBckATTRSSS/HbLXDcCE+eKLJgzhHW4S8+mblHbM6sp0Ivsz28fxU3aCUaBTMdhPNy12XusV
 +mSGqIGfBemEjpHw2lfrGfya2+ubLQh/byWJTTTAwysvlvy4qOwtt5SCrqjDeuRgzHeHK4xzU
 SPRvmkmpcf8ruW+IQHFZWG6q7ufXY15WcPRte+DxoC2hYgfWsH+xYmfxK6MOVAwYjx9JRgHic
 0EnUIHaEKTO8n8Ak6VSQaYCgb71WNEHCuprTsOrq0UghcejPzyUUGoV8/sxT/zUrnbOd6EIvq
 UbqDms5iKysY2g77d4vw41moAGtrH23IbOWDN3IKepGjD5A5oY+37Ag2XuOCMqSpKgiCVry9d
 QEbw3Xuy5az1pcWiW1X4nz//SfFz7WEuEEb5Z42o74HlyKm4rpYs2TOkgOShL0Z08YO1/M7Kz
 lELGjoZHyMMjpWLEVnStFXeJIcvYvKyrW63C1wza15117IPO+PkwS44+VPBgoioRImuJdzo1S
 A2El8rFrYfwbpn5njA+l2i0Cw7b+vq4mHRm01rxGGe1f0cxPhjNkbuGk2U6aGGodSQs+OZB/z
 yuBZP6xPohc1Ku/DbgmNemaDPU0s2TfPm+w94sSjCFPgXnBHqCyrGYVoiY8mJ4095jf5MKBko
 uPqpYrUQNCUqQ1UXjButkecFplfQo01BLacVocryv182fbGHFR3d6iMDyraiklNb5s4gcZz12
 doj8UdPqdpf7r3QtObMZ61pfehGva4drbIn8Vg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use bmp085.txt and change it into yaml format

fix links to datasheets in replaced documentation

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../devicetree/bindings/iio/pressure/bmp085.txt    | 27 ---------
 .../devicetree/bindings/iio/pressure/bmp085.yaml   | 70 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 27 deletions(-)
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
index 000000000000..c6721a7e8938
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -0,0 +1,70 @@
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
+    enum:
+      - bosch,bmp085
+      - bosch,bmp180
+      - bosch,bmp280
+      - bosch,bme280
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
+    maxItems: 1
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
