Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67475CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5BC20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZG/to7uC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfJ1JdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:33:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49290 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfJ1JdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:33:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9S9WxKL109675;
        Mon, 28 Oct 2019 04:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572255179;
        bh=rxOusbRtzaWzRY2Rmf9rDM18cyDMtpOkDzV61r0xEIQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZG/to7uCMakJ7BiMfKlt4bUZAsM43Zy2mN00eNFiPTZ+pPj6X7Wj1pv869yOnaKTK
         5D/mZQnwKyv0oqlUsDYW/xgCjZ8a5AKvbtapJlgdk2tobQ069a1psDGyWJI/BSIvHw
         b45RPcoxT7IkWqehC+yS0qD9anpSOY5z0KanqDJ8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9S9Wxh3066026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Oct 2019 04:32:59 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 04:32:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 04:32:59 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9S9WrLT072531;
        Mon, 28 Oct 2019 04:32:56 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3 controller
Date:   Mon, 28 Oct 2019 11:32:48 +0200
Message-ID: <20191028093249.22822-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028093249.22822-1-rogerq@ti.com>
References: <20191028093249.22822-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI platforms have a wrapper module around the Cadence USB3
controller. Add binding information for that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Cc: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/ti,j721e-usb.yaml | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
new file mode 100644
index 000000000000..5f5264b2e9ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/ti,j721e-usb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Bindings for the TI wrapper module for the Cadence USBSS-DRD controller
+
+maintainers:
+  - Roger Quadros <rogerq@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,j721e-usb
+
+  reg:
+    description: module registers
+
+  power-domains:
+    description:
+       PM domain provider node and an args specifier containing
+       the USB device id value. See,
+       Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+
+  clocks:
+    description: Clock phandles to usb2_refclk and lpm_clk
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ref
+      - const: lpm
+
+  ti,usb2-only:
+    description:
+      If present, it restricts the controller to USB2.0 mode of
+      operation. Must be present if USB3 PHY is not available
+      for USB.
+    type: boolean
+
+  ti,vbus-divider:
+    description:
+      Should be present if USB VBUS line is connected to the
+      VBUS pin of the SoC via a 1/3 voltage divider.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    cdns_usb@4104000 {
+          compatible = "ti,j721e-usb";
+          reg = <0x00 0x4104000 0x00 0x100>;
+          power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+          clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
+          clock-names = "ref", "lpm";
+          assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
+          assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
+          #address-cells = <2>;
+          #size-cells = <2>;
+
+          usb@6000000 {
+                compatible = "cdns,usb3";
+                reg = <0x00 0x6000000 0x00 0x10000>,
+                      <0x00 0x6010000 0x00 0x10000>,
+                      <0x00 0x6020000 0x00 0x10000>;
+                reg-names = "otg", "xhci", "dev";
+                interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
+                             <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
+                             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
+                interrupt-names = "host",
+                                  "peripheral",
+                                  "otg";
+                maximum-speed = "super-speed";
+                dr_mode = "otg";
+        };
+    };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

