Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE86C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC3121823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lne7yb6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfLFKvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:51:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6254 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:51:38 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dea32b00001>; Fri, 06 Dec 2019 02:51:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 06 Dec 2019 02:51:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 06 Dec 2019 02:51:33 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 10:51:32 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 10:51:32 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dea32b10001>; Fri, 06 Dec 2019 02:51:32 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH 02/18] dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
Date:   Fri, 6 Dec 2019 16:20:05 +0530
Message-ID: <1575629421-7039-3-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575629488; bh=4wCpTvNZgxIv4reZrsl0cSsrcZJFi6eF2CqMZErqum4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lne7yb6YwnV3H1GGxMZVKIhCL9g9oMKOgVlhZ+8PnrdIvIJLWnOULM1EF/VNV4xgU
         YQta2AgQjP/IF+TjxOCGOWbO0lenYvjLK4WB3jpEawiDH6EUzOfROgUoMCdDco71U4
         jKgHdjUHEnYeUO/WOvcLbLfxYC+MZwvd9EKOU1jU9s7RChTXS3oErL8sxg3yTkLKMi
         QqBZ0VwbhAWno+Xpbbmj9vOyBPkp+vbHvmZfR/2lyvwQF3a/CFvLaxeHtCKuAtuLcI
         Nm1cW6Ia+D9RhjSW88alJQtEpjheBXcEbXr4mfvbR0L09TjVDGG/ruu6L+yv/jFs0t
         ywGpyQWGGVdHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for the XUSB device mode controller
present on Tegra210 and Tegra186 SoC. This controller supports the USB 3.0
specification.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 204 +++++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
new file mode 100644
index 0000000..b23c451
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/nvidia,tegra-xudc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Device tree binding for NVIDIA Tegra XUSB device mode controller (XUDC)
+
+description:
+  The Tegra XUDC controller supports both USB 2.0 HighSpeed/FullSpeed and
+  USB 3.0 SuperSpeed protocols.
+
+maintainers:
+  - Nagarjuna Kristam <nkristam@nvidia.com>
+  - JC Kuo <jckuo@nvidia.com>
+  - Thierry Reding <treding@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: nvidia,tegra210-xudc # For Tegra210
+      - items:
+        - const: nvidia,tegra186-xudc # For Tegra186
+
+  interrupts:
+    maxItems: 1
+    description: Must contain the XUSB device interrupt.
+
+  power-domains:
+    maxItems: 2
+    description:
+      A list of PM domain specifiers that reference each power-domain
+      used by the XUSB device mode controller. This list must comprise of a
+      specifier for the XUSBA and XUSBB power-domains.
+      See ../power/power_domain.txt and ../arm/tegra/nvidia,tegra20-pmc.txt
+      for details.
+
+  power-domains-names:
+    maxItems: 2
+    description:
+       A list of names that represent each of the specifiers in
+       the 'power-domains' property.
+    items:
+      - const: ss
+      - const: dev
+
+  nvidia,xusb-padctl:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      phandle to the XUSB pad controller that is used to configure the USB pads
+      used by the XUDC controller.
+
+  phys:
+    minItems: 1
+    description:
+      Must contain an entry for each entry in phy-names.
+      See ../phy/phy-bindings.txt for details.
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: usb2-0
+      - const: usb2-1
+      - const: usb2-2
+      - const: usb2-3
+      - const: usb3-0
+      - const: usb3-1
+      - const: usb3-2
+      - const: usb3-3
+
+  avddio-usb-supply:
+    description: PCIe/USB3 analog logic power supply. Must supply 1.05 V.
+
+  hvdd-usb-supply:
+    description: USB controller power supply. Must supply 3.3 V.
+
+required:
+  - compatible
+  - power-domains
+  - power-domain-names
+  - nvidia,xusb-padctl
+  - phys
+  - phy-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          items:
+            const: nvidia,tegra210-xudc
+
+    then:
+      properties:
+        reg:
+          maxItems: 3
+          items:
+          - description: XUSB device controller registers
+          - description: XUSB device PCI Config registers
+          - description: XUSB device registers.
+        reg-names:
+          maxItems: 3
+          items:
+            - const: base
+            - const: fpci
+            - const: ipfs
+        clocks:
+          description:
+            Must contain an entry for all clocks used. See ../clock/clock-bindings.txt
+            for details.
+          maxItems: 5
+          items:
+            - description: Clock to enable core XUSB dev clock.
+            - description: Clock to enable XUSB super speed clock.
+            - description: Clock to enable XUSB super speed dev clock.
+            - description: Clock to enable XUSB high speed dev clock.
+            - description: Clock to enable XUSB full speed dev clock.
+        clock-names:
+          items:
+           - const: dev
+           - const: ss
+           - const: ss_src
+           - const: hs_src
+           - const: fs_src
+      required:
+        - reg
+        - reg-names
+        - clocks
+        - clock-names
+        - avddio-usb-supply
+        - hvdd-usb-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra186-xudc
+
+    then:
+      properties:
+        reg:
+          maxItems: 2
+          items:
+          - description: XUSB device controller registers
+          - description: XUSB device PCI Config registers
+        reg-names:
+          maxItems: 2
+          items:
+            - const: base
+            - const: fpci
+        clocks:
+          description:
+            Must contain an entry for all clocks used. See ../clock/clock-bindings.txt
+            for details.
+          maxItems: 4
+          items:
+            - description: Clock to enable core XUSB dev clock.
+            - description: Clock to enable XUSB super speed clock.
+            - description: Clock to enable XUSB super speed dev clock.
+            - description: Clock to enable XUSB full speed dev clock.
+        clock-names:
+          items:
+           - const: dev
+           - const: ss
+           - const: ss_src
+           - const: fs_src
+      required:
+        - reg
+        - reg-names
+        - clocks
+        - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@700d0000 {
+        compatible = "nvidia,tegra210-xudc";
+        reg = <0x0 0x700d0000 0x0 0x8000>,
+              <0x0 0x700d8000 0x0 0x1000>,
+              <0x0 0x700d9000 0x0 0x1000>;
+        reg-names = "base", "fpci", "ipfs";
+
+        interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&tegra_car TEGRA210_CLK_XUSB_DEV>,
+                 <&tegra_car TEGRA210_CLK_XUSB_SS>,
+                 <&tegra_car TEGRA210_CLK_XUSB_SSP_SRC>,
+                 <&tegra_car TEGRA210_CLK_XUSB_HS_SRC>,
+                 <&tegra_car TEGRA210_CLK_XUSB_FS_SRC>;
+        clock-names = "dev", "ss", "ss_src", "hs_src", "fs_src";
+
+        power-domains = <&pd_xusbdev>, <&pd_xusbss>;
+        power-domain-names = "dev", "ss";
+
+        nvidia,xusb-padctl = <&padctl>;
+
+        phys = <&micro_b>;
+        phy-names = "usb2-0";
+
+        avddio-usb-supply = <&vdd_pex_1v05>;
+        hvdd-usb-supply = <&vdd_3v3_sys>;
+    };
-- 
2.7.4

