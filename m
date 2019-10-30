Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6908ACA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CADA208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572456750;
	bh=9KCzCGayn00ir3A6/e9VNLOzsVQtDEOPu1WAna2nRsE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PzwWgYKY3DAYaMGeZDGCehc2u1UACJad9EA6okcLy026P9d4RnxVIrc3B0Iy+ddmV
	 hq0dwWHMjG61U8fJkYNct+qqkhxAwhPEWJcfpXpbM0SQ6P0FYgrX141u+DP7Aq8G6o
	 OL+B8G62pAc4QJy75bJha2+bFI4+LOvv+yJn3W5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfJ3Rc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfJ3Rc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:32:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9497F2054F;
        Wed, 30 Oct 2019 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572456747;
        bh=9KCzCGayn00ir3A6/e9VNLOzsVQtDEOPu1WAna2nRsE=;
        h=From:To:Cc:Subject:Date:From;
        b=arkn9LpDWOvS47Qpy4a6KQAykoy9jkh8Y2sXaQL5wVQmzAb7JybvTSobwkT+f7kGE
         +A83HozHN8b8uICtDL+Kjo0HrUlmWicqM1+qHNvhdZv+CKTnvc/HuCdgxHtjaWRUMZ
         9u/P2AAB2zVYFh0uAjrsDHXzoQjGWnVXn5+HdJA8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: Convert Generic Power Domain bindings to json-schema
Date:   Wed, 30 Oct 2019 18:32:15 +0100
Message-Id: <20191030173216.5993-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Generic Power Domain bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>

---

Changes since v2:
1. Keep description of consumers in power-domain.txt,
2. Rename power_domain.txt to power-domain.txt,
3. Indent example with four spaces (more readable).

Changes since v1:
1. Select all nodes for consumers,
2. Remove from consumers duplicated properties with dt-schema,
3. Fix power domain pattern,
4. Remove unneeded types.
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
 .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
 .../bindings/arm/freescale/fsl,scu.txt        |   2 +-
 .../bindings/clock/renesas,cpg-mssr.txt       |   2 +-
 .../bindings/clock/ti/davinci/psc.txt         |   2 +-
 .../firmware/nvidia,tegra186-bpmp.txt         |   2 +-
 .../bindings/power/amlogic,meson-gx-pwrc.txt  |   2 +-
 .../devicetree/bindings/power/fsl,imx-gpc.txt |   2 +-
 .../bindings/power/fsl,imx-gpcv2.txt          |   2 +-
 .../{power_domain.txt => power-domain.txt}    |  95 +------------
 .../bindings/power/power-domain.yaml          | 133 ++++++++++++++++++
 .../bindings/power/renesas,sysc-rmobile.txt   |   2 +-
 .../bindings/power/xlnx,zynqmp-genpd.txt      |   2 +-
 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |   2 +-
 .../bindings/soc/mediatek/scpsys.txt          |   2 +-
 .../bindings/soc/ti/sci-pm-domain.txt         |   2 +-
 MAINTAINERS                                   |   2 +-
 17 files changed, 149 insertions(+), 109 deletions(-)
 rename Documentation/devicetree/bindings/power/{power_domain.txt => power-domain.txt} (51%)
 create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 083dbf96ee00..f493d69e6194 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -100,7 +100,7 @@ Required sub-node properties:
 
 [0] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/power/power_domain.txt
+[2] Documentation/devicetree/bindings/power/power-domain.yaml
 [3] Documentation/devicetree/bindings/thermal/thermal.txt
 [4] Documentation/devicetree/bindings/sram/sram.txt
 [5] Documentation/devicetree/bindings/reset/reset.txt
diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index 401831973638..7b83ef43b418 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -110,7 +110,7 @@ Required properties:
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/thermal/thermal.txt
 [3] Documentation/devicetree/bindings/sram/sram.txt
