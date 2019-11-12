Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294B3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26CB222CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VL5kREgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfKLO3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:29:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfKLO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:29:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACETbG4045574;
        Tue, 12 Nov 2019 08:29:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568977;
        bh=NExSdKCWUJTypoMVmnkZw64WAdAPw9ouL0SwGsRb2fk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VL5kREgqwp7SBr7VYMVvFa6I1GJrcfhuNZxvSccpjQnR3uJRWglXKVuvlC6JWMSVB
         TTDZR6lF8iHHSweso6d4xR/DCCBxnw8PM8L2jgHyRViNroDIAB+gEYUTsm8aM6IA0g
         mJA0sPUuBXdDJJB7cOncutz6eaena5OA8wDblgcM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACETbsL038565;
        Tue, 12 Nov 2019 08:29:37 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:29:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:29:19 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriW044422;
        Tue, 12 Nov 2019 08:29:37 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 20/20] dt-bindings: media: cal: convert binding to yaml
Date:   Tue, 12 Nov 2019 08:31:52 -0600
Message-ID: <20191112143152.23176-21-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112143152.23176-1-bparrot@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ti-cal.txt to ti,cal.yaml.
Add ti,cal.yaml to the MAINTAINERS file.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 .../devicetree/bindings/media/ti,cal.yaml     | 202 ++++++++++++++++++
 .../devicetree/bindings/media/ti-cal.txt      |  81 -------
 MAINTAINERS                                   |   1 +
 3 files changed, 203 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,cal.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/ti-cal.txt

