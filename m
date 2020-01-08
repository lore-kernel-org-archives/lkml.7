Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09170C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499137;
	bh=ZmnIzpp81DmxYJOfDGkQtwvrwcDh8+AwRb0AtE1IvR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=sotorzkNeQDZMf5wYklUURWDC87Dnpva+3Q+yPPpV75M75v3OfQDViE07vG4VM+Dk
	 YgfQ918Q8aVsAIkTWM3liYzkiuSzRMo2p1TVsVDPa270f+eQi6g4o1B7MbQSLur9Tu
	 IVbJWAVO4KIQV6uTZhVzKBj5aBjynIXZa2lP/IXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgAHP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:58:57 -0500
Received: from foss.arm.com ([217.140.110.172]:46604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbgAHP6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:58:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6CEDA7;
        Wed,  8 Jan 2020 07:58:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAA9A3F534;
        Wed,  8 Jan 2020 07:58:53 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:58:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        heiko@sntech.de, icenowy@aosc.io, Jonathan.Cameron@huawei.com,
        laurent.pinchart@ideasonboard.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, mchehab+samsung@kernel.org,
        mripard@kernel.org, robh+dt@kernel.org, sam@ravnborg.org,
        shawnguo@kernel.org, sravanhome@gmail.com
Subject: Applied "regulator: bindings: add document bindings for mpq7920" to the regulator tree
In-Reply-To: <20200108131234.24128-3-sravanhome@gmail.com>
Message-Id: <applied-20200108131234.24128-3-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bindings: add document bindings for mpq7920

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

From f5fa59a61ecac5efcb77b294a10134aab358bb5c Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Wed, 8 Jan 2020 14:12:32 +0100
Subject: [PATCH] regulator: bindings: add document bindings for mpq7920

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Link: https://lore.kernel.org/r/20200108131234.24128-3-sravanhome@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/mps,mpq7920.yaml       | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
new file mode 100644
index 000000000000..598f3ea070c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mpq7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MPQ7920 PMIC
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - mps,mpq7920
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+
+      mps,switch-freq:
+        description: |
+          switching frequency must be one of following corresponding value
+          1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
+        $ref: "/schemas/types.yaml#/definitions/uint8"
+        enum: [ 0, 1, 2, 3 ]
+        default: 2
+
+      buck1:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          4.5A DC-DC step down converter
+
+        mps,buck-softstart:
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+           description: |
+             defines the soft start time of this buck, must be one of the following
+             corresponding values 150us, 300us, 610us, 920us
+
+         mps,buck-phase-delay:
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 0
+           description: |
+             defines the phase delay of this buck, must be one of the following
+             corresponding values 0deg, 90deg, 180deg, 270deg
+
+         mps,buck-ovp-disable:
+           type: boolean
+           description: |
+             disables over voltage protection of this buck
+
+      buck2:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          2.5A DC-DC step down converter
+
+        mps,buck-softstart:
+          description: |
+            defines the soft start time of this buck, must be one of the following
+            corresponding values 150us, 300us, 610us, 920us
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-phase-delay:
+          description: |
+            defines the phase delay of this buck, must be one of the following
+            corresponding values 0deg, 90deg, 180deg, 270deg
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 0
+
+        mps,buck-ovp-disable:
+          description: |
+            disables over voltage protection of this buck
+          type: boolean
+
+      buck3:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          4.5A DC-DC step down converter
+
+        mps,buck-softstart:
+           description: |
+             defines the soft start time of this buck, must be one of the following
+             corresponding values 150us, 300us, 610us, 920us
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+
+         mps,buck-phase-delay:
+           description: |
+             defines the phase delay of this buck, must be one of the following
+             corresponding values 0deg, 90deg, 180deg, 270deg
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+
+         mps,buck-ovp-disable:
+           description: |
+             disables over voltage protection of this buck
+           type: boolean
+
+      buck4:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          2.5A DC-DC step down converter
+
+        mps,buck-softstart:
+          description: |
+            defines the soft start time of this buck, must be one of the following
+            corresponding values 150us, 300us, 610us, 920us
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-phase-delay:
+          description: |
+            defines the phase delay of this buck, must be one of the following
+            corresponding values 0deg, 90deg, 180deg, 270deg
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-ovp-disable:
+          description: |
+            disables over voltage protection of this buck
+          type: boolean
+
+      ldortc:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V for RTC, always enabled
+
+      ldo2:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo3:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo4:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo5:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@69 {
+          compatible = "mps,mpq7920";
+          reg = <0x69>;
+
+          regulators {
+            mps,switch-freq = <1>;
+
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <400000>;
+             regulator-max-microvolt = <3587500>;
+             regulator-min-microamp  = <460000>;
+             regulator-max-microamp  = <7600000>;
+             regulator-boot-on;
+             mps,buck-ovp-disable;
+             mps,buck-phase-delay = <2>;
+             mps,buck-softstart = <1>;
+            };
+
+            ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <650000>;
+             regulator-max-microvolt = <3587500>;
+            };
+         };
+       };
+     };
+...
-- 
2.20.1