-[4] Documentation/devicetree/bindings/power/power_domain.txt
+[4] Documentation/devicetree/bindings/power/power-domain.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 70c1a624486d..e07735a8c2c7 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -124,7 +124,7 @@ Required properties for Pinctrl sub nodes:
 			CONFIG settings.
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/power/power_domain.txt
+[2] Documentation/devicetree/bindings/power/power-domain.yaml
 [3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
 
 RTC bindings based on SCU Message Protocol
diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
index 916a601b76a7..2def42096886 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -59,7 +59,7 @@ Required Properties:
 	power-managed through Module Standby should refer to the CPG device
 	node in their "power-domains" property, as documented by the generic PM
 	Domain bindings in
-	Documentation/devicetree/bindings/power/power_domain.txt.
+	Documentation/devicetree/bindings/power/power-domain.yaml.
 
   - #reset-cells: Must be 1
       - The single reset specifier cell must be the module number, as defined
diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt b/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
index dae4ad8e198c..5f746ebf7a2c 100644
--- a/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
@@ -67,5 +67,5 @@ Examples:
 
 Also see:
 - Documentation/devicetree/bindings/clock/clock-bindings.txt
-- Documentation/devicetree/bindings/power/power_domain.txt
+- Documentation/devicetree/bindings/power/power-domain.yaml
 - Documentation/devicetree/bindings/reset/reset.txt
diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
index ff380dadb5f9..e44a13bc06ed 100644
--- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
+++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
@@ -32,7 +32,7 @@ implemented by this node:
 
 - .../clock/clock-bindings.txt
 - <dt-bindings/clock/tegra186-clock.h>
-- ../power/power_domain.txt
+- ../power/power-domain.yaml
 - <dt-bindings/power/tegra186-powergate.h>
 - .../reset/reset.txt
 - <dt-bindings/reset/tegra186-reset.h>
diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
index 0fdc3dd1125e..99b5b10cda31 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
@@ -10,7 +10,7 @@ The Video Processing Unit power domain is controlled by this power controller,
 but the domain requires some external resources to meet the correct power
 sequences.
 The bindings must respect the power domain bindings as described in the file
-power_domain.txt
+power-domain.yaml
 
 Device Tree Bindings:
 ---------------------
diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
index 726ec2875223..f0f5553a9e74 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
@@ -19,7 +19,7 @@ Required properties:
   - ipg
 
 The power domains are generic power domain providers as documented in
-Documentation/devicetree/bindings/power/power_domain.txt. They are described as
+Documentation/devicetree/bindings/power/power-domain.yaml. They are described as
 subnodes of the power gating controller 'pgc' node of the GPC and should
 contain the following:
 
diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
index 7c7e972aaa42..61649202f6f5 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -17,7 +17,7 @@ Required properties:
 
 Power domains contained within GPC node are generic power domain
 providers, documented in
-Documentation/devicetree/bindings/power/power_domain.txt, which are
+Documentation/devicetree/bindings/power/power-domain.yaml, which are
 described as subnodes of the power gating controller 'pgc' node,
 which, in turn, is expected to contain the following:
 
diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power-domain.txt
similarity index 51%
rename from Documentation/devicetree/bindings/power/power_domain.txt
rename to Documentation/devicetree/bindings/power/power-domain.txt
index 8f8b25a24b8f..5b09b2deb483 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power-domain.txt
@@ -13,100 +13,7 @@ phandle arguments (so called PM domain specifiers) of length specified by the
 
 ==PM domain providers==
 
-Required properties:
- - #power-domain-cells : Number of cells in a PM domain specifier;
-   Typically 0 for nodes representing a single PM domain and 1 for nodes
-   providing multiple PM domains (e.g. power controllers), but can be any value
-   as specified by device tree binding documentation of particular provider.
-
-Optional properties:
- - power-domains : A phandle and PM domain specifier as defined by bindings of
-                   the power controller specified by phandle.
-   Some power domains might be powered from another power domain (or have
-   other hardware specific dependencies). For representing such dependency
-   a standard PM domain consumer binding is used. When provided, all domains
-   created by the given provider should be subdomains of the domain
-   specified by this binding. More details about power domain specifier are
-   available in the next section.
-
-- domain-idle-states : A phandle of an idle-state that shall be soaked into a
-                generic domain power state. The idle state definitions are
-                compatible with domain-idle-state specified in [1]. phandles
-                that are not compatible with domain-idle-state will be
-                ignored.
-  The domain-idle-state property reflects the idle state of this PM domain and
-  not the idle states of the devices or sub-domains in the PM domain. Devices
-  and sub-domains have their own idle-states independent of the parent
-  domain's idle states. In the absence of this property, the domain would be
-  considered as capable of being powered-on or powered-off.
-
-- operating-points-v2 : Phandles to the OPP tables of power domains provided by
-  a power domain provider. If the provider provides a single power domain only
-  or all the power domains provided by the provider have identical OPP tables,
-  then this shall contain a single phandle. Refer to ../opp/opp.txt for more
-  information.
-
-Example:
-
-	power: power-controller@12340000 {
-		compatible = "foo,power-controller";
-		reg = <0x12340000 0x1000>;
-		#power-domain-cells = <1>;
-	};
-
-The node above defines a power controller that is a PM domain provider and
-expects one cell as its phandle argument.
-
-Example 2:
-
-	parent: power-controller@12340000 {
-		compatible = "foo,power-controller";
-		reg = <0x12340000 0x1000>;
-		#power-domain-cells = <1>;
-	};
-
-	child: power-controller@12341000 {
-		compatible = "foo,power-controller";
-		reg = <0x12341000 0x1000>;
-		power-domains = <&parent 0>;
-		#power-domain-cells = <1>;
-	};
-
-The nodes above define two power controllers: 'parent' and 'child'.
-Domains created by the 'child' power controller are subdomains of '0' power
-domain provided by the 'parent' power controller.
-
-Example 3:
-	parent: power-controller@12340000 {
-		compatible = "foo,power-controller";
-		reg = <0x12340000 0x1000>;
-		#power-domain-cells = <0>;
-		domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
-	};
-
-	child: power-controller@12341000 {
-		compatible = "foo,power-controller";
-		reg = <0x12341000 0x1000>;
-		power-domains = <&parent>;
-		#power-domain-cells = <0>;
-		domain-idle-states = <&DOMAIN_PWR_DN>;
-	};
-
-	DOMAIN_RET: state@0 {
-		compatible = "domain-idle-state";
-		reg = <0x0>;
-		entry-latency-us = <1000>;
-		exit-latency-us = <2000>;
-		min-residency-us = <10000>;
-	};
-
-	DOMAIN_PWR_DN: state@1 {
-		compatible = "domain-idle-state";
-		reg = <0x1>;
-		entry-latency-us = <5000>;
-		exit-latency-us = <8000>;
-		min-residency-us = <7000>;
-	};
+See power-domain.yaml.
 
 ==PM domain consumers==
 
diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
new file mode 100644
index 000000000000..455b573293ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/power-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic PM domains
+
+maintainers:
+  - Rafael J. Wysocki <rjw@rjwysocki.net>
+  - Kevin Hilman <khilman@kernel.org>
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description: |+
+  System on chip designs are often divided into multiple PM domains that can be
+  used for power gating of selected IP blocks for power saving by reduced leakage
+  current.
+
+  This device tree binding can be used to bind PM domain consumer devices with
+  their PM domains provided by PM domain providers. A PM domain provider can be
+  represented by any node in the device tree and can provide one or more PM
+  domains. A consumer node can refer to the provider by a phandle and a set of
+  phandle arguments (so called PM domain specifiers) of length specified by the
+  \#power-domain-cells property in the PM domain provider node.
+
+properties:
+  $nodename:
+    pattern: "^(power-controller|power-domain)(@.*)?$"
+
+  domain-idle-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle of an idle-state that shall be soaked into a generic domain
+      power state. The idle state definitions are compatible with
+      domain-idle-state specified in
+      Documentation/devicetree/bindings/power/domain-idle-state.txt
+      phandles that are not compatible with domain-idle-state will be ignored.
+      The domain-idle-state property reflects the idle state of this PM domain
+      and not the idle states of the devices or sub-domains in the PM domain.
+      Devices and sub-domains have their own idle-states independent
+      of the parent domain's idle states. In the absence of this property,
+      the domain would be considered as capable of being powered-on
+      or powered-off.
+
+  operating-points-v2:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandles to the OPP tables of power domains provided by a power domain
+      provider. If the provider provides a single power domain only or all
+      the power domains provided by the provider have identical OPP tables,
+      then this shall contain a single phandle. Refer to ../opp/opp.txt
+      for more information.
+
+  "#power-domain-cells":
+    description:
+      Number of cells in a PM domain specifier. Typically 0 for nodes
+      representing a single PM domain and 1 for nodes providing multiple PM
+      domains (e.g. power controllers), but can be any value as specified
+      by device tree binding documentation of particular provider.
+
+  power-domains:
+    description:
+       A phandle and PM domain specifier as defined by bindings of the power
+       controller specified by phandle. Some power domains might be powered
+       from another power domain (or have other hardware specific
+       dependencies). For representing such dependency a standard PM domain
+       consumer binding is used. When provided, all domains created
+       by the given provider should be subdomains of the domain specified
+       by this binding.
+
+required:
+  - "#power-domain-cells"
+
+examples:
+  - |
+    power: power-controller@12340000 {
+        compatible = "foo,power-controller";
+        reg = <0x12340000 0x1000>;
+        #power-domain-cells = <1>;
+    };
+
+    // The node above defines a power controller that is a PM domain provider and
+    // expects one cell as its phandle argument.
+
+  - |
+    parent2: power-controller@12340000 {
+        compatible = "foo,power-controller";
+        reg = <0x12340000 0x1000>;
+        #power-domain-cells = <1>;
+    };
+
+    child2: power-controller@12341000 {
+        compatible = "foo,power-controller";
+        reg = <0x12341000 0x1000>;
+        power-domains = <&parent2 0>;
+        #power-domain-cells = <1>;
+    };
+
+    // The nodes above define two power controllers: 'parent' and 'child'.
+    // Domains created by the 'child' power controller are subdomains of '0' power
+    // domain provided by the 'parent' power controller.
+
+  - |
+    parent3: power-controller@12340000 {
+        compatible = "foo,power-controller";
+        reg = <0x12340000 0x1000>;
+        #power-domain-cells = <0>;
+        domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
+    };
+
+    child3: power-controller@12341000 {
+        compatible = "foo,power-controller";
+        reg = <0x12341000 0x1000>;
+        power-domains = <&parent3>;
+        #power-domain-cells = <0>;
+        domain-idle-states = <&DOMAIN_PWR_DN>;
+    };
+
+    DOMAIN_RET: state@0 {
+        compatible = "domain-idle-state";
+        reg = <0x0 0x0>;
+        entry-latency-us = <1000>;
+        exit-latency-us = <2000>;
+        min-residency-us = <10000>;
+    };
+
+    DOMAIN_PWR_DN: state@1 {
+        compatible = "domain-idle-state";
+        reg = <0x1 0x0>;
+        entry-latency-us = <5000>;
+        exit-latency-us = <8000>;
+        min-residency-us = <7000>;
+    };
diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index beda7d2efc30..49aba15dff8b 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -29,7 +29,7 @@ Optional nodes:
 
 Each of the PM domain nodes represents a PM domain, as documented by the
 generic PM domain bindings in
-Documentation/devicetree/bindings/power/power_domain.txt.
+Documentation/devicetree/bindings/power/power-domain.yaml.
 
 The nodes should be named by the real power area names, and thus their names
 should be unique.
diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
index 8d1b8200ebd0..54b9f9d0f90f 100644
--- a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
+++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
@@ -4,7 +4,7 @@ Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
 The binding for zynqmp-power-controller follow the common
 generic PM domain binding[1].
 
-[1] Documentation/devicetree/bindings/power/power_domain.txt
+[1] Documentation/devicetree/bindings/power/power-domain.yaml
 
 == Zynq MPSoC Generic PM Domain Node ==
 
diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
index 3b7d32956391..72ff033565e5 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
@@ -26,7 +26,7 @@ Optional properties:
     system power.  This node follows the power controller bindings[3].
 
 [1] Documentation/devicetree/bindings/reset/reset.txt
-[2] Documentation/devicetree/bindings/power/power_domain.txt
+[2] Documentation/devicetree/bindings/power/power-domain.yaml
 [3] Documentation/devicetree/bindings/power/power-controller.txt
 
 Example:
diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 876693a7ada5..8f469d85833b 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -8,7 +8,7 @@ The System Power Manager (SPM) inside the SCPSYS is for the MTCMOS power
 domain control.
 
 The driver implements the Generic PM domain bindings described in
-power/power_domain.txt. It provides the power domains defined in
+power/power-domain.yaml. It provides the power domains defined in
 - include/dt-bindings/power/mt8173-power.h
 - include/dt-bindings/power/mt6797-power.h
 - include/dt-bindings/power/mt2701-power.h
diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
index f541d1f776a2..6217e64309de 100644
--- a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
@@ -12,7 +12,7 @@ PM Domain Node
 ==============
 The PM domain node represents the global PM domain managed by the PMMC, which
 in this case is the implementation as documented by the generic PM domain
-bindings in Documentation/devicetree/bindings/power/power_domain.txt.  Because
+bindings in Documentation/devicetree/bindings/power/power-domain.yaml.  Because
 this relies on the TI SCI protocol to communicate with the PMMC it must be a
 child of the pmmc node.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 9f69d01da3a6..8fde5aa64bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6953,7 +6953,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
-F:	Documentation/devicetree/bindings/power/power_domain.txt
+F:	Documentation/devicetree/bindings/power/power-domain*
 
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
-- 
2.17.1

