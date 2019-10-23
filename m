Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C1CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94E120640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pSYPpqab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405494AbfJWM6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:58:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59084 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405475AbfJWM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwetP050665;
        Wed, 23 Oct 2019 07:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835520;
        bh=oWbKUNnALjWbrATEa7PoYdBtlkWYyB7FOT7VSgdGquw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pSYPpqabzONRZAThNF9g5dwTNh77neCe+XnvP6h4mViM2uTn4jjJ70kwSOJogd6vC
         qrnL3EIbJx1EMt5/57n42Uswr2fSAYgB4Jtw6zKkCgzfJqB82dUW65FZpChdfaOoVa
         tiIt01dUyoBrmiQ4AlfU/IrkskcGUL+Zu+DCView=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NCwe9e100913
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 07:58:40 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:39 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5oH061147;
        Wed, 23 Oct 2019 07:58:37 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
Date:   Wed, 23 Oct 2019 18:27:34 +0530
Message-ID: <20191023125735.4713-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
PHY but a wrapper used to configure some of the input signals to the
SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
 SERDES]
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
new file mode 100644
index 000000000000..8a1eccee6c1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI J721E WIZ (SERDES Wrapper)
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,j721e-wiz-16g
+              - ti,j721e-wiz-10g
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+    description: clock-specifier to represent input to the WIZ
+
+  clock-names:
+    items:
+      - const: fck
+      - const: core_ref_clk
+      - const: ext_ref_clk
+
+  num-lanes:
+    maxItems: 1
+    minimum: 1
+    maximum: 4
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  "#reset-cells":
+    const: 1
+
+  ranges: true
+
+  assigned-clocks:
+    maxItems: 2
+
+  assigned-clock-parents:
+    maxItems: 2
+
+patternProperties:
+  "^pll[0|1]_refclk$":
+    type: object
+    description: |
+      WIZ node should have subnodes for each of the PLLs present in
+      the SERDES.
+
+  "^cmn_refclk1?$":
+    type: object
+    description: |
+      WIZ node should have subnodes for each of the PMA common refclock
+      provided by the SERDES.
+
+  "^refclk_dig$":
+    type: object
+    description: |
+      WIZ node should have subnode for refclk_dig to select the reference
+      clock source for the reference clock used in the PHY and PMA digital
+      logic.
+
+  "^serdes@[0-9a-f]+$":
+    type: object
+    description: |
+      WIZ node should have '1' subnode for the SERDES. It could be either
+      Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
+      bindings specified in
+      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+      Torrent SERDES should follow the bindings specified in
+      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+
+required:
+  - compatible
+  - power-domains
+  - clocks
+  - clock-names
+  - num-lanes
+  - "#address-cells"
+  - "#size-cells"
+  - "#reset-cells"
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    wiz@5000000 {
+           compatible = "ti,j721e-wiz-16g";
+           #address-cells = <2>;
+           #size-cells = <2>;
+           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
+           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
+           num-lanes = <2>;
+           #reset-cells = <1>;
+
+           pll0_refclk {
+                  clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+                  clock-output-names = "wiz1_pll0_refclk";
+                  #clock-cells = <0>;
+                  assigned-clocks = <&wiz1_pll0_refclk>;
+                  assigned-clock-parents = <&k3_clks 293 13>;
+           };
+
+           pll1_refclk {
+                  clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
+                  clock-output-names = "wiz1_pll1_refclk";
+                  #clock-cells = <0>;
+                  assigned-clocks = <&wiz1_pll1_refclk>;
+                  assigned-clock-parents = <&k3_clks 293 0>;
+           };
+
+           cmn_refclk {
+                  clocks = <&wiz1_refclk_dig>;
+                  clock-output-names = "wiz1_cmn_refclk";
+                  #clock-cells = <0>;
+           };
+
+           cmn_refclk1 {
+                  clocks = <&wiz1_pll1_refclk>;
+                  clock-output-names = "wiz1_cmn_refclk1";
+                  #clock-cells = <0>;
+           };
+
+           refclk_dig {
+                  clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+                  clock-output-names = "wiz0_refclk_dig";
+                  #clock-cells = <0>;
+                  assigned-clocks = <&wiz0_refclk_dig>;
+                  assigned-clock-parents = <&k3_clks 292 11>;
+           };
+
+           serdes@5000000 {
+                  compatible = "cdns,ti,sierra-phy-t0";
+                  reg-names = "serdes";
+                  reg = <0x00 0x5000000 0x00 0x10000>;
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  resets = <&serdes_wiz0 0>;
+                  reset-names = "sierra_reset";
+                  clocks = <&wiz0_cmn_refclk>, <&wiz0_cmn_refclk1>;
+                  clock-names = "cmn_refclk", "cmn_refclk1";
+           };
+    };
-- 
2.17.1

