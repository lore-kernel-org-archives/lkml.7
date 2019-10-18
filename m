Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E44CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A63222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422126;
	bh=Tc8cnNhiKzhBvNO2Cs5Un7ikAUv1MsMjvHySPz7E1O8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tKKEUelUhwtPR86Ri0/SX7PcYS6QgvOE6jh9m+BmHStmTYXBS7nD2n7J76hQnLc0r
	 lNIWqoT9P08Q/N+Ns26aHD0BHu1Sfq0AmMxeKtC2uLt4XZwWsXTxxP3lSE5Iq79Jpl
	 GzRULlogl888kYi4refvZXKzqLTSTZjIc/OCIj/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410710AbfJRSIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:08:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44726 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505689AbfJRSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hWN6iotQzqORhI85NQUfvHQlZSBW0NQNxJUWC/ER/MQ=; b=jgcWFtxnHEJu
        MZv715iujjk/yK4ebDjzI0/uvzNNaHshYcNWieSW6P8gctwJxacbqpbmSfaMRDXLwZfnxLwy/Qu16
        5ulVRa6/EEUm7cl8XBUXDTIT6qB6E/84KbB+ajCCzRCAMjrCU24fpRqdB2oxSjaiourglMtklczEi
        jN3M8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeQ-0004Ei-JE; Fri, 18 Oct 2019 18:06:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 091CB2743276; Fri, 18 Oct 2019 19:06:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     alsa-devel@alsa-project.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Applied "dt-bindings: sound: Convert Samsung I2S controller to dt-schema" to the asoc tree
In-Reply-To: <20191004125914.1033-1-m.szyprowski@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180658.091CB2743276@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:06:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: sound: Convert Samsung I2S controller to dt-schema

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 2d39a1fc19ea2d33fd68f5d02e6136ddaae2ac11 Mon Sep 17 00:00:00 2001
From: Maciej Falkowski <m.falkowski@samsung.com>
Date: Fri, 4 Oct 2019 14:59:14 +0200
Subject: [PATCH] dt-bindings: sound: Convert Samsung I2S controller to
 dt-schema

Convert Samsung I2S controller to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
[mszyprow: integrated fix for minor spelling issues]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191004125914.1033-1-m.szyprowski@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/samsung-i2s.txt |  84 -----------
 .../bindings/sound/samsung-i2s.yaml           | 138 ++++++++++++++++++
 2 files changed, 138 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
