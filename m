Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E2C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883FB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfCZMbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:31:49 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfCZMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:31:49 -0400
Received: from localhost ([89.247.163.190]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUGNZ-1hYz6N1XzX-00RGvz; Tue, 26 Mar 2019 13:31:24 +0100
Date:   Tue, 26 Mar 2019 13:31:23 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] devantech-srf04.yaml: transform DT binding to YAML
Message-ID: <20190326123121.ibe3olu3yxptauws@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:+aNG149jcbuYqmoS1FcLb4ZqRan3eMznzWnK+1xbjVnQccBcCpy
 8hF005ooTX6Ef/p/vTc/fOvkeH9Q+5Cj9nMz3Bh3fLMu7h91y/5hyrIn8okUw2NH8a6lVl4
 SJFE5FlwxIchHudxoLFNOAz2J69eO7jExxqz92IUvNW38y74/gzQhvQ/qivG/WUo4RQGzFn
 DRiClsGtkLNfLMOyqyhzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EigqP6sLmBA=:OhNTIzeDTbtnEYfHMbs0jN
 xydQ88sm0J1DiEzN1uyUgy7HhTqlcJuy/YRmPxFUiiCYkZ6izdFShquX44lDOMZTgCPhKk9Dl
 tp6wUM5J8UaaHovbO+M0VJw9/UmxRijoUgD+mWKUai4q4k2qLaW4NMCpJDBOYnWJC5CeyXsq/
 gMDE+cKOcjENznewVNkAe4uqd3Ux4Tr7pAvR5UftSAnrHeoBiZpyG8NBvwbP9fy0MgmTn5FtC
 +eRmAiBF70uAK9Kn77emh+R7xGtk5lQa8E2U7ghYYa+Y4+EvI+sMqr93UPToQV1zW7d018hhk
 3Hw7SasPowA+F44gQU9DWHp2Ye/hKeNLpBZWRolL3EEGiuLGGeM2+HWY80S5NQdo4GABMD0i0
 fqKj9iMQGy7kyWor+5PP5gU462ZriN98vZodEL1I7pbIB5OhHMOcaLDf6WlA18mXiK6fWqJ8X
 M6gHb1rZcnMeVCihdDJmQc7bCqoaE1p0Du/69f1SAjRIslZ14r44KpueKFlOf0bKzBEZzcu/6
 v274TyIDPwnHYVUOTldGWu4UGB9EVeZ/Qo5J9vwJ4Vv937KOB4Iy75tMdjg0rugFc1UZykUcN
 ncOyjjMvznEBtUZ3ghA0fQ6yKmaekwL+Sde8YPlpJCfmu+xcBJtB5Unsh3Sxiuzjw50Wxz4ei
 GBDBgFEYPD9skogGJ7P60gQbRIJgRvJdGwL4biMA61R/d1b8iO7hSTAbfIyiyd3KSGkT0S1Xg
 P0cROKmmtv78PpbPX08nkRHhrONgEIPY20ehDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use devantech-srf04.txt and transform binding into yaml

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/devantech-srf04.yaml    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
new file mode 100644
index 000000000000..cd065393b062
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -0,0 +1,62 @@
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
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
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
