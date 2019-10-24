Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1424421655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fDWBIYHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439265AbfJXLrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:47:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45968 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfJXLrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:47:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9OBlPvn023731;
        Thu, 24 Oct 2019 06:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571917645;
        bh=NDN9/CcUPcm809+gjIJlWOrYqiVSCH+PMHSuTHZryIg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fDWBIYHG2tRnJ/5LCmf/uZRExpFNzc0D0Z8iRsukJmX++tg0qqe+grBsYL7bjX6td
         yM+g4A3Bhr4vP2Hv7sa8A82l7jHE9fJdeOyhJTguMPe8GqEbunjigkPBmfat2JpkYj
         bh/mjNMkzVDjXyGQOyHMNulQEBYA4EdHvbg7Xm74=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9OBlP1Z129870
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Oct 2019 06:47:25 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 24
 Oct 2019 06:47:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 24 Oct 2019 06:47:14 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9OBlIAK061379;
        Thu, 24 Oct 2019 06:47:21 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3 controller
Date:   Thu, 24 Oct 2019 14:47:16 +0300
Message-ID: <20191024114717.30984-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024114717.30984-1-rogerq@ti.com>
References: <20191024114717.30984-1-rogerq@ti.com>
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

