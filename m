Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA1820836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575918008;
	bh=yEUPCbKiUErbYBLYicuO3KmEB/AU+DrFOWBI63xwUX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=LG3sJo1/IOLDf9GlJIvQeHCNBaduK/8rCXNQ9Fppt/Q5d/IPN08qOjKZlkss8Pq7+
	 iahCRpgum1289klV4pWCKI585i1OAeFIZzSEVBnf1A7x4xiC7K6VFvIFMrqY5uDcdy
	 BJE1aFxhhJlz6UqBZOs+Dy59b5uQmCgBSJ25o90E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLITAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:00:06 -0500
Received: from foss.arm.com ([217.140.110.172]:42588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLITAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:00:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36BCA328;
        Mon,  9 Dec 2019 11:00:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8BC53F6CF;
        Mon,  9 Dec 2019 11:00:03 -0800 (PST)
Date:   Mon, 09 Dec 2019 19:00:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     alexandre.torgue@st.com, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Applied "dt-bindings: regulator: Convert stm32 booster bindings to json-schema" to the regulator tree
In-Reply-To: <20191122104536.20283-1-benjamin.gaignard@st.com>
Message-Id: <applied-20191122104536.20283-1-benjamin.gaignard@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: Convert stm32 booster bindings to json-schema

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

From 681700c38f3e989a3da940d0120b0268c25c54d8 Mon Sep 17 00:00:00 2001
From: Benjamin Gaignard <benjamin.gaignard@st.com>
Date: Fri, 22 Nov 2019 11:45:35 +0100
Subject: [PATCH] dt-bindings: regulator: Convert stm32 booster bindings to
 json-schema

Convert the STM32 regulator booster binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191122104536.20283-1-benjamin.gaignard@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/st,stm32-booster.txt   | 18 --------
 .../bindings/regulator/st,stm32-booster.yaml  | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt b/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
deleted file mode 100644
index 479ad4c8758e..000000000000
--- a/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-STM32 BOOSTER - Booster for ADC analog input switches
-
-Some STM32 devices embed a 3.3V booster supplied by Vdda, that can be used
-to supply ADC analog input switches.
-
-Required properties:
-- compatible: Should be one of:
-  "st,stm32h7-booster"
-  "st,stm32mp1-booster"
-- st,syscfg: Phandle to system configuration controller.
-- vdda-supply: Phandle to the vdda input analog voltage.
-
-Example:
-	booster: regulator-booster {
-		compatible = "st,stm32mp1-booster";
-		st,syscfg = <&syscfg>;
-		vdda-supply = <&vdda>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml b/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
new file mode 100644
index 000000000000..64f1183ce841
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/st,stm32-booster.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 booster for ADC analog input switches bindings
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+description: |
+  Some STM32 devices embed a 3.3V booster supplied by Vdda, that can be used
+  to supply ADC analog input switches.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - st,stm32h7-booster
+      - st,stm32mp1-booster
+
+  st,syscfg:
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: phandle to system configuration controller.
+
+  vdda-supply:
+    description: phandle to the vdda input analog voltage.
+
+required:
+  - compatible
+  - st,syscfg
+  - vdda-supply
+
+examples:
+  - |
+    regulator-booster {
+      compatible = "st,stm32mp1-booster";
+      st,syscfg = <&syscfg>;
+      vdda-supply = <&vdda>;
+    };
+
+...
-- 
2.20.1