deleted file mode 100644
index a88cb00fa096..000000000000
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-* Samsung I2S controller
-
-Required SoC Specific Properties:
-
-- compatible : should be one of the following.
-   - samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
-   - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
-     secondary fifo, s/w reset control and internal mux for root clk src.
-   - samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
-     playback, stereo channel capture, secondary fifo using internal
-     or external dma, s/w reset control, internal mux for root clk src
-     and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
-     is to allow transfer of multiple channel audio data on single data line.
-   - samsung,exynos7-i2s: with all the available features of exynos5 i2s,
-     exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
-     with only external dma and more no.of root clk sampling frequencies.
-   - samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
-     stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
-     slightly modified bit offsets.
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- dmas: list of DMA controller phandle and DMA request line ordered pairs.
-- dma-names: identifier string for each DMA request line in the dmas property.
-  These strings correspond 1:1 with the ordered pairs in dmas.
-- clocks: Handle to iis clock and RCLK source clk.
-- clock-names:
-  i2s0 uses some base clocks from CMU and some are from audio subsystem internal
-  clock controller. The clock names for i2s0 should be "iis", "i2s_opclk0" and
-  "i2s_opclk1" as shown in the example below.
-  i2s1 and i2s2 uses clocks from CMU. The clock names for i2s1 and i2s2 should
-  be "iis" and "i2s_opclk0".
-  "iis" is the i2s bus clock and i2s_opclk0, i2s_opclk1 are sources of the root
-  clk. i2s0 has internal mux to select the source of root clk and i2s1 and i2s2
-  doesn't have any such mux.
-- #clock-cells: should be 1, this property must be present if the I2S device
-  is a clock provider in terms of the common clock bindings, described in
-  ../clock/clock-bindings.txt.
-- clock-output-names (deprecated): from the common clock bindings, names of
-  the CDCLK I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
-  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices respectively.
-
-There are following clocks available at the I2S device nodes:
- CLK_I2S_CDCLK    - the CDCLK (CODECLKO) gate clock,
- CLK_I2S_RCLK_PSR - the RCLK prescaler divider clock (corresponding to the
-		    IISPSR register),
- CLK_I2S_RCLK_SRC - the RCLKSRC mux clock (corresponding to RCLKSRC bit in
-		    IISMOD register).
-
-Refer to the SoC datasheet for availability of the above clocks.
-The CLK_I2S_RCLK_PSR and CLK_I2S_RCLK_SRC clocks are usually only available
-in the IIS Multi Audio Interface.
-
-Note: Old DTs may not have the #clock-cells property and then not use the I2S
-node as a clock supplier.
-
-Optional SoC Specific Properties:
-
-- samsung,idma-addr: Internal DMA register base address of the audio
-  sub system(used in secondary sound source).
-- pinctrl-0: Should specify pin control groups used for this controller.
-- pinctrl-names: Should contain only one value - "default".
-- #sound-dai-cells: should be 1.
-
-
-Example:
-
-i2s0: i2s@3830000 {
-	compatible = "samsung,s5pv210-i2s";
-	reg = <0x03830000 0x100>;
-	dmas = <&pdma0 10
-		&pdma0 9
-		&pdma0 8>;
-	dma-names = "tx", "rx", "tx-sec";
-	clocks = <&clock_audss EXYNOS_I2S_BUS>,
-		<&clock_audss EXYNOS_I2S_BUS>,
-		<&clock_audss EXYNOS_SCLK_I2S>;
-	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-	#clock-cells = <1>;
-	samsung,idma-addr = <0x03000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_bus>;
-	#sound-dai-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
new file mode 100644
index 000000000000..53e3bad4178c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC I2S controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    description: |
+      samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
+
+      samsung,s5pv210-i2s: for 8/16/24bit multichannel (5.1) I2S with
+      secondary FIFO, s/w reset control and internal mux for root clock
+      source.
+
+      samsung,exynos5420-i2s: for 8/16/24bit multichannel (5.1) I2S for
+      playback, stereo channel capture, secondary FIFO using internal
+      or external DMA, s/w reset control, internal mux for root clock
+      source and 7.1 channel TDM support for playback; TDM (Time division
+      multiplexing) is to allow transfer of multiple channel audio data on
+      single data line.
+
+      samsung,exynos7-i2s: with all the available features of Exynos5 I2S.
+      Exynos7 I2S has 7.1 channel TDM support for capture, secondary FIFO
+      with only external DMA and more number of root clock sampling
+      frequencies.
+
+      samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
+      stereo channels. Exynos7 I2S1 upgraded to 5.1 multichannel with
+      slightly modified bit offsets.
+    enum:
+      - samsung,s3c6410-i2s
+      - samsung,s5pv210-i2s
+      - samsung,exynos5420-i2s
+      - samsung,exynos7-i2s
+      - samsung,exynos7-i2s1
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    minItems: 2
+    maxItems: 3
+
+  dma-names:
+    oneOf:
+      - items:
+          - const: tx
+          - const: rx
+      - items:
+          - const: tx
+          - const: rx
+          - const: tx-sec
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: iis
+      - items: # for I2S0
+          - const: iis
+          - const: i2s_opclk0
+          - const: i2s_opclk1
+      - items: # for I2S1 and I2S2
+          - const: iis
+          - const: i2s_opclk0
+    description: |
+      "iis" is the I2S bus clock and i2s_opclk0, i2s_opclk1 are sources
+      of the root clock. I2S0 has internal mux to select the source
+      of root clock and I2S1 and I2S2 doesn't have any such mux.
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names:
+    deprecated: true
+    oneOf:
+      - items: # for I2S0
+          - const: i2s_cdclk0
+      - items: # for I2S1
+          - const: i2s_cdclk1
+      - items: # for I2S2
+          - const: i2s_cdclk2
+    description: Names of the CDCLK I2S output clocks.
+
+  samsung,idma-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Internal DMA register base address of the audio
+      subsystem (used in secondary sound source).
+
+  pinctrl-0:
+    description: Should specify pin control groups used for this controller.
+
+  pinctrl-names:
+    const: default
+
+  "#sound-dai-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos-audss-clk.h>
+
+    i2s0: i2s@3830000 {
+        compatible = "samsung,s5pv210-i2s";
+        reg = <0x03830000 0x100>;
+        dmas = <&pdma0 10>,
+                <&pdma0 9>,
+                <&pdma0 8>;
+        dma-names = "tx", "rx", "tx-sec";
+        clocks = <&clock_audss EXYNOS_I2S_BUS>,
+                <&clock_audss EXYNOS_I2S_BUS>,
+                <&clock_audss EXYNOS_SCLK_I2S>;
+        clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+        #clock-cells = <1>;
+        samsung,idma-addr = <0x03000000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2s0_bus>;
+        #sound-dai-cells = <1>;
+    };
-- 
2.20.1

