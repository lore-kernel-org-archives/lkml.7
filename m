Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4FC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CF92075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfCZNkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:40:08 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCZNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:40:08 -0400
Received: from localhost ([89.247.163.190]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M72Xn-1h30rq0kgx-008Ymi; Tue, 26 Mar 2019 14:39:41 +0100
Date:   Tue, 26 Mar 2019 14:39:40 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] devantech-srf04.yaml: transform DT binding to YAML
Message-ID: <20190326133938.oitfjxlx2kou26lm@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:VIRtsjp4cKiHmZ3IdhI3AQ/qbZJX2+xnU/4zQ40LD5Sz8CH49t7
 7q0Ot1mBjhD/AR/ox8j0hlLf+Nv3UTyNGpgjPWowvlE+EVXRrVKTFkGBbCHiUqOiDyWIG/R
 dNqaaeVWF/43IY0bkTvgM3OfTYZc3VSObW0eTHVA2iCq06pSdGNqjpXPtzbCRpZQkFSI304
 rGGCN22NNw2TxkiBavMVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JR4WOPX3r+w=:J/C4eyngMV0QgPKvUKvXMm
 C2g0tGET114KzZc1G9i36VqFoRp50cfldaFk+tK6S7avSNA/JNbv7HuLwWvc6objW0pCdLIpT
 t7+WumdyDM084E519KnBpmEK5E7L0vPxgZQjDiap+LinlWiJBsLpeyAy6jJoyB78BYmD8mEqG
 VTsbb7PUDFPgVii2MoYiq9V5mmcvLqhCsK7BN5X2qnS9eBHbBjHpbCpkFZ5TgmT/M/mnv4Sji
 JxRDKMYYi3ECCYFzM4xOoIJNjhA23nQjTxpKEO5We+c4OoXOHYfrfVzY+C6Dl3Y/JTon9S61r
 kNsDLeeX/Wo+DUuZa6U7n8qHN/aDZXYMbXcaj7vW+o/1JElBe6CWdF//seSXSTQ8axH/ttdGc
 TXZ9JWLLL+WImv24bAZ1iEp/pTsdw39CS+41E/36UFU82J5NymX/cTqe7iijB7Lamu4kDJV9W
 otetVndW2f+hTRBe33Z8wrwgo9a04Q4diFX3CzaVVfv288Xo/X0avAI4JMQCMl5s0EbE+leNo
 eir105SzUwrTpOp7XOmzP+aZJgeSh5HCLJXCVuj5qGsPghCLEioy2QUHHjaKP91V+/SMC/ZB6
 uKLtlO0rrC18EY70r2m1S49AYiYCzDQ4swQ79+DiKkwPneVrT+DKs7Odd3J5zBsWYhCsAbr2+
 gDRp+VsCL6ddyvkpd0Bx49K2cu2lpS6T38nYlTTmEMDgYQJzWIwMOCDwnCHjB08MbIHsFXUbG
 C4eFNjrSd8L7OxsA1A7rIUmPck1xlWLBzTQl8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devantech-srf04.yaml: yaml devicetree binding for iio ultrasonic
proximity driver of devantech srf04

use devantech-srf04.txt, transform binding into yaml and remove the
outdated DT documentation

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/devantech-srf04.txt     | 28 ----------
 .../bindings/iio/proximity/devantech-srf04.yaml    | 59 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
deleted file mode 100644
index d4dc7a227e2e..000000000000
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Devantech SRF04 ultrasonic range finder
-  Bit-banging driver using two GPIOs
-
-Required properties:
- - compatible:	Should be "devantech,srf04"
-
- - trig-gpios:	Definition of the GPIO for the triggering (output)
-		This GPIO is set for about 10 us by the driver to tell the
-		device it should initiate the measurement cycle.
-
- - echo-gpios:	Definition of the GPIO for the echo (input)
-		This GPIO is set by the device as soon as an ultrasonic
-		burst is sent out and reset when the first echo is
-		received.
-		Thus this GPIO is set while the ultrasonic waves are doing
-		one round trip.
-		It needs to be an GPIO which is able to deliver an
-		interrupt because the time between two interrupts is
-		measured in the driver.
-		See Documentation/devicetree/bindings/gpio/gpio.txt for
-		information on how to specify a consumer gpio.
-
-Example:
-srf04@0 {
-	compatible = "devantech,srf04";
-	trig-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
-	echo-gpios = <&gpio2  6 GPIO_ACTIVE_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
new file mode 100644
index 000000000000..e7aab785c97d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/devantech-srf04.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Devantech SRF04 ultrasonic range finder
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  Bit-banging driver using two GPIOs:
+  - trigger-gpio is raised by the driver to start sending out an ultrasonic
+    burst
+  - echo-gpio is held high by the sensor after sending ultrasonic burst
+    until it is received once again
+
+  Specifications about the driver can be found at:
+  http://www.robot-electronics.co.uk/htm/srf04tech.htm
+
+properties:
+  compatible:
+    items:
+      - const: devantech,srf04
+
+  trig-gpios:
+    description:
+      Definition of the GPIO for the triggering (output) This GPIO is set
+      for about 10 us by the driver to tell the device it should initiate
+      the measurement cycle.
+    maxItems: 1
+
+  echo-gpios:
+    description:
+      Definition of the GPIO for the echo (input)
+      This GPIO is set by the device as soon as an ultrasonic burst is sent
+      out and reset when the first echo is received.
+      Thus this GPIO is set while the ultrasonic waves are doing one round
+      trip.
+      It needs to be an GPIO which is able to deliver an interrupt because
+      the time between two interrupts is measured in the driver.
+      See Documentation/devicetree/bindings/gpio/gpio.txt for information
+      on how to specify a consumer gpio.
+    maxItems: 1
+
+required:
+  - compatible
+  - trig-gpios
+  - echo-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    proximity {
+        compatible = "devantech,srf04";
+        trig-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+        echo-gpios = <&gpio2  6 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.11.0
