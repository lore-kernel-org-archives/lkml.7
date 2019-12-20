Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82AAC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713B421655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576847364;
	bh=z9BphCZrr8pVS6by4Dj/5isL6Vy7+SuDHoPLLbjcOIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=G+EaL4gFD/dD/KkrmFN1j03PqhjtiOhFqtulz/Y3XiE1MbWz2mnAJ/gFprmzsq9PZ
	 5qOyJpaBYjlRcLQy/tUwFR0Z1txlSmwxBkq19Aa3UUJMMzoW0JFGyA6ptlxobddPeI
	 WjV/p+lzpIHjpAwwyyO+HuhUovVlRDWlNniCspHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLTNJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:09:23 -0500
Received: from foss.arm.com ([217.140.110.172]:50680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfLTNJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:09:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 445FB30E;
        Fri, 20 Dec 2019 05:09:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B70A73F719;
        Fri, 20 Dec 2019 05:09:21 -0800 (PST)
Date:   Fri, 20 Dec 2019 13:09:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pascal Paillet <p.paillet@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, p.paillet@st.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: Convert stm32-pwr regulator to json-schema" to the regulator tree
In-Reply-To: <20191205161359.20755-1-p.paillet@st.com>
Message-Id: <applied-20191205161359.20755-1-p.paillet@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Convert stm32-pwr regulator to json-schema

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 130ac214294bcb5efc93229c7d10144c4992e90a Mon Sep 17 00:00:00 2001
From: Pascal Paillet <p.paillet@st.com>
Date: Thu, 5 Dec 2019 17:13:59 +0100
Subject: [PATCH] regulator: Convert stm32-pwr regulator to json-schema

Convert the stm32-pwr regulator binding to DT schema format using
json-schema.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191205161359.20755-1-p.paillet@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/st,stm32mp1-pwr-reg.txt         | 43 -------------
 .../regulator/st,stm32mp1-pwr-reg.yaml        | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
deleted file mode 100644
index e372dd3f0c8a..000000000000
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-STM32MP1 PWR Regulators
------------------------
-
-Available Regulators in STM32MP1 PWR block are:
-  - reg11 for regulator 1V1
-  - reg18 for regulator 1V8
-  - usb33 for the swtich USB3V3
-
-Required properties:
-- compatible: Must be "st,stm32mp1,pwr-reg"
-- list of child nodes that specify the regulator reg11, reg18 or usb33
-  initialization data for defined regulators. The definition for each of
-  these nodes is defined using the standard binding for regulators found at
-  Documentation/devicetree/bindings/regulator/regulator.txt.
-- vdd-supply: phandle to the parent supply/regulator node for vdd input
-- vdd_3v3_usbfs-supply: phandle to the parent supply/regulator node for usb33
-
-Example:
-
-pwr_regulators: pwr@50001000 {
-	compatible = "st,stm32mp1,pwr-reg";
-	reg = <0x50001000 0x10>;
-	vdd-supply = <&vdd>;
-	vdd_3v3_usbfs-supply = <&vdd_usb>;
-
-	reg11: reg11 {
-		regulator-name = "reg11";
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1100000>;
-	};
-
-	reg18: reg18 {
-		regulator-name = "reg18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	usb33: usb33 {
-		regulator-name = "usb33";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
new file mode 100644
index 000000000000..8d8f38fe85dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/st,stm32mp1-pwr-reg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP1 PWR voltage regulators
+
+maintainers:
+  - Pascal Paillet <p.paillet@st.com>
+
+properties:
+  compatible:
+    const: st,stm32mp1,pwr-reg
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Input supply phandle(s) for vdd input
+
+  vdd_3v3_usbfs-supply:
+    description: Input supply phandle(s) for vdd_3v3_usbfs input
+
+patternProperties:
+  "^(reg11|reg18|usb33)$":
+    type: object
+
+    allOf:
+      - $ref: "regulator.yaml#"
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwr@50001000 {
+      compatible = "st,stm32mp1,pwr-reg";
+      reg = <0x50001000 0x10>;
+      vdd-supply = <&vdd>;
+      vdd_3v3_usbfs-supply = <&vdd_usb>;
+
+      reg11 {
+        regulator-name = "reg11";
+        regulator-min-microvolt = <1100000>;
+        regulator-max-microvolt = <1100000>;
+      };
+
+      reg18 {
+        regulator-name = "reg18";
+        regulator-min-microvolt = <1800000>;
+        regulator-max-microvolt = <1800000>;
+      };
+
+      usb33 {
+        regulator-name = "usb33";
+        regulator-min-microvolt = <3300000>;
+        regulator-max-microvolt = <3300000>;
+      };
+    };
+...
-- 
2.20.1