diff --git a/Documentation/devicetree/bindings/media/ti,cal.yaml b/Documentation/devicetree/bindings/media/ti,cal.yaml
new file mode 100644
index 000000000000..1ea784179536
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti,cal.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/ti,cal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DRA72x CAMERA ADAPTATION LAYER (CAL) Device Tree Bindings
+
+maintainers:
+  - Benoit Parrot <bparrot@ti.com>
+
+description: |-
+  The Camera Adaptation Layer (CAL) is a key component for image capture
+  applications. The capture module provides the system interface and the
+  processing capability to connect CSI2 image-sensor modules to the
+  DRA72x device.
+
+  CAL supports 2 camera port nodes on MIPI bus. Each CSI2 camera port nodes
+  should contain a 'port' child node with child 'endpoint' node. Please
+  refer to the bindings defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+properties:
+  compatible:
+    enum:
+      # for DRA72 controllers
+      - ti,dra72-cal
+      # for DRA72 controllers pre ES2.0
+      - ti,dra72-pre-es2-cal
+      # for DRA76 controllers
+      - ti,dra76-cal
+      # for AM654 controllers
+      - ti,am654-cal
+
+  reg:
+    minItems: 2
+    items:
+      - description: The CAL main register region
+      - description: The RX Core0 (DPHY0) register region
+      - description: The RX Core1 (DPHY1) register region
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: cal_top
+      - const: cal_rx_core0
+      - const: cal_rx_core1
+
+  interrupts:
+    maxItems: 1
+
+  ti,camerrx-control:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      phandle to the device control module and offset to the
+      control_camerarx_core register
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    description:
+      List of phandle and PM domain specifier as documented in
+      Documentation/devicetree/bindings/power/power_domain.txt
+    maxItems: 1
+
+  # See ./video-interfaces.txt for details
+  ports:
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            const: 0
+            description: CSI2 Port #0
+
+        patternProperties:
+          endpoint:
+            type: object
+            additionalProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+              remote-endpoint: true
+
+        required:
+          - reg
+
+      port@1:
+        type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            const: 1
+            description: CSI2 Port #1
+
+        patternProperties:
+          endpoint:
+            type: object
+            additionalProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+              remote-endpoint: true
+
+        required:
+          - reg
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - ti,camerrx-control
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cal: cal@4845b000 {
+        compatible = "ti,dra72-cal";
+        reg = <0x4845B000 0x400>,
+              <0x4845B800 0x40>,
+              <0x4845B900 0x40>;
+        reg-names = "cal_top",
+                    "cal_rx_core0",
+                    "cal_rx_core1";
+        interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+        ti,camerrx-control = <&scm_conf 0xE94>;
+
+        ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              csi2_0: port@0 {
+                    reg = <0>;
+                    csi2_phy0: endpoint {
+                           remote-endpoint = <&csi2_cam0>;
+                           clock-lanes = <0>;
+                           data-lanes = <1 2>;
+                    };
+              };
+        };
+    };
+
+    i2c5: i2c@4807c000 {
+        clock-frequency = <400000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera-sensor@3c {
+               compatible = "ovti,ov5640";
+               reg = <0x3c>;
+
+               clocks = <&clk_ov5640_fixed>;
+               clock-names = "xclk";
+
+               port {
+                    csi2_cam0: endpoint {
+                            remote-endpoint = <&csi2_phy0>;
+                            clock-lanes = <0>;
+                            data-lanes = <1 2>;
+                    };
+               };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/media/ti-cal.txt b/Documentation/devicetree/bindings/media/ti-cal.txt
deleted file mode 100644
index 2deb256e7032..000000000000
--- a/Documentation/devicetree/bindings/media/ti-cal.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-Texas Instruments DRA72x CAMERA ADAPTATION LAYER (CAL)
-------------------------------------------------------
-
-The Camera Adaptation Layer (CAL) is a key component for image capture
-applications. The capture module provides the system interface and the
-processing capability to connect CSI2 image-sensor modules to the
-DRA72x device.
-
-Required properties:
-- compatible:
- Should be "ti,dra72-cal", for DRA72 controllers
- Should be "ti,dra72-pre-es2-cal", for DRA72 controllers pre ES2.0
- Should be "ti,dra76-cal", for DRA76 controllers
- Should be "ti,am654-cal", for AM654 controllers
-- reg:	CAL Top level, Receiver Core #0, Receiver Core #1 and Camera RX
-	control address space
-- reg-names: cal_top, cal_rx_core0, cal_rx_core1 and camerrx_control
-	     registers
-- interrupts: should contain IRQ line for the CAL;
-- ti,camerrx-control: phandle to the device control module and offset to
-		      the control_camerarx_core register.
-		      This node is meant to replace the "camerrx_control"
-		      reg entry above but "camerrx_control" is still
-		      handled for backward compatibility.
-
-CAL supports 2 camera port nodes on MIPI bus. Each CSI2 camera port nodes
-should contain a 'port' child node with child 'endpoint' node. Please
-refer to the bindings defined in
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-Example:
-	cal: cal@4845b000 {
-		compatible = "ti,dra72-cal";
-		reg = <0x4845B000 0x400>,
-		      <0x4845B800 0x40>,
-		      <0x4845B900 0x40>;
-		reg-names = "cal_top",
-			    "cal_rx_core0",
-			    "cal_rx_core1";
-		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
-		ti,camerrx-control = <&scm_conf 0xE94>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			csi2_0: port@0 {
-				reg = <0>;
-				csi2_phy0: endpoint {
-					remote-endpoint = <&csi2_cam0>;
-					clock-lanes = <0>;
-					data-lanes = <1 2>;
-				};
-			};
-			csi2_1: port@1 {
-				reg = <1>;
-			};
-		};
-	};
-
-	i2c5: i2c@4807c000 {
-		clock-frequency = <400000>;
-
-		camera-sensor@3c {
-			compatible = "ovti,ov5640";
-			reg = <0x3c>;
-
-			clocks = <&clk_fixed>;
-			clock-names = "xclk";
-
-			port {
-				csi2_cam0: endpoint {
-					remote-endpoint = <&csi2_phy0>;
-					clock-lanes = <0>;
-					data-lanes = <1 2>;
-				};
-			};
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 37a977cbac6f..909961cff0fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16324,6 +16324,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/platform/ti-vpe/
 F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
+	Documentation/devicetree/bindings/media/ti,cal.yaml
 
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
-- 
2.17.1

